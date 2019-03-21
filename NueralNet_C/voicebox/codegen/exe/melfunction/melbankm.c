/*
 * File: melbankm.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 17-Apr-2018 22:40:21
 */

/* Include Files */
#include <math.h>
#include <string.h>
#include "rt_nonfinite.h"
#include "melfunction.h"
#include "melbankm.h"
#include "melfunction_emxutil.h"
#include "sparse1.h"
#include "introsort.h"
#include "abs.h"
#include "floor.h"
#include "nullAssignment.h"
#include "frq2mel.h"
#include "mel2frq.h"

/* Function Definitions */

/*
 * MELBANKM determine matrix for a mel/erb/bark-spaced filterbank [X,MN,MX]=(P,N,FS,FL,FH,W)
 *
 *  Inputs:
 *        p   number of filters in filterbank or the filter spacing in k-mel/bark/erb [ceil(4.6*log10(fs))]
 *   n   length of fft
 *   fs  sample rate in Hz
 *   fl  low end of the lowest filter as a fraction of fs [default = 0]
 *   fh  high end of highest filter as a fraction of fs [default = 0.5]
 *   w   any sensible combination of the following:
 *              'b' = bark scale instead of mel
 *              'e' = erb-rate scale
 *              'l' = log10 Hz frequency scale
 *              'f' = linear frequency scale
 *
 *              'c' = fl/fh specify centre of low and high filters
 *              'h' = fl/fh are in Hz instead of fractions of fs
 *              'H' = fl/fh are in mel/erb/bark/log10
 *
 *         't' = triangular shaped filters in mel/erb/bark domain (default)
 *         'n' = hanning shaped filters in mel/erb/bark domain
 *         'm' = hamming shaped filters in mel/erb/bark domain
 *
 *         'z' = highest and lowest filters taper down to zero [default]
 *         'y' = lowest filter remains at 1 down to 0 frequency and
 *            highest filter remains at 1 up to nyquist freqency
 *
 *              'u' = scale filters to sum to unity
 *
 *              's' = single-sided: do not double filters to account for negative frequencies
 *
 *              'g' = plot idealized filters [default if no output arguments present]
 *
 *  Note that the filter shape (triangular, hamming etc) is defined in the mel (or erb etc) domain.
 *  Some people instead define an asymmetric triangular filter in the frequency domain.
 *
 *          If 'ty' or 'ny' is specified, the total power in the fft is preserved.
 *
 *  Outputs: x     a sparse matrix containing the filterbank amplitudes
 *             If the mn and mx outputs are given then size(x)=[p,mx-mn+1]
 *                  otherwise size(x)=[p,1+floor(n/2)]
 *                  Note that the peak filter values equal 2 to account for the power
 *                  in the negative FFT frequencies.
 *            mc    the filterbank centre frequencies in mel/erb/bark
 *       mn    the lowest fft bin with a non-zero coefficient
 *       mx    the highest fft bin with a non-zero coefficient
 *                  Note: you must specify both or neither of mn and mx.
 *
 *  Examples of use:
 *
 *  (a) Calcuate the Mel-frequency Cepstral Coefficients
 *
 *        f=rfft(s);           % rfft() returns only 1+floor(n/2) coefficients
 *   x=melbankm(p,n,fs);         % n is the fft length, p is the number of filters wanted
 *   z=log(x*abs(f).^2);         % multiply x by the power spectrum
 *   c=dct(z);                   % take the DCT
 *
 *  (b) Calcuate the Mel-frequency Cepstral Coefficients efficiently
 *
 *        f=fft(s);                        % n is the fft length, p is the number of filters wanted
 *        [x,mc,na,nb]=melbankm(p,n,fs);   % na:nb gives the fft bins that are needed
 *        z=log(x*(f(na:nb)).*conj(f(na:nb)));
 *
 *  (c) Plot the calculated filterbanks
 *
 *       plot((0:floor(n/2))*fs/n,melbankm(p,n,fs)')   % fs=sample frequency
 *
 *  (d) Plot the idealized filterbanks (without output sampling)
 *
 *       melbankm(p,n,fs);
 *
 *  References:
 *
 *  [1] S. S. Stevens, J. Volkman, and E. B. Newman. A scale for the measurement
 *      of the psychological magnitude of pitch. J. Acoust Soc Amer, 8: 185–19, 1937.
 *  [2] S. Davis and P. Mermelstein. Comparison of parametric representations for
 *      monosyllabic word recognition in continuously spoken sentences.
 *      IEEE Trans Acoustics Speech and Signal Processing, 28 (4): 357–366, Aug. 1980.
 * Arguments    : emxArray_real_T *x_d
 *                emxArray_int32_T *x_colidx
 *                emxArray_int32_T *x_rowidx
 * Return Type  : void
 */
void melbankm(emxArray_real_T *x_d, emxArray_int32_T *x_colidx, emxArray_int32_T
              *x_rowidx)
{
  int i0;
  double dv5[2];
  double mflh[2];
  double b4;
  double melinc;
  double b_mflh[4];
  double blim[4];
  static const signed char a[4] = { 0, 1, 24, 25 };

  double x;
  double b1;
  emxArray_real_T *y;
  double ndbl;
  double apnd;
  double cdiff;
  double absa;
  emxArray_real_T *b_y;
  double absb;
  int loop_ub;
  emxArray_real_T *pf;
  int nc;
  int nm1d2;
  int k;
  emxArray_real_T *fp;
  emxArray_boolean_T *b_x;
  int idx;
  boolean_T exitg1;
  int ii_data[1];
  int k2__data[1];
  int k3__data[1];
  int i1;
  emxArray_real_T *v;
  emxArray_real_T *c;
  emxArray_boolean_T *r0;
  emxArray_int32_T *r1;
  emxArray_int32_T *ridxInt;
  emxArray_int32_T *cidxInt;
  emxArray_int32_T *sortedIndices;
  cell_wrap_1 tunableEnvironment[2];
  cell_wrap_1 this_tunableEnvironment[2];

  /*       Copyright (C) Mike Brookes 1997-2009 */
  /*       Version: $Id: melbankm.m 9519 2017-02-23 07:52:51Z dmb $ */
  /*  */
  /*    VOICEBOX is a MATLAB toolbox for speech processing. */
  /*    Home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html */
  /*  */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  /*    This program is free software; you can redistribute it and/or modify */
  /*    it under the terms of the GNU General Public License as published by */
  /*    the Free Software Foundation; either version 2 of the License, or */
  /*    (at your option) any later version. */
  /*  */
  /*    This program is distributed in the hope that it will be useful, */
  /*    but WITHOUT ANY WARRANTY; without even the implied warranty of */
  /*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
  /*    GNU General Public License for more details. */
  /*  */
  /*    You can obtain a copy of the GNU General Public License from */
  /*    http://www.gnu.org/copyleft/gpl.html or by writing to */
  /*    Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA. */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% */
  /*  Note "FFT bin_0" assumes DC = bin 0 whereas "FFT bin_1" means DC = bin 1 */
  /*  1 if single sided else 2 */
  /*  default warping is mel */
  for (i0 = 0; i0 < 2; i0++) {
    dv5[i0] = 3200.0 * (double)i0;
  }

  frq2mel(dv5, mflh);

  /*  convert frequency limits into mel */
  /*  mel range */
  /*  bin index of highest positive frequency (Nyquist if n is even) */
  b4 = 0.0;
  for (i0 = 0; i0 < 2; i0++) {
    b4 += mflh[i0] * (-1.0 + 2.0 * (double)i0);
  }

  melinc = b4 / 25.0;

  /*  */
  /*  Calculate the FFT bins corresponding to [filter#1-low filter#1-mid filter#p-mid filter#p-high] */
  /*  */
  for (i0 = 0; i0 < 4; i0++) {
    b_mflh[i0] = mflh[0] + (double)a[i0] * melinc;
  }

  mel2frq(b_mflh, blim);
  for (i0 = 0; i0 < 4; i0++) {
    blim[i0] = blim[i0] * 256.0 / 8000.0;
  }

  /*  mel centre frequencies */
  x = floor(blim[0]);
  b1 = floor(blim[0]) + 1.0;

  /*  lowest FFT bin_0 required might be negative) */
  b4 = ceil(blim[3]);
  if ((128.0 < b4 - 1.0) || rtIsNaN(b4 - 1.0)) {
    b4 = 128.0;
  } else {
    b4--;
  }

  /*  highest FFT bin_0 required */
  /*  */
  /*  now map all the useful FFT bins_0 to filter1 centres */
  /*  */
  emxInit_real_T1(&y, 2);
  if (rtIsNaN(b1) || rtIsNaN(b4)) {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 1;
    emxEnsureCapacity_real_T(y, i0);
    y->data[0] = rtNaN;
  } else if (b4 < x + 1.0) {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 0;
    emxEnsureCapacity_real_T(y, i0);
  } else if ((rtIsInf(b1) || rtIsInf(b4)) && (x + 1.0 == b4)) {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 1;
    emxEnsureCapacity_real_T(y, i0);
    y->data[0] = rtNaN;
  } else if (b1 == x + 1.0) {
    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = (int)(b4 - (x + 1.0)) + 1;
    emxEnsureCapacity_real_T(y, i0);
    loop_ub = (int)(b4 - (x + 1.0));
    for (i0 = 0; i0 <= loop_ub; i0++) {
      y->data[y->size[0] * i0] = (x + 1.0) + (double)i0;
    }
  } else {
    ndbl = floor((b4 - (x + 1.0)) + 0.5);
    apnd = (x + 1.0) + ndbl;
    cdiff = apnd - b4;
    absa = fabs(x + 1.0);
    absb = fabs(b4);
    if ((absa > absb) || rtIsNaN(absb)) {
      absb = absa;
    }

    if (fabs(cdiff) < 4.4408920985006262E-16 * absb) {
      ndbl++;
      apnd = b4;
    } else if (cdiff > 0.0) {
      apnd = (x + 1.0) + (ndbl - 1.0);
    } else {
      ndbl++;
    }

    if (ndbl >= 0.0) {
      nc = (int)ndbl;
    } else {
      nc = 0;
    }

    i0 = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = nc;
    emxEnsureCapacity_real_T(y, i0);
    if (nc > 0) {
      y->data[0] = x + 1.0;
      if (nc > 1) {
        y->data[nc - 1] = apnd;
        nm1d2 = (nc - 1) / 2;
        for (k = 1; k < nm1d2; k++) {
          y->data[k] = (x + 1.0) + (double)k;
          y->data[(nc - k) - 1] = apnd - (double)k;
        }

        if (nm1d2 << 1 == nc - 1) {
          y->data[nm1d2] = ((x + 1.0) + apnd) / 2.0;
        } else {
          y->data[nm1d2] = (x + 1.0) + (double)nm1d2;
          y->data[nm1d2 + 1] = apnd - (double)nm1d2;
        }
      }
    }
  }

  emxInit_real_T1(&b_y, 2);
  i0 = b_y->size[0] * b_y->size[1];
  b_y->size[0] = 1;
  b_y->size[1] = y->size[1];
  emxEnsureCapacity_real_T(b_y, i0);
  loop_ub = y->size[0] * y->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_y->data[i0] = y->data[i0] * 8000.0 / 256.0;
  }

  emxInit_real_T1(&pf, 2);
  b_frq2mel(b_y, pf);
  loop_ub = pf->size[0] * pf->size[1] - 1;
  i0 = pf->size[0] * pf->size[1];
  pf->size[0] = 1;
  emxEnsureCapacity_real_T(pf, i0);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    pf->data[i0] = (pf->data[i0] - mflh[0]) / melinc;
  }

  /*  */
  /*   remove any incorrect entries in pf due to rounding errors */
  /*  */
  if (pf->data[0] < 0.0) {
    nullAssignment(pf);
    b1 = (x + 1.0) + 1.0;
  }

  if (pf->data[pf->size[1] - 1] >= 25.0) {
    i0 = pf->size[1];
    b_nullAssignment(pf, i0);
  }

  emxInit_real_T1(&fp, 2);
  i0 = fp->size[0] * fp->size[1];
  fp->size[0] = 1;
  fp->size[1] = pf->size[1];
  emxEnsureCapacity_real_T(fp, i0);
  loop_ub = pf->size[0] * pf->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    fp->data[i0] = pf->data[i0];
  }

  b_floor(fp);

  /*  FFT bin_0 i contributes to filters_1 fp(1+i-b1)+[0 1] */
  loop_ub = pf->size[0] * pf->size[1] - 1;
  i0 = pf->size[0] * pf->size[1];
  pf->size[0] = 1;
  emxEnsureCapacity_real_T(pf, i0);
  for (i0 = 0; i0 <= loop_ub; i0++) {
    pf->data[i0] -= fp->data[i0];
  }

  emxInit_boolean_T(&b_x, 2);

  /*  multiplier for upper filter */
  i0 = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = fp->size[1];
  emxEnsureCapacity_boolean_T(b_x, i0);
  loop_ub = fp->size[0] * fp->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_x->data[i0] = (fp->data[i0] > 0.0);
  }

  k = (1 <= b_x->size[1]);
  idx = 0;
  nm1d2 = 1;
  exitg1 = false;
  while ((!exitg1) && (nm1d2 <= b_x->size[1])) {
    if (b_x->data[nm1d2 - 1]) {
      idx = 1;
      ii_data[0] = nm1d2;
      exitg1 = true;
    } else {
      nm1d2++;
    }
  }

  if (k == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    k = !(1 > idx);
  }

  if (0 <= k - 1) {
    memcpy(&k2__data[0], &ii_data[0], (unsigned int)(k * (int)sizeof(int)));
  }

  /*  FFT bin_1 k2+b1 is the first to contribute to both upper and lower filters */
  i0 = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = fp->size[1];
  emxEnsureCapacity_boolean_T(b_x, i0);
  loop_ub = fp->size[0] * fp->size[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    b_x->data[i0] = (fp->data[i0] < 24.0);
  }

  k = (1 <= b_x->size[1]);
  idx = 0;
  nm1d2 = b_x->size[1];
  exitg1 = false;
  while ((!exitg1) && (nm1d2 > 0)) {
    if (b_x->data[nm1d2 - 1]) {
      idx = 1;
      ii_data[0] = nm1d2;
      exitg1 = true;
    } else {
      nm1d2--;
    }
  }

  if (k == 1) {
    if (idx == 0) {
      k = 0;
    }
  } else {
    k = !(1 > idx);
  }

  if (0 <= k - 1) {
    memcpy(&k3__data[0], &ii_data[0], (unsigned int)(k * (int)sizeof(int)));
  }

  /*  FFT bin_1 k3+b1 is the last to contribute to both upper and lower filters */
  /*  FFT bin_1 k4+b1 is the last to contribute to any filters */
  if (1 > k3__data[0]) {
    loop_ub = 0;
  } else {
    loop_ub = k3__data[0];
  }

  if (k2__data[0] > fp->size[1]) {
    i0 = 0;
    i1 = 0;
  } else {
    i0 = k2__data[0] - 1;
    i1 = fp->size[1];
  }

  /*  filter number_1 */
  if (k3__data[0] < 1) {
    idx = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = 0;
    emxEnsureCapacity_real_T(y, idx);
  } else {
    idx = y->size[0] * y->size[1];
    y->size[0] = 1;
    y->size[1] = k3__data[0];
    emxEnsureCapacity_real_T(y, idx);
    k = k3__data[0] - 1;
    for (idx = 0; idx <= k; idx++) {
      y->data[y->size[0] * idx] = 1.0 + (double)idx;
    }
  }

  emxInit_real_T1(&v, 2);
  if (fp->size[1] < k2__data[0]) {
    idx = v->size[0] * v->size[1];
    v->size[0] = 1;
    v->size[1] = 0;
    emxEnsureCapacity_real_T(v, idx);
  } else {
    idx = fp->size[1];
    nc = v->size[0] * v->size[1];
    v->size[0] = 1;
    v->size[1] = (idx - k2__data[0]) + 1;
    emxEnsureCapacity_real_T(v, nc);
    k = idx - k2__data[0];
    for (idx = 0; idx <= k; idx++) {
      v->data[v->size[0] * idx] = k2__data[0] + idx;
    }
  }

  emxInit_real_T1(&c, 2);
  idx = c->size[0] * c->size[1];
  c->size[0] = 1;
  c->size[1] = y->size[1] + v->size[1];
  emxEnsureCapacity_real_T(c, idx);
  k = y->size[1];
  for (idx = 0; idx < k; idx++) {
    c->data[c->size[0] * idx] = y->data[y->size[0] * idx];
  }

  k = v->size[1];
  for (idx = 0; idx < k; idx++) {
    c->data[c->size[0] * (idx + y->size[1])] = v->data[v->size[0] * idx];
  }

  /*  FFT bin_1 - b1 */
  if (1 > k3__data[0]) {
    k = 0;
  } else {
    k = k3__data[0];
  }

  if (k2__data[0] > fp->size[1]) {
    idx = 0;
    nc = 0;
  } else {
    idx = k2__data[0] - 1;
    nc = fp->size[1];
  }

  nm1d2 = v->size[0] * v->size[1];
  v->size[0] = 1;
  v->size[1] = (k + nc) - idx;
  emxEnsureCapacity_real_T(v, nm1d2);
  for (nm1d2 = 0; nm1d2 < k; nm1d2++) {
    v->data[v->size[0] * nm1d2] = pf->data[nm1d2];
  }

  nm1d2 = nc - idx;
  for (nc = 0; nc < nm1d2; nc++) {
    v->data[v->size[0] * (nc + k)] = 1.0 - pf->data[idx + nc];
  }

  emxFree_real_T(&pf);

  /*  lowest fft bin_1 */
  /*  highest fft bin_1 */
  if (b1 < 0.0) {
    idx = b_y->size[0] * b_y->size[1];
    b_y->size[0] = 1;
    b_y->size[1] = c->size[1];
    emxEnsureCapacity_real_T(b_y, idx);
    k = c->size[0] * c->size[1];
    for (idx = 0; idx < k; idx++) {
      b_y->data[idx] = (c->data[idx] + b1) - 1.0;
    }

    b_abs(b_y, c);
    k = c->size[0] * c->size[1] - 1;
    idx = c->size[0] * c->size[1];
    c->size[0] = 1;
    emxEnsureCapacity_real_T(c, idx);
    for (idx = 0; idx <= k; idx++) {
      c->data[idx] = (c->data[idx] - b1) + 1.0;
    }

    /*  convert negative frequencies into positive */
  }

  /*  end */
  /*  double all except the DC and Nyquist (if any) terms */
  idx = b_x->size[0] * b_x->size[1];
  b_x->size[0] = 1;
  b_x->size[1] = c->size[1];
  emxEnsureCapacity_boolean_T(b_x, idx);
  k = c->size[0] * c->size[1];
  for (idx = 0; idx < k; idx++) {
    b_x->data[idx] = (c->data[idx] + (b1 + 1.0) > 2.0);
  }

  emxInit_boolean_T(&r0, 2);
  idx = r0->size[0] * r0->size[1];
  r0->size[0] = 1;
  r0->size[1] = c->size[1];
  emxEnsureCapacity_boolean_T(r0, idx);
  k = c->size[0] * c->size[1];
  for (idx = 0; idx < k; idx++) {
    r0->data[idx] = (c->data[idx] + (b1 + 1.0) < 130.0);
  }

  /*  there is no Nyquist term if n is odd */
  k = b_x->size[1] - 1;
  nm1d2 = 0;
  for (nc = 0; nc <= k; nc++) {
    if (b_x->data[nc] && r0->data[nc]) {
      nm1d2++;
    }
  }

  emxInit_int32_T1(&r1, 2);
  idx = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  r1->size[1] = nm1d2;
  emxEnsureCapacity_int32_T(r1, idx);
  nm1d2 = 0;
  for (nc = 0; nc <= k; nc++) {
    if (b_x->data[nc] && r0->data[nc]) {
      r1->data[nm1d2] = nc + 1;
      nm1d2++;
    }
  }

  idx = y->size[0] * y->size[1];
  y->size[0] = 1;
  y->size[1] = r1->size[1];
  emxEnsureCapacity_real_T(y, idx);
  k = r1->size[0] * r1->size[1];
  for (idx = 0; idx < k; idx++) {
    y->data[idx] = 2.0 * v->data[r1->data[idx] - 1];
  }

  emxFree_int32_T(&r1);
  k = b_x->size[1];
  nm1d2 = 0;
  for (nc = 0; nc < k; nc++) {
    if (b_x->data[nc] && r0->data[nc]) {
      v->data[nc] = y->data[nm1d2];
      nm1d2++;
    }
  }

  emxFree_boolean_T(&b_x);
  emxFree_real_T(&y);
  emxFree_boolean_T(&r0);

  /*  */
  /*  sort out the output argument options */
  /*  */
  k = c->size[0] * c->size[1] - 1;
  idx = c->size[0] * c->size[1];
  c->size[0] = 1;
  emxEnsureCapacity_real_T(c, idx);
  for (idx = 0; idx <= k; idx++) {
    c->data[idx] = (c->data[idx] + (b1 + 1.0)) - 1.0;
  }

  nc = c->size[1];
  idx = b_y->size[0] * b_y->size[1];
  b_y->size[0] = 1;
  b_y->size[1] = (loop_ub + i1) - i0;
  emxEnsureCapacity_real_T(b_y, idx);
  for (idx = 0; idx < loop_ub; idx++) {
    b_y->data[b_y->size[0] * idx] = 1.0 + fp->data[idx];
  }

  k = i1 - i0;
  for (i1 = 0; i1 < k; i1++) {
    b_y->data[b_y->size[0] * (i1 + loop_ub)] = fp->data[i0 + i1];
  }

  emxFree_real_T(&fp);
  emxInit_int32_T(&ridxInt, 1);
  emxInit_int32_T(&cidxInt, 1);
  emxInit_int32_T(&sortedIndices, 1);
  assertValidIndexArg(b_y, ridxInt);
  assertValidIndexArg(c, cidxInt);
  i0 = sortedIndices->size[0];
  sortedIndices->size[0] = c->size[1];
  emxEnsureCapacity_int32_T1(sortedIndices, i0);
  k = 1;
  emxFree_real_T(&b_y);
  while (k <= nc) {
    sortedIndices->data[k - 1] = k;
    k++;
  }

  emxInitMatrix_cell_wrap_1(tunableEnvironment);
  i0 = tunableEnvironment[0].f1->size[0];
  tunableEnvironment[0].f1->size[0] = cidxInt->size[0];
  emxEnsureCapacity_int32_T1(tunableEnvironment[0].f1, i0);
  loop_ub = cidxInt->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    tunableEnvironment[0].f1->data[i0] = cidxInt->data[i0];
  }

  i0 = tunableEnvironment[1].f1->size[0];
  tunableEnvironment[1].f1->size[0] = ridxInt->size[0];
  emxEnsureCapacity_int32_T1(tunableEnvironment[1].f1, i0);
  loop_ub = ridxInt->size[0];
  for (i0 = 0; i0 < loop_ub; i0++) {
    tunableEnvironment[1].f1->data[i0] = ridxInt->data[i0];
  }

  emxInitMatrix_cell_wrap_1(this_tunableEnvironment);
  for (i0 = 0; i0 < 2; i0++) {
    emxCopyStruct_cell_wrap_1(&this_tunableEnvironment[i0],
      &tunableEnvironment[i0]);
  }

  emxFreeMatrix_cell_wrap_1(tunableEnvironment);
  introsort(sortedIndices, cidxInt->size[0], this_tunableEnvironment);
  permuteVector(sortedIndices, cidxInt);
  permuteVector(sortedIndices, ridxInt);
  emxFreeMatrix_cell_wrap_1(this_tunableEnvironment);
  if (c->size[1] >= 1) {
    nm1d2 = c->size[1];
  } else {
    nm1d2 = 1;
  }

  emxFree_real_T(&c);
  i0 = x_d->size[0];
  x_d->size[0] = nm1d2;
  emxEnsureCapacity_real_T1(x_d, i0);
  for (i0 = 0; i0 < nm1d2; i0++) {
    x_d->data[i0] = 0.0;
  }

  i0 = x_colidx->size[0];
  x_colidx->size[0] = 130;
  emxEnsureCapacity_int32_T1(x_colidx, i0);
  x_colidx->data[0] = 1;
  i0 = x_rowidx->size[0];
  x_rowidx->size[0] = nm1d2;
  emxEnsureCapacity_int32_T1(x_rowidx, i0);
  for (i0 = 0; i0 < nm1d2; i0++) {
    x_rowidx->data[i0] = 0;
  }

  nm1d2 = 0;
  for (k = 0; k < 129; k++) {
    while ((nm1d2 + 1 <= nc) && (cidxInt->data[nm1d2] == k + 1)) {
      x_rowidx->data[nm1d2] = ridxInt->data[nm1d2];
      nm1d2++;
    }

    x_colidx->data[k + 1] = nm1d2 + 1;
  }

  emxFree_int32_T(&cidxInt);
  emxFree_int32_T(&ridxInt);
  for (k = 0; k < nc; k++) {
    x_d->data[k] = v->data[sortedIndices->data[k] - 1];
  }

  emxFree_int32_T(&sortedIndices);
  emxFree_real_T(&v);
  idx = 1;
  for (k = 0; k < 129; k++) {
    nm1d2 = x_colidx->data[k];
    x_colidx->data[k] = idx;
    while (nm1d2 < x_colidx->data[k + 1]) {
      b4 = 0.0;
      nc = x_rowidx->data[nm1d2 - 1];
      while ((nm1d2 < x_colidx->data[k + 1]) && (x_rowidx->data[nm1d2 - 1] == nc))
      {
        b4 += x_d->data[nm1d2 - 1];
        nm1d2++;
      }

      if (b4 != 0.0) {
        x_d->data[idx - 1] = b4;
        x_rowidx->data[idx - 1] = nc;
        idx++;
      }
    }
  }

  x_colidx->data[129] = idx;

  /*  */
  /*  plot results if no output arguments or g option given */
  /*  */
}

/*
 * File trailer for melbankm.c
 *
 * [EOF]
 */
