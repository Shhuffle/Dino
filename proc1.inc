;Contains the procedure - SAFAL


 drawline proc far   ; this far is necessary since this procedure is called in the other file with different code segment
    mov dx , 10
    mov cx, 0
    drawlinel1:  
        mov ah, 0Ch
        mov al, 04h
        mov bh, 00h
        int 10h
        inc cx
        cmp cx, 320
        jne drawlinel1  
        ret
    drawline endp
    
