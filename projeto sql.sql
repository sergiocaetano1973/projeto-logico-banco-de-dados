-- criação do banco de dados para o cenario E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
		idCliente int auto_increment primary key,
        Fname varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_client unique (CPF)
);


-- criar tabeba produto
-- size = dimensão do produto
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum('Eletronicos','Vestimenta','Brinquedos','Alimentos','Móveis') not null, 
        avaliação float default 0,
        size varchar(10),
        constraint unique_cpf_client unique (CPF)
);

-- termine de emplementar a tabela e crie a conexão com as tabelas necessarias
-- e reflita as modificaçoes no diagrama esquema relacional
-- criar constraint relacionadas ao pagamento
create table payments(
		idclient int,
        id_payment int,
        typePayment enum('Boleto','Cartão','dois Cartões'),
        limitAvailable float,
        primary key(idClient, id_payment)
);
-- criar tabela pedido

create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('cncelado','Confirmado','Em processamento') not null,
        orderDescription varchar(255),
        sendValue float default 10,
        PaymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)

);

-- criar tabela estoque

create table productStorege(
		idProdStorege int auto_increment primary key,
        storegeLocation varchar(225),
        quantity int default 0

);

-- criar tabela fornecedor


create table seller(
		idSeller int auto_increment primary key,
        SocialName varchar(225) not null,
        abstName varchar(255),
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contato char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
        constraint unique_cpf_seller unique (CPF)
        
        );
        
create table productSeller(
		idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
        constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);

create table productOrder(
		idOproduct int,
        idOorder int,
        podQuantity int default 1,
        poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_product_seller foreign key (idPOproduct) references product(idProduct),
        constraint fk_product_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
		idLproduct int,
		idPLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_product_seller foreign key (idLproduct) references product(idProduct),
        constraint fk_product_product foreign key (idLstorage) references orders(productSeller)
);
