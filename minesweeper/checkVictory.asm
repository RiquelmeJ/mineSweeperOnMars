.include "macros.asm"

.globl checkVictory

checkVictory:
    save_context
    move $s0, $a0 # board
    li $t0, 0 # $t0 = count
    li $t9, SIZE
    
    li $s1, 0 # i = 0
    loop_externo:
   	bge $s1, $t9, loop_externo_final
    	li $s2, 0 # j = 0
    	loop_interno:
    		bge $s2, $t9, loop_interno_final
    		condicional_1:
    			mul $s3, $s1, $t9 # $s3 = i * SIZE
    			add $s3, $s3, $s2 # $s3 += j
    			sll $s3, $s3, 2 # $s3 *= 2^2
    			add $s3, $s3, $s0 # andando s3 casas a partir de s0 (0,0)
    			lw $t8, 0($s3) # salvando em t8 o conteúdo do endereço salvo em s3 (como um ponteiro)
    			
    			# $t8 = board[i][j]
    			# $s3 = &board[i][j]
    			
    			blt $t8, $zero, condicional_1_final 
    				addi $t0, $t0, 1 # count++
    		condicional_1_final:
    			addi $s2, $s2, 1 # j++
    			j loop_interno
    	loop_interno_final:
    		addi $s1, $s1, 1 # i++
    		j loop_externo
    loop_externo_final:
    
    condicional_2:
    
   	mul $t3, $t9, $t9 # $t3 = SIZE^2
    	subi $t3, $t3, BOMB_COUNT # $t3 -= BOMB_COUNT
    	bge $t0, $t3, condicional_2_final # SE count < SIZE^2 - BOMB_COUNT
    		li $v0, 0
    		restore_context
    		jr $ra
    		
    condicional_2_final:
    	li $v0, 1
    	restore_context
    	jr $ra
    				
    			
    			
    			
    		
    		
    
    
	