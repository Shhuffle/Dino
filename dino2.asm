.model large
.stack 100h



.data                                                           
  ;                                                                           y_min x_min    y_max    x_max
  ;dino dimensions   offset addreess dinodimen each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn] [goingUp] [goingDown]
  ;                                                                   -       +2    +4       +6       +8          +10       +12
  dinodimen dw 40 , 160 , 120 , 180 , 130, 0 ,0 
  dinoJumpHeight dw 100 ;-> Not the height but the actual y-value
  

  ;obstacle dimenstions offset addreess object each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn]
 objectdimen dw 40 , 170 , 170 , 180 , 180
  
  
  


.code
    ;include path to the folder
    include inc\draw.inc 

    main proc far 
        mov ax , @data
        mov ds , ax

 

        refresh:
               ;to open a window in graphics mode
            mov ah , 00h 
            mov al ,13h
            int 10h

            ; Draw the base line
            call drawline

            ; Draw the Dino
            call drawdino

            ; Draw the obstracle
            call drawobstacle

            ; Update the dino
            call updateDino

            ; Update Object
            

        jmp refresh

        ;wait for key input before exiting the program
        mov ah , 00h 
        int 16h 


        ;return contorl to the os
        mov ah , 4ch 
        int 21h






    main endp
    end main 
    
    






 

















