import sys
from random import randint
import random_connected_graph as rcg

if len(sys.argv) < 7:
	print "Usage: python generate.py <num-nodes> <num-edges> <num-blocks> <num-agents> <num-tables> <instance-number>"
	exit()

#print "Generating tablemover problem..."

numNodes = int(sys.argv[1])
numEdges = int(sys.argv[2])
numBlocks = int(sys.argv[3])
numAgents = int(sys.argv[4])
numTables = int(sys.argv[5])
instanceNumber = int(sys.argv[6])

#print "Number of nodes:", numNodes
#print "Number of edges:", numEdges
#print "Number of blocks:", numBlocks
#print "Number of agents:", numAgents
#print "Numver of tables:", numTables

nodes = [x for x in range(0, numNodes)]

graph = rcg.random_walk(nodes, numEdges)
edges = graph.edges

blocksLoc = [0] * numBlocks
for i in range(0, numBlocks):
	blocksLoc[i] = randint(0, numNodes - 1)

agentsLoc = [0] * numAgents
tablesLoc = [0] * numTables

for i in range(0, numTables):
	tablesLoc[i] = randint(0, numNodes - 1)
	for j in range(2 * i, 2 * i + 2):
		agentsLoc[j] = tablesLoc[i]


finalLoc = randint(0, numNodes - 1)

problemName = "table" + str(numNodes) + "_" + str(numBlocks) + "_" + str(numTables) + "_" + str(instanceNumber)

insPddl = "(define (problem " + problemName + ") (:domain tablemover)\n"

insPddl += "(:objects\n"
for i in range(0, numAgents):
	insPddl += "\ta" + str(i) + " - agent\n"
for i in range(0, numBlocks):
	insPddl += "\tb" + str(i) + " - block\n"
for i in range(0, numNodes):
	insPddl += "\tr" + str(i) + " - room\n"
for i in range(0, numTables):
	insPddl += "\tleft" + str(i) + " right" + str(i) + " - side" + str(i) + "\n"
insPddl += ")\n"

insPddl += "(:init\n"
for i in range(0, numBlocks):
	insPddl += "\t(on-floor b" + str(i) + ")\n"
for i in range(0, numBlocks):
	insPddl += "\t(inroom b" + str(i) + " r" + str(blocksLoc[i]) + ")\n"
for i in range(0, numAgents):
	insPddl += "\t(inroom a" + str(i) + " r" + str(agentsLoc[i]) + ")\n"
for i in range(0, numAgents):
	insPddl += "\t(available a" + str(i) + ")\n"
for i in range(0, numAgents):
	insPddl += "\t(handempty a" + str(i) + ")\n"
for i in range(0, len(edges)):
	origin, desti = edges[i]
	insPddl += "\t(connected r" + str(origin) + " r" + str(desti) + ")\n"
	insPddl += "\t(connected r" + str(desti) + " r" + str(origin) + ")\n"
for i in range(0, numTables):
	insPddl += "\t(down left" + str(i) + ")\n"
	insPddl += "\t(down right" + str(i) + ")\n"
for i in range(0, numTables):
	insPddl += "\t(clear left" + str(i) + ")\n"
	insPddl += "\t(clear right" + str(i) + ")\n"
for i in range(0, numTables):
	insPddl += "\t(inroom Table" + str(i) + " r" + str(tablesLoc[i]) + ")\n"
insPddl += ")\n"

insPddl += "(:goal (and\n"
for i in range(0, numTables):
	insPddl += "\t(down left" + str(i) + ")\n"
	insPddl += "\t(down right" + str(i) + ")\n"
for i in range(0, numBlocks):
	insPddl += "\t(on-floor b" + str(i) + ")\n"
for i in range(0, numBlocks):
	insPddl += "\t(inroom b" + str(i) + " r" + str(finalLoc) + ")\n"

insPddl += "))\n"
insPddl += ")"

print insPddl

#with open(problemName + ".pddl", 'w') as f:
#	f.write(insPddl)
