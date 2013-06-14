#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

bool isPalindrome(int Target) {
	char String[7]; // Ugly hack to improve performance for this test.
	int Last = sprintf(String, "%i", Target);
	if(--Last < 0) {
		fputs("Error testing for palindromeinity.\n",stderr);
		exit(1);
	}
	for(int Index = 0; Index <= Last/2; ++Index)
		if(String[Index] != String[Last-Index])
			return false;
	return true;
}

int main() {
	int Max = 0;
	for(int I = 999; I > 99; --I) {
		for(int J = 999; J > 99; --J) {
			if(isPalindrome(I*J) && (I*J > Max)) {
				Max = I*J;
			}
		}
	}
	printf("%i\n", Max);
	return 0;
}
