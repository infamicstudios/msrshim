#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <inttypes.h>

struct msr {
    uint64_t value;
    bool     valid;
};

struct msr a[]={{1000, true}, {2000,false}};

int main(){
    printf("%"PRIu64" , %d\n", a[1].value, a[1].valid);

    return 0;
};

