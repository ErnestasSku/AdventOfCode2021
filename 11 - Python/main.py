
def readFile(input):
    f = open(input, "r")
    l = []
    for x in f:
        l.append([int(i) for i in x if i != "\n"])
    return l

pos = lambda x, y : [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1), (x + 1, y + 1), (x + 1, y - 1), (x - 1, y + 1), (x - 1, y - 1)]

def part1(steps, grid):
    
    flashes = 0
    for i in range(steps):
        newGrid = []
        #increment by one
        for g in grid:
            res = map(lambda x: x + 1, g)
            newGrid.append(list(res))
        
        grid = newGrid
        
        toFlash = [(x, y) 
                   for x in range(10) for y in range(10)
                   if newGrid[x][y] > 9]
        
        p = 0
        while p < len(toFlash):
            x, y = toFlash[p]
            p += 1
            if grid[x][y] != '#':
                flashes += 1
            
            grid[x][y] = '#'
            toDecrement = pos(x, y)
            valid = [(u, v) for (u, v) in toDecrement if (u >= 0 and v >= 0 and u < 10 and v < 10) ]
            # print(valid)
            for v in valid:
                if grid[v[0]][v[1]] != '#':
                    grid[v[0]][v[1]] += 1
                   
            t = [ (u, v) for u in range(10) for v in range(10) 
                         if  grid[u][v] != '#' and (grid[u][v] > 9 and (not (u, v) in toFlash))  ]  

            toFlash = toFlash + t   

        for i in range(10):
            for j in range(10):
                if grid[i][j] == '#':
                    grid[i][j] = 0
    
    print(flashes)

def part2(grid):
    
    finalState = [[0 for k in range(10)] for i in range(10)]

    step = 0
    while grid != finalState:
        step += 1
        
        newGrid = []
        for g in grid:
            res = map(lambda x: x + 1, g)
            newGrid.append(list(res))
        
        grid = newGrid
        
        toFlash = [(x, y) 
                   for x in range(10) for y in range(10)
                   if newGrid[x][y] > 9]
        p = 0
        while p < len(toFlash):
            x, y = toFlash[p]
            p += 1
            
            grid[x][y] = '#'
            toDecrement = pos(x, y)
            valid = [(u, v) for (u, v) in toDecrement if (u >= 0 and v >= 0 and u < 10 and v < 10) ]
            # print(valid)
            for v in valid:
                if grid[v[0]][v[1]] != '#':
                    grid[v[0]][v[1]] += 1
                   
            t = [ (u, v) for u in range(10) for v in range(10) 
                         if  grid[u][v] != '#' and (grid[u][v] > 9 and (not (u, v) in toFlash))  ]  

            toFlash = toFlash + t   

        for i in range(10):
            for j in range(10):
                if grid[i][j] == '#':
                    grid[i][j] = 0
    print(step)       

        

def main():
    grid = readFile("input.txt")
    
    part1(100, grid)
    part2(grid)    
       
if __name__ == "__main__":
    main()