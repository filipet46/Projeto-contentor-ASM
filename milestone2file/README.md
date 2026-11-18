
=====================================================
# Projeto de Arquitetura de Computadores: Motor de Processamento de Dados Simbólicos em Assembly IA-32
## Milestone 2:  Contentor de Dados, categorizaçao dos valores e soma com inteiros signed

## 1. Overview
   Evoluçap do motor para incluir a categorizaçao em tempo de execuçao dos valores do contentor.

   O programa percorre automaticamente os elementos do contentor, classifica cada inteiro como Positivo, Negativo ou Zero e atualiza os contadores de cada categoria. Ao mesmo tempo tambem faz a soma total desses valores tendo em conta numeros negativos e possiveis situaçoes de overflow.

## 2. Estrutura de Dados Escolhida 
Foram utilizados os seguintes tipos de dados:

- **Contentor (`.long`):** Conjunto de  inteiros de 32 bits com sinal
- **Contadores (`.byte`):** Variaveis para guardar os acumuladores das categorias dos inteiros com sinal(`positivos`, `negativos`, `zeros`). Como o contentor é composto por apens 8 posicoes um bite e suficiente para armazenar estas contagens.

## 3. Arquiteturas e Decisoes Tecnicas
    Para percorrer o contentor, classificar os inteiros e fazer a soma total foi implementado um ciclo automatico, para evitar a necessidade de realizar as operacoes manualmente e de modo a deixar o codigo mas simples e pratico de alterar.

##  3.1. **Inicializacao dos Registers:**
    Foi utilizada a instrução XORL para inicializar os registos utilizados no processamento:

        %esi: índice da posição atual do contentor.
        %ebx: acumulador dos 32 bits inferiores da soma.
        %edx: acumulador dos 32 bits superiores da soma.
        %ecx: contador de iterações, inicializado com 8.

    A instrução xorl registo, registo permite colocar um registo a zero de forma eficiente.
## 3.2. **Endereçamento indexado:** 
    Foi utilizada a instruçao:
-    `movl contentor(,%esi,4), %eax`
    Este modo de endereçamento permite aceder diretamente a cada elemento do contentor atravez do indice %esi que é multiplicado por 4 porque cda elemento ocupa 4 bytes.
    Desta forma, o programa consegue percorrer sequencialmente todas as posições do vetor.
## 3.3. **Avaliação Condicional com Sinal:**
    Após a comparação, são utilizados os seguintes saltos condicionais:
        JL: desvia para a classificação de números negativos.
        JG: desvia para a classificação de números positivos.
    Caso nenhum dos saltos seja executado, o valor é zero.
    Dependendo da classificação, é incrementado o respetivo contador através da instrução INCB.

Esta estrutura implementa o padrão IF-THEN-ELSE, permitindo tomar decisões durante a execução do programa.
#   3.4. **Tratamento de casos de OverFlow:**
    Para calcular a soma total dos elementos, foi utilizada uma representação de 64 bits através de dois registos de 32 bits:
        %ebx: guarda os 32 bits inferiores do resultado.
        %edx: guarda os 32 bits superiores do resultado.

    São utilizadas as instruções ADDL e ADCL:
        ADDL %eax, %ebx: adiciona o valor atual aos 32 bits inferiores da soma.
        ADCL %edi, %edx: adiciona os 32 bits superiores do valor, juntamente com o carry (CF) produzido pela soma anterior.

    O registo %edi é utilizado para fazer a extensão do sinal do valor de 32 bits para 64 bits:
        Se o número for positivo ou zero, %edi recebe 0x00000000.
        Se o número for negativo, %edi recebe 0xFFFFFFFF.

    Desta forma, é possível somar corretamente números inteiros com sinal, preservando o resultado de 64 bits e considerando o carry entre os dois registos.

##   3.5. **Controlo do Ciclo:**
    Foi utilizado o registo %ecx, inicializado com o valor 8, para controlar o número de iterações.
    A instrução LOOP ciclo_contentor decrementa automaticamente o contador e repete o ciclo enquanto este não chegar a zero.
    Assim, garante-se que todos os 8 elementos do contentor são processados exatamente uma vez.

=====================================================
# Autor
- * Nome: Filipe Tavares n-139704
- * Curso: Engenharia Informatica Aplicada
- * Instituicao: UA-Estga



