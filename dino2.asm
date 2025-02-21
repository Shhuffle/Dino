.model large
.stack 100h



.data                                                           
  ;                                                                           y_min x_min    y_max    x_max
  ;dino dimensions   offset addreess dinodimen each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn] [goingUp] [goingDown]
  ;                                                                   -       +2    +4       +6       +8          +10       +12
  dinodimen dw 40 , 140 , 120 , 165 , 130, 0 ,0 
  dinoJumpHeight dw 100 ;-> Not the height but the actual y-value
  

  ;obstacle dimenstions offset addreess object each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn]
 
 objectdimen dw 40 , 170 , 170 , 180 , 180 
    objectSpeed dw 10
  
  
  clock dw 0
 gamestate db 0 ; set the value to 1 if collision is detected 

  




.code
    ;include path to the folder
    include inc\draw.inc 
    include inc\update.inc
    include inc\mes.inc
    include inc\coll.inc
    include inc\utils.inc

    main proc far 
        mov ax , @data
        mov ds , ax
        
        ;to open a window in graphics mode
        mov ah , 00h 
        mov al ,13h
        int 10h

        refresh:

            cmp word ptr [clock], 65530 
            jb skipClock
                mov [clock], 0
            skipClock:
                add word ptr [clock], 1
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
           call updateObject
            


            ; Check collision
            call collide 


            call clearScreen
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
    
    






 

















