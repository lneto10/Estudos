def soma (x,y):
    return x+y

def menu ():
    x = int(input("Insira um valor para soma: "))
    y = int(input("Insira outro valor para soma: "))
    resultado = soma(x,y)
    print(resultado)

print("Fora do menu")
menu()
