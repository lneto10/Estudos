import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;


public class Main {
    public static void main(String[] args) {

        List<String> list = new ArrayList<>(); // lista não aceita tipo primitivo. Somente wrapper class.

        list.add("Teste1");
        list.add("Teste2");
        list.add("aTeste3");
        list.add(2,"Teste4");
        list.add("teste");
        list.add("Teste2"); // adiciona elementos


        System.out.println(list.size()); // imprime o tamanho da lista
        for(String x : list){
            System.out.println(x); // imprime a lista
        }
        System.out.println("___________________________");
        System.out.println(list.size());
        list.removeIf(x -> x.charAt(0) == 'T'); // excluir por predicado. Tudo que começa com T
        System.out.println(list.size());

        System.out.println("Index of teste "+list.indexOf("teste")); // busca qual o indice da lista


        List<String> result = list.stream().filter(x -> x.charAt(0) == 't').collect(Collectors.toList()); // mantenha somente na lista itens que inicia com T
        //converto para Stream, faço a operação LAMBDA e depois converto para list;
        for(String x : result){
            System.out.println(x); // imprime a lista
        }
        System.out.println("___________________________");


    }
}