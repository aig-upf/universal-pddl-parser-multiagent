#! /usr/bin/env python

import argparse
import random


def getArguments():
    argParser = argparse.ArgumentParser()
    argParser.add_argument("rows", type=int, help="number of rows in the grid")
    argParser.add_argument("columns", type=int, help="number of columns in the grid")
    argParser.add_argument("agents", type=int, help="number of agents")
    argParser.add_argument("small", type=int, help="number of small boxes")
    argParser.add_argument("medium", type=int, help="number of medium boxes")
    argParser.add_argument("large", type=int, help="number of large boxes")
    return argParser.parse_args()


def getObjectsForType(objType, objPrefix, numObjects):
    objStr = ""
    if numObjects > 0:
        objStr += "\t"
        for o in range(1, numObjects + 1):
            objStr += "%s%s " % (objPrefix, o)
        objStr += "- %s\n" % objType
    return objStr


def getObjects(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    objStr = "(:objects\n"
    objStr += getObjectsForType("agent", "a", numAgents)
    objStr += getObjectsForType("smallbox", "s", numSmall)
    objStr += getObjectsForType("mediumbox", "m", numMedium)
    objStr += getObjectsForType("largebox", "l", numLarge)

    if numRows > 0 and numColumns > 0:
        objStr += "\t"
        for r in range(1, numRows + 1):
            for c in range(1, numColumns + 1):
                objStr += "r%sx%s " % (r, c)
        objStr += "- location\n"

    objStr += ")\n"
    return objStr


def getInitForObjects(objPrefix, numObjects, numRows, numColumns, objLocations):
    initStr = ""
    for o in range(1, numObjects + 1):
        objName = "%s%s" % (objPrefix, o)
        objRow, objCol = random.randint(1, numRows), random.randint(1, numColumns)
        initStr += "\t(at %s r%sx%s)\n" % (objName, objRow, objCol)
        objLocations[objName] = (objRow, objCol)
    return initStr


def getGoalForObjects(objPrefix, numObjects, numRows, numColumns, objLocations):
    goalStr = ""
    for o in range(1, numObjects + 1):
        objName = "%s%s" % (objPrefix, o)
        objRow, objCol = 0, 0
        while objRow < 1 or objCol < 1 or (objRow, objCol) == objLocations[objName]:
            objRow, objCol = random.randint(1, numRows), random.randint(1, numColumns)
        goalStr += "\t(at %s r%sx%s)\n" % (objName, objRow, objCol)
    return goalStr


def getInit(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    initialLocations = {}

    initStr = "(:init\n"
    initStr += getInitForObjects("a", numAgents, numRows, numColumns, initialLocations)
    initStr += getInitForObjects("s", numSmall, numRows, numColumns, initialLocations)
    initStr += getInitForObjects("m", numMedium, numRows, numColumns, initialLocations)
    initStr += getInitForObjects("l", numLarge, numRows, numColumns, initialLocations)

    for r in range(1, numRows + 1):
        for c in range(1, numColumns + 1):
            if r > 1:
                initStr += "\t(connected r%sx%s r%sx%s)\n" % (r, c, r - 1, c)
            if r < numRows:
                initStr += "\t(connected r%sx%s r%sx%s)\n" % (r, c, r + 1, c)
            if c > 1:
                initStr += "\t(connected r%sx%s r%sx%s)\n" % (r, c, r, c - 1)
            if c < numColumns:
                initStr += "\t(connected r%sx%s r%sx%s)\n" % (r, c, r, c + 1)

    initStr += ")\n"
    return initStr, initialLocations


def getGoal(numRows, numColumns, numAgents, numSmall, numMedium, numLarge, initialLocations):
    goalStr = "(:goal (and\n"
    # goalStr += getGoalForObjects("a", numAgents, numRows, numColumns, initialLocations)
    goalStr += getGoalForObjects("s", numSmall, numRows, numColumns, initialLocations)
    goalStr += getGoalForObjects("m", numMedium, numRows, numColumns, initialLocations)
    goalStr += getGoalForObjects("l", numLarge, numRows, numColumns, initialLocations)
    goalStr += "))\n"
    return goalStr


def getProblemName(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    return "p%s_%s_%s_%s_%s_%s" % (numRows, numColumns, numAgents, numSmall, numMedium, numLarge)


def generateInstance(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    pddlStr = "(define (problem %s) (:domain boxpushing)\n" % getProblemName(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)
    pddlStr += getObjects(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)

    initStr, initialBoxLocations= getInit(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)
    pddlStr += initStr

    pddlStr += getGoal(numRows, numColumns, numAgents, numSmall, numMedium, numLarge, initialBoxLocations)
    pddlStr += ")\n"

    return pddlStr


if __name__ == "__main__":
    argParser = getArguments()
    pddlStr = generateInstance(argParser.rows, \
                               argParser.columns, \
                               argParser.agents, \
                               argParser.small, \
                               argParser.medium, \
                               argParser.large)
    problemName = getProblemName(argParser.rows, \
                                 argParser.columns, \
                                 argParser.agents, \
                                 argParser.small, \
                                 argParser.medium, \
                                 argParser.large)

    with open("%s.pddl" % problemName, 'w') as f:
        f.write(pddlStr)
