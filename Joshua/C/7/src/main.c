#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>

// Worst primality test ever, but I don't care.
bool isPrime(uint64_t Num) {
	for(uint64_t Current = 2; Current < Num; ++Current) {
		if(!(Num%Current)) {
			return false;
		}
	}
	return true;
}

int main() {
	uint64_t Current = 2;
	uint64_t Level = 0;
	while(Level != 10001) {
		if(isPrime(Current)) {
			++Level;
		}
		++Current;
	}
	--Current;
	printf("%" PRIu64 "\n", Current);
	return 0;
}
