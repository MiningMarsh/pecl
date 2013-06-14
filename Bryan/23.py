import math as Math
def factor(n):
	res=[]
	for i in range(1,int(Math.sqrt(n))+1):
		if n%i == 0:
			res.append(i)
			res.append(n/i)
	return list(set(res)-set([n]))
nums = set(list(range(1,28123)))
abunsums = set()
def abundant(n):
	if sum(factor(n)) > n:
		return True
	return False
abu = []
for i in range(12,28123):
	if abundant(i):
		abu.append(i)
for i in range(len(abu)):
	for j in range(i,len(abu)):
		if abu[i]+abu[j]>28123:
			break
		abunsums.add(abu[i]+abu[j])
print(sum(list(nums-abunsums)))
