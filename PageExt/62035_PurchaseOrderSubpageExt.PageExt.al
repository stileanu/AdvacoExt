pageextension 62035 PurchOrderSubpage extends "Purchase Order Subform"
{

    layout
    {
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