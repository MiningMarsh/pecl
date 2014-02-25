#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>

// Worst primality test ever, but I don't care.
uint64_t differenceOfSquares(uint64_t Num) {
	return (Num*(Num+1)*(3*(Num*Num)-Num-2))/12;
}

int main() {
	printf("%" PRIu64 "\n", differenceOfSquares(100));
	return 0;
}
