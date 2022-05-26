public class Conta {
    double saldo;
    int agencia; 
    int numero;
    Boolean ativo;

     void deposita(double valor) {
        this.saldo += valor;   
    
    }
    
    void mensagem()
    {
        System.out.println ("Deposito realizado -- metodo mensagem");
    }
    void imprimesaldo (){
        System.out.println("Valor em conta: "+this.saldo);
    }


    public Boolean saca (double valor){
        if (this.saldo >= valor){
            this.saldo-= valor;
            return true;
        } else {
            return false;
        }
    }

    public Boolean transfere(double valor, Conta destino){
        if (this.saldo >= valor){
            this.saldo-=valor;
            destino.deposita(valor);
            destino.mensagem();
            destino.imprimesaldo();
            this.imprimesaldo();
            return true;
        }else {
            return false; 
        }

    }
    
}