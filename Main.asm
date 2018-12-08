; Main.asm
; Name: Ronak Patel & Ethan Golla
; UTEid: rhp544 & emg2952 
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
               .ORIG x4000
; initialize the stack pointer
		LD R6, sp

; set up the keyboard interrupt vector table entry
		LD R0, isradr
		STI R0, ivt

; enable keyboard interrupts
		LD R0, sp
		STI R0, kbsr


; start of actual program
		AND R0, R0, #0
		AND R1, R1, #0
		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
		STI R0, buffer		; Loop for checking new char in buffer
loop		LDI R1, buffer
		BRz loop		
		STI R0, buffer
		ADD R4, R3, #0
		ADD R3, R2, #0
		ADD R2, R1, #0
		LD R5, leta		;Begin check for start codon
		ADD R5, R5, R4
		BRnp notstart
		LD R5, letu
		ADD R5, R5, R3
		BRnp notstart
		LD R5, letg
		ADD R5, R5, R2
		BRnp notstart		
		STI R1, ddr			;Start Codon has been entered
		LD R5, pipe
		STI R5, ddr
		BRnzp code
notstart	STI R1, ddr
		BRnzp loop



code		AND R2, R2, #0
		AND R3, R3, #0
		AND R4, R4, #0
repeat		LDI R1, buffer
		BRz repeat		
		STI R0, buffer
		ADD R4, R3, #0
		ADD R3, R2, #0
		ADD R2, R1, #0
		LD R1, letu
		ADD R1, R1, R4
		BRnp run
		LD R1, leta
		ADD R1, R1, R3
		BRz checkmore
		LD R1, letg
		ADD R1, R1, R3
		BRnp run
checka		LD R1, leta
		ADD R1, R1, R2
		BRz stop
		BRnp run
checkmore	LD R1, letg
		ADD R1, R1, R2
		BRnp checka
stop		STI R2, ddr		
		TRAP x25
run		STI R2, ddr
		BRnzp repeat
leta		.FILL x-41
letc		.FILL x-43
letg		.FILL x-47
letu		.FILL x-55
buffer		.FILL x4600
pipe		.FILL x7C
kbsr		.FILL xFE00
ddr		.FILL xFE06
ivt		.FILL x0180
isradr		.FILL x2600
sp		.FILL x4000
		.END
