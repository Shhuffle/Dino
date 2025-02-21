.model large
.stack 100h



.data                                                           
  ;                                                                           y_min x_min    y_max    x_max
  ;dino dimensions   offset addreess dinodimen each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn] [goingUp] [goingDown]
  ;                                                                   -       +2    +4       +6       +8          +10       +12
  dinodimen dw 40 , 140 , 120 , 165 , 130, 0 ,0 
  dinoJumpHeight dw 100 ;-> Not the height but the actual y-value
  

  ;obstacle dimenstions offset addreess object each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn]
objectdimen dw 69 , 170 , 200 , 180 , 230 



 gamestate db 0 ; set the value to 1 if collision is detected 
  



  
  


.code
    ;include path to the folder
    include inc\draw.inc 
    include inc\update.inc
     include inc\mes.inc
     include inc\coll.inc

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

            mov ah , 0
            mov [gamestate], ah

            ; Update Object


            ; Check collision
            call collide 

            ; check game over
            mov ah , [gamestate]
            cmp ah , 1
            jne refresh
            jmp refresh_exit
         
        jmp refresh
        refresh_exit:
        ;wait for key input before exiting the program
        mov ah , 00h 
        int 16h 

  
        ;return contorl to the osb
        mov ah , 4ch 
        int 21h






    main endp
    end main 
    
    






 

















