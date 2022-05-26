import java.util.Scanner;
public class Main {
    
        public static void main (String [] args){
            Double indice;
            Scanner scanner = new Scanner (System.in);
            Poluicao poluicao = new Poluicao();

            System.out.println ("Informe o indice de poluicao: ");
            
            indice = scanner.nextDouble();

            poluicao.lerindice(indice);
        }
}
