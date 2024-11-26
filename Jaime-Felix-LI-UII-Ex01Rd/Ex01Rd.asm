					TITLE	Programa para concatenar dos cadenas

; Prototipos de llamadas al sistema operativo
GetStdHandle	PROTO	:QWORD
ReadConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
WriteConsoleW	PROTO	:QWORD,	:QWORD, :QWORD, :QWORD, :QWORD
ExitProcess		PROTO	CodigoSalida:QWORD

				.DATA
Cadena01		WORD	40 DUP ( ? )
Cadena02		WORD	40 DUP ( ? )
Cadena03		WORD	80 DUP ( ? )
LongCadena01	QWORD	?
LongCadena02	QWORD	?
LongCadena03	QWORD	?
MenEnt01		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 'p', 'r', 'i', 'm', 'e', 'r', 'a', ' ', 'c', 'a', 'd', 'e', 'n', 'a', ':', ' '
MenEnt02		WORD	'P', 'r', 'o', 'p', 'o', 'r', 'c', 'i', 'o', 'n', 'e', ' ', 'l', 'a', ' ', 's', 'e', 'g', 'u', 'n', 'd', 'a', ' ', 'c', 'a', 'd', 'e', 'n', 'a', ':', ' '
; Definir el mensaje de salida correspondiente

; Variables utilizadas por las llamadas al sistema
ManejadorE		QWORD	?
ManejadorS		QWORD	?
Caracteres		QWORD	?
SaltoLinea		WORD	13, 10
STD_INPUT		EQU		-10
STD_OUTPUT		EQU		-11

				.CODE
Principal		PROC

				; Alinear espacio en la pila
				SUB		RSP, 40

				; Obtener manejador estándar del teclado
				MOV		RCX, STD_INPUT
				CALL	GetStdHandle
				MOV		ManejadorE, RAX

				; Obtener manejador estándar de la consola
				MOV		RCX, STD_OUTPUT
				CALL	GetStdHandle
				MOV		ManejadorS, RAX

				; Solicitar la primera cadena
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, MenEnt01				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF MenEnt01		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				MOV		RCX, ManejadorE				; Manejador del teclado donde se lee la cadena
				LEA		RDX, Cadena01				; Dirección de la cadena a leer
				MOV		R8, LENGTHOF Cadena01		; Número de caracteres máximo a leer
				LEA		R9, LongCadena01			; Dirección de la variable donde se guarda el total de caracteres leídos
				MOV		R10, 0						; Reservado para uso futuro
				CALL	ReadConsoleW

				SUB		LongCadena01, 2				; Para eliminar el <Enter>

				; Solicitar la segunda cadena

				; Debe copiar toda la primera cadena a la tercera cadena.
				; Después debe copiar toda la segunda cadena a la tercera cadena sin volver a inicializar el registro RDI.

				; Mostrar el resultado correspondiente
				; La tercer cadena en pantalla

				; Salto de línea
				MOV		RCX, ManejadorS				; Manejador de la consola donde se escribe
				LEA		RDX, SaltoLinea				; Dirección de la cadena a escribir
				MOV		R8, LENGTHOF SaltoLinea		; Número de caracteres a escribir
				LEA		R9, Caracteres				; Dirección de la variable donde se guarda el total de caracteres escrito
				MOV		R10, 0						; Reservado para uso futuro
				CALL	WriteConsoleW

				; Salir al sistema operativo
				MOV		RCX, 0
				CALL	ExitProcess

Principal		ENDP
				END