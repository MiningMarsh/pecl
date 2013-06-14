f = open("triangle.txt","r")
lines = []
for line in f:
    a = []
    for x in line.split(" "):
        a.append(int(x))
    lines.append(a)
for i in range(len(lines)-1):
    line = lines[i]
    v = lines[i+1][:]
    for j in range(len(line)):
        if line[j] + lines[i+1][j] > v[j]:
            v[j] = line[j] + lines[i+1][j]
        if line[j] + lines[i+1][j+1] > v[j+1]:
            v[j+1] = line[j] + lines[i+1][j+1]
    lines[i+1]=v
print(max(lines[-1]))

