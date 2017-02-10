import sys

if len(sys.argv) < 2:
    print "Usage: python generate_instance.py <grid-size> <num-agents> <percent-blocked-doors>"
    exit()

gridSize = int(sys.argv[1])
numAgents = int(sys.argv[2])
percentBlocked = float(sys.argv[3])

doorCount = 1
doors = []
rooms = []
for i in range(0, gridSize):
    for j in range(0, gridSize):
        rooms.append((i, j))
        if j + 1 < gridSize:
            doors.append(((i, j), (i, j + 1)))
        if i + 1 < gridSize:
            doors.append(((i, j), (i + 1, j)))

print doors
print rooms
