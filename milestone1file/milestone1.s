
.section .note.GNU-stack,"",@progbits

# ************** Armazem de Dados  **************
.data 
contentor: .long 10,20, 30, 40, 50, 60, 70, 80 #reservar espaco para o contentor de 8 valores de 32 bits cada

# ************** codigo executavel  **************
.text
.globl main

main: #funcao principal
    #meter so registers a zero
    xorl %esi, %esi 
    xorl %ebx, %ebx
    xorl %edx, %edx

    movl $8, %ecx

    ciclo_soma: #ciclo para somar automaticamente os 8 valores, com carry se necessario
        movl contentor(,%esi,4), %eax
        addl %eax,%ebx
        adcl $0,%edx  #soma ao %edx o bit de carry flag
        inc %esi
        dec %ecx
        jne ciclo_soma  #caso o contador de ciclos %ecx !=0 repete o 'ciclo_soma'
        
    ret #fim da funcao principal
