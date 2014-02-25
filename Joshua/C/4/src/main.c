#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <math.h>

bool isPalindrome(int Target) {
	int Thing = 9;	
	int Base = 1;
	int Result = 0;
	for(int I = 1; Thing < Target; I++) {
		Result = Result*10 + (Target/Base)%10;
		Base *= 10;
		Thing = Thing*10 + 9;
	}
	Result = Result*10 + (Target/Base)%10;
	return Result == Target;
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
