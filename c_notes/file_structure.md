# Structure of a C File

Usually, an individual C source file contains a set of related functions or declarations used by an application.   The following is a suggested layout of a C file:

---
## Top Docstring
```c
/*******************************************************************************
 *  @file: my_module.c
 *  
 *  @brief: Add description of what is contained.
*******************************************************************************/
```

---
## Includes

Include header files used in this module.
```c
#include <stdio.h>
#include "my_module.h"
```

## Constants and Macros

The next section would define any constants used within the source file.

```c
#define NUM_ITEMS     10
#define ARRAY_LENGTH(name)    (sizeof(name)/sizof(name[0]))
```

