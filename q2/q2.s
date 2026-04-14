.data
fmt:      .asciz "%d "
nextline: .asciz "\n"

.text
.global main
main:
    addi sp,sp,-96
    sd ra, 88(sp)
    sd s0, 80(sp)
    sd s1, 72(sp)
    sd s2, 64(sp)
    sd s3, 56(sp)
    sd s4, 48(sp)
    sd s5, 40(sp)
    sd s6, 32(sp)
    sd s7, 24(sp)
    sd s8, 16(sp)
    
    mv s0,a0
    mv s1,a1
    addi s2,s0,-1
    ble s2,zero,end
    
    slli s6,s2,2
    mv a0,s6
    call malloc
    mv s3,a0

    mv a0,s6
    call malloc
    mv s4,a0

    mv a0,s6
    call malloc
    mv s5,a0

argu:
    li s7,0

loading_loop:
    bge s7,s2, prepare
    addi t0, s7,1
    slli t0,t0,3
    add t0,s1,t0
    ld a0,0(t0)
    call atoi
    slli t1,s7,2
    add t1,s3,t1
    sw a0,0(t1)
    addi s7,s7,1
    j loading_loop

prepare:
    li s6,-1
    addi s7,s2,-1

compute:
    blt s7,zero,print_fianl
    slli t0,s7,2
    add t0, s3,t0
    lw t4,0(t0)

pop:
    blt s6,zero, set_result
    slli t0,s6,2
    add t0,s5,t0
    lw t0, 0(t0)
    slli t1,t0,2
    add t1,s3,t1
    lw t1,0(t1)
    bgt t1,t4,set_result
    addi s6,s6,-1
    j pop

set_result:
    slli t0,s7,2
    add t0,s4,t0
    blt s6,zero,no_greater
    slli t1,s6,2
    add t1,s5,t1
    lw t1,0(t1)
    sw t1,0(t0)
    j push

no_greater:
    li t1,-1
    sw t1,0(t0)

push:
    addi s6,s6,1
    slli t0,s6,2
    add t0,s5,t0
    sw s7,0(t0)
    addi s7,s7,-1
    j compute

print_fianl:
    li s8,0

print_loop:
    bge s8,s2,new
    slli t0,s8,2
    add t0,s4,t0
    lw a1,0(t0)
    la a0,fmt
    call printf
    addi s8,s8,1
    j print_loop

new:
    la a0,nextline
    call printf

end:
    ld ra, 88(sp)
    ld s0, 80(sp)
    ld s1, 72(sp)
    ld s2, 64(sp)
    ld s3, 56(sp)
    ld s4, 48(sp)
    ld s5, 40(sp)
    ld s6, 32(sp)
    ld s7, 24(sp)
    ld s8, 16(sp)
    addi sp,sp,96
    ret




    