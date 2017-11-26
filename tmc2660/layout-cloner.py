#!/usr/bin/env python
#
# Clone a template PCB file multiple times to an output file that just starts
# out with the non-placed and non-routed components.
#
# Basic ops to get a template cloned:
#  - Template: Start with a schematic with 1xx components and create a
#    template *.kicad_pcb with only these 1xx components, placed and wired
#    up with tracks and zones. This is the template schematic and board.
#  - Create number of blocks needed from the template schematic,
#    annotated with multiples of 100
#       ./create-blocks-from-template.sh <number>
#  - Use these blocks in a schematic in a hierarchical composition.
#  - Create a *.kicad_pcb that will contain the 1xx, 2xx, ... components
#    placed anywhere and ratsnest wired (as they come from importing from the
#    schematic). Leave these unrouted and unplaced, just route any additional
#    components the usual way.
#    (here saved as tmc2660-quad-baseline.kicad_pcb).
#  - modify layout-cloner: edit numberOfClones and DoTransform() if needed.
#  - run ./layout-cloner.py <template-pcb> <baseline> <output>
#    (Elements copied over from the template will have a magic timestamp (0x42))
#  - Edit the output to fix minor issues. After editing, it is possible to
#    remove tracks/zones/graphic elements with ./clean-magic-tstamp.py to
#    create a fresh baseline that does not contain elements copied over from
#    the template. This will be useful for a future iteration.
##

# TODO: specify offset from template to result board (could be part of
#       DoTransform())
# TODO: In KiCAD, implement the concept of a 'session', so that we don't
#       have to create a magic timestamp.

import sys
import re
from pcbnew import *

if len(sys.argv) < 3:
    print "usage: ", sys.argv[0], "<template> <baseline> [<outfile>]"
    exit(1)

templateBoardFile = sys.argv[1]
inputBoardFile = sys.argv[2]
outputBoardFile = sys.argv[3] if len(sys.argv) > 3 else inputBoardFile + ".cloned"

# Don't copy these layers.
excludeLayers = { 44 }  # 44:edge cuts

# Set a magic timestamp so that it is possible to remove copied items later
# identified by this timestamp.
magicTimestamp = 0x42

# TODO: the following templateRefStart, templateRefModulo, numberOfClones,
# and DoTransform() should come from some include file or some sort ?

cloneCount = 4
templateRefStart = 100	 # Starting point of numbering in template
templateRefModulo = 100  # Difference between hierarchical sheets

# This is the function you want to implement do do the transformation.
# 'object' is the object to operate on, operations such as
#    object.Move(wxPoint)  and object.Rotate(wxPoint, angle) are supported
# 'i' is the index of the block; the zero'th block is the template, so the
#    smallest index is 1
def DoTransform(object, i):
    flipOverAt = cloneCount  # simply cloneCount for no-flipping
    move_dx = FromMM(25)
    if i < flipOverAt:
        delta = wxPoint(i * move_dx, 0)
        object.Move(delta)
    else:
        testangle = 1800
        object.Rotate(wxPoint(FromMM(125), FromMM(62.5)), testangle)
        delta = wxPoint(-(i - flipOverAt) * move_dx, 0)
        object.Move(delta)


templateBoard = LoadBoard(templateBoardFile)

# First, extract all the parts we are interested in from the template
# board and remember them.
templateModuleTuples = []
templateZones = []
templateTracks = []
templateDrawings = []

# Find all the modules mentioned in the template area that look like
# they have a proper designator with a number inside the expected range.
# Keep these conveniently preprocessed in a tuple ('R', 100, <module>)
for module in templateBoard.GetModules():
    templateRef = module.GetReference()
    designatorMatch = re.findall(r"(\D+)(\d+)", templateRef)
    if len(designatorMatch) != 1:
        print "Unusual component designator, can't deal with ", templateRef
        continue
    t = designatorMatch.pop(0)
    designatorTuple = t[0], int(t[1]), module    # ('R', 100, <module>)
    if designatorTuple[1] < templateRefStart or designatorTuple[1] >= templateRefStart + templateRefModulo:
        print "Not cloning component ", templateRef, ": designator number out of range"
        continue
    templateModuleTuples.append(designatorTuple)

# .. zones
for i in range(0, templateBoard.GetAreaCount()):
    zone = templateBoard.GetArea(i)
    if zone.GetLayer() not in excludeLayers:
        templateZones.append(zone)

# .. tracks
for track in templateBoard.GetTracks():
    templateTracks.append(track)

# ... and drawings.
for drawing in templateBoard.GetDrawings():
    if drawing.GetLayer() not in excludeLayers:
        templateDrawings.append(drawing)


# We've collected all template elements, let's get to work on the components
# in the input file.

board = LoadBoard(inputBoardFile)
for i in range(0, cloneCount):
    netMapping = {}
    for moduleTuple in templateModuleTuples:
        cloneRef = moduleTuple[0] + str(moduleTuple[1] + i*templateRefModulo)
        cloneModule = board.FindModuleByReference(cloneRef)
        if cloneModule is None:
            print "Couldn't find ", cloneRef, " to place"
            continue

        templateModule = moduleTuple[2];

        if cloneModule.GetLayer() is not templateModule.GetLayer():
            cloneModule.Flip(wxPoint(1,1))
        cloneModule.SetOrientation(templateModule.GetOrientation())

        # The clone module is placed somewhere randomly on the board.
        # To have the following relative transformations work, we move the
        # module to the position of the template module to start.
        cloneModule.SetPosition(templateModule.GetPosition())

        # Font-size, thickness, relative position.
        cloneModule.Reference().SetEffects(templateModule.Reference())
        cloneModule.Value().SetEffects(templateModule.Value())

        DoTransform(cloneModule, i)

        # Build a map of what nets are connected in the original module
        # versus the clone. We need that to connect the right signals to
        # clone-local zones and tracks that have different net-ids.
        for pad in templateModule.Pads():
            clonePad = cloneModule.FindPadByName(pad.GetName())
            if clonePad is None:
                continue     # Mounting holes might have anonymous pads
            netMapping[pad.GetNet().GetNet()] = clonePad.GetNet().GetNet()

    # Now copy all the areas for this clone and connect the appropriate nets.
    # Note, we need to first add the zones and tracks to the board _before_
    # we can set the net, as the availability of the net is tested in the
    # context of the target board which might be different from the template
    # board.
    for zone in templateZones:
        zoneClone = zone.Duplicate()
        DoTransform(zoneClone, i)
        zoneClone.SetTimeStamp(magicTimestamp)
        board.Add(zoneClone)
        if zone.GetNetCode() in netMapping.keys():
            zoneClone.SetNetCode(netMapping[zone.GetNetCode()])

    # Same for tracks.
    for track in templateTracks:
        trackClone = track.Duplicate()
        DoTransform(trackClone, i)
        trackClone.SetTimeStamp(magicTimestamp)
        board.Add(trackClone)
        if track.GetNetCode() in netMapping.keys():
            trackClone.SetNetCode(netMapping[track.GetNetCode()])

    for drawing in templateDrawings:
        drawingClone = drawing.Duplicate()
        DoTransform(drawingClone, i)
        drawingClone.SetTimeStamp(magicTimestamp)
        board.Add(drawingClone)

print "Writing", outputBoardFile
board.Save(outputBoardFile)
