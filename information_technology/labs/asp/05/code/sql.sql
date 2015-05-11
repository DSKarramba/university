ALTER PROCEDURE dbo.DeleteTypes
	@p_i_id_type int
AS
	DELETE FROM tbTypes WHERE (i_id_type = @p_i_id_type)

ALTER PROCEDURE dbo.InsertTypes
  @p_vc_name varchar(50)
AS
  INSERT INTO tbTypes(vc_name) VALUES (@p_vc_name)

ALTER PROCEDURE dbo.UpdateTypes
  @p_i_id_type int,
  @p_vc_name varchar(50)
AS
  UPDATE tbTypes SET vc_name = @p_vc_name WHERE (i_id_type = @p_i_id_type)

ALTER PROCEDURE dbo.OrderFullSum
  @i_id_order int
AS
	SELECT SUM(tbOrderDetail.m_sum)
	FROM tbOrderDetail WHERE tbOrderDetail.i_id_order = @i_id_order

ALTER PROCEDURE dbo.SellerOrdersSum
	@i_id_seller int
AS
	SELECT SUM(tbOrderDetail.m_sum)
	FROM tbOrderDetail, tbOrder
	WHERE tbOrder.i_id_seller = @i_id_seller
	  AND tbOrder.i_id_order = tbOrderDetail.i_id_order

ALTER PROCEDURE dbo.SelectGoods
  @p_i_id_group int
AS
  SELECT tbGoods.vc_name, tbGoods.m_price
  FROM tbGoods
  WHERE (tbGoods.i_id_group = @p_i_id_group)
