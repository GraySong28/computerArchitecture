;Написать программу, которая определяет в данном слове
;(см. таблицу #1) содержимое разрядов i и i + 1 и формирует число К в виде:
;		0, если i = 0 и i + 1 = 0
;К = 	1, если i = 0 и i + 1 = 1
;		2, если i = 1 и i + 1 = 0
;		3, если i = 1 и i + 1 = 1,
;где i - номер варианта.
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
myWorld dw	068DEh
otvet	dw	?
maska1	dw	0000000000000010b
maska2	dw	0000000000000100b


MAIN    proc    near
		;Мои команды
		mov ax, myWorld; помещаю в регистр ax слово своего варианта
		and ax, maska1; провожу операцию логического и при помощи заданой маски, чтобы узнать значение второго бита слова
		mov bx, myWorld;
		and bx, maska2; провожу операцию логического и при помощи заданой маски, чтобы узнать значение третьего бита слова
		cmp ax, 0
		jz metka1; если второй бит числа равен 0, перемещаемся на metka1
		cmp ax, 1
		jz metka2; если второй бит числа равен 1, перемещаемся на metka2
		
		metka1:
			cmp bx, 0 ; если третий бит числа равен 0 перемещаемся на metka1_1, если нет, значит Ответ = 1
			jz metka1_1
			mov otvet, 1
				jmp exit
			metka1_1:
				mov otvet, 0; если третий бит числа равен 1, значит Ответ = 1
				jmp exit
				
		metka2:
			cmp bx, 0 ; если третий бит числа равен 0 перемещаемся на metka2_1, если нет, значит Ответ = 3
			jz metka2_1
			mov otvet, 3
				jmp exit
			metka2_1:
				mov otvet, 2; если третий бит числа равен 1, значит Ответ = 1
				jmp exit
        ;свой результат занести в ax перед этой строкой
		exit:
		mov ax, otvet
		mov     date,ax
		call    DISP
		ret
MAIN    endp            

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

