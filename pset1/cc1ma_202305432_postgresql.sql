--Deletando o banco de dados uvv caso ele já exista.

DROP DATABASE IF EXISTS uvv;

--Deletando o usuário guilherme caso ele já exista.

DROP USER IF EXISTS guilherme;

--Criação do usuário guilherme com permissão de criar banco de dados, cargo e senha criptografada.

CREATE USER guilherme
WITH CREATEDB CREATEROLE
ENCRYPTED PASSWORD 'guilherme@vizzoni';

--Criação do banco de dados uvv, com o dono do bd sendo "guilherme".

CREATE DATABASE uvv
WITH OWNER = guilherme
TEMPLATE = template0
ENCODING = 'UTF8'
LC_COLLATE = 'pt_BR.UTF-8'
LC_CTYPE = 'pt_BR.UTF-8'
ALLOW_CONNECTIONS = 'true';

--Adição de comentários no banco de dados.

COMMENT ON DATABASE uvv IS 'Banco de dados utilizado para lojas uvv';


-- Conectando ao usuário "guilherme".	

SET role guilherme;

--Acesso ao banco de dados com o usuário "guilherme".

\c "host=localhost dbname=uvv user=guilherme password=guilherme@vizzoni"

-- Deletando o esquema "lojas" caso ele já exista.

DROP SCHEMA IF EXISTS lojas
;

-- Criação do esquema lojas, onde o usuário "guilherme" pode criar tabelas.

CREATE SCHEMA  lojas 
AUTHORIZATION  guilherme;

--Adição de comentários no esquema.

COMMENT ON SCHEMA lojas IS 'Esquema onde será criado e administrado o banco de dados das lojas UVV';

--Definindo o esquema como padrão.

SET SEARCH_PATH TO lojas, "$user", public;

--Definindo o esquema como padrão para a utilização do usuário "guilherme".

ALTER USER guilherme
SET SEARCH_PATH TO lojas, "$user", public;

-- Criação da tabela "clientes".

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);

-- Adição de comentários na tabela "clientes".

COMMENT ON TABLE lojas.clientes IS 'Mostra informações de todos os clientes da loja';

-- Adição de comentários nas colunas da tabela "clientes".

COMMENT ON TABLE lojas.clientes IS 'Esta tabela armazenará os dados dos clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Identificação de cada cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'Identifica o email inserido pelo cliente.';
COMMENT ON COLUMN lojas.clientes.nome IS 'Identifica o nome completo do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'Identifica o 1º telefone do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Identifica o 2º telefone do cliente.';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Identifica o 3º telefone do cliente.';

--Criação da tabela "pedidos".

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

-- Adição de comentários na tabela "pedidos".

COMMENT ON TABLE lojas.pedidos IS 'Tabela Pedidos';

-- Adição de comentários nas colunas da tabela "pedidos".

COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Identificação do pedido do cliente';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Identifica a data e horário do pedido do cliente';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'chave estrangeira do cliente_id da tabela clientes';
COMMENT ON COLUMN lojas.pedidos.status IS 'Identifica o status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'chave estrangeira da loja_id da tabela lojas';

--Criação da tabela "lojas".

CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);

-- Adição de comentários na tabela "lojas".

COMMENT ON TABLE lojas.lojas IS 'Tabela Lojas';

-- Adição de comentários nas colunas da tabela "lojas".

COMMENT ON COLUMN lojas.lojas.loja_id IS 'Identificação da loja';
COMMENT ON COLUMN lojas.lojas.nome IS 'Identifica o nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Identifica o endereço web da loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Identifica o endereço onde se encontra a loja física';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Identifica a latitude demográfica da loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Identifica a longitude demográfica da loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'Identifica a logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Identifica o anexo da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Identifica o link do arquivo da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Identifica a codificação da logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Identifica a data da ultima atualização da logo da loja';

--Criação da tabela "produtos".

CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

-- Adição de comentários na tabela "produtos".

COMMENT ON TABLE lojas.produtos IS 'Tabela Produtos';

-- Adição de comentários nas colunas da tabela "produtos".

COMMENT ON COLUMN lojas.produtos.produto_id IS 'Identificação do produto';
COMMENT ON COLUMN lojas.produtos.nome IS 'Identifica o nome dado ao produto para identificação';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Identifica o preço unitario dado ao produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Identifica os detalhes dados ao produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Identifica a imagem determinada do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Identifica o anexo da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Identifica o link da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Identifica a codificação da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Identifica a data da ultima atualização/alteração da imagem do produto';

--Criação da tabela "estoques".

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);

-- Adição de comentários na tabela "estoques".

COMMENT ON TABLE lojas.estoques IS 'Tabela Estoques';

-- Adição de comentários nas colunas da tabela "estoques".

COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Identificação de estoques da loja';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Chave estrangeira da tabela lojas';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Chave estrangeira da tabela produtos';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Informa a quantidade de produtos no estoque';

--Criação da tabela "envios".

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);

-- Adição de comentários na tabela "envios".

COMMENT ON TABLE lojas.envios IS 'Tabela Envios';

-- Adição de comentários nas colunas da tabela "envios".

COMMENT ON COLUMN lojas.envios.envio_id IS 'Identificação dos envios';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Chave estrangeira da tabela lojas';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Chave estrangeira da tabela clientes';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Informa o endereço da entrega para envio';
COMMENT ON COLUMN lojas.envios.status IS 'Informa o status do envio';

--Criação da tabela "pedidos_itens".

CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

-- Adição de comentários na tabela "pedidos_itens".

COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela de Pedidos e Itens';

-- Adição de comentários nas colunas da tabela "pedidos_itens".

COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Chave primária e estrangeira da tabela pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Chave primária e estrangeira da tabela produtos';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Informa o número da linha do pedido com os itens';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Informa o preço unitário dos itens dentro do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Informa a quantidade de itens no pedido';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Chave estrangeira da tabela envios';

--Criação de um relacionamento entre as tabelas pai "produtos" e filho "estoques".

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "produtos" e filho "pedidos_itens".

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "lojas" e filho "estoques".

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "lojas" e filho "envios".

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "lojas" e filho "pedidos".

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "clientes" e filho "pedidos".

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "clientes" e filho "envios".

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "envios" e filho "pedidos_itens".

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um relacionamento entre as tabelas pai "pedidos" e filho "pedidos_itens".

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO REGRA QUE EM PEDIDOS, A COLUNA STATUS ACEITE SOMENTE: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO, ENVIADO

ALTER TABLE lojas.pedidos
ADD CONSTRAINT checar_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

--CRIANDO REGRA QUE EM ENVIOS, A COLUNA STATUS ACEITE SOMENTE: CRIADO, ENVIADO, TRANSITO, ENTREGUE

ALTER TABLE lojas.envios
ADD CONSTRAINT checar_status_dos_envios
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRÂNSITO', 'ENTREGUE'));

--CRIANDO UMA REGRA QUE ME GARANTE QUE PELO MENOS UMAS DAS COLUNAS "ENDERECO_WEB" OU "ENDERECO_FISICO" ESTEJAM PREENCHIDAS

ALTER TABLE lojas.lojas
ADD CONSTRAINT endereco_unico
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

--CRIANDO UMA REGRA QUE ME GARANTE QUE O PREÇO UNITÁRIO NÃO SEJA NEGATIVO

ALTER TABLE lojas.produtos
ADD CONSTRAINT preco_unitario_somente_positivo
CHECK (preco_unitario >= 0);

--CRIANDO UMA REGRA QUE ME GARANTE QUE O ESTOQUE NÃO SEJA NEGATIVO/essa ta repetida la em cima! cuidado ae

ALTER TABLE lojas.estoques
ADD CONSTRAINT estoques_somente_positivos
CHECK (quantidade >= 0);

-- Comando definindo o formato em que é adicionada a data.

ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_formatacao_data_hora_ CHECK (TO_CHAR(data_hora, 'DD-MM-YYYY') = TO_CHAR(data_hora, 'DD-MM-YYYY'));

-- Inserção de Dados na tabela produtos.

	INSERT INTO Lojas.produtos (produto_id, nome, preco_unitario, detalhes, imagem, imagem_mime_type, imagem_arquivo, imagem_charset, imagem_ultima_atualizacao)
	VALUES 
	    (1, 'Produto 1', 10.99, 'Detalhes do produto 1', NULL, NULL, NULL, NULL, NULL),
	    (2, 'Produto 2', 15.99, 'Detalhes do produto 2', NULL, NULL, NULL, NULL, NULL),
	    (3, 'Produto 3', 20.99, 'Detalhes do produto 3', NULL, NULL, NULL, NULL, NULL);

-- Inserção de Dados na tabela lojas.

	INSERT INTO Lojas.lojas (loja_id, nome, endereco_web, endereco_fisico, latitude, longitude, logo, logo_mime_type, logo_arquivo, logo_charset, logo_ultima_atualizacao)
	VALUES 
    		(1, 'Loja 1', 'https://www.loja1.com', null, 123.456, 789.123, null, null, null, null, null),
    		(2, 'Loja 2', null, 'Rua da Loja 2', 456.789, 321.987, null, null, null, null, null),
    		(3, 'Loja 3', 'https://www.loja3.com', 'Rua da Loja 3', 789.123, 654.321, null, null, null, null, null);

-- Inserção de Dados na tabela estoques.

	INSERT INTO Lojas.estoques (estoque_id, loja_id, produto_id, quantidade)
	VALUES 
	    (1, 1, 1, 100),
	    (2, 2, 2, 200),
	    (3, 3, 3, 300);

-- Inserção de Dados na tabela clientes.
	
	INSERT INTO Lojas.clientes (cliente_id, email, nome, telefone1, telefone2, telefone3)
	VALUES 
	    (1, 'cliente1@example.com', 'Cliente 1', '123456789', NULL, NULL),
	    (2, 'cliente2@example.com', 'Cliente 2', '987654321', NULL, NULL),
	    (3, 'cliente3@example.com', 'Cliente 3', '456789123', NULL, NULL);

-- Inserção de Dados na tabela envios.

	INSERT INTO Lojas.envios (envio_id, loja_id, cliente_id, endereco_entrega, status)
	VALUES 
	    (1, 1, 1, 'Endereço de entrega 1', 'ENVIADO'),
	    (2, 2, 2, 'Endereço de entrega 2', 'TRANSITO'),
	    (3, 3, 3, 'Endereço de entrega 3', 'ENTREGUE');

-- Inserção de Dados na tabela pedidos.	

	INSERT INTO Lojas.pedidos (pedido_id, data_hora, cliente_id, status, loja_id)
	VALUES 
	    (1, current_timestamp, 1, 'ABERTO', 1),
	    (2, current_timestamp, 2, 'COMPLETO', 2),
	    (3, current_timestamp, 3, 'PAGO', 3);

-- Inserção de Dados na tabela pedidos_itens.

	INSERT INTO Lojas.pedidos_itens (pedido_id, produto_id, numero_da_linha, preco_unitario, quantidade, envio_id)
	VALUES 
	    (1, 1, 1, 9.99, 2, 1),
	    (2, 2, 2, 12.99, 3, 2),
	    (3, 3, 3, 15.99, 1, 3);