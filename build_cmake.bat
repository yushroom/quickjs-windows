if not exist build mkdir build
cd build
cmake -G "Visual Studio 15 2017 Win64" ..
cmake --build . --target qjsc --config Release

cd ..
set qjsc=".\build\Release\qjsc.exe"
%qjsc% -c -o repl.c -m repl.js
rem %qjsc% -c -o qjscalc.c qjscalc.js

cd build
cmake ..
cmake --build . --target qjs --config Release

pause