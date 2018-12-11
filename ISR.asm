; ISR.asm
; Name: Ronak Patel & Ethan Golla
; UTEid: rhp544 & emg2952
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
		ST R0, save0
		ST R1, save1
		LDI R0, KBDR
		LD R1, leta
		ADD R1, R1, R0
		BRz valid		
		LD R1, letc
		ADD R1, R1, R0
		BRz valid
		LD R1, letg
		ADD R1, R1, R0
		BRz valid
		LD R1, letu
		ADD R1, R1, R0
		BRnp isrdone
valid		STI R0, buff
isrdone		LD R0, save0
		LD R1, save1
		RTI
save0		.BLKW 1
save1		.BLKW 1
buff		.FILL x4600
KBDR		.FILL xFE02
leta		.FILL x-41
letc		.FILL x-43
letg		.FILL x-47
letu		.FILL x-55
		.END
