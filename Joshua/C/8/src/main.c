#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdbool.h>

// Convert letter to digit.
int char2num(char Number) {
	// Ascii is my friend.
	return Number-'0';
}

int main(int ArgCount, char** Arguments) {
	// Holds filename.
	char* Filename = "triangle.txt";

	// Check if a different filename was specified.
	if(ArgCount > 1) {
		Filename = Arguments[1];
	}

	// Holds highest found number so far.
	int Max = 0;

	// Open input.
	FILE* Input = fopen(Filename, "rb");
	if(!Input) {
		return 0;
	}

	// Holds current digits.
	int Digits[5] = {1,1,1,1,1};

	int Next = fgetc(Input);
	while(Next != EOF) {
		if(Next == '\n') {
			Next = fgetc(Input);
			continue;
		}
		for(int I = 0; I < 4; I++) {
			Digits[I] = Digits[I + 1];
		}
		Digits[4] = char2num(Next);
		int New = 1;
		for(int I = 0; I < 5; I++) {
			New *= Digits[I];
		}
		if(New > Max) {
			Max = New;
		}
		Next = fgetc(Input);
	}

	fclose(Input);
	printf("%i\n", Max);

	return 0;
}
