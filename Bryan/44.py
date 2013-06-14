def pent(n):
	return n*(3*n-1)/2
ps = []
pss = set()
ps.append(0)
last=1001
n_last=1
m = ps[-1]*2
while m==ps[-1]*2:
	for i in range(n_last,last):
		ps.append(pent(i))
		pss.add(pent(i))
	m = ps[-1]*2
	for i in range(n_last+1,last):
		for j in range(1,len(ps)):
			n = abs(ps[i]-ps[j]) 
			if n in pss:
				if n < m and ps[i]+ps[j] in pss:
					m = n
	n_last=last
	last += 500
print(m)
