
/* limpando a base de dados */

select * from venda
delete From venda

select * from ITEM_VENDA
delete From item_venda

select * from CONTAS_RECEBER
delete  from CONTAS_RECEBER

select * from COMPRA
delete from compra

select * from ITEM_COMPRA
delete from item_compra

select * from CONTAS_PAGAR

delete from CONTAS_PAGAR

select * from fornecedor
delete from FORNECEDOR

select * from CLIENTE
delete from cliente

select * from empresa
delete from empresa

select * from PRODUTO
delete from produto

/* ATUALIZANDO A TABELA DE USUARIO */
select * from USUARIO

delete from USUARIO
where id_usuario > 2

update USUARIO set nome='ADM',SENHA='ADM'
WHERE ID_USUARIO=1

update USUARIO set nome='APOIO',SENHA='APOIO'
WHERE ID_USUARIO=2