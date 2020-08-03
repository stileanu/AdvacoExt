pageextension 62007 SalesOrderExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Salesperson Code")
        {
            field(Rep; Rep)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}