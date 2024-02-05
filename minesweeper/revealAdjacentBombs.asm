.include "macros.asm"

.globl revealAdjacentCells

revealAdjacentCells: 
	save_context
	move $s0, $a0  # board
	move $s1, $a1  # row
	move $s2, $a2  # column
	
	# for (int i = row - 1; i <= row + 1; ++i) 
	
	sub $s3, $s1, 1  # $s3 = i e estou armazenando em s4 a sub
	loop_externo:
	addi $t0, $s1, 1       # t0 (temporaria) = row + 1
	bgt $s3, $t0, loop_externo_final   # Se i > row + 1, saia do loop externo
	
	# for (int j = column - 1; j <= column + 1; ++j)
	
	sub $s4, $s2, 1 # j = $s4 e estou armazenando em $s4 a sub
	loop_interno:
	addi $t1, $s2, 1  # t1 = column + 1
	bgt $s4, $t1, loop_interno_final  # Se j > column + 1, saia do loop interno
	
	# if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -2)
	
	li $t2, SIZE
	blt $s3, $zero, else_invalid #se $s3 for menor que $zero
	bge $s3, $t2, else_invalid   #se $s3 for maior ou igual a $t2
	blt $s4, $zero, else_invalid
	bge $s4, $t2, else_invalid
	
	# faltando essa parte board[i][j] == -2
	
	
	
	# int x = countAdjacentBombs(board, i, j);
	
	move $a0 , $s0 # os registradores em a ele servem para passar parâmetros para a função, os valores nesses registradores podem ser substituidos
	move $a1, $s3  # i
	move $a2, $s4  # j
	
	jal countAdjacentBombs
	
	move $s5, $v0 # em $v0 tem o numero de bombas adjacentes e eu to movendo para o $s5 que eh o x 
	# $vo sao usados para armazenar valores q retornam de funções 
	
	
	# board[i][j] = x;
	
	li $t0, SIZE  # Tamanho do tabuleiro (8)
   	mul $t1, $s3, $t0  # i * SIZE
    	add $t1, $t1, $s4  # i * SIZE + j
	sll $t1, $t1, 2  # (i * SIZE + j) * 4 (para obter o deslocamento em bytes, no caso o valor real)
    	add $t1, $s0, $t1  # Adicionar o endereço base do tabuleiro

    	# Atribuir x à célula do tabuleiro
    	sw $s5, 0($t1)  # board[i][j] = x = $s5
    	
    	# if (!x)
    	beqz $s5, call_revealAdjacentCells #verificando se $s5 == 0, se um registrador eh igual a 0 
    	#beqz significa pule para ... se for igual a 0 
    	j end_if  # se $s5 n for == 0 
    	
    	
    	call_revealAdjacentCells:
  	move $a0, $s0  # board
    	move $a1, $s3  # i
    	move $a2, $s4  # j

    	jal revealAdjacentCells

	end_if
	
	restore_context #voltar os resgistradores para os valores iniciais
  	jr $ra # última instrução de uma função