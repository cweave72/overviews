[//]: tocstart
Table of Contents
-----------------
* [C Types](#c-types)
  * [Standard Integers (32-bit platform)](#standard-integers-(32-bit-platform))
  * [<stdint.h> Integers](#<stdint.h>-integers)
  * [Boolean Type](#boolean-type)
  * [Enumerated Type](#enumerated-type)
  * [Structures](#structures)
  * [Typedefs](#typedefs)
  * [Scope of Variables](#scope-of-variables)
    * [External Variables](#external-variables)
  * [void Type](#void-type)

[//]: tocend

# C Types

## Standard Integers (32-bit platform)

`unsigned char`
* Size: 1 bytes
* Range: 0 to 255
* printf format: "%c"

`char`
* Size: 1 bytes
* Range: -128 to 127
* printf format: "%c"

`unsigned short int`

* Size: 2 bytes
* Range: 0 to 2**16 - 1
* printf format: "%hu"

`short int`

* Size: 2 bytes
* Range: -2**15 to 2**15 - 1
* printf format: "%hd"

`unsigned int`

* Size: 4 bytes (32-bits)
* Range: 0 to 2**32 - 1
* printf format: "%u"

`int`

* Size: 4 bytes
* Range: -2**31 to 2**31 - 1
* printf format: "%d"

`unsigned long long int`

* Size: 8 bytes (64-bits)
* Range: 0 to 2**64 - 1
* printf format: "%llu"

`long long int`

* Size: 8 bytes
* Range: -2**63 to 2**63 - 1
* printf format: "%lld"

## <stdint.h> Integers

Integer types with specific implied bit widths.

Header required: `<stdint.h>`

`int8_t`   : 8-bit signed value
`uint8_t`  : 8-bit unsigned value
`int16_t`  : 16-bit signed value
`uint16_t` : 16-bit unsigned value
`int32_t`  : 32-bit signed value
`uint32_t` : 32-bit unsigned value
`int64_t`  : 64-bit signed value
`uint64_t` : 64-bit unsigned value

## Boolean Type

Header required: `<stdbool.h>`

`bool` : values {`true`, `false`}

## Enumerated Type

Enumerated types range over a set of named constants, called enumerators.

Examples: 
```c
/* Use default values. First item is 0, 1, etc... */
enum {
    STATE_0,
    STATE_1,
    STATE_2
}

/* Create bit masks */
enum {
    EVENT_START_MASK = 0x0001,
    EVENT_PROCESSING_MASK = 0x0002,
    STATE_END_MASK = 0x0004
}

/* Initialize the first member, the rest increment. */
enum {
    JAN = 1,
    FEB,
    MAR,
    APR,
    MAY,
    JUN,
    JUL,
    AUG,
    SEP,
    OCT,
    NOV,
    DEC
}
```

## Structures

Probably, the most useful storage type.  Creates an object with named members.

Defining a struct:  Defines a struct type so that you can 
```c
/* Define a Person struct so that it may be used in declaring objects.. */
struct Person {
    char name[32];
    unsigned char height;
    unsigned char weight;
}

/* Now declare, to allocate storage for a variable (these are uninitialized). */
struct Person person1;
struct Person person2;

/* Declare and provide initialization. */
struct Person person3 = {
    .name = "Tom";
    .height = 60;
    .weight = 150;
};

/* Declare and init to 0 */
struct Person person4 = { 0 };
```

Use the object:
```c
{
    /* Initialize person1 */
    person1.name = "Fred";
    person1.height = 64;
    person1.weight = 180;

    /* Print details of person3 */
    printf("Person3: name = %s, height = %u, weight = %u\n",
        person3.name,
        person3.height,
        person3.weight);
}
```

## Typedefs

Typedefs create user-defined types that can be used in the same ways as built-in
type.  These are most-often used with structs but can be used to rename standard
types as well.

```c
/* Re-name the standard types. */
typedef U8 unsigned char;
typedef U16 unsigned short int;
typedef U32 unsigned int;

typedef S8 char;
typedef S16 short int;
typedef S32 int;

/* Create a complex data type. */
typedef struct {
    S32 real;
    S32 imag;
} Complex;

/* You can now use this new data type as input parameters to a function.
*/
static void conjugate(Complex argIn, Complex *conjOut)
{
    conjOut->real = argIn.real;
    conjOut->imag = -argIn.imag;
}

main {
    Complex sampleIn = {
        .real = 55;
        .imag = 196;

    Complex conj;

    /* Compute complex-conjugate */
    conjugate(sampleIn, &conj);
}
```

## Scope of Variables

Declarations within a .c file can have 3 levels of scope (or visibility):

  1. **global** : Declared variable is visible throughout the entire program (see `extern`).

  2. **static** : Declared variable is only visible within the .c file it is
     declared, but visible within any function in the file.  Sometimes, also
     called a "local-global".

  3. **local** : If declared within a function, a variable is local to that function
     only and cannot be referenced outside of the function.

*example.c*

```c
#include <stdint.h>

/* A global variable. */
uint32_t systemFlags = 0;

/* A variable for this file only. */
static uint32_t currentStatus = 0;

int main(void)
{
    /* Local variable */
    uint8_t state = 0;

    while (systemFlags != 0x80000000)
    {
        ...
    }
}
```

### External Variables

Global variables declared somewhere in the program may be referenced in any
other .c file using the `extern` qualifier.  This tells the compiler that this
variable is declared somewhere outside the current .c file. This will resolved
in the last phase of building (the linker phase). A linker error will be
generated if the global symbol is not found.

```c
/* In the declaration section of your .c file: */
extern uint32_t systemFlags;

/* You can now read and write the global in this file. */
```

> **Warning**:  Global variables are usually used sparingly.  If you find that you
> are using many global variables, you are heading down the wrong path.

## void Type

The `void` type denotes a nonexistent value.  It is used in function
declarations to designate either no return value is present or the argument list
is empty.

```c
/* This function does not return a value. */
void myFunc(int arg)
{
    ...
}

/* This function accepts no input arguments. */
int getCount(void)
{
    ...
}
```

A common use of `void` is within a function to designate an input as unused.
This is achieved by casting an input to a `void` - this is used to avoid unused
function parameter warnings from the compiler.

```c
int someFunction(int arg1, int arg2)
{
    /* Signal that arg2 is unused. */
    (void)arg2;

    ...
}
```
