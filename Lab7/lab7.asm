nata segment 'code'
assume cs:nata
org 100h
begin: jmp main
;--------------------------------- DATA
Gorod 	DB 30, 'Горловка ', 10,'Makeevka ' ; 12 символов на город
		DB 33, 'Шахтерск ', 70,'Снежное '
		DB 90, 'Торез ', 80,'Иловайск '
		DB 75, 'Дебальцево ', 20,'Ясиноватая '
		DB 35, 'Харцызск '
Rezult 	DB 12 Dup(?),'$'
Buf 	DB 3,3 Dup(?)
Distance DB ?
Mes 	DB 'Magazina s takoi pribiliy net !$'
Eter 	DB 10,13,'$'
Podskaz DB 'Vvedite pribil:$'
;---------------------------------
main proc near
;------------------------------------- PROGRAM
; ------ Подсказка -------
mov ah,09
lea dx,podskaz
int 21h
; Ввод строки
mov ah,0ah
lea dx,Buf
int 21h
; Преобразование символов в число
; Получаем десятки из буфера
mov bl,buf+2
sub bl,30h
mov al,10
imul bl ; в al - десятки
; Получаем единицы из буфера
mov bl,buf+3
sub bl,30h
; Складываем ------
add al,bl
mov distance,al ; сохраняем в distance
; -------- Переход на новую строку ---
mov ah,09h
lea dx,eter
int 21h
; --- сканирование таблицы городов ----
cld ; искать слева направо

mov cx,117 ; сколько байт сканировать
lea di,gorod ; строка, где искать
mov al,distance ; что искать
repne scasb ; поиск
je @m2
; ------- Сообщение об отсутствии города
mov ah,09h
lea dx,Mes
int 21h
jmp @m3 ; выходим из программы
; -------- переписываем в результат
@m2:
cld
mov si,di
lea di,rezult
mov cl,12
rep movsb
; ----- Вывод результата ----
mov ah,09h
lea dx,rezult
int 21h
;-------------------------------------
@m3: mov ah,08
int 21h
ret
main endp
nata ends
end begin