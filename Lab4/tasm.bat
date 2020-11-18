cls
D:\Sharaga\Arch\Lab4\tasm lab4_2.asm
if errorlevel 1 goto oshibka
D:\Sharaga\Arch\Lab4\tlink lab4_2.obj /t
del lab4_2.obj
del lab4_2.map
:oshibka
pause