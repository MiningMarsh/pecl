from helpermodules import prime
ps = set()
for i in range(1000,10000):
	if prime(i):
		ps.add(i)
mat = []
for jl in range(1,3333):
	for start in ps:
		if start + jl in ps and start+jl*2 in ps:
			mat.append((str(start),str(start+jl),str(start+2*jl)))

def are_permut2(x,y):
	e = {}
	for l in y:
		e[l]=0
	for l in y:
		e[l]+=1
	for l in x:
		if not l in e:
			return False
		else:
			e[l] -= 1
	for k in e:
		if e[k] != 0:
			return False
	return True

def are_permut3(tr):
	if are_permut2(tr[0],tr[1]) and are_permut2(tr[1],tr[2]):
		return True
	return False

for tr in mat:
	if are_permut3(tr):
		print tr
