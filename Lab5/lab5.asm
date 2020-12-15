;������� �ணࠬ�� �� �몥 ��ᥬ���� ��� ���᫥��� ���祭��
;��।�������� ��⥣ࠫ� �� ��⮤� ��אַ㣮�쭨���.
;3 - 5x + (x^2/5)
; �஬���⮪ ��⥣�஢���� [0;2]
; ������⢮ ࠧ������ 40
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
; ��� ��६����
s 		dw 		0 ; �㬬�
a 		dw 		0 ; ��砫�
b 		dw 		40 ; �����
x 		dw 		? ; ⥪��� �窠

MAIN    proc    near
		;��� �������
		mov ax, a ; ������ ��砫��� ���
		mov x, ax
		mov cx, 39 ; ���稪 横��
	m1:
		imul x ; dx:ax = x*x
		mov bx, 5
		idiv bx ; ax = x*x/5
		push ax
		mov al, 5
		imul x ; ax = 5 * x
		mov bx, ax
		mov ax, 3
		sub ax, bx ; ax = 3 - 5x
		pop bx
		add ax, bx ; ax = 3 - 5x + x*x/5
		add s, ax
		add x, 1
		mov ax, x
		loop m1

		mov ax, s
		cwd
		mov bx, 40
		idiv bx
		
		mov s, ax
		mov ax, s
		mov     date,ax
		call    DISP
		ret
MAIN    endp            

; ��楤�� �뢮��� १���� ���᫥���, ����饭�� � data
DISP proc near 
;----- �뢮� १���� �� �࠭ ----------------
;--- ��᫮ ����⥫쭮� ?----------
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
;--- ����砥� ����⪨ ����� ---------------
@m1:    mov     ax,date
@m2:    cwd     
        mov     bx,10000
        idiv    bx
        mov     T_Th,al
;------- ����砥� ����� ------------------------------
        mov     ax,dx
        cwd
        mov     bx,1000
        idiv    bx
        mov     Th,al
;------ ����砥� �⭨ ---------------
        mov     ax,dx
        mov     bl,100
        idiv    bl
        mov     Hu,al
;---- ����砥� ����⪨ � ������� ----------------------
        mov     al,ah   
        cbw
        mov     bl,10
        idiv    bl
        mov     Tens,al
        mov     Ones,ah
;--- �뢮��� ���� -----------------------
        cmp     my_s,'+'
        je      @m500
        mov     ah,02h
        mov     dl,my_s
        int     21h
;----------  �뢮��� ���� -----------------
@m500:  cmp     T_TH,0    ; �஢�ઠ �� ����
        je      @m200
        mov     ah,02h    ; �뢮��� �� �࠭, �᫨ �� ����
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

