rem @echo off
set clang=D:\library\LLVM9\bin\clang-cl.exe /O2 /Ob2 /Ot -D_CRT_NONSTDC_NO_WARNINGS -DCONFIG_VERSION=\"2020-01-05\"  -D_CRT_SECURE_NO_WARNINGS -DWIN32_LEAN_AND_MEAN
rem %clang% -c test.c
rem %clang% -c libbf.c -o libbf.o
%clang% -c libregexp.c -o libregexp.o
%clang% -c libunicode.c -o libunicode.o
%clang% -c cutils.c -o cutils.o
%clang% -c quickjs.c -o quickjs.o -DEMSCRIPTEN=1
%clang% -c quickjs-libc.c -o quickjs-libc.o
%clang% -c getopt.c -o getopt.o
%clang% qjsc.c libregexp.o libunicode.o quickjs.o quickjs-libc.o cutils.o getopt.o -o qjsc.exe
.\qjsc.exe -c -o repl.c -m repl.js
%clang% -c repl.c -o repl.o
%clang% qjs.c libregexp.o libunicode.o quickjs.o quickjs-libc.o cutils.o getopt.o repl.o -o qjs.exe
rem pause