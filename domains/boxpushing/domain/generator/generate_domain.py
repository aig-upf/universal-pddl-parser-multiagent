#! /usr/bin/env python

import argparse
import itertools

def getArguments():
    argParser = argparse.ArgumentParser()
    argParser.add_argument("size", type=int, help="maximum size of a box")
    argParser.add_argument("--single-agent", "-s", dest="singleagent", action="store_true", help="create single agent domain")
    argParser.set_defaults(singleagent=False)
    return argParser.parse_args()


def getTypes(maxBoxSize):
    typeStr = "(:types box agent - locatable"

    for i in range(1, maxBoxSize + 1):
        typeStr += " bsize%d" % i
    typeStr += " - box"

    typeStr += " location)\n"
    return typeStr


def getPredicates():
    predStr = "(:predicates\n"
    predStr += "\t(at ?l - locatable ?x - location)\n"
    predStr += "\t(connected ?x - location ?y - location)\n"
    predStr += ")\n"
    return predStr


def getActions(maxBoxSize, singleAgent):
    if singleAgent:
        actionStr = "(:action move\n"
        actionStr += "\t:parameters (?a - agent ?x - location ?y - location)\n"
        actionStr += "\t:precondition (and (at ?a ?x) (connected ?x ?y))\n"
        actionStr += "\t:effect	(and (at ?a ?y) (not (at ?a ?x)))\n"
        actionStr += ")\n"

        for i in range(1, maxBoxSize + 1):
            boxType = "bsize%d" % i
            actionStr += "(:action push-%s\n" % boxType

            actionStr += "\t:parameters ("
            for j in range(1, i + 1):
                actionStr += "?a%d - agent ?b%d - %s ?x%d ?y%d - location " % (j, j, boxType, j, j)
            actionStr += ")\n"

            actionStr += "\t:precondition (and\n"
            for j in range(1, i + 1):
                actionStr += "\t\t(at ?a%d ?x%d) (at ?b%d ?x%d) (connected ?x%d ?y%d)\n" % (j, j, j, j, j, j)
                if j > 1:
                    actionStr += "\t\t(not (= ?a%d ?a%d)) (= ?b%d ?b%d) (= ?x%d ?x%d) (= ?y%d ?y%d)\n" % (j - 1, j, j - 1, j, j - 1, j, j - 1, j)
            actionStr += "\t)\n"

            actionStr += "\t:effect (and\n"
            for j in range(1, i + 1):
                actionStr += "\t\t(at ?a%d ?y%d) (at ?b%d ?y%d) (not (at ?a%d ?x%d)) (not (at ?b%d ?x%d))\n" % (j, j, j, j, j, j, j, j)
            actionStr += "\t)\n"

            actionStr += ")\n"
    else:
        actionStr = "(:action move\n"
        actionStr += "\t:agent ?a - agent\n"
        actionStr += "\t:parameters (?x - location ?y - location)\n"
        actionStr += "\t:precondition (and (at ?a ?x) (connected ?x ?y))\n"
        actionStr += "\t:effect	(and (at ?a ?y) (not (at ?a ?x)))\n"
        actionStr += ")\n"

        for i in range(1, maxBoxSize + 1):
            boxType = "bsize%d" % i
            actionStr += "(:action push-%s\n" % boxType
            actionStr += "\t:agent ?a - agent\n"
            actionStr += "\t:parameters (?b - %s ?x - location ?y - location)\n" % boxType
            actionStr += "\t:precondition (and (at ?a ?x) (at ?b ?x) (connected ?x ?y)"

            if i > 1:
                actionStr += " (exists ("
                for j in range(2, i + 1):
                    actionStr += "?a%d - agent " % j
                actionStr += ") (and "
                for x in itertools.combinations(range(2, i + 1), 2):
                    actionStr += "(not (= ?a%d ?a%d))" % x
                for j in range(2, i + 1):
                    actionStr += "(not (= ?a ?a%d)) (push-%s ?a%d ?b ?x ?y) " % (j, boxType, j)
                actionStr += "))"
            actionStr += ")\n"

            actionStr += "\t:effect	(and (at ?a ?y) (at ?b ?y) (not (at ?a ?x)) (not (at ?b ?x))))\n"

    return actionStr


def generateDomain(maxBoxSize, singleAgent):
    pddlStr = "(define (domain boxpushing)\n"
    pddlStr += "(:requirements :typing"
    if not singleAgent:
        pddlStr += " :multi-agent"
    pddlStr += ")\n"
    pddlStr += getTypes(maxBoxSize)
    pddlStr += getPredicates()
    pddlStr += getActions(maxBoxSize, singleAgent)
    pddlStr += ")\n"
    return pddlStr


if __name__ == "__main__":
    argParser = getArguments()

    domainName = "domain%d.pddl" % argParser.size

    with open(domainName, 'w') as f:
        f.write(generateDomain(argParser.size, argParser.singleagent))
