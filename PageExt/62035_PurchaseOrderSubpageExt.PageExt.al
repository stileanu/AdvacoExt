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
        }
    }

}