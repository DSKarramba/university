ALTER PROCEDURE dbo.AveragePrice
	@avg float = 0 output
AS
	SELECT @avg=AVG(tbGoods.m_price) FROM tbGoods
	RETURN @avg
