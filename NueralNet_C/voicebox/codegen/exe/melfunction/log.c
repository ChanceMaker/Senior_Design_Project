/*
 * File: log.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 17-Apr-2018 22:40:21
 */

/* Include Files */
#include <math.h>
#include "rt_nonfinite.h"
#include "melfunction.h"
#include "log.h"

/* Function Definitions */

/*
 * Arguments    : double x[24]
 * Return Type  : void
 */
void b_log(double x[24])
{
  int k;
  for (k = 0; k < 24; k++) {
    x[k] = log(x[k]);
  }
}

/*
 * File trailer for log.c
 *
 * [EOF]
 */
