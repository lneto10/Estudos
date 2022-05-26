public class Poluicao{
    Double indice; 

    
    void lerindice (Double indice){
        if (indice < 0.30){
            System.out.println("Boa: Nenhuma providência");
        } else if (indice <= 0.30 && indice < 0.40){
            System.out.println("Ruim: Suspender empresas da lista  A");
        } else if (indice <= 0.40 && indice <= 0.50){
            System.out.println("Péssima: Suspender empresas da lista A e B");

        } else {
            System.out.println("Suspender todas as empresas");
        }
        
    }

}

