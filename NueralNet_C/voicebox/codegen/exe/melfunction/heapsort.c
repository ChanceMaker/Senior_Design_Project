/*
 * File: heapsort.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 17-Apr-2018 22:40:21
 */

/* Include Files */
#include "rt_nonfinite.h"
#include "melfunction.h"
#include "heapsort.h"

/* Function Declarations */
static void heapify(emxArray_int32_T *x, int idx, int xstart, int xend, const
                    cell_wrap_1 cmp_tunableEnvironment[2]);

/* Function Definitions */

/*
 * Arguments    : emxArray_int32_T *x
 *                int idx
 *                int xstart
 *                int xend
 *                const cell_wrap_1 cmp_tunableEnvironment[2]
 * Return Type  : void
 */
static void heapify(emxArray_int32_T *x, int idx, int xstart, int xend, const
                    cell_wrap_1 cmp_tunableEnvironment[2])
{
  boolean_T changed;
  int extremumIdx;
  int leftIdx;
  int extremum;
  boolean_T varargout_1;
  int cmpIdx;
  int xcmp;
  changed = true;
  extremumIdx = (idx + xstart) - 2;
  leftIdx = ((idx << 1) + xstart) - 2;
  while (changed && (leftIdx + 1 < xend)) {
    changed = false;
    extremum = x->data[extremumIdx];
    cmpIdx = leftIdx;
    xcmp = x->data[leftIdx];
    varargout_1 = ((cmp_tunableEnvironment[0].f1->data[x->data[leftIdx] - 1] <
                    cmp_tunableEnvironment[0].f1->data[x->data[leftIdx + 1] - 1])
                   || ((cmp_tunableEnvironment[0].f1->data[x->data[leftIdx] - 1]
                        == cmp_tunableEnvironment[0].f1->data[x->data[leftIdx +
                        1] - 1]) && (cmp_tunableEnvironment[1].f1->data[x->
      data[leftIdx] - 1] < cmp_tunableEnvironment[1].f1->data[x->data[leftIdx +
      1] - 1])));
    if (varargout_1) {
      cmpIdx = leftIdx + 1;
      xcmp = x->data[leftIdx + 1];
    }

    varargout_1 = ((cmp_tunableEnvironment[0].f1->data[x->data[extremumIdx] - 1]
                    < cmp_tunableEnvironment[0].f1->data[xcmp - 1]) ||
                   ((cmp_tunableEnvironment[0].f1->data[x->data[extremumIdx] - 1]
                     == cmp_tunableEnvironment[0].f1->data[xcmp - 1]) &&
                    (cmp_tunableEnvironment[1].f1->data[x->data[extremumIdx] - 1]
                     < cmp_tunableEnvironment[1].f1->data[xcmp - 1])));
    if (varargout_1) {
      x->data[extremumIdx] = xcmp;
      x->data[cmpIdx] = extremum;
      extremumIdx = cmpIdx;
      leftIdx = ((((cmpIdx - xstart) + 2) << 1) + xstart) - 2;
      changed = true;
    }
  }

  if (changed && (leftIdx + 1 <= xend)) {
    extremum = x->data[extremumIdx];
    varargout_1 = ((cmp_tunableEnvironment[0].f1->data[x->data[extremumIdx] - 1]
                    < cmp_tunableEnvironment[0].f1->data[x->data[leftIdx] - 1]) ||
                   ((cmp_tunableEnvironment[0].f1->data[x->data[extremumIdx] - 1]
                     == cmp_tunableEnvironment[0].f1->data[x->data[leftIdx] - 1])
                    && (cmp_tunableEnvironment[1].f1->data[x->data[extremumIdx]
                        - 1] < cmp_tunableEnvironment[1].f1->data[x->
                        data[leftIdx] - 1])));
    if (varargout_1) {
      x->data[extremumIdx] = x->data[leftIdx];
      x->data[leftIdx] = extremum;
    }
  }
}

/*
 * Arguments    : emxArray_int32_T *x
 *                int xstart
 *                int xend
 *                const cell_wrap_1 cmp_tunableEnvironment[2]
 * Return Type  : void
 */
void b_heapsort(emxArray_int32_T *x, int xstart, int xend, const cell_wrap_1
                cmp_tunableEnvironment[2])
{
  int n;
  int idx;
  int t;
  n = xend - xstart;
  for (idx = n + 1; idx > 0; idx--) {
    heapify(x, idx, xstart, xend, cmp_tunableEnvironment);
  }

  for (idx = 1; idx <= n; idx++) {
    t = x->data[xend - 1];
    x->data[xend - 1] = x->data[xstart - 1];
    x->data[xstart - 1] = t;
    xend--;
    heapify(x, 1, xstart, xend, cmp_tunableEnvironment);
  }
}

/*
 * File trailer for heapsort.c
 *
 * [EOF]
 */
