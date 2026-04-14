.text

.global make_node
make_node:
    addi sp,sp,-16
    sd ra, 8(sp)
    sd s0, 0(sp)

    mv s0,a0
    li a0,24
    call malloc

    sw s0,0(a0)
    sd zero,8(a0)
    sd zero,16(a0)

    ld ra, 8(sp)
    ld s0, 0(sp)
    addi sp,sp,16

    ret

.global insert
insert:
    addi sp,sp,-24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)

    mv s1,a1
    mv s0,a0
    

    beq a0,zero, base
    lw t0, 0(a0)
    bge a1,t0, right

left:
    ld a0, 8(a0)
    mv a1,s1
    call insert

    sd a0, 8(s0)
    mv a0,s0
    j end

right :
    ld a0, 16(a0)
    mv a1,s1
    call insert

    sd a0, 16(s0)
    mv a0,s0
    j end

base:
    mv a0,s1
    call make_node

end:
    ld ra, 16(sp)
    ld s0, 8(sp)
    ld s1, 0(sp)
    addi sp,sp,24
    ret

.global get
get:
    addi sp,sp,-24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)

    mv s1,a1
    mv s0,a0

    beq a0,zero, get_base
    lw t0,0(a0)
    beq t0,a1, get_base
    bgt t0,a1, get_left

get_right:
    ld a0, 16(a0)
    mv a1,s1
    call get

    j get_end

get_left:
    ld a0,8(a0)
    mv a1,s1
    call get

    j get_end

get_base:
    j get_end

get_end:
    ld ra, 16(sp)
    ld s0, 8(sp)
    ld s1, 0(sp)
    addi sp,sp,24
    ret



.global getAtMost
getAtMost:
    addi sp,sp,-24
    sd ra, 16(sp)
    sd s0, 8(sp)
    sd s1, 0(sp)

    li a2,-1

loop:
    beq a1,zero,most_end
    lw t0,0(a1)
    beq t0,a0, val_end
    blt t0,a0, most_right

    ld a1,8(a1)
    j loop

most_right:
    lw a2,0(a1)
    ld a1,16(a1)
    j loop

val_end:
    mv a0,t0
    ld ra, 16(sp)
    ld s0, 8(sp)
    ld s1, 0(sp)
    addi sp,sp,24
    ret

most_end:
    mv a0,a2
    ld ra, 16(sp)
    ld s0, 8(sp)
    ld s1, 0(sp)
    addi sp,sp,24
    ret