.include "macros.asm"

.globl revealAdjacentCells

revealAdjacentCells: 
	save_context
	move $s0, $a0  # board
	move $s1, $a1  # row
	move $s2, $a2  # column
	
	li $t6, SIZE # SIZE
	
	# for (int i = row - 1; i <= row + 1; ++i) 
	subi $s6, $s1, 1 # s6 = i = row - 1
	addi $t1, $s1, 1 # $t1 = row + 1
		
	loop_externo:
		bgt $s6, $t1, loop_externo_final # SE i > row + 1, SAI
		
		# for (int j = column - 1; j <= column + 1; j++)
		subi $s7, $s2, 1 #$s7 = j = column - 1
		addi $t3, $s2, 1 #$t3 = column + 1
		
		loop_interno:
			bgt $s7, $t3, loop_interno_final # SE j > column + 1, SAI
		
			# SE (i >= 0 E i < SIZE E j >= 0 E j < SIZE E board[i][j] == -2) ENTÃO
			condicional_1:
				li $t6, SIZE # SIZE
				blt $s6, $zero, condicional_1_final # SE i >= 0 
				bge $s6, $t6,  condicional_1_final # SE i < SIZE
				blt $s7, $zero, condicional_1_final # SE j >= 0
				bge $s7, $t6,  condicional_1_final # SE j < SIZE
			
				mul $t5, $s6, $t6 #  $t5 = i * SIZE
				add $t5, $t5, $s7 #  $t5 += j
				sll $t5, $t5, 2 # $t5 *= 2^2
				add $t5, $t5, $s0 #pegando endereço de memória de board[i][j]
				lw $t9, 0($t5) # estou pegando o conteudo para onde o registrador ta apontando
				
				# $t9 = board[i][j]
				# $t5 = &board[i][j]
				
				bne $t9, -2, condicional_1_final # SE board[i][j] == -2
				move $a0, $s0  # board
				move $a1, $s6  # i
				move $a2, $s7  # j
			
				jal countAdjacentBombs
				
				li $t6, SIZE
				mul $t5, $s6, $t6 #  $t5 = i * SIZE
				add $t5, $t5, $s7 #  $t5 += j
				sll $t5, $t5, 2 # $t5 *= 2^2
				add $t5, $t5, $s0 #pegando endereço de memória de board[i][j]
				move $s4, $v0  # $s4 = x = countAdjacentBombs
				sw  $s4, ($t5) # board[row][column] = x
				
				condicional_2:
					bnez $s4, condicional_2_final
					move $a0, $s0  # board
					move $a1, $s6  # i
					move $a2, $s7  # j
					
					jal revealAdjacentCells
		
				condicional_2_final:
			condicional_1_final:
				addi $s7, $s7, 1
				j loop_interno
		loop_interno_final:
			addi $s6, $s6, 1
			j loop_externo
	loop_externo_final:
		restore_context #voltar os resgistradores para os valores iniciais
  		jr $ra # última instrução de uma função