; Author : Matthew Romleski
; Tech ID: 12676184
; Program which runs through a size 40 array of 8-bit elements and counts the number of elements that are divisible by 8.

		.include <atxmega128A1Udef.inc>

		.dseg
		.def	countReg = r0
		.def	storeReg = r16
		.def	loopConReg = r17

		.cseg
		.org	0x00
		rjmp	start
		.org	0xF6

start:	ldi		ZL, low(array << 1) ; Gets the byte address of the program memory.
		ldi		ZH, high(array << 1) ; ^^
		ldi		loopConReg, 1 ; Initial 

loop:	cpi		loopConReg, 41 ; Checks if the loop has gone through all the elements.
		breq	done ; Branches if it has.
		lpm		storeReg, Z+ ; Loads the element into the register.
		andi	storeReg, 7 ; Ands it with 0000 0111. If the result is > 0, then it had the 0th||1st||2nd bit set.
		cpi		storeReg, 0 ; If storeReg & 7 = 0 (0||1||2 bit NOT set), sets Z in SREG to 1.
		brne	loopCn ; and if Z = 0, then this skips the count increment.
		inc		countReg

loopCn:	inc		loopConReg
		jmp		loop

done:	rjmp	done

array:	.db		 1,  2,  3,  4,  5,  6,  7,  8,  9, 10
		.db		11, 12, 13, 14, 15, 16, 17, 18, 19, 20
		.db		21, 22, 23, 24, 25, 26, 27, 28, 29, 30
		.db		31, 32, 33, 34, 35, 36, 37, 38, 39, 40