/*
 * File: nullAssignment.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 17-Apr-2018 22:40:21
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "melfunction.h"
#include "nullAssignment.h"
#include "melfunction_emxutil.h"

/* Function Definitions */

/*
 * Arguments    : emxArray_real_T *x
 *                int idx
 * Return Type  : void
 */
void b_nullAssignment(emxArray_real_T *x, int idx)
{
  int nxin;
  int k;
  nxin = x->size[1] - 1;
  for (k = idx; k <= nxin; k++) {
    x->data[k - 1] = x->data[k];
  }

  k = x->size[0] * x->size[1];
  if (1 > nxin) {
    x->size[1] = 0;
  } else {
    x->size[1] = nxin;
  }

  emxEnsureCapacity_real_T(x, k);
}

/*
 * Arguments    : emxArray_real_T *x
 * Return Type  : void
 */
void nullAssignment(emxArray_real_T *x)
{
  int nxin;
  int k;
  nxin = x->size[1] - 1;
  for (k = 1; k <= nxin; k++) {
    x->data[k - 1] = x->data[k];
  }

  k = x->size[0] * x->size[1];
  if (1 > nxin) {
    x->size[1] = 0;
  } else {
    x->size[1] = nxin;
  }

  emxEnsureCapacity_real_T(x, k);
}

/*
 * File trailer for nullAssignment.c
 *
 * [EOF]
 */
