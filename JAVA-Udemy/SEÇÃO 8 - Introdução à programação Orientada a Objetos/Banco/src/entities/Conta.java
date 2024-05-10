package entities;

public class Conta {

    private int conta;
    private String nomeTitular;
    private double saldoConta;


    public Conta(int conta, String nome, double depositoInicial) {
        this.conta = conta;
        this.nomeTitular = nome;
        this.saldoConta = depositoInicial;
        this.saldo
    }

    public Conta(int conta, String nome) {
        this.conta = conta;
        this.nomeTitular = nome;
    }

    public int getConta() {
        return conta;
    }


    public String getNomeTitular() {
        return nomeTitular;
    }


    public double getSaldoConta() {
        return saldoConta;
    }



    public void setNomeTitular(double nomeTitular) {
        this.nomeTitular = nomeTitular;
    }

    public void depositoConta(double valorDeposito){
        this.saldoConta = this.saldoContA
    }

}
