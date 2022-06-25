use store;
-- -----------------------------------------------------
-- Productos vendidos digitando el tipo de documento y número del mismo.
-- -----------------------------------------------------
select product.pro_name
       from customer
inner join
    customer_product_bought on
    customer.cus_id=customer_product_bought.customer_cus_id
inner join product on product.pro_id=customer_product_bought.product_pro_id
       where cus_document_type='TI' and cus_document = '1103119753';
-- -----------------------------------------------------
-- Productos vendido y su proveedor digitando el id de la compra.
-- -----------------------------------------------------
select sup_name
       from supplier
 inner join product on supplier.sup_id=product.supplier_sup_id
       inner join customer_product_bought on product.pro_id = customer_product_bought.product_pro_id
       where customer_product_bought.product_pro_id=5;