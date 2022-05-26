public class Main {
    
        public static void main (String [] args){
            Mercadoria mercadoria = new Mercadoria();

            mercadoria.descricao = "Notebook";
            mercadoria.nome = "Computador";
            mercadoria.pcusto = 200.00;
            mercadoria.pvenda = 300.00;
            mercadoria.qtdestoque = 4.00;

            System.out.println ("O valor de desconto da mercadoria eh: "+mercadoria.calculodesconto(1500.00));

            
        }
}
