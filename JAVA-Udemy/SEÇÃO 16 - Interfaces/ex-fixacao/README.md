# Exercício de Fixação

Uma empresa deseja automatizar o processamento de seus contratos. O processamento de um contrato consiste em gerar as parcelas a serem pagas para aquele contrato, com base no número de meses desejado.

A empresa utiliza um serviço de pagamento online para realizar o pagamento das parcelas. Os serviços de pagamento online tipicamente cobram um juro mensal, bem como uma taxa por pagamento. Por enquanto, o serviço contratado pela empresa é o do **Paypal**, que aplica juros simples de **1%** a cada parcela, mais uma **taxa de pagamento de 2%**.

## Descrição do Programa

O programa deve:

- Ler os dados de um contrato (número do contrato, data do contrato e valor total do contrato).
- Ler o número de meses para parcelamento do contrato.
- Gerar os registros de parcelas a serem pagas (data e valor), sendo:
  - A primeira parcela paga um mês após a data do contrato.
  - A segunda parcela paga dois meses após a data do contrato.
  - E assim por diante.

Ao final, o programa deve exibir os dados das parcelas na tela.

---

## Exemplo de Execução

Entre os dados do contrato: Numero: 8028 Data (dd/MM/yyyy): 25/06/2018 Valor do contrato: 600.00 Entre com o numero de parcelas: 3 Parcelas: 25/07/2018 - 206.04 25/08/2018 - 208.08 25/09/2018 - 210.12