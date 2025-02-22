
clearScreen proc far
    push es        
    push di        
    mov ax, 0A000h 
    mov es, ax
    xor di, di     
    mov al, 0      
    mov cx, 64000  

    rep stosb      

    pop di         
    pop es         
    ret
clearScreen endp

  
  
printDecScore proc
    mov cx, 0
    mov dx, 0
    label1:
        cmp ax, 0
        je print1
        mov bx, 10
        div bx
        push dx
        inc cx
        mov dx, 0
        jmp label1
    print1:
        cmp cx, 0
        je exitpr
        pop dx
        add dx, 30h
        mov ah, 02h
        int 21h
        dec cx
        jmp print1
    exitpr:

ret

calcscore proc far 
    xor dx , dx 
    mov ax , [clock]
    mov cx , [scoreSpeed]
    div cx 
    cmp dx , 0
    jne exitCalcScore
    mov ax , [score]
    inc ax 
    mov [score] , ax 
    exitCalcScore:  
ret
calcscore endp