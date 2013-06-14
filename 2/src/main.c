#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>

int main() {
	int Total = 2;
	int Last = 1;
	int Current = 2;
	while(Current <= 4000000) {
		int Temp = Last;
		Last = Current;
		Current = Last + Temp;
		if(!(Current%2))
			Total += Current;
	}
	printf("%u\n", Total);
}
