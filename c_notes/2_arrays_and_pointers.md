[//]: tocstart
Table of Contents
-----------------
* [Arrays and Pointers](#arrays-and-pointers)
  * [Arrays](#arrays)
    * [Size vs. Length](#size-vs.-length)
  * [Pointers](#pointers)
    * [Relationship to Arrays](#relationship-to-arrays)
    * [Pointer Arithmetic](#pointer-arithmetic)
  * [Strings](#strings)

[//]: tocend

# Arrays and Pointers

Pointers and arrays are strongly related in C, enough that they are usually
discussed at the same time.

## Arrays

An **array** is an object that holds a contiguous set of a certain type.  Any
defined type (built-in or user-specific) may be declared as an array.

The declaration:
```c
int a[10];
```
declares a block of 10 consecutive `int` objects in memory, accessed using:
`a[0]`, `a[1]`, ... `a[9]`.

An array can also be declared with an implied size determined by the initialization:
```c
int a[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
```

### Size vs. Length

The size of an array (i.e. the amount of bytes in memory, an array takes), is
the size of the base type * the number of elements. In the case of `a[10]` above,
this would be `sizeof(int) * 10`, or 40 bytes (since `sizeof(int)` = 4).

> **Note**: 
> The `sizeof()` operator yields the number of bytes required to store an object
> of the type of its operand. When applied to an array, the result is the number
> of *bytes* in the array, **not** the number of elements of the array.  Thus,
> using the example above `sizeof(a)` yields 40, not 10.

On the other hand, the *length* of an array is typically taken to mean the
number of elements in an array. We can use a macro such as below to determine
the number of elements in an array:

```c
#include <stdint.h>  // for uint16_t

#define ARRAY_LENGTH(name)    (sizeof(name)/sizof(name[0]))

/* Declare an array of 12 u16s (24 bytes total). */
uint16_t myArray[12];

/*  Declare a variable to hold the number of elements in myArray.
    sizeof(myArray) = 24      (since an array of 12 u16's)
    sizeof(myArray[0]) = 2    (since each element is a u16)
    sizeof(myArray)/sizeof(myArray[0]) = 12
*/
unsigned int num_items = ARRAY_LENGTH(myArray);
```

## Pointers

A **pointer** is a variable that contains the address of some object in memory
and is usually represented as 4 bytes.

Consider the following declarations:

```c
unsigned int data = 100;
unsigned int *pData;
```

- The first declaration, creates an object in memory named `data`, sets aside 4
bytes to hold its value and then loads the value 100 into the memory designated.

- The second, creates a *pointer* that can reference an `unsigned int` type.  It
is not useful yet, since it does not point to anything.

We now introduce the `&` operator.  When placed before the name of a
variable, the `&` means "address of" the following variable. To see how this
works, let's assign our pointer declared above:

```c
pData = &data;
```

This sets the value of `pData` to be the "address of" the variable `data`. If we
were to inspect the value of `pData` in a debugger, we would see something like
`pData = 0x80251000`.  The value of the pointer is wherever the compiler placed
the object `data` in memory. This value itself is not altogether useful, just
that it represents a address in the computer's memory.

Now that our pointer actually points to a real object, we can obtain the value
of the original object by *de-referencing* the pointer.  This term comes from
the fact that pointers are seen as "references-to" some object in memory.

```c
/* De-reference the pointer to obtain the pointed-to object's value. */
printf("The orignal value is %u\n", *pData);
```

The result would be: `"The original value is 100"`

> **Note** With pointers, the interpretation of `*` is based on the context of its use:
> 
> - When used in a declaration following the type, read it as "pointer to" the
>   type.  
>
>   For example, `unsigned int *` interpret as "*pointer to* `unsigned int`"
> 
> - When used in an expression, interpret as *de-referencing*.>
>
>   For example: `x = *pData;` interpret as `x = the value referenced by pData`"

### Relationship to Arrays

Arrays and pointers are closely coupled.  

Consider the following code snippet:

```c
int a[4] = {0, 1, 2, 3};
```

Below are a few identities to be aware of:

1. The name of an array by itself is a pointer to the array.
    * `a` without any brackets can be thought of as having type `int *`
2. The address of the first array element is equivalent to a pointer to the
   array. 
    * That is, `&a[0] == a`
3. The following are equivalent ways to access array elements:
    * `a[0]` is equiv. to `*(a + 0)`
    * `a[1]` is equiv. to `*(a + 1)`
    * `a[2]` is equiv. to `*(a + 2)`
    * `a[3]` is equiv. to `*(a + 3)`
    * `a[p]` is equiv. to `*(a + p)`  (for p <= 3)



### Pointer Arithmetic

When you declare a variable as a pointer to a specific type, the compiler
inherently knows how to perform arithmetic on the pointer.  Performing
arithmetic on pointers really only makes sense when considering arrays.


## Strings

A string is simply another name for an array of type `char`. However, a string
implies that the contents are printable ASCII characters.

