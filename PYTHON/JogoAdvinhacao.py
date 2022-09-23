from os import system
from tokenize import Double
system("cls")

print("********************************")
print("Bem vindo ao jogo de advinhacao")
print("********************************")

numero_secreto = 42 
total_de_tentativas = 3
contador = 1

while (contador <= total_de_tentativas):
    print("Tentativa de {} de {}". format(contador,total_de_tentativas))
    #print("Tentativa de ",contador,"de ",total_de_tentativas)
    chute = int(input("Digite seu numero: "))


    acertou = chute == 42
    maior = chute > 42
    menor = chute < 42 
    print("VocE digitou o numero", chute)


    if (acertou):
        print("Voce acertou")
        break
    elif (maior): 
        print("Voce errou. Informou numero a maior")
    else:
        print("Voce informou numero a menor")
    contador += 1

