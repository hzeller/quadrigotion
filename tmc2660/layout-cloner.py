#!/usr/bin/env python

# Clone an input PCB file that has an area marked to be cloned to
# an output file.
#
# Basic ops to get a template
#  - Create blocks annotated with multiples 100 ./create-blocks-from-template.sh
#  - Use these in schematic. Name each sheet TMC2660-100, TMC2660-200, ...
#  - Create a clean slate *.kicad_pcb by starting from the template:
#      cp template/tmc2660-mono.kicad_pcb tmc2660-quad.kicad_pcb
#  - The template only contains the layout for 100. Now in pcbnew update
#    from schematic to import the wire-connected components for
#    block 200,300,...
#  - modify layout-cloner: edit numberOfClones and DoTransform()
#  - run ./layout-cloner.py <filename>; Verify that the cloned blocks look good.
#  - copy the cloned kicad_pcb to the main kicad pcb and edit from there,
#    wiring up the rest.
#
# Original inspired by https://github.com/tlantela/KiCAD_layout_cloner but
# with fixes to net assignment and copying drawings. TODO: send pull request.
#
import sys
import re
from pcbnew import *

if len(sys.argv) < 2:
    print "usage: ", sys.argv[0], "<filename> [<outfile>]"
    exit(1)

inputBoard = sys.argv[1]
outputBoardFile = sys.argv[2] if len(sys.argv) > 2 else inputBoard + ".cloned"

# Don't copy these layers.
excludeLayers = { 41, 44 }  # comment; edge cuts


templateRefStart = 100	 # Starting point of numbering in template
templateRefModulo = 100  # Difference between hierarchical sheets

numberOfClones = 4

# This is the function you want to implement do do the transformation.
# 'object' is the object to operate on, operations such as
#    object.Move(wxPoint)  and object.Rotate(wxPoint, angle) are supported
# 'i' is the index of the block; the zero'th block is the template, so the
#    smallest index is 1
def DoTransform(object, i):
    flipOverAt = numberOfClones / 2  # simply numberOfClones for no-flipping
    move_dx = FromMM(25)
    if i < flipOverAt:
        delta = wxPoint(i * move_dx, 0)
        object.Move(delta)
    else:
        testangle = 1800
        object.Rotate(wxPoint(FromMM(125), FromMM(62.5)), testangle)
        delta = wxPoint(-(i - flipOverAt) * move_dx, 0)
        object.Move(delta)


board = LoadBoard(inputBoard)

# All the objects we extract from the template zone
templateModuleTuples = []
templateZones = []
templateTracks = []
templateDrawings = []
templateRect = None

# First, find the area on the board where we are looking for templates
# to clone. This is marked as a comment zone
for i in range(0, board.GetAreaCount()):
    zone = board.GetArea(i)
    if zone.GetLayer() == 41:
        templateRect = zone.GetBoundingBox()

if templateRect is None:
    print "Please put section to be cloned in a comment zone"
    exit(1)

print 'Cloning board found between ', templateRect.GetOrigin(), ' width: ', templateRect.GetWidth(), ' height: ', templateRect.GetHeight()

# Find all the modules mentioned in that template area that look like
# they have a proper designator with a number inside the expected range.
# Keep these conveniently preprocessed in a tuple ('R', 100, <module>)
for module in board.GetModules():
    if module.HitTest(templateRect):
        templateRef = module.GetReference()
        designatorMatch = re.findall(r"(\D+)(\d+)", templateRef)
        if len(designatorMatch) != 1:
            print "Unusual component designator, can't clone ", templateRef
            continue
        t = designatorMatch.pop(0)
        designatorTuple = t[0], int(t[1]), module    # ('R', 100, <module>)
        if designatorTuple[1] < templateRefStart or designatorTuple[1] >= templateRefStart + templateRefModulo:
            print "Not cloning component ", templateRef, ": designator number out of range"
            continue
        templateModuleTuples.append(designatorTuple)

# .. zones
for i in range(0, board.GetAreaCount()):
    zone = board.GetArea(i)
    if zone.GetLayer() not in excludeLayers and templateRect.Contains(zone.GetPosition()):
        templateZones.append(zone)

# .. tracks
boardTracks = board.GetTracks()
for track in boardTracks:
    if track.HitTest(templateRect):
        templateTracks.append(track)

# ... and drawings.
for drawing in board.GetDrawings():
    if drawing.GetLayer() not in excludeLayers and templateRect.Contains(drawing.GetBoundingBox()):
        templateDrawings.append(drawing)

# We've collected all template elements, now create clones from it.
for i in range(1, numberOfClones):
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

        # The clone module is placed somewhere on the canvas.
        # To have the following relative transformations work, we move the
        # module to the position of the template module to start.
        cloneModule.SetPosition(templateModule.GetPosition())

        # Font-size, thickness, relative position.
        cloneModule.Reference().SetEffects(templateModule.Reference())
        cloneModule.Value().SetEffects(templateModule.Value())

        DoTransform(cloneModule, i)

        # Build a map of what nets are connected in the original module
        # versus the clone. We need that later to connect the right signals
        # to clone-local zones and tracks
        for pad in templateModule.Pads():
            clonePad = cloneModule.FindPadByName(pad.GetName())
            if clonePad is None:
                continue     # Mounting holes might have anonymous pads
            netMapping[pad.GetNet().GetNet()] = clonePad.GetNet().GetNet()

    # Now copy all the areas for this clone and connect the appropriate nets
    for zone in templateZones:
        zoneClone = zone.Duplicate()
        DoTransform(zoneClone, i)
        if zone.GetNetCode() in netMapping.keys():
            zoneClone.SetNetCode(netMapping[zone.GetNetCode()])
        board.Add(zoneClone)

    # Same for tracks.
    for track in templateTracks:
        trackClone = track.Duplicate()
        DoTransform(trackClone, i)
        if track.GetNetCode() in netMapping.keys():
            trackClone.SetNetCode(netMapping[track.GetNetCode()])
        boardTracks.Append(trackClone)

    for drawing in templateDrawings:
        drawingClone = drawing.Duplicate()
        DoTransform(drawingClone, i)
        board.Add(drawingClone)

board.Save(outputBoardFile)
print "Writing", outputBoardFile
