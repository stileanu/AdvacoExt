TableExtension 50116 SalesInvoiceLineExt extends "Sales Invoice Line"
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
        field(50004; User; code[15])
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