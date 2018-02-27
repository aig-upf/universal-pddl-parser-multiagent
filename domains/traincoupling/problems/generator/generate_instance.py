#! /usr/bin/env python

import argparse
import random


def getArguments():
    argParser = argparse.ArgumentParser()
    argParser.add_argument("size", type=int, help="lateral size of a squared grid")
    argParser.add_argument("locomotive", type=int, help="number of locomotives")
    argParser.add_argument("wagons", type=int, help="number of wagons")
    argParser.add_argument("tracks", type=int, help="number of tracks between adjacent cells in the grid")
    return argParser.parse_args()


def getProblemName(gridSize, numLocomotives, numWagons, numTracks):
    return "p%s_%s_%s_%s" % (gridSize, numLocomotives, numWagons, numTracks)


def getTotalTracks(gridSize, numTracks):
    # numTracks = number of tracks shared between two adjacent yards
    totalNumTracks = ((gridSize - 2) ** 2) * 4 * numTracks  # inner tracks
    totalNumTracks += 4 * (2 * numTracks)  # corners
    totalNumTracks += 4 * (gridSize - 2) * (3 * numTracks)  # laterals (without corners)
    return totalNumTracks


def getObjectsForType(objType, objPrefix, numObjects):
    objStr = ""
    if numObjects > 0:
        objStr += "\t"
        for o in range(1, numObjects + 1):
            objStr += "%s%s " % (objPrefix, o)
        objStr += "- %s\n" % objType
    return objStr


def getObjects(gridSize, numLocomotives, numWagons, numTracks):
    objStr = "(:objects\n"
    objStr += getObjectsForType("locomotive", "l", numLocomotives)
    objStr += getObjectsForType("wagon", "w", numWagons)
    objStr += getObjectsForType("track", "t", getTotalTracks(gridSize, numTracks))

    if gridSize > 0:
        objStr += "\t"
        for r in range(1, gridSize + 1):
            for c in range(1, gridSize + 1):
                objStr += "y%sx%s " % (r, c)
        objStr += "- yard\n"

    objStr += ")\n"
    return objStr


def getInitForObjects(objPrefix, numObjects, gridSize, objLocations):
    initStr = ""
    for o in range(1, numObjects + 1):
        objName = "%s%s" % (objPrefix, o)
        objRow, objCol = random.randint(1, gridSize), random.randint(1, gridSize)
        initStr += "\t(at-yard %s y%sx%s)\n" % (objName, objRow, objCol)
        objLocations[objName] = (objRow, objCol)
    return initStr


def getInit(gridSize, numLocomotives, numWagons, numTracks):
    initialLocations = {}
    initStr = "(:init\n"
    initStr += getInitForObjects("l", numLocomotives, gridSize, initialLocations)
    initStr += getInitForObjects("w", numWagons, gridSize, initialLocations)

    for w in range(1, numWagons + 1):
        initStr += "\t(unattached w%s)\n" % w

    trackId = 1
    for r in range(1, gridSize + 1):
        for c in range(1, gridSize + 1):
            if r > 1:
                for i in range(0, numTracks):
                    initStr += "\t(has-track t%s y%sx%s y%sx%s)\n" % (trackId, r, c, r - 1, c)
                    trackId += 1
            if r < gridSize:
                for i in range(0, numTracks):
                    initStr += "\t(has-track t%s y%sx%s y%sx%s)\n" % (trackId, r, c, r + 1, c)
                    trackId += 1
            if c > 1:
                for i in range(0, numTracks):
                    initStr += "\t(has-track t%s y%sx%s y%sx%s)\n" % (trackId, r, c, r, c - 1)
                    trackId += 1
            if c < gridSize:
                for i in range(0, numTracks):
                    initStr += "\t(has-track t%s y%sx%s y%sx%s)\n" % (trackId, r, c, r, c + 1)
                    trackId += 1

    initStr += ")\n"
    return initStr, initialLocations


def getGoalForObjects(objPrefix, numObjects, gridSize, objLocations):
    goalStr = ""
    for o in range(1, numObjects + 1):
        objName = "%s%s" % (objPrefix, o)
        objRow, objCol = 0, 0
        while objRow < 1 or objCol < 1 or (objRow, objCol) == objLocations[objName]:
            objRow, objCol = random.randint(1, gridSize), random.randint(1, gridSize)
        goalStr += "\t(at-yard %s y%sx%s)\n" % (objName, objRow, objCol)
    return goalStr


def getGoal(gridSize, numWagons, initialLocations):
    goalStr = "(:goal (and\n"
    goalStr += getGoalForObjects("w", numWagons, gridSize, initialLocations)
    for w in range(1, numWagons + 1):
        goalStr += "\t(unattached w%s)\n" % w
    goalStr += "))\n"
    return goalStr


def generateInstance(gridSize, numLocomotives, numWagons, numTracks):
    pddlStr = "(define (problem %s) (:domain traincoupling)\n" % getProblemName(gridSize, numLocomotives, numWagons, numTracks)
    pddlStr += getObjects(gridSize, numLocomotives, numWagons, numTracks)

    initStr, initialLocations = getInit(gridSize, numLocomotives, numWagons, numTracks)
    pddlStr += initStr

    pddlStr += getGoal(gridSize, numWagons, initialLocations)
    pddlStr += ")\n"
    return pddlStr


if __name__ == "__main__":
    argParser = getArguments()
    pddlStr = generateInstance(argParser.size, \
                               argParser.locomotive, \
                               argParser.wagons, \
                               argParser.tracks)
    problemName = getProblemName(argParser.size, \
                                 argParser.locomotive, \
                                 argParser.wagons, \
                                 argParser.tracks)

    with open("%s.pddl" % problemName, 'w') as f:
        f.write(pddlStr)
