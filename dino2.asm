.model large
.stack 100h



.data 




.code
    include proc1.inc 

    main proc far 
        mov ax , @data
        mov ds , ax

        ;to open a window in graphics mode
        mov ah , 00h 
        mov al ,13h
        int 10h

        call drawline
        ;wait for key input before exiting the program
        mov ah , 00h 
        int 16h 


        ;return contorl to the os
        mov ah , 4ch 
        int 21h


    main endp
    end main 
    
    






 

















