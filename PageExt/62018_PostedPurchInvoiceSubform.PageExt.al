pageextension 62018 PostedPurchInvoiceSubformExt extends "Posted Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Vendor P/#';
            }
        }
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