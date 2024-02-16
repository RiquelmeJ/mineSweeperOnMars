.include "macros.asm"

.globl play

play:
	save_context
	move $s0, $a2  # board
	move $s1, $a0  # row
	move $s2, $a1  # column
	li $t0, SIZE # SIZE
	
	
	mul $s3, $s1, $t0      # $s3 = row * SIZE (calculate row offset)
	add $s3, $s3, $s2      # $s3 += column (add column offset)
	sll $s3, $s3, 2        # $s3 = $s3 * 2^2 (multiply by 4 to account for word size)
	add $s3, $s3, $s0      # $s3 = board + index (add base address of board)
	lw $s6, 0($s3) # estou pegando o conteudo para onde o registrador ta apontando
	# if (board[row][column] == -1) 

	# $s6 = board[row][column]
	# $s3 = &board[row][column]
	
	condicional_1:
		bne $s6, -1, condicional_1_final
		move $v0, $zero  # $v0 é usado para retornar um valor 
		restore_context #voltar os resgistradores para os valores iniciais
  		jr $ra
		  
	# if (board[row][column] == -2) {
	condicional_1_final:
		condicional_2:
			bne $s6, -2, condicional_2_final
			move $s4, $zero # $s4 = x = 0
			
			move $a0, $s0  # board
			move $a1, $s1  # row
			move $a2, $s2  # column 
			
			jal countAdjacentBombs
			move $s4, $v0  # $s4 = x = countAdjacentBombs
			sw $s4, 0($s3) # board[row][column] = x
			
			condicional_3:
				bnez $s4, condicional_3_final
				move $a0, $s0  # board
				move $a1, $s1  # row
				move $a2, $s2  # column
				jal revealAdjacentCells
			condicional_3_final:
		condicional_2_final:
        	li $v0, 1 # return 1
        	restore_context #voltar os resgistradores para os valores iniciais
  		jr $ra # última instrução de uma função