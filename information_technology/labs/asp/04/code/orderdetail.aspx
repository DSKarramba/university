<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="orderdetail.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Страница OrderDetail</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
</head>
  <body>
    <form id="frm1" class="main" runat="server">
      <div id="nav">
        Перейти на страницы: <br />
        <asp:Button ID="btP1" runat="server" class="button_sel"
            Text="or_det" OnCommand="bt_Click" CommandArgument="orderdetail" />
        <asp:Button ID="btP2" runat="server" class="button"
            Text="order" OnCommand="bt_Click" CommandArgument="order" />
        <asp:Button ID="btP3" runat="server" class="button"
            Text="sellers" OnCommand="bt_Click" CommandArgument="sellers" />
        <asp:Button ID="btP4" runat="server" class="button"
            Text="clients" OnCommand="bt_Click" CommandArgument="clients" />
        <asp:Button ID="btP5" runat="server" class="button"
            Text="types" OnCommand="bt_Click" CommandArgument="types" />
        <asp:Button ID="btP6" runat="server" class="button"
            Text="goods" OnCommand="bt_Click" CommandArgument="goods" />
        <asp:Button ID="btP7" runat="server" class="button"
            Text="groups" OnCommand="bt_Click" CommandArgument="groups" />
      </div>
      <div style="text-align: center">
        <asp:GridView ID="gvOD" runat="server" style="width: 100%" 
          AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" 
          BorderStyle="Double" BorderWidth="3px" CellPadding="4" DataSourceID="dsOD" 
          GridLines="Horizontal" onrowdeleting="gvOD_RowDeleting" 
          onrowupdating="gvOD_RowUpdating">
          <RowStyle BackColor="White" ForeColor="#333333" />
          <Columns>
            <asp:BoundField DataField="i_id_orderdetail" HeaderText="ИД" 
              InsertVisible="False" ReadOnly="True" SortExpression="i_id_orderdetail" />
            <asp:TemplateField HeaderText="? заказа" SortExpression="i_id_order">
              <EditItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="dsO" 
                  DataTextField="i_id_order" DataValueField="i_id_order" 
                  SelectedValue='<%# Bind("i_id_order") %>'>
                </asp:DropDownList>
              </EditItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Bind("i_id_order") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Товар" SortExpression="vc_name">
              <EditItemTemplate>
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="dsG" 
                  DataTextField="vc_name" DataValueField="i_id_good" 
                  SelectedValue='<%# Bind("i_id_good") %>'>
                </asp:DropDownList>
              </EditItemTemplate>
              <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Bind("vc_name") %>'></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="f_count" HeaderText="Кол-во" 
              SortExpression="f_count" />
            <asp:BoundField DataField="m_price" HeaderText="Цена" 
              SortExpression="m_price" />
            <asp:BoundField DataField="m_sum" HeaderText="Сумма" SortExpression="m_sum" ReadOnly="true" />
            <asp:CommandField HeaderText="Правка" ShowEditButton="True" />
            <asp:CommandField HeaderText="Удаление" ShowDeleteButton="True" />
          </Columns>
          <FooterStyle BackColor="White" ForeColor="#333333" />
          <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
          <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
          <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="dsOD" runat="server" DataSourceMode="DataSet"
          ConnectionString="<%$ ConnectionStrings:labsConnectionString %>" 
          SelectCommand="SELECT tbOrderDetail.*, tbGoods.vc_name
                         FROM tbOrderDetail, tbGoods
                         WHERE tbOrderDetail.i_id_good = tbGoods.i_id_good"           
          UpdateCommand="UPDATE tbOrderDetail SET f_count = @p_f_count, i_id_good = @p_i_id_good,
                         i_id_order = @p_i_id_order, m_price = @p_m_price
                         WHERE i_id_orderdetail = @p_i_id_orderdetail"
          InsertCommand="INSERT INTO tbOrderDetail(i_id_order, i_id_good, f_count, m_price)
                         VALUES(@p_i_id_order, @p_i_id_good, @p_f_count, @p_m_price)"
          DeleteCommand="DELETE FROM tbOrderDetail WHERE (i_id_orderdetail = @p_i_id_orderdetail)" > 
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsG" runat="server" DataSourceMode="DataReader"
          ConnectionString="<%$ ConnectionStrings:labsConnectionString %>" 
          SelectCommand="SELECT tbGoods.* FROM tbGoods"> 
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="dsO" runat="server" DataSourceMode="DataReader"
          ConnectionString="<%$ ConnectionStrings:labsConnectionString %>" 
          SelectCommand="SELECT tbOrder.i_id_order FROM tbOrder"> 
        </asp:SqlDataSource>
        <br />
        <span style="margin: 1em">Заказ:</span><asp:DropDownList ID="ddlO" 
          runat="server" DataSourceID="dsO" DataTextField="i_id_order" 
          DataValueField="i_id_order"></asp:DropDownList>
        <span style="margin: 1em">Товар:</span><asp:DropDownList ID="ddlG" 
          runat="server" DataSourceID="dsG" DataTextField="vc_name" 
          DataValueField="i_id_good"></asp:DropDownList>
        <br />
        <span style="margin-right: 1em">Цена:</span><asp:TextBox ID="tbP" runat="server"></asp:TextBox>
        <span style="margin-right: 1em">Кол-во:</span><asp:TextBox ID="tbC" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="bAdd" runat="server" OnClick="bAdd_Click" Text="Добавить" style="margin-top: .5em"/>
      </div>
    </form>
  </body>
</html>
