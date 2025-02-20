.model large
.stack 100h



.data 
  ;dino dimensions   offset addreess dinodimen each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn] 
  dinodimen dw 15 , 160 , 120 , 180 , 130
  

  ;obstacle dimenstions offset addreess object each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn]
 objectdimen dw 4 , 150 , 170 , 180 , 180
  
  
  


.code
    ;include path to the folder
    include inc\draw.inc 

    main proc far 
        mov ax , @data
        mov ds , ax

        ;to open a window in graphics mode
        mov ah , 00h 
        mov al ,13h
        int 10h

        call drawline
        ;wait for key input before exiting the program
        call drawdino
        call drawobstacle
        mov ah , 00h 
        int 16h 


        ;return contorl to the os
        mov ah , 4ch 
        int 21h






    main endp
    end main 
    
    






 

















