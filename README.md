# Sistema de Gerenciamento de Funcionários - Parque Aquático

Este projeto é uma aplicação para gerenciar funcionários de um parque aquático. Ele permite realizar operações de **consulta**, **inserção** e **exclusão** de dados de funcionários, como CPF, nome,
cargo e outras informações.

## Funcionalidades

- **Consultar Funcionários**: Realiza consultas no banco de dados com base no CPF do funcionário.
- **Inserir Funcionários**: Insere novos funcionários no banco de dados, com seus dados pessoais e de contato.
- **Excluir Funcionários**: Exclui registros de funcionários do banco de dados utilizando o CPF.

## Tecnologias Utilizadas

- **Python**: Linguagem principal do projeto.
- **Pandas**: Para manipulação e análise de dados.
- **SQLAlchemy**: Para se comunicar com o banco de dados PostgreSQL de maneira eficiente.
- **Psycopg2**: Para conectar diretamente ao PostgreSQL.
- **Panel**: Para construir a interface gráfica da aplicação.
- **PostgreSQL**: Sistema de banco de dados utilizado para armazenar os dados dos funcionários.


## Configuração do Banco de Dados
Criação das principais tabelas utilizadas na tela desenvolvida.

### Tabela `funcionario`
```sql
CREATE TABLE aquapark.funcionario (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    salario FLOAT,
    email VARCHAR(100),
    data_admissao DATE,
    rua VARCHAR(100),
    cidade VARCHAR(50),
    estado CHAR(2),
    cep VARCHAR(10)
);
```

### Tabela `telefone_funcionario`
```sql
CREATE TABLE aquapark.telefone_funcionario (
    cpf_funcionario VARCHAR(11),
    telefone VARCHAR(15),
    FOREIGN KEY (cpf_funcionario) REFERENCES aquapark.funcionario(cpf)
);
