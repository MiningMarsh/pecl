st = ""
counter = 0
for i in range(1,1000001):
	if len(st) >= 1000000:
		break
	st += str(i)
	if counter%300==0:
		print(len(st))
	counter+=1
xs = list(st)
prod = 1
c = 1
for i in range(7):
	prod*=int(xs[c-1])
	c*=10
print prod
