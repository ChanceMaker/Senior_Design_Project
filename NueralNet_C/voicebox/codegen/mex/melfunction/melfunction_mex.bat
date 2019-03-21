@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2018a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2018a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=melfunction_mex
set MEX_NAME=melfunction_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2018a\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for melfunction > melfunction_mex.mki
echo COMPILER=%COMPILER%>> melfunction_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> melfunction_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> melfunction_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> melfunction_mex.mki
echo LINKER=%LINKER%>> melfunction_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> melfunction_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> melfunction_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> melfunction_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> melfunction_mex.mki
echo OMPFLAGS= >> melfunction_mex.mki
echo OMPLINKFLAGS= >> melfunction_mex.mki
echo EMC_COMPILER=lcc64>> melfunction_mex.mki
echo EMC_CONFIG=optim>> melfunction_mex.mki
"C:\Program Files\MATLAB\R2018a\bin\win64\gmake" -j 1 -B -f melfunction_mex.mk
