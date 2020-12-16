pageextension 62035 PurchOrderSubpage extends "Purchase Order Subform"
{

    layout
    {
        addafter("Line Amount")
        {

            field("Order No."; "Order No.")
            {
                Caption = 'SO / WO#';
                ApplicationArea = all;

            }     // Add changes to page layout here
        }
    }


    actions
    {



    }

    var
        myInt: Integer;
}