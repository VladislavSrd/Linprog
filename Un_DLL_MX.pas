unit Un_DLL_MX;

interface
type
  pDouble = ^Double;
  mxComplexty = (mxREAL, mxCOMPLEX);pmxArray=^mxArray;
  mxArray=record
  end;
 //Из библиотеки libmx.dll
 function mxCreateDoubleMatrix(m,n:Integer;
      mxData:mxComplexty):pmxArray; cdecl; external 'libmx.dll';
  procedure mxSetName(arr_ptr:pmxArray; const name:String);
       cdecl; external 'libmx.dll';
  function mxGetPr(arr_ptr:pmxArray):pDouble;cdecl; external 'libmx.dll';
  function mxGetPi(arr_ptr:pmxArray):pDouble;cdecl; external 'libmx.dll';
  function mxGetM(arr_ptr:pmxArray):Integer; cdecl; external 'libmx.dll';
  function mxGetN(arr_ptr:pmxArray):Integer; cdecl; external 'libmx.dll';
 procedure mxDestroyArray(arr_ptr:pmxArray); cdecl; external 'libmx.dll';
  procedure mxFree(var ram:THandle); cdecl; external 'libmx.dll';
  function mxTranspose(x:pmxArray):pmxArray; cdecl; external 'libmx.dll';
  // Из библиотеки mclmcr.dll
  function mclInitializeApplication(A:THandle;B:Integer):Boolean;
        cdecl; external 'mclmcr.dll';
  function mclTerminateApplication:Boolean; cdecl; external 'mclmcr.dll';
  //Из моей библиотеки lpa_dll
  function _linprogInitialize:Boolean; cdecl; external 'linprog.dll';
  function _linprogTerminate:Boolean; cdecl; external 'linprog.dll';
  procedure _mlfLp121(i:Integer; var pout:pmxArray; f,A,b,lb:pmxArray);
      cdecl; external 'linprog.dll';

implementation

end.
