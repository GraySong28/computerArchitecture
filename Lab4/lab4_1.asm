;������� �ணࠬ��, ����� ��।���� � ������ ᫮��
;(�. ⠡���� #1) ᮤ�ন��� ࠧ�冷� i � i + 1 � �ନ��� �᫮ � � ����:
;		0, �᫨ i = 0 � i + 1 = 0
;� = 	1, �᫨ i = 0 � i + 1 = 1
;		2, �᫨ i = 1 � i + 1 = 0
;		3, �᫨ i = 1 � i + 1 = 1,
;��� i - ����� ��ਠ��.
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
myWorld dw	068DEh
otvet	dw	?
maska1	dw	0000000000000010b
maska2	dw	0000000000000100b


MAIN    proc    near
		;��� �������
		mov ax, myWorld; ������ � ॣ���� ax ᫮�� ᢮��� ��ਠ��
		and ax, maska1; �஢��� ������ �����᪮�� � �� ����� ������� ��᪨, �⮡� 㧭��� ���祭�� ��ண� ��� ᫮��
		mov bx, myWorld;
		and bx, maska2; �஢��� ������ �����᪮�� � �� ����� ������� ��᪨, �⮡� 㧭��� ���祭�� ���쥣� ��� ᫮��
		cmp ax, 0
		jz metka1; �᫨ ��ன ��� �᫠ ࠢ�� 0, ��६�頥��� �� metka1
		cmp ax, 1
		jz metka2; �᫨ ��ன ��� �᫠ ࠢ�� 1, ��६�頥��� �� metka2
		
		metka1:
			cmp bx, 0 ; �᫨ ��⨩ ��� �᫠ ࠢ�� 0 ��६�頥��� �� metka1_1, �᫨ ���, ����� �⢥� = 1
			jz metka1_1
			mov otvet, 1
				jmp exit
			metka1_1:
				mov otvet, 0; �᫨ ��⨩ ��� �᫠ ࠢ�� 1, ����� �⢥� = 1
				jmp exit
				
		metka2:
			cmp bx, 0 ; �᫨ ��⨩ ��� �᫠ ࠢ�� 0 ��६�頥��� �� metka2_1, �᫨ ���, ����� �⢥� = 3
			jz metka2_1
			mov otvet, 3
				jmp exit
			metka2_1:
				mov otvet, 2; �᫨ ��⨩ ��� �᫠ ࠢ�� 1, ����� �⢥� = 1
				jmp exit
        ;᢮� १���� ������ � ax ��। �⮩ ��ப��
		exit:
		mov ax, otvet
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

