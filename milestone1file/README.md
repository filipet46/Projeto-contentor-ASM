
=====================================================
# Projeto de Arquitetura de Computadores: Motor de Processamento de Dados Simbólicos em Assembly IA-32
## Milestone 1:  Contentor de Dados e Rotina de Soma com controlo de Overflow

## Overview
    Criacao da estrutura de dados base do motor, um contentor para armazenar uma sequencia de 8 valores de inteiros de 32 bits, e de uma rotina que percorre a sequencia e e calcula a soma total dos valores, guardando os de seguida em um registo dedicado em Assembly IA-32

## Estrutura de Dados Escolhida (.long)
    O contentor foi declarado na seccao .data com o tipo .long(32 bits).
-   **Foi escolhido usar .long por ser pedido a criacao de inteiros de 32 bits, e pelo facto da arquitetura do GAS/IA-32 usar os registos nativos a 32 bits(ex: eax, ebx, esi, etc...)**

## Arquiteturas e Decisoes Tecnicas
    Para percorrer o contentor e fazer a operacao pedida(soma) foi escolhido usar um ciclo de soma que percorre automaticamente o contentor, em vez de fazer as operacoes manualmente, com a seguinte estrutura:
-   1. **Inicializacao eficiente dos Registers:** Utilizacao da instrucao de `xorl`(`esi`,`ebx`,`edx`), para zerar os registos usados(pois trocar um registo consigo mesmo 'e uma forma muito eficiente de o colocar a 0.) para o indice de posicao, o acumulador da soma e a flag de overflow.
-   2. **Modo de enderecamento indexado (base(,%index,scale) destino):** Foi usado a instrucao `movl contentor(,%esi,4), %eax` para calcular o endereco do contentor a trabalhar em cada iteracao do ciclo, por ser mais eficiente do que calcular o endereco manualmente.
-   3. **Tratamento de casos de OverFlow:** Para contornar os casos de OverFlow foi feita a adicao combinando dois registos de 32 bits(`EDX:EBX`), onde a adicao de cada elemento foi guardada na parte baixa `ebx` e caso exista um transbordo esse bit e acumulado na parte alta `edx`.
-   4. **Controlo do Ciclo:** Um contador decrescente em `ecx` que comeca em 8, assegura que sao feitas as somas de todos os numeros do contentor, acabando com o jump `jne ciclo_soma` quando o contador chega a 0.

=====================================================
# Autor
- * Nome: Filipe Tavares n-139704
- * Curso: Engenharia Informatica Aplicada
- * Instituicao: UA-Estga



