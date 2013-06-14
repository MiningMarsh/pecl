import math as Math
num = 600851475143
pfacts = []
i=2
while True:
	upb = int(Math.sqrt(num))+1
	if num%i == 0:
		num /= i
		pfacts.append(i)
	if i >upb:
		pfacts.append(num)
		break
	i+=1
print(max(pfacts))
