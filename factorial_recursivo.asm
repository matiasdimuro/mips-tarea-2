.data
prompt: .asciiz "INGRESE NUMERO DEL FACTORIAL A CALCULAR:  " # print string
space:  .asciiz "\n"        # space between numbers

.text
.globl main
main:

## INGRESO Y LEO EL NUMERO
li		      $v0, 4		        # syscall read string code
la		      $a0, prompt		    # load prompt adress
syscall                       # read prompt (number)
li          $v0, 5            # syscall read_int code
syscall                       # read number
move        $t0, $v0          # move number in $a0 to $t1
li		      $v0, 4		        # syscall read string code
la		      $a0, space		    # read space
syscall                       # add space

## RESTO 1 AL NUMERO ELEGIDO
addi		    $t1, $t0, -1      # $t1 = $t0-- (number - 1)

## SALTO A LA FUNCION QUE CALCULA EL FACTORIAL
jal         loop              # jump to "loop" target and save position to $ra

## FINALIZACION DEL PROGRAMA
li		      $v0, 10		        # syscall halt code
syscall                       # halt

## FUNCION LOOP QUE CALCULA EL FACTORIAL
loop:
beq		      $t1, $zero, exit  # if $t1 == 0 go to exit
mul         $t0, $t0, $t1     # number *=  number-1
addi		    $t1, $t1, -1      # $t1 = $t0-- (number - 1)
j           loop              # jump to loop

## IMPRIMO RESULTADO DEL FACTORIAL
exit:
li          $v0, 1            # syscall print int code
move        $a0, $t0          # move $t0 to $a0
syscall

## VUELVO A LA INSTRUCCION SEGUIDA AL JAL (FINALIZACION DEL PROGRAMA)
jr    $ra
