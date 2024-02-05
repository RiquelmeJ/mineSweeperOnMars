.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
	move $s0, $a0  # board
	move $s1, $a1  # row
	move $s2, $a2  # column
	
	li $s3, 0   # count = 0
	li $t6, SIZE #
	
	subi $t0, $s1, 1 # $t0 = i
	addi $t1, $s1, 1 # $t1 = row + 1
		
	loop_externo:
	bgt $t0, $t1, loop_externo_final
	
	subi $t2, $s2, 1 #$t2 = j = column - 1
	addi $t3, $s2, 1 #$t3 = column + 1
	
		loop_interno:
		bgt $t2, $t3, loop_interno_final
		
			condicional:
			
			blt $t0, $zero, else_invalid # i >= 0
			bge $t0, $t6,  else_invalid # i < SIZE
			blt $t2, $zero, else_invalid # j >= 0
			bge $t2, $t6,  else_invalid # j < SIZE
			
			mul $t5, $t0, $t6 # i * SIZE
			add $t5, $t5, $t2 # + j
			sll $t5, $t5, 2 #índice * 4
			add $t5, $t5, $s0 #pegando endereço de memória de board[i][j]
			lw $t5, 0($t5) # estou pegando o conteudo para onde o registrador ta apontando
			bne $t5, -1, else_invalid # board[i][j] == -1
			
			# count++
			addi $s3, $s3, 1   # count = count + 1 
			
			condicional_final:
			addi $t2, $t2, 1
			j loop_interno
			
		loop_interno_final:
		addi $t0, $t0, 1
		j loop_interno
		
	loop_externo_final:
	
	# return count
	move $v0, $s3  # $v0 é usado para retornar um valor 
	
	restore_context #voltar os resgistradores para os valores iniciais
  	jr $ra # última instrução de uma função

