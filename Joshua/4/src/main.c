#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool isPalindrome(int Target) {
	int Size = 1;
	int Thing = 9;
	while(Thing < Target) {
		++Size;
		Thing = Thing*10 + 9;
	}
	int Base1 = 1;
	int Base2 = pow(10, Size-1);
	while(Base2 > Base1) {
		if((Target/Base2)%10 != (Target/Base1)%10) {
			return false;
		}
		Base2 /= 10;
		Base1 *=10;
	}
	return true;
}

int main() {
	int Max = 0;
	int Lower = 100; 
	for(int I = 999; I >= Lower; --I) {
		for(int J = 999; J > 99; --J) {
			if(isPalindrome(I*J) && (I*J > Max)) {
				Max = I*J;
				Lower = sqrt(Max);
			}
		}
	}
	printf("%i\n", Max);
	return 0;
}
