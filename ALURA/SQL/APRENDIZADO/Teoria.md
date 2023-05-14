### Entidades SQL

## Tables - Tabelas 
Uma tabela é composta por colunas e as linhas chamamos de registros. Toda tabela possui campos identificado pelo seu nome. 

Os dados inseridos nos campos, devem ser do mesmo tipo do que foi definido no campo. Ex. Campo Texto: Só pode ser armazenado dados do tipo Texto.

Valor Vazio é diferente de Valor em branco. Valor vazio é ausência de valor. 


## Chaves Primárias 
Cujo valor não pode se repetir. 

Chave Primárias Compostas - Um ou mais campos combinados são definidos de chaves primárias. 

Chaves primárias não são obrigatórias. Tabelas podem ser criadas sem a definição de chaves primárias

## Bancos de dados relacionais 

- A relação entre as tabelas se dá pela Chave estrangeira (Foreign Key)
- Estes campos devem ter as mesmas propriedades
- Campo Normal com chave primária (1:N)

# Índice 
- Ajuda a fazer buscas mais rápidas associadas à coluna 
- O banco de dados cria de forma automática índices nas criações de chaves primárias. 
- A estrutura de índices ajuda muito a otimização de consultas. 
- Porém, a criação de índices gera lentidão na hora de atualiza a tabela. 

# Visões 
- Como se fossem tabelas lógicas

# Procedures/Funções 
- Transact SQL. Estrutura de lógica de programação em SQL. 

# Trigger 
- Comandos de bancos de dados quando alguma coisa acontecer. 
- Os comandos podem ser em SQL ou Transact SQL. 