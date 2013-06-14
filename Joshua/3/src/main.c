#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

int main() {
	const unsigned long long Target = 600851475143;
	unsigned long long Sqrt = 775147;
	bool* Primes = malloc(Sqrt/sizeof(int));
	if(!Primes) {
		fputs("Memory error.\n", stderr);
		return 1;
	}

	return 0;
}
