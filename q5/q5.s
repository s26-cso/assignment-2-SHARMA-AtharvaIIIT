.data
file: .asciz "input.txt"
mode: .asciz "r"
yessir: .asciz "Yes\n"
not: .asciz "No\n"

.text
.global main
main:
    addi sp,sp,-32
    sd ra,24(sp)
    sd s0,16(sp)
    sd s1,8(sp)
    sd s2,0(sp)

    la a0,file
    la a1,mode
    call fopen
    mv s0,a0

    mv a0,s0
    li a1,0
    li a2,2
    call fseek

    mv a0,s0
    call ftell
    mv s1,a0

    li s2,0
    addi s1,s1,-1

    li t0,1

loop:
    bge s2,s1,done

    mv a0,s0
    mv a1,s2
    li a2,0
    call fseek

    mv a0,s0
    call fgetc
    mv t1,a0

    mv a0,s0
    mv a1,s1
    li a2,0
    call fseek

    mv a0,s0
    call fgetc
    mv t2,a0

    bne t1,t2,nope

    addi s2,s2,1
    addi s1,s1,-1
    j loop

nope:
    li t0,0

done:
    beq t0,zero,nah

    la a0,yessir
    call printf
    j end

nah:
    la a0,not
    call printf

end:
    mv a0,s0
    call fclose

    ld ra,24(sp)
    ld s0,16(sp)
    ld s1,8(sp)
    ld s2,0(sp)
    addi sp,sp,32
    ret