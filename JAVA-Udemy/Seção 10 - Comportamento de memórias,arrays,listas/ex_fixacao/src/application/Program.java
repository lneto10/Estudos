package application;

import entities.Funcionario;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;
/* Fazer um programa para ler um número inteiro N e depois os dados (id, nome e salario) de
N funcionários. Não deve haver repetição de id.
Em seguida, efetuar o aumento de X por cento no salário de um determinado funcionário.
Para isso, o programa deve ler um id e o valor X. Se o id informado não existir, mostrar uma
mensagem e abortar a operação. Ao final, mostrar a listagem atualizada dos funcionários,
conforme exemplos.
Lembre-se de aplicar a técnica de encapsulamento para não permitir que o salário possa
ser mudado livremente. Um salário só pode ser aumentado com base em uma operação de
aumento por porcentagem dada.*/
public class Program {
    public static void main(String[] args) {
        Locale.setDefault(Locale.US);
        Scanner sc = new Scanner(System.in);
        List<Funcionario> list = new ArrayList<>();

        //inserindo dados

        System.out.print("Quantos funcionarios irá cadastrar? ");
        int n = sc.nextInt();

        for(int i = 1;i<=n;i++){
            System.out.print("Funcionario n° "+i+" :");
            System.out.print("Insira o ID: ");
            int id = sc.nextInt();
            while(temID(list,id)){
                System.out.println("ID já existente. Tente novamente: ");
                id = sc.nextInt();
            }
            System.out.print("Insira o nome: ");
            sc.nextLine();
            String nome = sc.nextLine();
            System.out.print("Insira o salario: ");
            Double salario = sc.nextDouble();

            list.add(new Funcionario(id,nome,salario));

        }
        //impressão da lista
        System.out.println("Imprimindo funcionarios");
        for(Funcionario obj : list){
            System.out.println(obj);
        }

        //Atualizando salario
        System.out.println("____________________");
        System.out.print("Insira o ID do funcionario que deseja atualizar o salario: ");
        int id = sc.nextInt();
        Funcionario func = list.stream().filter(x -> x.getId() == id).findFirst().orElse(null); // a variável do tipo objeto func, recebe o retorno da busca feito na lista.
        if (func != null){ // caso não encontre nada, é nulo.
           System.out.print("Insira o % de aumento: ");
           double percentual = sc.nextDouble();
           func.atualizarSalario(percentual);
        }else{
            System.out.println("Não foi encontrado o funcionário");
        }

        //impressão da lista
        System.out.println("Imprimindo funcionarios");
        for(Funcionario obj : list){
            System.out.println(obj);
        }

    }
    public static boolean temID(List<Funcionario> list,int id){
        Funcionario func = list.stream().filter(x -> x.getId() == id).findFirst().orElse(null);
        return func != null;
    }
}
