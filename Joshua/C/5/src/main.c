#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>

// Worst primality test ever, but I don't care.
bool isDiv(uint64_t Num) {
	for(uint64_t Current = 1; Current <= 20; ++Current) {
		if(Num%Current) {
			return false;
		}
	}
	return true;
}

int main() {
	uint64_t Current = 1;
	while(!isDiv(++Current));
	printf("%" PRIu64 "\n", Current);
	return 0;
}
