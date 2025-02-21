
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

  
  

