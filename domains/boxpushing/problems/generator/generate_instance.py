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


def getObjects(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    objStr = "(:objects\n"

    if numAgents > 0:
        objStr += "\t"
        for a in range(1, numAgents + 1):
            objStr += "a%s " % a
        objStr += "- agent\n"

    if numSmall > 0:
        objStr += "\t"
        for s in range(1, numSmall + 1):
            objStr += "s%s " % s
        objStr += "- smallbox\n"

    if numMedium > 0:
        objStr += "\t"
        for m in range(1, numMedium + 1):
            objStr += "m%s " % m
        objStr += "- mediumbox\n"

    if numLarge > 0:
        objStr += "\t"
        for l in range(1, numLarge + 1):
            objStr += "l%s " % l
        objStr += "- largebox\n"

    if numRows > 0 and numColumns > 0:
        objStr += "\t"
        for r in range(1, numRows + 1):
            for c in range(1, numColumns + 1):
                objStr += "r%sx%s " % (r, c)
        objStr += "- location\n"

    objStr += ")\n"
    return objStr


def getInit(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    initStr = "(:init\n"

    for a in range(1, numAgents + 1):
        agentRow, agentCol = random.randint(1, numRows), random.randint(1, numColumns)
        initStr += "\t(at a%s r%sx%s)\n" % (a, agentRow, agentCol)

    for s in range(1, numSmall + 1):
        boxRow, boxCol = random.randint(1, numRows), random.randint(1, numColumns)
        initStr += "\t(at s%s r%sx%s)\n" % (s, boxRow, boxCol)

    for m in range(1, numMedium + 1):
        boxRow, boxCol = random.randint(1, numRows), random.randint(1, numColumns)
        initStr += "\t(at m%s r%sx%s)\n" % (m, boxRow, boxCol)

    for l in range(1, numLarge + 1):
        boxRow, boxCol = random.randint(1, numRows), random.randint(1, numColumns)
        initStr += "\t(at l%s r%sx%s)\n" % (l, boxRow, boxCol)

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
    return initStr


def getGoal(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    goalStr = "(:goal (and\n"

    for a in range(1, numAgents + 1):
        agentRow, agentCol = random.randint(1, numRows), random.randint(1, numColumns)
        goalStr += "\t(at a%s r%sx%s)\n" % (a, agentRow, agentCol)

    for s in range(1, numSmall + 1):
        boxRow, boxCol = random.randint(1, numRows), random.randint(1, numColumns)
        goalStr += "\t(at s%s r%sx%s)\n" % (s, boxRow, boxCol)

    for m in range(1, numMedium + 1):
        boxRow, boxCol = random.randint(1, numRows), random.randint(1, numColumns)
        goalStr += "\t(at m%s r%sx%s)\n" % (m, boxRow, boxCol)

    for l in range(1, numLarge + 1):
        boxRow, boxCol = random.randint(1, numRows), random.randint(1, numColumns)
        goalStr += "\t(at l%s r%sx%s)\n" % (l, boxRow, boxCol)

    goalStr += "))\n"
    return goalStr


def getProblemName(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    return "p%s_%s_%s_%s_%s_%s" % (numRows, numColumns, numAgents, numSmall, numMedium, numLarge)


def generateInstance(numRows, numColumns, numAgents, numSmall, numMedium, numLarge):
    pddlStr = "(define (problem %s) (:domain boxpushing)\n" % getProblemName(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)
    pddlStr += getObjects(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)
    pddlStr += getInit(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)
    pddlStr += getGoal(numRows, numColumns, numAgents, numSmall, numMedium, numLarge)
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
