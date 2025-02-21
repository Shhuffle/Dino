.model large
.stack 100h



.data                                                           
  ;                                                                           y_min x_min    y_max    x_max
  ;dino dimensions   offset addreess dinodimen each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn] [goingUp] [goingDown]
  ;                                                                   -       +2    +4       +6       +8          +10       +12
  dinodimen dw 40 , 140 , 120 , 165 , 130, 0 ,0 
  dinoJumpHeight dw 100 ;-> Not the height but the actual y-value
  

  ;obstacle dimenstions offset addreess object each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn]
objectdimen dw 69 , 170 , 120 , 180 , 130 



 gamestate db 0 ; set the value to 1 if collision is detected 


 deathMessage db "You are dead LOL, get better$"
 newLine db 0dh, 0ah, "$"

 score dw 0


  




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
            ; Clear the screen
            call clearScreen

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

        ; Now the game is over Show stuff to the player
        ; Basic steps
            ; Take cursur to the center of the screen
            ; print the text
            ; goto new line
            ; print 
            ; 200 height = 320 width
        
        mov dh, 100
        mov dl, 160
        mov ah, 02h
        int 10h

        lea si, deathMessage
        mov ah, 09h
        int 21h

        lea si, newLine
        mov ah, 09h
        int 21h




        ;wait for key input before exiting the program
        mov ah , 00h 
        int 16h 

  
        ;return contorl to the osb
        mov ah , 4ch 
        int 21h






    main endp
    end main 
    
    






 

















