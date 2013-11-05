#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

// Represents the triangle of numbers.
struct triangle {
	// Number of rows.
	unsigned int Size;
	// Number of allocated row pointer.s
	unsigned int RealSize;
	// The rows of numbers.
	int** Rows;
}; typedef struct triangle triangle;

triangle* triangle_create() {
	//Allocate the triangle.
	triangle* Triangle = malloc(sizeof(triangle));
	if(!Triangle) {
		return NULL;
	}

	// Initialize the triangle.
	Triangle->Size = 0;
	Triangle->RealSize = 0;
	Triangle->Rows = NULL;

	// Return the new triangle.
	return Triangle;
}

// Delete the last row of a triangle.
void triangle_deleteRow(triangle* Triangle) {
	// Free the row.
	free(Triangle->Rows[Triangle->Size - 1]);
	// Update size of triangle.
	Triangle->Size--;
}

void triangle_destroy(triangle* Triangle) {
	// Delete the rows of the triangle.
	while(Triangle->Size) {
		triangle_deleteRow(Triangle);
	}

	// Free the triangle.
	free(Triangle->Rows);
	free(Triangle);
}

// Add an empty row to the triangle.
bool triangle_addRow(triangle* Triangle) {
	// Calculate the new size of the triangle.
	unsigned int NewSize = Triangle->Size + 1;
	
	// Allocate the new row.
	int* NewRow = malloc(sizeof(int) * NewSize);
	if(!NewRow) {
		return false;
	}
	
	// Check to see if the triangle has any row pointers.
	if(Triangle->RealSize == 0) {
		int** NewRows = malloc(sizeof(int*));
		if(!NewRows) {
			free(NewRow);
			return false;
		}

		// We now have 1 row pointer.
		Triangle->RealSize = 1;
		Triangle->Rows = NewRows;
	}

	// Check to see if we need to increase the storage of the triangle.
	if(NewSize > Triangle->RealSize) {
		unsigned int NewRealSize = Triangle->RealSize * 2;
		int** NewRows = realloc(Triangle->Rows, sizeof(int*)*NewRealSize);
		if(!NewRows) {
			free(NewRow);
			return false;
		}
		Triangle->Rows = NewRows;
		Triangle->RealSize = NewRealSize;
	}

	Triangle->Rows[NewSize - 1] = NewRow;
	Triangle->Size = NewSize;

	return true;
}


triangle* triangle_read(char* Filename) {
	// Create an empty triangle.
	triangle* Triangle = triangle_create();
	if(!Triangle) {
		return NULL;
	}

	// Open the file.
	FILE* File = fopen(Filename, "rb");
	if(!File) {
		free(Triangle);
		return NULL;
	}

	// Find number of lines.
	unsigned int Size = 0;
	int Next;
	while((Next = fgetc(File)) != -1) {
		if(Next == '\n') {
			Size++;
		}
	}
	
	fclose(File);
	// Open the file.
	File = fopen(Filename, "rb");
	if(!File) {
		free(Triangle);
		return NULL;
	}

	// Read in each row.
	for(unsigned int Row = 1; Row <= Size; Row++) {
		if(!triangle_addRow(Triangle)) {
			triangle_destroy(Triangle);
			fclose(File);
			return NULL;
		}

		// Read in the row.
		for(unsigned int Cell = 0; Cell < Row; Cell++) {
			int Next;
			fscanf(File, "%d", &Next);
			Triangle->Rows[Row-1][Cell] = Next;
		}
	}

	// Close resources and return the new triangle.
	fclose(File);
	return Triangle;
}

int triangle_collapse(triangle* Triangle) {
	// Base case.
	if(Triangle->Size == 1) {
		return Triangle->Rows[0][0];
	}
	
	// The number of rows the triangle has.
	unsigned int Size = Triangle->Size;

	// For every cell in the second to last row.
	for(int Cell = 0; Cell < Size - 1; ++Cell) {
		int Max = 0;
		// Find the max of the two routes below it.
		for(int I = 0; I < 2; I++) {
			if(Triangle->Rows[Size - 1][I + Cell] > Max) {
					Max = Triangle->Rows[Size - 1][I + Cell];
			}
		}
		// Assign it the larger row.
		Triangle->Rows[Size - 2][Cell] += Max;
	}
	
	// Delete the row (the "fold" bit).
	triangle_deleteRow(Triangle);
	// Recurse.
	return triangle_collapse(Triangle);
}

int main(int ArgCount, char** Arguments) {
	// Holds filename.
	char* Filename = "triangle.txt";

	// Check if a different filename was specified.
	if(ArgCount > 1) {
		Filename = Arguments[1];
	}

	// Read the file.
	triangle* Triangle = triangle_read(Filename);
	if(!Triangle) {
		fprintf(stderr, "Error reading file %s.\n", Filename);
		return 1;
	}

	printf("%i\n", triangle_collapse(Triangle));

	triangle_destroy(Triangle);
	return 0;
}
