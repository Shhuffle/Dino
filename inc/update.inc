updateDino proc far
    ; The basic idea for now is 
    ; On key press from user
        ; pressedKey == 'Space'
            ; y=y-1
            ; goingUp = true
            ; goingDown = false

        ; if(y > someValue AND goingUp)
            ; y=y -1
            ; END
        
        ; if(y == baseLine AND goingDown)
            ; goingUp = flase
            ; goingDown=flase
            ;END

        ; if(y > somveValue AND goingDown)
            ; y=y+1
            ; END
        ; if(y == someValue AND goingUp)
            ; y=y+1
            ; goindgUp = false
            ; goingDown = true
            ; END
        

    ; IMPLEMENTATION
    lea si, dinodimen

    ; Check key press
    mov ah , 01h
    int 16h

    jnz take_key
    jz dont_wait_for_key

    take_key:
        ; if a key was pressed
        mov ah, 0    
        int 16h

        ; check if it is spacebar
        cmp al, 20h
        jne dont_wait_for_key

    
    ; y=y-1
    dec word ptr [si+2]
    dec word ptr [si+6]
    
    ; goingUp = true
    ; goingDown = false
    mov byte ptr [si+10], 1
    mov byte ptr [si+12], 0


    ; Perfom regardless of if the key was entered or not!    
    dont_wait_for_key:


    ; if(y > someValue AND goingUp)
        ; y=y -1
        ; END
    mov ax, dinoJumpHeight
    cmp [si+2], ax
    ja case1a
    jbe cond_1_false
        case1a:
        cmp byte ptr [si+10], 1
        je case2a
        jne cond_1_false
            case2a:
            dec word ptr [si+2]
            dec word ptr [si+6]
            jmp exit_sub
    cond_1_false:


    ; if(y == baseLine AND goingDown)
            ; goingUp = flase
            ; goingDown=flase
            ;END
    mov ax, 180 ; Hard coded y coordinate of the base line
    cmp [si+6], ax
    je case1d
    jne cond_4_false
        case1d:
        cmp byte ptr [si+12], 1
        je case2d
        jne cond_4_false
            case2d:
            mov byte ptr [si+10],0
            mov byte ptr [si+12],0
            jmp exit_sub
    cond_4_false:


    ; if(y > somveValue AND goingDown)
        ; y=y+1
        ; END
    mov ax, dinoJumpHeight
    cmp [si+2], ax
    ja case1b
    jbe cond_2_false
        case1b:
        cmp byte ptr [si+12], 1
        je case2b
        jne cond_2_false
            case2b:
            inc word ptr [si+2]
            inc word ptr [si+6]
            jmp exit_sub
    cond_2_false:

    ; ----------------------------------------
    jmp lol
    
    ; -----------------------------------------
    exit_sub_th:
    jmp exit_sub
    ; -----------------------------------------

    lol:
    ; -----------------------------------------

    ; if(y == someValue AND goingUp)
        ; y=y+1
        ; goingUp = false
        ; goingDown = true
        ; END
    mov ax, dinoJumpHeight
    cmp [si+2], ax
    je case1c
    jne cond_3_false
        case1c:
        cmp byte ptr [si+10], 1
        je case2c
        jne cond_3_false
            case2c:
            inc word ptr [si+2]
            inc word ptr [si+6]
            mov byte ptr [si+10],0
            mov byte ptr [si+12],1
            jmp exit_sub
    cond_3_false:



    
    exit_sub:

ret
updateDino endp


updateObject proc far

    mov ax, [clock]   
    mov dx, 0         
    mov cx, [objectSpeed]         
    div cx            
    cmp dx, 0         
    jne exit          


    mov si, offset objectdimen

    cmp word ptr[si+8], 1
    jnb inside
    mov [si + 4] , 300
    mov [si + 8], 310

    inside:
    sub word ptr [si+4], 1
    sub word ptr [si+8], 1

    exit:
    
ret
updateObject endp