
CREATE TABLE produtos (
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
COMMENT ON TABLE produtos IS 'Tabela Produtos';
COMMENT ON COLUMN produtos.produto_id IS 'Identificação do produto';
COMMENT ON COLUMN produtos.nome IS 'O nome dado ao produto para identificação';
COMMENT ON COLUMN produtos.preco_unitario IS 'O preço unitario dado ao produto';
COMMENT ON COLUMN produtos.detalhes IS 'Os detalhes dados ao produto';
COMMENT ON COLUMN produtos.imagem IS 'A imagem determinada do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'O anexo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'O link da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'A codificação da imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'A data da ultima atualização/alteração da imagem do produto';


CREATE TABLE lojas (
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
COMMENT ON TABLE lojas IS 'Tabela Lojas';
COMMENT ON COLUMN lojas.loja_id IS 'Identificação da loja';
COMMENT ON COLUMN lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'O endereço web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'O endereço onde se encontra a loja física';
COMMENT ON COLUMN lojas.latitude IS 'a latitude da loja';
COMMENT ON COLUMN lojas.longitude IS 'A longitude de onde se encontra a loja';
COMMENT ON COLUMN lojas.logo IS 'A logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'anexo da logo da loja';
COMMENT ON COLUMN lojas.logo_arquivo IS 'O link do arquivo da logo da loja';
COMMENT ON COLUMN lojas.logo_charset IS 'A codificação da logo da loja';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'A data da ultima atualização da logo da loja';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS 'Tabela Estoques';
COMMENT ON COLUMN estoques.estoque_id IS 'Identificação de estoques da loja';
COMMENT ON COLUMN estoques.loja_id IS 'Chave estrangeira da tabela lojas';
COMMENT ON COLUMN estoques.produto_id IS 'Chave estrangeira da tabela produtos';
COMMENT ON COLUMN estoques.quantidade IS 'Informa a quantidade de produtos no estoque';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'Tabela Clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'Identificação do cliente';
COMMENT ON COLUMN clientes.email IS 'Escreva seu email aqui:';
COMMENT ON COLUMN clientes.nome IS 'Insira seu nome aqui:';
COMMENT ON COLUMN clientes.telefone1 IS 'insira seu numero de telefone:';
COMMENT ON COLUMN clientes.telefone2 IS 'insira seu 2° numero de telefone:';
COMMENT ON COLUMN clientes.telefone3 IS 'insira seu 3° numero de telefone:';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios IS 'Tabela Envios';
COMMENT ON COLUMN envios.envio_id IS 'Identificação dos envios';
COMMENT ON COLUMN envios.loja_id IS 'Chave estrangeira da tabela lojas';
COMMENT ON COLUMN envios.cliente_id IS 'Chave estrangeira da tabela clientes';
COMMENT ON COLUMN envios.endereco_entrega IS 'Insira o endereço da entrega para envio';
COMMENT ON COLUMN envios.status IS 'Informa o status do envio';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE pedidos IS 'Tabela Pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'Identificação do pedido do cliente';
COMMENT ON COLUMN pedidos.data_hora IS 'data e horário do pedido do cliente';
COMMENT ON COLUMN pedidos.cliente_id IS 'chave estrangeira do cliente_id da tabela clientes';
COMMENT ON COLUMN pedidos.status IS 'status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'chave estrangeira da loja_id da tabela lojas';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE pedidos_itens IS 'Tabela de Pedidos e Itens';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Chave primária e estrangeira da tabela pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Chave primária e estrangeira da tabela produtos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Informa o número da linha do pedido com os itens';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Informa o preço unitário dos itens dentro do pedido';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Informa a quantidade de itens no pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Chave estrangeira da tabela envios';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
