;Contains the procedure - SAFAL

drawline proc far   ; this far is necessary since this procedure is called in the other file with different code segment
    mov dx , 180
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

  





drawdino proc far
    lea si , dinodimen
    mov cx , [si+4]
    mov dx , [si+2]  ; since each value is of 16 bit
    
    drawdinol1: ;drawdino loop 1 
        mov ah , 0ch 
        mov al , [si]
        mov bh , 00h 
        int 10h
        inc cx
        
        cmp cx , [si+8] 

        jb drawdinol1
        
        mov cx , [si+4] ; reset the column pixel 
        inc dx 

        cmp dx , [si+6]
       
        jb drawdinol1
 
ret
drawdino endp




drawobstacle proc far
    
    lea si , objectdimen
    mov cx , [si+4]
    mov dx , [si+2] 
 
    
    
    
    drawobstaclel1: 
        mov ah , 0ch 
        mov al , [si]
        mov bh , 00h 
        int 10h
        inc cx
        
        cmp cx , [si+8] 

        jb drawdinol1
        
        mov cx , [si+4] ; reset the column pixel 
        inc dx 

        cmp dx , [si+6]
        jb drawdinol1
    
   
  
  
  
ret
drawobstacle endp




    
