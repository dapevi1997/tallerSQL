-- -----------------------------------------------------
-- Crear base de datos.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS store DEFAULT CHARACTER SET utf8 ;
USE store ;

-- -----------------------------------------------------
-- Tabla cliente.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer (
  cus_id INT NOT NULL AUTO_INCREMENT,
  cus_name VARCHAR(20) NOT NULL,
  cus_document_type VARCHAR(2) NOT NULL,
  cus_document VARCHAR(10) NOT NULL,
  PRIMARY KEY (cus_id),
  UNIQUE INDEX cus_document_type_UNIQUE (cus_document_type ASC, cus_document ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla proveedor.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS supplier (
  sup_id INT NOT NULL AUTO_INCREMENT,
  sup_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (sup_id))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla producto.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  pro_id INT NOT NULL AUTO_INCREMENT,
  supplier_sup_id INT NOT NULL,
  pro_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (pro_id),
  INDEX fk_product_supplier1_idx (supplier_sup_id ASC) VISIBLE,
  CONSTRAINT fk_product_supplier1
    FOREIGN KEY (supplier_sup_id)
    REFERENCES supplier (sup_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla de compras.
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS customer_product_bought (
  customer_cus_id INT NOT NULL,
  product_pro_id INT NOT NULL,
  deleted TINYINT NULL DEFAULT 0,
  PRIMARY KEY (customer_cus_id, product_pro_id),
  INDEX fk_customer_has_product_product1_idx (product_pro_id ASC) VISIBLE,
  INDEX fk_customer_has_product_customer1_idx (customer_cus_id ASC) VISIBLE,
  CONSTRAINT fk_customer_has_product_customer1
    FOREIGN KEY (customer_cus_id)
    REFERENCES customer (cus_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_customer_has_product_product1
    FOREIGN KEY (product_pro_id)
    REFERENCES product (pro_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Guardado de provedores.
-- -----------------------------------------------------
insert into supplier(sup_name)values ('Diana');
insert into supplier(sup_name)values ('P&G');
insert into supplier(sup_name)values ('FritoLay');
-- -----------------------------------------------------
-- Guardado de clientes.
-- -----------------------------------------------------
insert into customer(cus_name, cus_document_type, cus_document)values
('Daniel','CC','1103119753');
insert into customer(cus_name, cus_document_type, cus_document)values
('José','TI','1103119753');
-- -----------------------------------------------------
-- Guardado de productos.
-- -----------------------------------------------------
insert into product(supplier_sup_id, pro_name) values (1,'Arroz');
insert into product(supplier_sup_id, pro_name) values (1,'Aceite');
insert into product(supplier_sup_id, pro_name) values (1,'Mantequilla');
insert into product(supplier_sup_id, pro_name) values (2,'Shampoo');
insert into product(supplier_sup_id, pro_name) values (2,'Desinfectante');
insert into product(supplier_sup_id, pro_name) values (2,'Colgate');
insert into product(supplier_sup_id, pro_name) values (3,'Cheetos');
insert into product(supplier_sup_id, pro_name) values (3,'Doritos');
insert into product(supplier_sup_id, pro_name) values (3,'Maní');
-- -----------------------------------------------------
-- Guardado de compras de Daniel.
-- -----------------------------------------------------
insert into customer_product_bought(customer_cus_id, product_pro_id) VALUES (1,1);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (1,3);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (1,9);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (1,5);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (1,8);
-- -----------------------------------------------------
-- Guardado de compras de José.
-- -----------------------------------------------------
insert into customer_product_bought(customer_cus_id, product_pro_id) VALUES (2,2);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (2,3);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (2,4);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (2,6);
insert into customer_product_bought(customer_cus_id,product_pro_id) VALUES (2,7);
-- -----------------------------------------------------
-- Mostrar ventas.
-- -----------------------------------------------------
select cus_id,cus_name,cus_document_type,cus_document,product.pro_name, supplier.sup_name,
customer_product_bought.deleted
from customer
inner join customer_product_bought on customer.cus_id=customer_product_bought.customer_cus_id
inner join product on product.pro_id=customer_product_bought.product_pro_id
inner join supplier on supplier.sup_id=product.supplier_sup_id;
-- -----------------------------------------------------
-- Borrado lógico.
-- -----------------------------------------------------
update customer_product_bought set deleted=1 where product_pro_id=1 and customer_cus_id=1;
update customer_product_bought set deleted=1 where product_pro_id=2 and customer_cus_id=2;
-- -----------------------------------------------------
-- Borrado físico.
-- -----------------------------------------------------
delete from customer_product_bought where product_pro_id=3 and customer_cus_id=1;
delete from customer_product_bought where product_pro_id=4 and customer_cus_id=2;
-- -----------------------------------------------------
-- Modificar nombre de producto y proveedor.
-- -----------------------------------------------------
update product set pro_name='Jabón', supplier_sup_id=2 where pro_name='Arroz';
update product set pro_name='Espaguete', supplier_sup_id=1 where pro_name='Desinfectante';
update product set pro_name='Crema de peinar', supplier_sup_id=2 where pro_name='Doritos';