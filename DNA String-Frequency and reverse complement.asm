;PENANO and PUNO
%include "io.inc"

section .data
    DNA times 256 db 0
nCOUNT db 0
    nA db 0
    nC db 0
    nG db 0
    nT db 0
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    PRINT_STRING "DNA Input: "
    GET_STRING [DNA], 256
    PRINT_STRING [DNA]
    mov ah, 0x0
    lea esi, [DNA]

L1:
    mov al, [esi]
    cmp AL, 0
    je NULL_INPUT
    cmp al, 'A'
    je COUNT_A
    cmp al, 'C'
    je COUNT_C
    cmp al, 'G'
    je COUNT_G
    cmp al, 'T'
    je COUNT_T
    jmp INVALID

COUNT_A:
    cmp ah, 0x1
    je PRINT_T
    inc byte[nA]
    jmp NEXT
    
COUNT_C:
    cmp ah, 0x1
    je PRINT_G
    inc byte[nC]
    jmp NEXT
    
COUNT_G:
    cmp ah, 0x1
    je PRINT_C
    inc byte[nG]
    jmp NEXT
   
COUNT_T:
    cmp ah, 0x1
    je PRINT_A
    inc byte[nT]
    jmp NEXT
    
PRINT_A:
    PRINT_CHAR 'A'
    jmp IS_END

PRINT_C: 
    PRINT_CHAR 'C'
    jmp IS_END

PRINT_G:
    PRINT_CHAR 'G'
    jmp IS_END

PRINT_T:
    PRINT_CHAR 'T'
    jmp IS_END 
       
IS_END:
    dec esi
    mov al, [esi]
    cmp al, 0x0
    je EXIT
    jmp L1
    
NEXT:
    inc byte[nCOUNT]
    inc esi
    mov al, [esi]    
    cmp al, 0x0
    je DISPLAY_COUNT
    jmp L1
   
NULL_INPUT: NEWLINE
      PRINT_STRING "Error: Null input"
      JMP EXIT
      
INVALID:
    NEWLINE
    PRINT_STRING "Error: Invalid character(s) found"   
    jmp EXIT
    
DISPLAY_COUNT:
    NEWLINE
    PRINT_STRING "DNA string length: "
    PRINT_UDEC 1, [nCOUNT]
    NEWLINE
    PRINT_STRING "Frequency of A: "
    PRINT_UDEC 1, [nA]
    NEWLINE
    PRINT_STRING "Frequency of C: "
    PRINT_UDEC 1, [nC]
    NEWLINE
    PRINT_STRING "Frequency of G: "
    PRINT_UDEC 1, [nG]
    NEWLINE
    PRINT_STRING "Frequency of T : "
    PRINT_UDEC 1, [nT]
    NEWLINE
    jmp COMPLEMENT
      
COMPLEMENT: 
    PRINT_STRING "Reverse complement of the DNA string:"
    inc ah
    dec esi
    jmp L1
    
EXIT:
    xor eax, eax
    ret