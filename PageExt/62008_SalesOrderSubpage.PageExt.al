pageextension 62008 SalesOrderSubpageExt extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit Price")
        {
            field("Commission Calculated"; "Commission Calculated")
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