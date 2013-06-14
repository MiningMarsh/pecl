##RATHER DUMB SOLUTION
##STILL RUNS IN SUPER SPEED!
x = set()
for i in range(2,101):
	for j in range(2,101):
		x.add(i**j)
print len(x)
