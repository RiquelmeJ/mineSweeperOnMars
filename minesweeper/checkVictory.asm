.include "macros.asm"

.globl checkVictory

checkVictory:

    save_context
	move $s0, $a0  # board
	li $s1, 0 # $s1 = count = 0
	
	#for (int i = 0; i < SIZE; ++i)
	li $t0, 0 # $t0 = i = 0
	li $t2, SIZE
	loop_externo: #perguntar Ramon
	bge $t0, $t2, loop_externo_final
		li $t1, 0 # $t1 = j = 0
		loop_interno: #perguntando Ramon
		bge $t1, $t2, loop_interno_final
			mul $t7, $t0, $t2 # i * SIZE
			add $t7, $t7, $t1 # + j
			sll $t7, $t7, 2 #índice * 4
			add $t7, $t7, $s0 #pegando endereço de memória de board[i][j]
			lw $t7, 0($t7) # estou pegando o conteudo para onde o registrador ta apontando
			blt $t7, 0, condicional1_final
				addi $s2, $s2, 1 #count++
			condicional1_final:
			addi $t1, $t1, 1
			j loop_interno
		loop_interno_final:
		addi $t0, $t0, 1
		j loop_externo
	loop_externo_final:
	#for (int j = 0; j < SIZE; ++j) 
	li $t1, 0 # $t1 = j = 0
	li $t3, BOMB_COUNT #$t3 = BOMB_COUNT
	mul $t4, $t2, $t2 #$t4 = SIZE ^ 2
	sub $t4, $t4, $t3 #$t4 = SIZE ^ 2 - BOMB_COUNT
	bge $s1, $t4, condicional2_final
	 	li $v0, 0 #$v0 = 0
		restore_context #voltar os resgistradores para os valores iniciais
  		jr $ra
	condicional2_final:
	li $v0, 1 #$v1 = 1
	restore_context #voltar os resgistradores para os valores iniciais
  	jr $ra
	  
    
