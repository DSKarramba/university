<div style="text-align: center; margin-top: 2em">
  <asp:SqlDataSource ID="dsSum" runat="server"
    SelectCommand="SellerOrdersSum" SelectCommandType="StoredProcedure"
    DataSourceMode="DataReader" 
    ConnectionString="<%$ ConnectionStrings:labsConnectionString %>" >
    <SelectParameters>
      <asp:Parameter Name="i_id_seller" DefaultValue="1" Type="Int32" />
    </SelectParameters>
  </asp:SqlDataSource>

  <asp:GridView ID="gvSum" runat="server" AutoGenerateColumns="False" 
    DataSourceID="dsSum" CellPadding="4" 
    ForeColor="#333333" GridLines="None">
    <RowStyle BackColor="#EFF3FB" />
    <Columns>
      <asp:BoundField DataField="Column1" HeaderText="" 
        SortExpression="Column1" ReadOnly="True" ShowHeader="False" />
    </Columns>
    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
    <EditRowStyle BackColor="#2461BF" />
    <AlternatingRowStyle BackColor="White" />
  </asp:GridView>

  <asp:DropDownList ID="ddlCh" runat="server" DataSourceID="dsS" 
    DataTextField="vc_name" DataValueField="i_id_seller">
  </asp:DropDownList>
  <asp:Button ID="bCh" OnClick="bCh_Click" Text="Выбрать" runat="server" style="margin-left: 1em"/>
</div>
