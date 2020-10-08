pageextension 62018 PostedPurchInvoiceSubformExt extends "Posted Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Work Order No."; Rec."Work Order No.")
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