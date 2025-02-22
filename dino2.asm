.model large
.stack 100h



.data                                                           
  ;                                                                           y_min x_min    y_max    x_max
  ;dino dimensions   offset addreess dinodimen each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn] [goingUp] [goingDown]
  ;                                                                   -       +2    +4       +6       +8          +10       +12
  dinodimen dw 40 , 140 , 120 , 165 , 130, 0 ,0 
  dinoJumpHeight dw 130 ;-> Not the height but the actual y-value
  

  ;obstacle dimenstions offset addreess object each value is  of word [color] [Row] [Column] [MaxRow] [MaxColumn]

 
 objectdimen dw 40 , 170 , 170 , 180 , 180 
    objectSpeed dw 1
  
  
  clock dw 0
 gamestate db 0 ; set the value to 1 if collision is detected 

  

 deathMessage db "You are dead LOL, get better$"
 scoreMessage db "Score : $"
 newLine db 0dh, 0ah, "$"

 score dw 0
 scoreSpeed dw 70 ; determins how fast the score increses greater value means slower speed


  




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
        

        refresh:
            call clearScreen

            ;to open a window in graphics mode
            mov ah , 00h 
            mov al ,13h
            int 10h

            ; Clock calculation
            cmp word ptr [clock], 65530 
            jb skipClock
                mov [clock], 0
            skipClock:
                add word ptr [clock], 1


            ; print score to screen
            mov dh, 100
            mov dl, 100
            mov ah, 02h
            int 10h
            mov ax, [score]
            call printDecScore


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

            call calcscore
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
        
        mov dh, 10
        mov dl, 160
        mov ah, 02h
        int 10h

        mov dx, offset deathMessage
        mov ah, 09h
        int 21h

        mov dx, offset newLine
        mov ah, 09h
        int 21h
        mov dx, offset newLine
        mov ah, 09h
        int 21h


        mov dx, offset scoreMessage
        mov ah, 09h
        int 21h

       

        mov ax, [score]
        call printDecScore




        ;wait for key input before exiting the program
        mov ah , 00h 
        int 16h 
        



        

  
        ;return contorl to the osb
        mov ah , 4ch 
        int 21h






    main endp
    end main 
    
    





 

















