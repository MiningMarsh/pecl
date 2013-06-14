from math import sqrt
def prime(n):
	if n==2 or n == 3:
		return True
	if n % 2 == 0:
		return False
	for i in range(3,int(sqrt(n))+1,2):
		if n % i == 0:
			return False
	return True
p = []
for i in range(2,5000):
	if prime(i):
		p.append(i)
print p[:20]
xs = set()
for i in range(1,3000):
	for j in p:
		xs.add(j+2*(i**2))
oddc = set()
for i in range(3,6000,2):
	if not prime(i):
		oddc.add(i)
print min(list(oddc-xs))
