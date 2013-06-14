#include <stdlib.h>
#include <stdio.h>

int main() {
	unsigned int Total = 0;
	int Current;
	for(Current=1; Current<1000; ++Current)
		if((!(Current%3))||(!(Current%5)))
			Total+=Current;
	printf("%u\n", Total);
}
