;Написать программу, основная часть которой выполняет следующие действия:
;1) передает через стек параметры в первую процедуру Z = A/B, X1, X2.
;2) вычисляет значение выражения Y1=A1/A2-4 и передает его во вторую процедуру.
;3) первая процедура возвращает в основную программу значение
;переменной Y, вычисляющееся по формуле: 
;Y = X1 + X2, если Z > 1 
;Y = X1/X2, если Z <= 1
;4) вторая процедура возвращает в основную программу значение
;переменной Y2, вычисляющееся по формуле:
;Y2 = 0, если Y1 > 10
;Y2 = 1, если Y1 <= 10
;---------------------------------
wow    segment  'code'
       assume   cs:wow, ds:wow, ss:wow, es:wow
       org     100h
begin: jmp     main   
;---------------------------------
date    dw      ?
my_s    db     '+'
T_Th    db      ?
Th      db      ?
Hu      db      ?
Tens    db      ?
Ones    db      ?
;---------------------------------
; Мои переменные
a		dw		24
a1		dw		16
a2		dw		4
b		dw		6
x1		dw		9
x2		dw		3
z		dw		?
y		dw		?
y1		dw		?
y2		dw		?

MAIN    proc    near
		;Мои команды
		; расчитываю z
		push x1
		mov ax, a
		cwd
		mov bx, b
		div bx ; расчитал a/b, результат в ax
		mov z, ax
		call Proc1; вызываю процедуру 1
		call Proc2; вызываю процедуру 2
		
		mov ax, y
		mov date,ax
		call DISP
		ret
MAIN    endp        

;
Proc1	proc	near
		; вычисляем Y1=A1/A2-4
		mov ax, a1
		cwd
		mov bx, a2
		div bx
		sub ax, 4
		mov y1, ax
		cmp z, 1; сравнение z с 1, если Z > 1, продрлжаем, если Z <= 1 на метку m1
		jl m1
		; Z > 1, значит Y = X1 + X2
		mov ax, x1
		add ax, x2
		jmp exit
		m1:; Z <= 1, значит Y = X1/X2 
			mov ax, x1
			cwd
			mov bx, x2
			div bx
		exit:
			mov y, ax; значение попадает в y
        ret
Proc1	endp
Proc2	proc	near
		; нахожу значение y2
		cmp y1, 10; сравнение y1 с 10, Y1 > 10, продрлжаем, если Y1 <= 10 на метку m2
		jl m2
		; Y1 > 10, значит Y2 = 0
		mov y2, 0
		jmp vihod
		m2: ; Y1 <= 10, значит Y2 = 1
			mov y2, 1
		vihod:
		ret
Proc2	endp
; Процедура выводит результат вычислений, помещенный в data
DISP proc near 
;----- Вывод результата на экран ----------------
;--- Число отрицательное ?----------
        mov     ax,date               
        and     ax,1000000000000000b
        mov     cl,15
        shr     ax,cl
        cmp     ax,1
        jne     @m1
        mov     ax,date
        neg     ax
        mov     my_s,'-'
        jmp     @m2
;--- Получаем десятки тысяч ---------------
@m1:    mov     ax,date
@m2:    cwd     
        mov     bx,10000
        idiv    bx
        mov     T_Th,al
;------- Получаем тысячи ------------------------------
        mov     ax,dx
        cwd
        mov     bx,1000
        idiv    bx
        mov     Th,al
;------ Получаем сотни ---------------
        mov     ax,dx
        mov     bl,100
        idiv    bl
        mov     Hu,al
;---- Получаем десятки и единицы ----------------------
        mov     al,ah   
        cbw
        mov     bl,10
        idiv    bl
        mov     Tens,al
        mov     Ones,ah
;--- Выводим знак -----------------------
        cmp     my_s,'+'
        je      @m500
        mov     ah,02h
        mov     dl,my_s
        int     21h
;----------  Выводим цифры -----------------
@m500:  cmp     T_TH,0    ; проверка на ноль
        je      @m200
        mov     ah,02h    ; выводим на экран, если не ноль
        mov     dl,T_Th
        add     dl,48
        int     21h

@m200:  cmp     T_Th,0
        jne     @m300
        cmp     Th,0
        je      @m400
@m300:  mov     ah,02h
        mov     dl,Th
        add     dl,48
        int     21h

@m400:  cmp     T_TH,0
        jne     @m600
        cmp     Th,0
        jne     @m600
        cmp     hu,0
        je      @m700
@m600:  mov     ah,02h
        mov     dl,Hu
        add     dl,48
        int     21h

@m700:  cmp     T_TH,0
        jne     @m900
        cmp     Th,0
        jne     @m900
        cmp     Hu,0
        jne     @m900 
        cmp     Tens,0
        je      @m950
@m900:  mov     ah,02h
        mov     dl,Tens
        add     dl,48
        int     21h

@m950:  mov     ah,02h
        mov     dl,Ones
        add     dl,48
        int     21h     
        
        mov     ah,02h
        mov     dl,10
        int     21h
        mov     ah,02h
        mov     dl,13
        int     21h
;-------------------------------------
        mov     ah,08
        int     21h
        ret
DISP    endp 

wow     ends
        end     begin 

