import java.util.Scanner;

public class Matriz {
    int numero [][] = new int [5][5];
   Scanner scanner = new Scanner (System.in);
   int par = 0;
   int impar = 0;
    
   void lermatriz(){
        for (int i = 0;i<5;i++){
         for (int j = 0;j<5;j++){
           System.out.println("Informe um numero para o vetor: ");
           this.numero[i][j] = scanner.nextInt();
           if (this.numero[i][j] % 2 == 0){
               this.par ++;
           } else {
               this.impar ++;
           }
        }
        }

       
    }

    void paresimpares() {
        System.out.println("Valor de par: "+par);
        System.out.println ("Valor de impar: "+impar);
    }
    void impressaomatriz () {
        System.out.println ("Valores da matriz");
        for (int i = 0; i < 5; i++){
            for (int j = 0; j <5; j++){
                System.out.println (this.numero[i][j]);
            }
        }
    }

    void diagonais(){
        System.out.println("Diagonal principal");
        for (int i = 0; i< 5; i++){
            if (this.numero[i][i] < 10 && this.numero[i][i] >= 0){
                System.out.println("0");
            }
            System.out.println(this.numero[i][i]+" ");
        }

        System.out.println("\nDiagonal Secundaria");
            for (int i = 4; i>=0; i--){
                if (this.numero[i][5 - 1 - i] < 10 && this.numero[i][5-1-i] >=0 ){
                    System.out.println("0");
                }
                System.out.println(this.numero[i][5-1-i]);
            }
    }
    
    void maxemin() {
        int min = 0;
        int max = 0;

        for (int i = 0; i < 5; i++){
            for (int j = 0; j < 5; j++){
                if (this.numero[i][j] > max){
                    max = this.numero[i][j];
                } else if (this.numero[i][j] < min) {
                    min = this.numero[i][j];
                }
                System.out.println("Valor do minimo: "+min +"Vaor maximo: "+max);
            }
        }
    }

}