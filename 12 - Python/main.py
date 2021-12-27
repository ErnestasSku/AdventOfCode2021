

def readFile(input):
    file = open(input, "r")
    graph = {}
    for i in file:
        # print(i.split("-"))
        f, s = i.split("-")
        
        s = s.replace("\n", "")

        if f in graph:
            graph[f] = graph[f] + [s]
        else:
            graph[f] = []
            graph[f] = graph[f] + [s]
        if s in graph:
            graph[s] = graph[s] + [f]
        else:
            graph[s] = []
            graph[s] = graph[s] + [f]

    for i in file:
        print(i)    
    # for x in graph:
    #     print(x, graph[x])
    return graph


# Since it asks to find All paths instead of the shortest one, wecan use DFS.
def part1(graph):
    paths = dfs(graph, 'start')
    print(paths)

def dfs(graph, start, visited=None):
    count = 0
    if visited is None:
        visited = set()

    if start == 'end':
        return 1

    if (not start.isupper()):
        visited.add(start)
    
    for next in set(graph[start]) - visited:
        count += dfs(graph, next, visited)
    
    if start in visited:
        visited.remove(start)
    return count

def main():
    data = readFile("input.txt")
    part1(data)

if __name__ == "__main__":
    main()