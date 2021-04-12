pageextension 62035 PurchOrderSubpage extends "Purchase Order Subform"
{

    layout
    {
        addafter("No.")
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Vendor P/#';
            }
        }
        addafter("Line Amount")
        {

            field("Work Order No."; "Work Order No.")
            {
                Caption = 'SO / WO#';
                ApplicationArea = all;
            }
            //ICE RSK 1/30/21 added
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }

        }

    }

}