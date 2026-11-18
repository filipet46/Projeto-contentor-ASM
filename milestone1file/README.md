
=====================================================
# Projeto de Arquitetura de Computadores: Motor de Processamento de Dados Simbólicos em Assembly IA-32
## Milestone 2:  Contentor de Dados, categorizaçao dos valores e soma com valores signed

## Overview
   Evoluçap do motor para incluir a categorizaçao em tempo de execuçao dos valores do contentor(positivos, negativos, zeros)

## Estrutura de Dados Escolhida (.long)
-**Contentor (`.long`): ** Conjunto de  inteiros de 32 bits com sinal
-**Contadores (`.long`): ** Variaveis para guardar os acumuladores das categorias dos inteiros com sinal(`positivos`, `negativos`, `zeros`)

## Arquiteturas e Decisoes Tecnicas
    Para percorrer o contentor e fazer a operacao pedida(soma) foi escolhido usar um ciclo de soma que percorre automaticamente o contentor, em vez de fazer as operacoes manualmente, com a seguinte estrutura:
-   1. **Inicializacao eficiente dos Registers:** Utilizacao da instrucao de `xorl`(`esi`,`ebx`,`edx`,`%edi`), para zerar os registos usados(pois trocar um registo consigo mesmo 'e uma forma muito eficiente de o colocar a 0.) para o indice de posicao, o acumulador da soma e a flag de overflow.
-   2. **Modo de enderecamento indexado (base(,%index,scale) destino):** Foi usado a instrucao `movl contentor(,%esi,4), %eax` para calcular o endereco do contentor a trabalhar em cada iteracao do ciclo, por ser mais eficiente do que calcular o endereco manualmente.
-  3. **Avaliação Condicional com Sinal:** Uso da instrução `cmpl $0, %eax` seguida de saltos condicionais com sinal (`jl`, `jg`) para desviar para as funçoes de incremento das variáveis de acumuladores das categorias (`positivos`, `negativos`, `zeros`).
-   4. **Tratamento de casos de OverFlow:** xxx.

-   5. **Controlo do Ciclo:** Um contador decrescente em `ecx` que comeca em 8, assegura que sao feitas as somas de todos os numeros do contentor, acabando com o jump `jne ciclo_soma` quando o contador chega a 0.

=====================================================
# Autor
- * Nome: Filipe Tavares n-139704
- * Curso: Engenharia Informatica Aplicada
- * Instituicao: UA-Estga



