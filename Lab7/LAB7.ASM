ded segment 'code'
	assume cs:ded
	org 100h
begin: jmp main
; Данные
magazin db 10, 'Globus    ', 15, 'Phoenix   '
	db 20, 'Prizma    ', 22, 'PapaPizza '
	db 25, 'GameOver  ', 26, 'Tesla     '
	db 37, 'Hex       ', 48, 'Spike     '
	db 69, 'Laguna    ', 70, 'Invoke    '
result 	db 12 Dup(?),'$'
buf	db 3, 3 Dup(?)
summa	db ?
mes	db 'Введите прибыль магазина:$'
netu	db 'Такого магазина нет! $'
eter	db 10, 13, '$'
;#############
main proc near
;Вывод первого сообщения
	mov ah, 09
	lea dx, mes
	int 21h
;Ввод пользователем значения
	mov ah,0ah
	lea dx, buf
	int 21h
;Преобразование числа в строку
	mov bl, buf + 2
	sub bl, 30h
	mov al, 10
	imul bl

	mov bl, buf+3
	sub bl, 30h
	
	add al, bl
	mov summa, al
; Вывод пустой строки
	mov ah, 09h
	lea dx, eter
	int 21h
; Сканирование таблицы городов
	cld
	mov cx, 110
	lea di, magazin
	mov al, summa
repne scasb
	je @m2
; Если совпадений нет
	mov ah, 09h
	lea dx, netu
	int 21h
	jmp @m3
; Запись результата
@m2:
	cld
	mov si, di
	lea di, result
	mov cl, 10
rep movsb
	mov ah, 09h
	lea dx, result
	int 21h
@m3:
	mov ah, 08
	int 21h
	ret
main endp
ded ends
	end begin