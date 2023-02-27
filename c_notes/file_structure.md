[//]: tocstart
Table of Contents
-----------------
* [Structure of a C Module](#structure-of-a-c-module)
  * [C Source File](#c-source-file)
    * [Top Docstring](#top-docstring)
    * [Includes](#includes)
    * [Constants and Macros](#constants-and-macros)
    * [Declarations](#declarations)
    * [Static functions](#static-functions)
    * [Exported functions](#exported-functions)
    * [Source File Example: `my_module.c`](#source-file-example:-`my_module.c`)
  * [Header File](#header-file)
    * [The Docstring](#the-docstring)
    * [Header Guard](#header-guard)
    * [Required Header Includes](#required-header-includes)
    * [Global Definitions](#global-definitions)
    * [Exported Globals](#exported-globals)
    * [Exported Functions](#exported-functions)
    * [Example: `my_module.h`](#example:-`my_module.h`)

[//]: tocend

# Structure of a C Module

Usually, an individual C source module or library contains a set of related
functions and declarations the provide some functionality. In its simplest form,
a module consists of a source file (.c) and a header (.h) file.

The following provides some guidelines for structuring the source and header
files.

## C Source File

---

### Top Docstring

Placed at the very top of the file, this should identify the purpose of the
module (as well as any other relevant documentation).

```c
/*******************************************************************************
 *  @file: my_module.c
 *  
 *  @brief: Add description of what is contained.
*******************************************************************************/
```

---

### Includes

Include header files used in this module.

```c
#include <stdio.h>
#include "my_module.h"
```

### Constants and Macros

The next section would define any constants used within the source file.

```c
#define NUM_ITEMS     10
#define ARRAY_LENGTH(name)    (sizeof(name)/sizof(name[0]))
```

---

### Declarations

This section would include declarations for any static variables used by the
module or global variables exported by the module (note - these would be
`extern`'d in the module's header file).

> **Recall**: 
> * *static* : variables which are only visible (in scope) within the current c source file.
>
> * *global* : variables visible anywhere in an application which links against
>   the source module. Available in other modules through an `extern` statement.

```c
/* Local Vars */
static logging_level = 3;
static uint32_t eventCount = 0;

/* Global Vars */
bool MyModule_enabled = false;
```

---

### Static functions

This section would declare any *static* functions used within this source file.
This would include local utilities and helpers that are only relevant to
functionality provided in this module.

> **Note**:
> Static functions must be defined above where they are used.  This could be in
> the form of the complete function declaration as shown below, or via a single
> function prototype declaration in the module's declarations section:
>
> For example:
```c
static void writePin(void *self, uint8_t state);
```

```c
/******************************************************************************
    writePin
*//**
    @brief Writes a GPIO pin.
******************************************************************************/
static void
writePin(void *self, uint8_t state)
{
    Gpio *obj = (Gpio *)self;
    GPIO_WritePin(obj->port, obj->pin, state);
}

/******************************************************************************
    togglePin
*//**
    @brief Toggles a GPIO pin.
******************************************************************************/
static void
togglePin(void *self)
{
    Gpio *obj = (Gpio *)self;
    GPIO_TogglePin(obj->port, obj->pin);
}
```

---

### Exported functions

*Exported* (or global) functions make up the API of your module or library. They
encompass the user's entrypoints into your library. Each of these functions
should have a matching prototype (i.e. the function's signature) declaration in
the library's header file.

Note that it is good practice to prefix each exported function with the name of
your library module.

```c
/******************************************************************************
    [docimport MyModule_getCount]
*//**
    @brief Gets the current timer value.
    @return Returns the current count
******************************************************************************/
uint32_t
MyModule_getCount(void)
{
    return GET_COUNT();
}

/******************************************************************************
    [docimport MyModule_init]
*//**
    @brief Initializes a MyModule object.
    @param[in] self  Pointer to the MyModule object. Object should be initialized
    prior to call.
    @param[in] state  The initial state.
******************************************************************************/
void
MyModule_init(MyModule *self, uint8_t state)
{
    /* Initialization operations */
}
```

### Source File Example: `my_module.c`

```c
/*******************************************************************************
 *  @file: my_module.c
 *  
 *  @brief: Add description of what is contained.
*******************************************************************************/
#include <stdio.h>
...
#include "my_module.h"

/* Definitions */
...
#define NUM_ITEMS     10
#define ARRAY_LENGTH(name)    (sizeof(name)/sizof(name[0]))
...

/* Declarations */

/* Local Vars */
static logging_level = 3;
static uint32_t eventCount = 0;

/* Global Vars */
bool MyModule_enables = false;

/* Static Functions */

/******************************************************************************
    writePin
*//**
    @brief Writes a GPIO pin.
******************************************************************************/
static void
writePin(void *self, uint8_t state)
{
    Gpio *obj = (Gpio *)self;
    GPIO_WritePin(obj->port, obj->pin, state);
}

...

/******************************************************************************
    togglePin
*//**
    @brief Toggles a GPIO pin.
******************************************************************************/
static void
togglePin(void *self)
{
    Gpio *obj = (Gpio *)self;
    GPIO_TogglePin(obj->port, obj->pin);
}

/* Global Functions */

/******************************************************************************
    [docimport MyModule_getCount]
*//**
    @brief Gets the current timer value.
    @return Returns the current count
******************************************************************************/
uint32_t
MyModule_getCount(void)
{
    return GET_COUNT();
}

...

/******************************************************************************
    [docimport MyModule_init]
*//**
    @brief Initializes a MyModule object.
    @param[in] self  Pointer to the MyModule object. Object should be initialized
    prior to call.
    @param[in] state  The initial state.
******************************************************************************/
void
MyModule_init(MyModule *self, uint8_t state)
{
    /* Initialization operations */
    MyModule_enabled = true;
}
```

## Header File

Most C source files should have an accompanying C Header file which provides any
definitions which a user of the module should know about. The following sections
will details the sections of the fictional `my_module.h` corresponding to
`my_module.c` detailed above.

### The Docstring

Similar to the source file, the header should have a top docstring.

```c
/*******************************************************************************
 *  @file: my_module.h
 *   
 *  @brief: Header for MyModule initialization and usage.
*******************************************************************************/
```

### Header Guard

The so-called *header guard* is a C preprocessor macro which prevents the
inclusion of a header file more than once. When a header file is `#include`'d,
the C preprocessor simply inserts the contents of the specified file into the
current file.

The header guard is typically achieved as follows:

```c
#ifndef MYMODULE_H
#define MYMODULE_H

<contents of file>

#endif
```

The entire contents of the header file should be within the `#ifndef` to
`#endif` pair.  During the build process, when the C preprocessor encounters the
first instance of `#include "my_module.h"`, the definition `MYMODULE_H` is
undefined. This causes the preprocessor to insert the contents of the header
into an internal copy of the source file which included it.
 
If/when another source file also `#include`'s my_module.h, the definition
`MYMODULE_H` will already exist, causing the preprocessor to skip re-including
the contents.  Without the header guard, the compiler will complain about
re-definition of anything defined within the header (i.e. functions, structs,
typedefs, etc...). 

### Required Header Includes

A header file usually needs to include other header files to provide types and
constants defined in other system or user header files. Ideally, A user of your
module should only needs to `#include "my_module.h"` in order to get all the
header dependencies.

```c
#include <stdint.h>
#include <stdbool.h>
#include "other_local_module.h"
...
```

### Global Definitions

The next section should `#define` any constants, macros and typedefs needed for
anyone using your module. This may also include any function-like macros.


### Exported Globals

A module that contains global variables should *export* this variable for use
via an `extern` statement.  In this way, a user may get access to a global by
simply `#include`'ing the header file.

For example, let's consider the example used previously. A global flag which
indicates if the module has been initialized would be exported as follows:

```c
/* Export Global variable */
extern bool MyModule_enabled;
```

### Exported Functions

The last section should contain the function prototypes for any global function
provided by the module.  This is essentially documentation for your API - where
the user can look to see how to use your library.

### Example: `my_module.h`

```c
/*******************************************************************************
 *  @file: my_module.h
 *   
 *  @brief: Header for MyModule
*******************************************************************************/
#ifndef MYMODULE_H
#define MYMODULE_H

#include <stdint.h>
#include <stdbool.h>

/* Definitions */
#define MYMODULE_MAX_ITEMS  8

/* Types */

typedef enum MyModuelState
{
    STATE_IDLE = 0,
    STATE_RUNNING,
    STATE_EXPIRED
    
} MyModuleState;

typedef struct MyModule
{
    /** @brief Internal state variables. */
    MyModuleState state;
    uint32_t items[MYMODULE_MAX_ITEMS];

} MyModule;

/* Exported Globals */
extern bool MyModule_enabled;

/* Function Prototypes */

/******************************************************************************
    [docexport MyModule_getCount]
*//**
    @brief Gets the current timer value.
    @return Returns the current count
******************************************************************************/
uint32_t
MyModule_getCount(void);

...

/******************************************************************************
    [docimport MyModule_init]
*//**
    @brief Initializes a MyModule object.
    @param[in] self  Pointer to the MyModule object. Object should be initialized
    prior to call.
    @param[in] state  The initial state.
******************************************************************************/
void
MyModule_init(MyModule *self, uint8_t state);

#endif
```
