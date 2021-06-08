pageextension 62041 BlanketPurchOrderSubformExt extends "Blanket Purchase Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Vendor P/#';
            }
        }
    }
}