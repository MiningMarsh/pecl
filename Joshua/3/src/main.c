#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

int main() {
	const unsigned long long Target = 600851475143;
	unsigned long long Sqrt = 775147;
	bool* Primes = malloc(Sqrt*sizeof(bool));
	if(!Primes) {
		fputs("Memory error.\n", stderr);
		return 1;
	}

	for(unsigned long long Index = 0; Index < Sqrt; ++Index)
		Primes[Index] = true;

	for(unsigned long long ToTest = 2; ToTest < Sqrt; ++ToTest)
		for(unsigned long long Index = 2; Index*ToTest < Sqrt; ++Index)
			Primes[Index*ToTest] = false;

	for(unsigned long long Index = Sqrt - 1; Index >= 0; --Index)
		if(Primes[Index] && !(Target%Index)) {
			printf("%llu\n", Index);
			free(Primes);
			return 0;
		}

	free(Primes);
	return 0;
}
