public class Mercadoria {
    String nome; 
    String descricao;
    Double pcusto;
    Double pvenda;
    Double qtdestoque;


    Double calculodesconto (Double pvenda){
        Double desconto;

        if (pvenda < 1000){
            desconto = pvenda * 0.05;
        }
        else if (pvenda > 1000 && pvenda < 2000){
            desconto = pvenda * 0.10;
        }
        else {
            desconto = pvenda * 0.15;
        }
        return desconto;
    }
}

