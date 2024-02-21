**Universidade Federal do Cariri** 
**Bacharelado em Ciência da Computação**
**Alunos:** Helen Christine Turbano e Silva e Riquelme Jatay Ribeiro Scarcela Bezerra 
**Professor:** Ramon Santos Nepomuceno
# Trabalho de Arquitetura e Organização de Computadores

Olá! Nesse documento, iremos explicar o funcionamento do projeto *Minesweeper* e como ocorreu a construção de cada um dos componentes.![visão geral do projeto](https://ibb.co/558d8bt "tela inicial do projeto")
## Sobre o jogo

[adicionar descrição]

## Funções
### revealAdjacentCells

A função revealAdjacentCells recebe um tabuleiro (representado por um array bidimensional), uma linha e uma coluna como entrada. Antes de começar a analisar as células adjacentes, ela configura variáveis e limites para os loops que percorrerão as células vizinhas.

**Iteração sobre as células vizinhas:** A função percorre as células vizinhas à célula de referência, indo de row - 1 até row + 1 para as linhas e de column - 1 até column + 1 para as colunas. Isso é feito utilizando dois loops aninhados.
**Verificação de limites:** Dentro dos loops, a função verifica se as células vizinhas estão dentro dos limites do tabuleiro. Isso é importante para evitar acessar áreas de memória inválidas.
**Verificação de condições:** Se a célula vizinha estiver dentro dos limites do tabuleiro e ainda não tiver sido revelada, a função verifica se há bombas adjacentes à célula. Isso é feito chamando a função countAdjacentBombs.
**Revelação recursiva:** Se a célula vizinha não contiver bombas adjacentes, ela é revelada e o processo é repetido recursivamente para todas as células vazias adjacentes. Isso é feito chamando a própria função revealAdjacentCells para as células adjacentes.
**Contagem de bombas:** Se a célula vizinha tiver bombas adjacentes, a função conta o número de bombas e armazena o resultado na célula atual.
**Encerramento:** Após analisar todas as células vizinhas, a função encerra sua execução.

### 

### countAdjacentCells
Iniciamos a função countAdjacentBombs recebendo um tabuleiro, uma linha e uma coluna como entrada. Inicializamos um contador de bombas adjacentes (count) como zero e configuramos variáveis e limites para os loops que irão percorrer as células vizinhas.

**Iteramos sobre as células vizinhas:** A função percorre as células vizinhas à célula de referência, indo de row - 1 até row + 1 para as linhas e de column - 1 até column + 1 para as colunas. Fizemos isso utilizando dois loops aninhados.
**Verificamos os limites:** Dentro dos loops, a função verifica se as células vizinhas estão dentro dos limites do tabuleiro. Isso é importante para evitar acessar áreas de memória inválidas.
**Verificamos as condições:** Se a célula vizinha estiver dentro dos limites do tabuleiro e ainda não tiver sido revelada (board[i][j] == -1), a função incrementa o contador de bombas adjacentes (count).
**Encerramos e Retornamos:** Após analisar todas as células vizinhas, a função retorna o valor do contador count.

### checkVictory

Iniciamos a função checkVictory recebendo um tabuleiro como entrada. Ela inicializa uma variável de contagem (count) como zero e configura variáveis e limites para os loops que percorrerão todas as células do tabuleiro.

**Iteração sobre as células do tabuleiro:** A função percorre todas as células do tabuleiro, indo de i = 0 até i = SIZE - 1 para as linhas e de j = 0 até j = SIZE - 1 para as colunas. Isso é feito utilizando dois loops aninhados.
**Verificação de células reveladas:** Para cada célula do tabuleiro, a função verifica se a célula está revelada (board[i][j] >= 0). Se estiver revelada, isso significa que não é uma bomba (-1 ou maior), então o contador count é incrementado.
**Verificação de vitória:** Após percorrer todas as células do tabuleiro, a função verifica se o número de células reveladas (count) é igual ao número total de células do tabuleiro menos o número de bombas (SIZE^2 - BOMB_COUNT). Se for, isso significa que todas as células não bombas foram reveladas e o jogador venceu o jogo.
**Retorno do resultado:** Se a condição de vitória for atendida, a função retorna 1 (indicando vitória), caso contrário, retorna 0 (indicando que o jogo ainda não foi vencido).
**Encerramento:** Após verificar a vitória, a função restaura o contexto e retorna para a chamada anterior.

