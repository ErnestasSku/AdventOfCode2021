def readFile(input):
    f = open(input, "r")
    l = []
    for x in f:
        l.append(x)
    return l

pos = lambda x, y: ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)) 

def part1(list):
    sum = 0
    for x in range(len(list)):
        for y in range(len(list[x]) - 1):
            toCheck = pos(x, y)
            valid = [x for x in toCheck if (x[0] >= 0 and x[1] >= 0 and 
                                            x[0] < len(list[0]) - 1 and x[1] < len(list[0]) - 1) and
                                            x[0] < len(list) ]

            low = True
            for i in valid:
                if(list[x][y] >= list[i[0]][i[1]]):
                    low = False
            if (low):
                sum += int(list[x][y]) + 1
    print(sum)

def part2(list):
    lowPoints = []
    for x in range(len(list)):
        for y in range(len(list[x]) - 1):
            toCheck = pos(x, y)
            valid = [x for x in toCheck if (x[0] >= 0 and x[1] >= 0 and 
                                            x[0] < len(list[0]) - 1 and x[1] < len(list[0]) - 1) and
                                            x[0] < len(list) ]

            low = True
            for i in valid:
                if(list[x][y] >= list[i[0]][i[1]]):
                    low = False
            if (low):
                lowPoints.append((x, y))
    # print(lowPoints)
    
    all = []
    for i in lowPoints:
        x, y = i
        all.append(bfsLike(list, i))

    all.sort(reverse=True)
    top = all[:3]
    ans = 1
    for i in top:
        ans *= i
    print(ans)


def bfsLike(map, pos):
    
    size = 0
    x, y = pos
    
    if ((x >= 0 and y >= 0 and x < len(map[0]) - 1 and y < len(map[0]) - 1) and x < len(map)):
        if map[x][y] != "#" and map[x][y] < "9":
            size = 1
            l1 = list(map[x])
            l1[y] = "#"
            map[x] = "".join(l1)
            size += bfsLike(map, (x - 1, y))
            size += bfsLike(map, (x + 1, y))
            size += bfsLike(map, (x, y + 1))
            size += bfsLike(map, (x, y - 1))
    return size
        

    


def main():
    list = readFile("input.txt")
    part1(list)
    part2(list)

if __name__ == "__main__":
    main()