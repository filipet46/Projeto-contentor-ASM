
.section .note.GNU-stack,"",@progbits

# ************** Armazem de Dados  **************
.data 
contentor: .long 2000000000,2000000000, -500000000, 40, 50, 60, 70, 80 #reservar espaco para o contentor de 8 valores de 32 bits cada
positivos: .byte 0
negativos: .byte 0
zeros: .byte 0
# ************** codigo executavel  **************
.text
.globl main

main: #funcao principal
    #meter so registers a zero
    xorl %esi, %esi 
    xorl %ebx, %ebx
    xorl %edx, %edx

    movl $8, %ecx

    ciclo_contentor: #ciclo para somar automaticamente os 8 valores, com carry se necessario
        movl contentor(,%esi,4), %eax
        inc %esi #Atualizar o indice para o proximo salto
        
        cmpl $0,%eax
        #if numero negativo
        jl acumula_negativo

        #else-if numero positivo
        jg acumula_positivo
        
        #else numero == 0
        incb zeros
        xorl %edi, %edi
        jmp continua_ciclo

        acumula_negativo:
            incb negativos
            movl $0xFFFFFFFF,%edi
            jmp continua_ciclo
            
        acumula_positivo:
            incb positivos
             xorl %edi, %edi
        continua_ciclo:
        addl %eax,%ebx
        adcl %edi,%edx  #soma ao %edx o bit de carry flag

        loop ciclo_contentor #caso o contador de ciclos %ecx !=0 salta para o rotulo 'ciclo_contentor'
        
    #restaurar os registos utilizados
    popl %edi
    popl %esi
    popl %ebx
    
    ret #fim da funcao principal
