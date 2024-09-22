CREATE TABLE funcionario (
    cpf varchar(16) PRIMARY KEY,
    nome varchar(100) NOT NULL,
    cargo varchar(50) NOT NULL,
    salario decimal(10, 2) NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    data_admissao date NOT NULL,
    rua varchar(100),
    cidade varchar(50),	
    estado varchar(2),
    cep varchar(10)
);

CREATE TABLE telefone_funcionario (	
    cpf_funcionario varchar(16),
    telefone varchar(15),
    PRIMARY KEY (cpf_funcionario, telefone),
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf) ON DELETE CASCADE	
);

CREATE TABLE cliente (
    cpf varchar(16) PRIMARY KEY,
    nome varchar(100) NOT NULL,
    data_nascimento date NOT NULL,
    email varchar(100) UNIQUE NOT NULL,
    rua varchar(100),
    cidade varchar(50),
    estado varchar(2),
    cep varchar(10)
);

CREATE TABLE telefone_cliente (
    cpf_cliente varchar(16),
    telefone varchar(15),
    PRIMARY KEY (cpf_cliente, telefone),
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf) ON DELETE CASCADE
);

CREATE TABLE atracao (
    id_atracao serial PRIMARY KEY,
    nome varchar(100) UNIQUE NOT NULL,
    descricao text,
    horario_funcionamento varchar(50),
    capacidade int
);

CREATE TABLE tipo_bilhete (	
    tipo varchar(20) PRIMARY KEY
);

INSERT INTO tipo_bilhete (tipo) values ('ENTRADA_INTEIRA'), ('MEIA_ENTRADA');

CREATE TABLE bilhete ( 	
    cod_bilhete serial PRIMARY KEY,
    data_validade date NOT NULL,
    data_compra date,
    status varchar(20) NOT NULL,
    valor decimal(10, 2) NOT NULL,
    tipo varchar(20) NOT NULL REFERENCES tipo_bilhete(tipo),
    doc_comprovante varchar(100),
    justificativa_desc text,
    cpf_cliente varchar(16), -- Relacionamento com Cliente
    FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf) ON DELETE CASCADE
);

CREATE TABLE acesso (
    id_acesso serial PRIMARY KEY,
    cod_bilhete int,
    hora_entrada timestamp NOT NULL,
    hora_saida timestamp,	
    FOREIGN KEY (cod_bilhete) REFERENCES bilhete(cod_bilhete) ON DELETE CASCADE
);

CREATE TABLE feedback (
    id_feedback serial PRIMARY KEY,
    cod_bilhete int,
    data_hora timestamp NOT NULL,
    descricao text,
    nota int,
    FOREIGN KEY (cod_bilhete) REFERENCES bilhete(cod_bilhete) ON DELETE CASCADE
);

CREATE TABLE escala (
    id_escala serial PRIMARY KEY,
    id_atracao int,
    cpf_funcionario varchar(16),
    data_alocacao date NOT NULL,
    hora_inicio time NOT NULL,
    hora_fim time NOT NULL,
    FOREIGN KEY (id_atracao) REFERENCES atracao(id_atracao) ON DELETE CASCADE,
    FOREIGN KEY (cpf_funcionario) REFERENCES funcionario(cpf) ON DELETE CASCADE
);

CREATE TABLE possibilita_feedback (
    cod_bilhete int,
    id_feedback int,
    PRIMARY KEY (cod_bilhete, id_feedback),
    FOREIGN KEY (cod_bilhete) REFERENCES bilhete(cod_bilhete) ON DELETE CASCADE,
    FOREIGN KEY (id_feedback) REFERENCES feedback(id_feedback) ON DELETE CASCADE
);



INSERT INTO funcionario (cpf, nome, cargo, salario, email, data_admissao, rua, cidade, estado, cep) VALUES
(50961084365, 'Carlos Silva', 'Salva-vidas', 3000.00, 'carlos.fun@gmail.com', '2022-05-01', 'Rua Vicente Moreira', 'Fortaleza', 'CE', 60000-000),
(86155777363, 'Ana Julia', 'Atendente de Bilheteria', 1800.00, 'ana@gmail.com', '2022-06-15', 'Rua Monte Rey', 'Fortaleza', 'CE', 60000-000),
(70348366343, 'João Barbosa', 'Salva-vidas', 3000.00, 'joao@gmail.com', '2023-01-20', 'Rua Dom Lucas', 'Quixadá', 'CE', 63900-001),
(23136230394, 'Mariana Souza', 'Recepcionista', 2200.00, 'mariana@gmail.com', '2023-03-05', 'Rua Cônego Aureliano Mota', 'Quixeramobim', 'CE', 63800-000),
(40804084341, 'Pedro Júnior', 'Manutenção', 2000.00, 'pedro@gmail.com', '2021-09-10', 'Avenida Herminio Sampaio', 'Fortaleza', 'CE', 60000-000),
(92190364361, 'Fernanda Ferreira', 'Limpeza', 2400.00, 'fernanda@gmail.com', '2022-12-02', 'Avenida Agenor Araújo', 'Iguatu', 'CE', 63500-058),
(25929579369, 'Ricardo Moura', 'Segurança', 3600.00, 'ricardo@gmail.com', '2022-07-22', 'Rua Monte Rey', 'Fortaleza', 'CE', 60000-000),
(19408073363, 'Juliana Martins', 'Atendente de Bilheteria', 1800.00, 'juliana.fun@gmail.com', '2023-02-15', 'Avenida Plácido Castelo', 'Quixadá', 'CE', 63900-001),
(47008265336, 'Lucas Ferreira', 'Gerente', 4500.00, 'lucas@gmail.com', '2023-04-10', 'Avenida Barão de Studart', 'Fortaleza', 'CE', 60000-000),
(58788419320, 'Sofia Costa', 'Limpeza', 2400.00, 'sofia@gmail.com', '2023-05-25', 'Rua Cônego Aureliano Mota', 'Quixeramobim', 'CE', 63800-000);

INSERT INTO telefone_funcionario (cpf_funcionario, telefone) VALUES
(50961084365, '(85)98799-6088'),
(86155777363, '(85)99723-8449'),
(70348366343, '(85)98672-5642'),
(23136230394, '(85)99572-5043'),
(40804084341, '(85)98106-2813'),
(92190364361, '(85)98163-5414'),
(25929579369, '(85)97289-1101'),
(19408073363, '(85)99463-7746'),
(47008265336, '(85)98751-2744'),
(58788419320, '(85)98901-5263');

INSERT INTO cliente (cpf, nome, data_nascimento, email, rua, cidade, estado, cep) VALUES
(82856476333, 'Carlos Almeida', '1990-01-15', 'carlos@gmail.com', 'Rua Luís Rosio', 'Fortaleza', 'CE', 60000-000),
(57418982895, 'André Magno', '2001-02-20', 'andre@gmail.com', 'Rua Oscar Freire', 'São Paulo', 'SP', 05409-010),
(39403472642, 'Clara Souza', '1992-03-25', 'clara@gmail.com', 'Rua Abadia Toledo', 'Uberaba', 'MG', 38046-594),
(89799252393, 'Maria Letícia', '2005-05-31', 'leticia@gmail.com', 'Avenida Plácido Castelo', 'Quixadá', 'CE', 63900-001),
(08696694430, 'Pedro Martins', '1994-05-05', 'pedro@gmail.com', 'Avenida Euclides Dourado', 'Garanhuns', 'PE', 55296-500),
(91037777743, 'Camilo Pereira', '1995-06-10', 'camilo@gmail.com', 'Avenida Vieira Souto', 'Rio de Janeiro', 'RJ', 22420-000),
(29654605864, 'Thiago Rodrigues', '1996-07-15', 'thiago@gmail.com', 'Rua Brás Cardoso', 'São Paulo', 'SP', 04510-030),
(28471316390, 'Stefany Torres', '2005-01-15', 'stefany@gmail.com', 'Avenida Plácido Castelo', 'Quixadá', 'CE', 63900-001),
(72621559620, 'Juliana Almeida', '1988-09-25', 'juliana@gmail.com', 'Avenida Gomes', 'Itajubá', 'MG', 37505-028),
(67101148808, 'Eduardo Bosco', '1999-10-30', 'eduardo@gmail.com', 'Rua Elvira Ferraz', 'São Paulo', 'SP', 04552-040);

INSERT INTO telefone_cliente (cpf_cliente, telefone) VALUES
(82856476333, '(85)98746-7445'),
(57418982895, '(11)98614-1253'),
(39403472642, '(34)97274-8510'),
(89799252393, '(85)99115-7439'),
(08696694430, '(81)98685-5413'),
(91037777743, '(22)97552-8081'),
(29654605864, '(11)98643-5804'),
(28471316390, '(85)99738-2511'),
(72621559620, '(35)98074-4831'),
(67101148808, '(11)99743-2775');

INSERT INTO atracao (nome, descricao, horario_funcionamento, capacidade) VALUES
('Piscina Adulto', 'Piscina para adultos', '09:00 - 18:00', 100),
('Piscina Infantil', 'Piscina para crianças', '09:00 - 18:00', 100),
('Tobogã', 'Tobogã gigante', '10:00 - 17:00', 30),
('Raia de Natação', 'Raia para natação', '08:00 - 18:00', 20),
('Área de Recreação', 'Área para atividades recreativas', '09:00 - 18:00', 40),
('Parque Inflável', 'Ambiente com brinquedos infláveis', '10:00 - 18:00', 25),
('Caminhada', 'Trilha para caminhada', '07:00 - 19:00', 15),
('Balde Maluco', 'Balde de água gigante', '09:00 - 18:00', 30),
('Bar da Piscina', 'Bar localizado próximo à piscina', '10:00 - 22:00', 60),
('Restaurante', 'Restaurante com refeições completas', '11:00 - 22:00', 60);

INSERT INTO bilhete (data_validade, data_compra, status, valor, tipo, doc_comprovante, justificativa_desc, cpf_cliente) VALUES
('2024-08-02', '2024-08-01', 'Ativo', 100.00, 'ENTRADA_INTEIRA', 'null', 'null', 82856476333),
('2024-08-03', '2024-08-02', 'Expirado', 50.00, 'MEIA_ENTRADA', '46381', 'Estudante', 57418982895),
('2024-08-02', '2024-08-01', 'Ativo', 100.00, 'ENTRADA_INTEIRA', 'null', 'null', 39403472642),
('2024-08-05', '2024-08-04', 'Usado', 50.00, 'MEIA_ENTRADA', '38168', 'Estudante', 89799252393),
('2024-08-05', '2024-08-04', 'Expirado', 100.00, 'ENTRADA_INTEIRA', 'null', 'null', 08696694430),
('2024-08-07', '2024-08-06', 'Ativo', 50.00, 'MEIA_ENTRADA', '49563', 'Estudante', 91037777743),
('2024-08-02', '2024-08-01', 'Expirado', 100.00, 'ENTRADA_INTEIRA', 'null', 'null', 29654605864),
('2024-08-07', '2024-08-06', 'Usado', 50.00, 'MEIA_ENTRADA', '59140', 'Estudante', 28471316390),
('2024-08-08', '2024-08-07', 'Usado', 100.00, 'ENTRADA_INTEIRA', 'null', 'null', 72621559620),
('2024-08-11', '2024-08-10', 'Ativo', 50.00, 'MEIA_ENTRADA', '30942', 'Estudante', 67101148808);

INSERT INTO acesso (cod_bilhete, hora_entrada, hora_saida) VALUES
(1, '2024-08-01 09:00:00', '2024-08-01 17:00:00'),
(2, '2024-08-02 09:30:00', '2024-08-02 16:30:00'),
(3, '2024-08-02 10:00:00', '2024-08-02 14:00:00'),
(4, '2024-08-06 11:00:00', '2024-08-06 19:00:00'),
(5, '2024-08-01 12:00:00', '2024-08-01 15:00:00'),
(6, '2024-08-04 13:00:00', '2024-08-04 21:00:00'),
(7, '2024-08-07 14:00:00', '2024-08-07 21:00:00'),
(8, '2024-08-03 15:00:00', '2024-08-03 20:00:00'),
(9, '2024-08-09 16:00:00', '2024-08-09 18:00:00'),
(10, '2024-08-08 17:00:00', '2024-08-08 19:00:00');

INSERT INTO feedback (cod_bilhete, data_hora, descricao, nota) VALUES
(1, '2024-08-01 16:00:00', 'Ótimo parque, gostei muito', 9),
(2, '2024-08-02 15:30:00', 'Bom, mas poderia ter mais opções de comida', 7),
(3, '2024-08-02 13:30:00', 'Excelente experiência', 10),
(4, '2024-08-06 16:00:00', 'Atendimento razoável', 5),
(5, '2024-08-01 14:00:00', 'Muito divertido', 10),
(6, '2024-08-04 19:00:00', 'Preços um pouco altos', 6),
(7, '2024-08-07 20:00:00', 'Ótimo para famílias', 10),
(8, '2024-08-03 17:30:00', 'Lugar muito limpo', 9),
(9, '2024-08-09 17:00:00', 'Diversão garantida', 10),
(10, '2024-08-08 18:00:00', 'Tudo excelente', 10);

INSERT INTO escala (id_atracao, cpf_funcionario, data_alocacao, hora_inicio, hora_fim) VALUES
(1, 23136230394, '2024-08-01', '09:00:00', '17:00:00'),
(2, 47008265336, '2024-08-01', '09:00:00', '17:00:00'),
(3, 50961084365, '2024-08-02', '10:00:00', '18:00:00'),
(4, 19408073363, '2024-08-02', '10:00:00', '18:00:00'),
(5, 86155777363, '2024-08-03', '11:00:00', '19:00:00'),
(6, 58788419320, '2024-08-03', '11:00:00', '19:00:00'),
(7, 25929579369, '2024-08-04', '12:00:00', '20:00:00'),
(8, 40804084341, '2024-08-04', '12:00:00', '20:00:00'),
(9, 70348366343, '2024-08-05', '13:00:00', '21:00:00'),
(10, 92190364361, '2024-08-05', '13:00:00', '21:00:00');

INSERT INTO possibilita_feedback (cod_bilhete, id_feedback) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);