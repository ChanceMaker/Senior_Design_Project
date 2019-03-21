/*
 * File: sparse1.h
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 18-Apr-2018 08:46:33
 */

#ifndef SPARSE1_H
#define SPARSE1_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "melfunction_types.h"

/* Function Declarations */
extern void assertValidIndexArg(const emxArray_real_T *s, emxArray_int32_T *sint);
extern void permuteVector(const emxArray_int32_T *idx, emxArray_int32_T *y);

#endif

/*
 * File trailer for sparse1.h
 *
 * [EOF]
 */
