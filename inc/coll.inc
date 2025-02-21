;to implement the collision 


collide proc far 
   lea si , dinodimen 
   lea bx , objectdimen 

   mov cx , [si+4] ; min column of dino leftmost corner of dino
   mov ax , [bx+8] ; max column of obstacle rightmost corner of dino 

   cmp cx , ax ; check if the obstacle is on the left of the dino In this case no need to check for the collision 
   ja  collideExit 



    ; check if the bottomost line of the dino is greater then obstacle height or not 
    ; if yes then dino is in jump state no need to check for collision 

   mov cx , [si+6] ; max row of dino 
   mov ax , [bx+2] ; min row of obstacle 
   cmp cx ,ax
   jb collideExit


   ; if the obstacle is not at the left and if dino is not above the obstacle then check for collision 

   mov cx , [si + 8] ; rightmost part of the dino 
   mov ax , [bx + 4] ; leftmost part of the obstacle  
   cmp cx ,ax 
   jb collideExit


    mov [gamestate], 1
 
   

    collideExit:
     
ret 


collide endp