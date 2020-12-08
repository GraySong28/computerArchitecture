ded segment 'code'
	assume cs:ded, ds:ded, ss:ded, es:ded
	org 100h
begin: jmp main
; Переменные
num dt 0ADFF2F7FFF007CFC0032h
counter db 0 ; кол-во нулей в заданом числе
dozens DB ?
units DB ?
str0 db 'Contents of a given number of 10 bytes: $'
str1 db 10,13,'The number of zeros in a given number = $'
;---------------------------------
main proc near
; Код
	mov bp, 0 ; номер байта на котором сейчас находимся
	mov cx, 10 ; цикл по количеству байт числа
; начало внешнего цикла
m1: 	push cx ; помещаю в стек счетчик цикла
		mov al, byte ptr [num+bp] ; помещаю в регистр al bp байт
		; начало вложеного цикла по 8 байтам
		mov cx, 8 ; цикл по кол-ву битов в байте
m2: 	test al, 00000001b ; проверяю нулевой бит в байте
		jne m3 ; если он не равен 0, то продолжаем цикл, если равен увеличиваем счётчик
		add counter,1 ; увеличение счетчика
m3: 	shr al, 1 ; сдвигаю al на бит вправо
		loop m2 ; конец цикла по кол-ву битов в байте
		; конец вложеного цикла по 8 байтам
		add bp, 1 ; переход к следущему байту
		pop cx ; выталкиваю из стека счетчик цикла
		loop m1 ; конец цикла по количеству байтов
		; конец внешнего цикла
		
	; Вывод строки str0
	mov ah, 09h
	lea dx, str0
	int 21h
	
	; Вывод исходного числа в двоичном виде
	mov bp, 9
	mov cx, 10
	m23: push cx
	mov bl,byte ptr [num+bp]
	; вывод одного байта
	mov cx, 8
	m25: push cx
	test bl, 10000000b

	je m26
	mov ah, 02h ; вывод 1.
	mov dl, '1'
	int 21h
	jmp m27
	m26: ; вывод 0.
	mov ah, 02h
	mov dl, '0'
	int 21h
	m27: shl bl, 1 ; сдвиг влево на 1 бит
	pop cx
	loop m25
	mov ah, 02h ; вывод пробела после вывода 8 бит
	mov dl, ' '
	int 21h
	sub bp, 1 ; переход к следующему байту
	pop cx
	loop m23
	; конец вывода в двоичном виде
	
	; вывод результата
	mov al, counter
	cbw
	mov bl, 10
	idiv bl ; в al десятки, в ah единицы
	mov dozens, al
	mov units, ah
	; вывод строки str1
	mov ah, 09h
	lea dx, str1
	int 21h
	; вывод числа
	mov ah, 02h ; вывод десятков
	mov dl, dozens
	add dl, 30h
	int 21h
	mov ah, 02h
	mov dl, units ; вывод единиц
	add dl, 30h
	int 21h
	mov ah, 08 ; ожидание нажатия клавиши
	int 21h
ret
main endp
ded ends
	end begin