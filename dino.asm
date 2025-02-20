; Bibidh was here!
; Safal 123

.model small
.stack 100h

.data 
 temp db ?
 time dw 9999h
.code

 
delay_2s proc near


    mov cx, 0090          ; Outer loop counter (adjust as necessary)
outer_loop:
    mov bx, 10000         ; Inner loop counter (adjust for timing)
inner_loop:
    nop                   ; No operation (just a placeholder)
    dec bx                ; Decrement inner loop counter
    jnz inner_loop        ; Repeat until bx is 0
    dec cx                ; Decrement outer loop counter
    jnz outer_loop        ; Repeat until cx is 0



delay_2s endp


delay_1s proc near


    mov cx, 0010          ; Outer loop counter (adjust as necessary)
outer_loop1:
    mov bx, 10000         ; Inner loop counter (adjust for timing)
inner_loop1:
    nop                   ; No operation (just a placeholder)
    dec bx                ; Decrement inner loop counter
    jnz inner_loop1        ; Repeat until bx is 0
    dec cx                ; Decrement outer loop counter
    jnz outer_loop1        ; Repeat until cx is 0



delay_1s endp

delay_u1s proc near


    mov cx, 0001         ; Outer loop counter (adjust as necessary)
outer_loopu1:
    mov bx, 00010         ; Inner loop counter (adjust for timing)
inner_loopu1:
    nop                   ; No operation (just a placeholder)
    dec bx                ; Decrement inner loop counter
    jnz inner_loopu1        ; Repeat until bx is 0
    dec cx                ; Decrement outer loop counter
    jnz outer_loopu1        ; Repeat until cx is 0



delay_u1s endp







clearScreen proc near
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



drawline proc near    
  

    mov dx , 180
    mov ah, 00h
    mov al, 13h
    int 10h

    mov cx, 0
    

l1:  
    mov ah, 0Ch
    mov al, 04h
    mov bh, 00h
    int 10h

    inc cx
    cmp cx, 320
    jne l1  
    

    ret
drawline endp

jumpdino proc near
    
    
 

    mov cx , 120
    mov dx , 150
   
    mov dx , 140
    l2:
    mov ah , 0ch 
    mov al , 15
    mov bh , 00h
    int 10h
    inc cx
    cmp cx , 130
    jb l2
    mov cx , 120
    inc dx 
    cmp dx , 165
    jb l2
    call delay_2s
    
   
   
ret
jumpdino endp


dino proc near 
    call drawline
    mov cx , 120
    mov dx , 155
    l7:
    mov ah , 0ch 
    mov al , 15
    mov bh , 00h
    int 10h
    inc cx
    cmp cx , 130
    jb l7
    mov cx , 120
    inc dx 
    cmp dx , 180
    jb l7
   
   
    
ret
dino endp


obstacle proc near
    push bp
    mov bp , sp
    mov cx , [bp + 4]
    mov dx , 170
    mov bl , cl
    add bl , 10
    
    mov dx , 175
    
    l8:
    mov al , 15
    mov bh , 00h
    int 10h
    inc cx 
    cmp cl , bl
    jb l8
    mov cx , [bp+4]
    
    inc dx 
    cmp dx , 180
    jb l8
    call delay_u1s
   
  
  
pop bp    
ret
obstacle endp




main proc near
    mov ax, @data
    mov ds , ax 
    mov ax , 0
    mov [time] , ax

    refresh:
     call dino
     pop bx
     inc bx 
     cmp bx , 300
     jb okay
     mov bx , 0 
     okay:
     push bx
     call obstacle
   
     mov ah , 01h
     int 16h 
     jz refresh
     
  
    
     mov ah , 00h ; to check the key pressed value when keystroke value is available 
     int 16h
  
    cmp al , 13 ; check for enter 
    je exit

    cmp al , 32 ; check for space bar
    jne refresh
    call drawline
    call jumpdino
    
  
   

    
    jmp refresh 
    exit:

    mov ah, 0
    mov al, 03h  
    int 10h  


    mov ah , 4ch
    int 21h
    
main endp

end main
 