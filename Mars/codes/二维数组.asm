.data
matrix: .space  256             # int matrix[8][8]   8*8*4 字节
                                # matrix[0][0] 的地址为 0x00，matrix[0][1] 的地址为 0x04，……
                                # matrix[1][0] 的地址为 0x20，matrix[1][1] 的地址为 0x24，……
                                # ……
str_enter:  .asciiz "\n"
str_space:  .asciiz " "

# 这里使用了宏，%i 为存储当前行数的寄存器，%j 为存储当前列数的寄存器
# 把 (%i * 8 + %j) * 4 存入 %ans 寄存器中
.macro  getindex(%ans, %i, %j)
    sll %ans, %i, 3             # %ans = %i * 8
    add %ans, %ans, %j          # %ans = %ans + %j
    sll %ans, %ans, 2           # %ans = %ans * 4
.end_macro

.text
li  $v0, 5
syscall
move $s0, $v0                   # 行数
li  $v0, 5
syscall
move $s1, $v0                   # 列数
# 这里使用了循环嵌套
li  $t0, 0                      # $t0 是一个循环变量

in_i:                           # 这是外层循环
beq $t0, $s0, in_i_end
li  $t1, 0                      # $t1 是另一个循环变量
in_j:                           # 这是内层循环
beq $t1, $s1, in_j_end
li  $v0, 5
syscall                         # 注意一下下面几行，在 Execute 页面中 Basic 列变成了什么
getindex($t2, $t0, $t1)         # 这里使用了宏，就不用写那么多行来算 ($t0 * 8 + $t1) * 4 了
sw  $v0, matrix($t2)            # matrix[$t0][$t1] = $v0
addi $t1, $t1, 1
j   in_j
in_j_end:
addi $t0, $t0, 1
j   in_i
in_i_end:
# 这里使用了循环嵌套，和输入的时候同理
li  $t0, 0

out_i:
beq $t0, $s0, out_i_end
li  $t1, 0
out_j:
beq $t1, $s1, out_j_end
getindex($t2, $t0, $t1)
lw  $a0, matrix($t2)            # $a0 = matrix[$t0][$t1]
li  $v0, 1
syscall
la  $a0, str_space
li  $v0, 4
syscall                         # 输出一个空格
addi $t1, $t1, 1
j   out_j
out_j_end:
la  $a0, str_enter
li  $v0, 4
syscall                         # 输出一个回车
addi $t0, $t0, 1
j   out_i

out_i_end:
li  $v0, 10
syscall