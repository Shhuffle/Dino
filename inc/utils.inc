
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




scoreObjectspeed proc far 


mov cx , [score] ;

cmp cx , 10
ja speed2

mov [objectSpeed] , 1 
mov [scoreSpeed] , 70
jmp Speedexit
speed2:


cmp cx , 50
ja speed3

mov [objectSpeed] , 2

mov [scoreSpeed] , 50 
jmp Speedexit
speed3:


cmp cx , 200
ja speed4

mov [objectSpeed] , 3 

    mov [scoreSpeed] , 50 
    jmp Speedexit
    speed4:


cmp cx , 300
ja speed5

mov [objectSpeed] , 4 

    mov [scoreSpeed] , 40 
    jmp Speedexit
    speed5:

    Speedexit:


ret
scoreObjectspeed endp