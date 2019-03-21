/*
 * File: frq2mel.h
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 18-Apr-2018 08:46:33
 */

#ifndef FRQ2MEL_H
#define FRQ2MEL_H

/* Include Files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "melfunction_types.h"

/* Function Declarations */
extern void b_frq2mel(const emxArray_real_T *frq, emxArray_real_T *mel);
extern void frq2mel(const double frq[2], double mel[2]);

#endif

/*
 * File trailer for frq2mel.h
 *
 * [EOF]
 */
