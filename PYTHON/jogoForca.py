def jogar():
    print("******* Bem vindo ao jogo **********")

    palavra_secreta = "corinthians"
    letras_acertadas = ['_','_','_','_','_','_','_','_','_','_','_']

    enforcou = False
    acertou = False

    while (not enforcou and not acertou):

        chute= input(("Qual letra: "))
        index = 0

        for letra in palavra_secreta:
            if (chute.upper() == letra.upper()):
                letras_acertadas[index]=letra
            index = index+1
        print(letras_acertadas)

jogar()

