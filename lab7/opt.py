# open a file
m = {}
mp = {}
with open('icg.txt', 'r') as f:
    f1 = open('icg_opt.txt', 'w')
    # read a list of lines into data
    data = f.read().splitlines()
    print(data)
    for line in data:
        a, b = line.split('=')
        
        if '+' in b or '-' in b or '*' in b or '/' in b:
            x, y = None, None
            if '+' in b:
                x,y = b.split('+')
            if '-' in b:
                x,y = b.split('-')
            if '*' in b:
                x,y = b.split('*')
            if '/' in b:
                x,y = b.split('/')
            if not(x in mp):
                mp[x] = []
            mp[x].append(b)
            if not(y in mp):
                mp[y] = []
            mp[y].append(b)
        else:
            if not(b in mp):
                mp[b] = []
            mp[b].append(b)
        print(m)
        print(mp)
        if a in mp:
            for i in mp[a]:
                if i in m:
                    m[i] = ""

        if b in m and m[b] != "":
            f1.write(a + '=' + m[b] + '\n')
        else:
            f1.write(a + '=' + b + '\n')
        m[b] = a
    f1.close()

class Node:
    def __init__(self, value):
        self.value = value
        self.children = []

nodes_map = {}

with open('icg_opt.txt', 'r') as f:
    data = f.read().splitlines()

    for line in data:
        a, b = line.split('=')
        if a not in nodes_map:
            nodes_map[a] = Node(a)
        if '+' in b or '-' in b or '*' in b or '/' in b:
            x, y, z = None, None, None
            if '+' in b:
                x,y = b.split('+')
                if x not in nodes_map:
                    nodes_map[x] = Node(x)
                if y not in nodes_map:
                    nodes_map[y] = Node(y)
                z = Node('+')
            if '-' in b:
                x,y = b.split('-')
                if x not in nodes_map:
                    nodes_map[x] = Node(x)
                if y not in nodes_map:
                    nodes_map[y] = Node(y)
                z = Node('-')
            if '*' in b:
                x,y = b.split('*')
                if x not in nodes_map:
                    nodes_map[x] = Node(x)
                if y not in nodes_map:
                    nodes_map[y] = Node(y)
                z = Node('*')
            if '/' in b:
                x,y = b.split('/')
                if x not in nodes_map:
                    nodes_map[x] = Node(x)
                if y not in nodes_map:
                    nodes_map[y] = Node(y)
                z = Node('/')
            nodes_map[a].children.append(z)
            z.children.append(nodes_map[x])
            z.children.append(nodes_map[y])
        else:
            if b not in nodes_map:
                nodes_map[b] = Node(b)
            nodes_map[a].children.append(nodes_map[b])

print("\nDAG: \nAdjacency List:")

# print adjacency list of all nodes
for key, value in nodes_map.items():
    print(key, value.value, end="")
    for child in value.children:
        print(" -> ", child.value, end="")
    print()
   
