public class TestaMetodo 
{
    public static void main (String[] args)
    {
        Conta conta2 = new Conta();
        /*conta2.saldo = 100;
        System.out.println("O Valor da conta e: "+conta2.saldo);
        conta2.deposita(500);
        System.out.println("O Valor da conta e: "+conta2.saldo);
        conta2.mensagem();
        Boolean conseguiuretirar = conta2.saca(200);
        conta2.imprimesaldo();
        System.out.println("Conseguiu retirar? "+conseguiuretirar);
        Conta contaCarol = new Conta ();
        contaCarol.deposita(500);
        if (contaCarol.transfere(10000,conta2)){
            System.out.println("Realizado com sucesso");
        }else {
            System.out.println("Nao realizado");
        }*/

       // Cliente luiz = new Cliente();
        //luiz.nome = "Luiz Barbozateste Neto";
        Conta contadoluiz = new Conta();
        contadoluiz.deposita(100);
        contadoluiz.imprimesaldo();
        
        
        

        
    }
}
