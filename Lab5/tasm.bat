cls
D:\Sharaga\Arch\Lab5\tasm lab5.asm
if errorlevel 1 goto oshibka
D:\Sharaga\Arch\Lab5\tlink lab5.obj /t
del lab5.obj
del lab5.map
:oshibka
pause