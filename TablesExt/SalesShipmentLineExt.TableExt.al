TableExtension 50111 SalesShipmentLineExt extends "Sales Shipment Line"
{
    /*
    //>> HEF  Who Created File Code
    */
    fields
    {
        field(50000; "Commission Calculated"; Boolean)
        {
            Caption = 'Commission Calculated';
        }
        field(50004; User; code[50])
        {
            Caption = 'User';
        }
    }
    trigger OnInsert()
    begin
        //>> HEF Add User Who Created File
        User := USERID;
        //>> End Insert  
    end;
}