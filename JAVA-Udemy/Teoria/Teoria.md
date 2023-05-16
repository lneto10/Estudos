# Orientação a Objetos com JAVA - Nélio Alves 

## Classe 
- É um tipo estruturado que pode conter Atributos (dados/campos) e Métodos (Funções/Operações)
- A classe também pode prover outros recursos, como: Construtores, sobrecargas, encapsulamento, herança, polimorfismo
- Para importar a classe para o programa principal, no Eclipse, pressione CTRL+SHIFT+O

- As variáveis estáticas que declaramos no programa, são criados na área da  memória STACK. 
- Durante a execução do programa, é possível realizar a alocação dinâmica da memória (através do comano NEW em JAVA)
- Quando eu informo o x = new Triangule() é criado um objeto do tipo TRIANGULE na área de memória chamado HEAP. 
- Heap é a área de memória onde são criados os objetos dinâmicos durante a execução. 
- a variável x está na área STACK, porém lá não estará a informação do X, mas sim o endereço de memória que aponta para objeto criado na  área de memória chamado HEAP. É apenas uma referência. 

## Métodos 

- São as funções e operações que contém dentro da classe
- No método é necessário especificar o tipo de retorno (caso seja uma função, informo o tipo de retorno: Double por exemplo), para procedimentos, informo o VOID 


![Classe](img/classe.png)