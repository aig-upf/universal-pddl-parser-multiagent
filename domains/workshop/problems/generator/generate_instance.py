import sys
from random import randint
import random_connected_graph as rcg

if len(sys.argv) < 6:
    print "Usage: python generate_instance.py <num-agents> <num-pallet> <num-big-rooms> <num-small-rooms-per-big-room> <num-instance>"
    exit()

numAgents = int(sys.argv[1])
numPallet = int(sys.argv[2])
numBigRooms = int(sys.argv[3])
numSmallRooms = int(sys.argv[4])
numInstance = int(sys.argv[5])

edgeSet = []

for i in range(0, numBigRooms):
    nodes = [x for x in range(0, numSmallRooms)]
    graph = rcg.random_walk(nodes, numSmallRooms - 1)

    for edge in graph.edges:
        edgeSet.append(("r%dn%d" % (i, edge[0]), "r%dn%d" % (i, edge[1])))

lockedEdges = []
bigRoomConnections = []
nodes = [x for x in range(0, numBigRooms)]
graph = rcg.random_walk(nodes, numBigRooms - 1)

for r0, r1 in graph.edges:
    n0 = randint(0, numSmallRooms - 1)
    n1 = randint(0, numSmallRooms - 1)
    lockedEdges.append(("r%dn%d" % (r0, n0), "r%dn%d" % (r1, n1)))
    bigRoomConnections.append((r0, r1))

palletLocations = []
for i in range(0, numPallet):
    bigRoom = randint(0, numBigRooms - 1)
    smallRoom = randint(0, numSmallRooms - 1)
    palletLocations.append("r%dn%d" % (bigRoom, smallRoom))

agentLocations = []
forkliftLocations = []

for i in range(0, numAgents, 2):
    bigRoom = randint(0, numBigRooms - 1)
    smallRoomA1 = randint(0, numSmallRooms - 1)
    smallRoomA2 = randint(0, numSmallRooms - 1)
    smallRoomForklift = randint(0, numSmallRooms - 1)
    agentLocations.append("r%dn%d" % (bigRoom, smallRoomA1))
    agentLocations.append("r%dn%d" % (bigRoom, smallRoomA2))
    forkliftLocations.append("r%dn%d" % (bigRoom, smallRoomForklift))

switchLocations = []
switchConnections = []
keyLocations = []
keyFits = []

doorId = len(edgeSet)

for r0, r1 in bigRoomConnections:
    smallRoomKey0 = randint(0, numSmallRooms - 1)
    smallRoomSwitch0 = randint(0, numSmallRooms - 1)
    smallRoomKey1 = randint(0, numSmallRooms - 1)
    smallRoomSwitch1 = randint(0, numSmallRooms - 1)

    switchLocations.append("r%dn%d" % (r0, smallRoomSwitch0))
    switchLocations.append("r%dn%d" % (r1, smallRoomSwitch1))

    keyLocations.append("r%dn%d" % (r0, smallRoomKey0))
    keyLocations.append("r%dn%d" % (r1, smallRoomKey1))

    switchConnections.append("d%d" % doorId)
    switchConnections.append("d%d" % doorId)
    keyFits.append("d%d" % doorId)
    keyFits.append("d%d" % doorId)

    doorId = doorId + 1

""" OUTPUT """

insPddl = "(define (problem workshop%d_%d_%d_%d_%d) (:domain workshop)\n" % (numAgents, numPallet, numBigRooms, numSmallRooms, numInstance)

# objects
insPddl += "(:objects\n"
for i in range(0, numBigRooms):
    for j in range(0, numSmallRooms):
        insPddl += "\tr%dn%d - room\n" % (i, j)

for i in range(0, len(edgeSet) + len(lockedEdges)):
    insPddl += "\td%d - door\n" % (i)

for i in range(0, numPallet):
    insPddl += "\tp%d - pallet\n" % (i)

for i in range(0, numAgents):
    insPddl += "\ta%d - agent\n" % (i)

for i in range(0, numAgents / 2):
    insPddl += "\tf%d - forklift\n" % (i)

for i in range(0, 2 * len(lockedEdges)):
    insPddl += "\tk%d - key\n" % (i)

for i in range(0, 2 * len(lockedEdges)):
    insPddl += "\ts%d - switch\n" % (i)

insPddl += ")\n"

# init
insPddl += "(:init\n"
for i in range(0, len(edgeSet)):
    insPddl += "\t(adjacent %s %s d%d)\n" % (edgeSet[i][0], edgeSet[i][1], i)
    insPddl += "\t(adjacent %s %s d%d)\n" % (edgeSet[i][1], edgeSet[i][0], i)

for i in range(0, len(lockedEdges)):
    insPddl += "\t(adjacent %s %s d%d)\n" % (lockedEdges[i][0], lockedEdges[i][1], i + len(edgeSet))
    insPddl += "\t(adjacent %s %s d%d)\n" % (lockedEdges[i][1], lockedEdges[i][0], i + len(edgeSet))

for i in range(0, len(edgeSet)):
    insPddl += "\t(unlocked d%d)\n" % (i)

for i in range(0, len(lockedEdges)):
    insPddl += "\t(locked d%d)\n" % (i + len(edgeSet))

for i in range(0, numPallet):
    insPddl += "\t(inroom p%d %s)\n" % (i, palletLocations[i])

for i in range(0, numAgents):
    insPddl += "\t(inroom a%d %s)\n" % (i, agentLocations[i])

for i in range(0, numAgents / 2):
    insPddl += "\t(inroom f%d %s)\n" % (i, forkliftLocations[i])

for i in range(0, len(keyLocations)):
    insPddl += "\t(inroom k%d %s)\n" % (i, keyLocations[i])

for i in range(0, len(switchLocations)):
    insPddl += "\t(inroom s%d %s)\n" % (i, switchLocations[i])

for i in range(0, numAgents / 2):
    insPddl += "\t(empty f%d)\n" % (i)

for i in range(0, len(switchConnections)):
    insPddl += "\t(connected s%d %s)\n" % (i, switchConnections[i])

for i in range(0, len(keyFits)):
    insPddl += "\t(fits k%d %s)\n" % (i, keyFits[i])

insPddl += ")\n"

# goal
insPddl += "(:goal (and\n"
for i in range(0, numPallet):
    insPddl += "\t(examined p%d)\n" % (i)
insPddl += "))\n"
insPddl += ")\n"

print insPddl
