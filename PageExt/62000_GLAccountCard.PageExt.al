pageextension 62000 GLAccountCardExt extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Reconciliation Account")
        {
            field("Include for Commissions"; Rec."Include for Commissions")
            {
                ApplicationArea = all;
            }
        }

    }

}