cls
D:\Sharaga\Arch\Lab6\tasm lab6.asm
if errorlevel 1 goto oshibka
D:\Sharaga\Arch\Lab5\tlink lab6.obj /t
del lab6.obj
del lab6.map
:oshibka
pause