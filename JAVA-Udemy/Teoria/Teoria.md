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


![Classe](/Teoria/img/classe.PNG)

# Construtores 
- É uma operação especial da classe que executa no momento da instanciação do objeto. 
- É utilizado comumente para iniciar valores de atributos, e fazer com que o objeto receba dados no momento de sua construção. 
- É possivel especificar mais de um construtor na mesma classe: Sobrecarga. 

# This
- A palavra this é importante pois referencia o atributo do objeto. Caso não utilize a palavra this, a prioridade é sempre a variável local do método. 
- Diferencia atributos de variáveis locais. 

# Sobrecarga 
- É um recurso que uma classe possui de oferecer mais de uma operação com o mesmo nome, porém com diferentes listas de parâmetros

# Encapsulamento
- É um principio que consiste em esconder detalhes de implementação de uma classe, expondo apenas operações seguras e que mantenham os objetos em um estado consistente. 
- O objeto deve sempre em estar um estado consistente, e a própria classe deve garantir isso. 
- Um objeto não deve expor nenhum atributo (modificador de acesso para private)
- Os atributos devem ser aecssados por meio de métodos get e set.

# Modificadores de Acesso 
- Private: O membro só pode ser acessado na própria classe. 
- Caso o atributo não esteja especificado o tipo de acesso no momento da sua instanciação, só pode ser acessado pelo mesmo pacote. 
- Protected: O membro só pode ser acessado no mesmo pacote, bem como subclasses de pacotes diferentes. 
- Public: pode ser acessado por todas a classes. A menos que esteja em um módulo diferente que não exporte o pacote onde ele está. 