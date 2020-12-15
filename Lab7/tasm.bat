cls
D:\Sharaga\Arch\Lab6\tasm lab7.asm
if errorlevel 1 goto oshibka
D:\Sharaga\Arch\Lab5\tlink lab7.obj /t
del lab7.obj
del lab7.map
:oshibka
pause