#!/usr/bin/env python

import sys
from pcbnew import *

if len(sys.argv) < 2:
    print "usage: ", sys.argv[0], "<filename> [<outfile>]"
    exit(1)

magicTimestamp = 0x42

inputBoard = sys.argv[1]
outputBoardFile = sys.argv[2] if len(sys.argv) > 3 else inputBoard + ".cleaned"

board = LoadBoard(inputBoard)

# Remove all items that have the magic timestamp
removeTracks = []
for track in board.GetTracks():
    if track.GetTimeStamp() == magicTimestamp:
        removeTracks.append(track)

removeZones = []
for i in range(0, board.GetAreaCount()):
    zone = board.GetArea(i)
    if zone.GetTimeStamp() == magicTimestamp:
        removeTracks.append(zone)

removeDrawings = []
for drawing in board.GetDrawings():
    if drawing.GetTimeStamp() == magicTimestamp:
        removeDrawings.append(drawing)

for track in removeTracks:
    board.Remove(track)

for zone in removeZones:
    board.Remove(zone)

for drawing in removeDrawings:
    board.Remove(drawing)

print "Writing", outputBoardFile
board.Save(outputBoardFile)
