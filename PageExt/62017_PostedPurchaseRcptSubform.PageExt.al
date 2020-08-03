pageextension 62017 PostedPurchaseRcptSubformExt extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Expected Receipt Date")
        {
            field("Orig. Expected Receipt Date"; "Orig. Expected Receipt Date")
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