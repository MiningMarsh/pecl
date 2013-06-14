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

