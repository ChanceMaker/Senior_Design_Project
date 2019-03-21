/*
 * File: _coder_melfunction_api.h
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 18-Apr-2018 08:46:33
 */

#ifndef _CODER_MELFUNCTION_API_H
#define _CODER_MELFUNCTION_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_melfunction_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void melfunction(real_T x[16000], real_T c[24]);
extern void melfunction_api(const mxArray * const prhs[1], int32_T nlhs, const
  mxArray *plhs[1]);
extern void melfunction_atexit(void);
extern void melfunction_initialize(void);
extern void melfunction_terminate(void);
extern void melfunction_xil_terminate(void);

#endif

/*
 * File trailer for _coder_melfunction_api.h
 *
 * [EOF]
 */
