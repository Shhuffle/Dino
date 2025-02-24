
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

    ; if is in sprint mode just exit
    cmp isInSprintMode, 1
    je Speedexit
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
    mov [scoreSpeed] , 60 
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
    cmp cx , 300
    ja speed6
    mov [objectSpeed] , 5 
    mov [scoreSpeed] , 40 
    jmp Speedexit
    
    speed6:
    cmp cx , 400
    ja Speedexit
    mov [objectSpeed] , 6 
    mov [scoreSpeed] , 30 
    Speedexit:
ret
scoreObjectspeed endp


Reset proc far  
        inc byte ptr [totalSession]
        mov byte ptr [score] , 0 
        mov byte ptr[clock] , 0
        mov byte ptr[scoreSpeed] , 70
        mov byte ptr[isInSprintMode] , 0
        mov byte ptr[gamestate] , 0
        lea di , objectdimen
        lea si , dinodimen
        mov bl , [totalSession]
        ;Reset the dimension for the dino 40 , 140 , 120 , 165 , 130, 0 ,0 
        mov byte ptr[si] ,  bl
        mov byte ptr[si+2] , 140
        mov byte ptr[si+4] , 120
        mov byte ptr[si+6] , 165
        mov byte ptr[si+8] , 130
        mov byte ptr[si+10] , 0
        mov byte ptr[si+12] , 0
        inc byte ptr [totalSession]
        mov bl , [totalSession]
        ;Reset the dimension for the obstacle  40 , 170 , 170 , 180 , 180 
        mov byte ptr[di] , bl 
        mov word ptr[di+2] , 170
        mov byte ptr[di+4] , 170
        mov byte ptr[di+6],180
        mov word ptr[di+8] , 180
        mov byte ptr[objectSpeed] , 1
    ret 
    reset endp 