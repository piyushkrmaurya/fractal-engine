#include <stdio.h>
#include <stdlib.h>
#include <complex.h>

// Define a maximum number of iterations for the check
#define MAX_ITER 1000

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <real> <imaginary>\n", argv[0]);
        return 1; // Failure (bad input)
    }

    // Parse command-line arguments to doubles
    double creal = strtod(argv[1], NULL);
    double cimag = strtod(argv[2], NULL);

    // Create the complex number c = x + iy
    double complex c = creal + cimag * I;
    
    // Initialize z = 0
    double complex z = 0.0 + 0.0 * I;

    int n = 0;
    for (n = 0; n < MAX_ITER; n++) {
        // z = z*z + c
        z = z * z + c;

        // If the magnitude (absolute value) of z exceeds 2,
        // it has "escaped".
        if (cabs(z) > 2.0) {
            break; // Not in the set
        }
    }

    // Print the result (the escape count) to stdout.
    // This is what Python will capture.
    printf("%d\n", n);
    
    return 0;
}
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 