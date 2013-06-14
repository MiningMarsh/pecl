def fth(n):
	return n*n*n*n*n
ns = []
for i in range(10000001):
	n = sum(map(fth,map(int,list(str(i)))))
	if n == i:
		ns.append(i)
		print i
print sum(ns)
