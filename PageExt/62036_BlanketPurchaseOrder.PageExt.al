pageextension 62036 BlanketPurchOrderExt extends "Blanket Purchase Order"
{
    layout
    {
        addbefore("Ship-to")
        {
            field(ShipmentMethodCode; "Shipment Method Code")
            {
                Caption = 'Shipment Method Code';
                ApplicationArea = Basic, Suite;
                //Visible = lPurchGroup;
                ToolTip = 'Specifies the delivery conditions of the related shipment, such as free on board (FOB).';

            }
            field("Shipping Agent"; "Shipping Agent")
            {
                ApplicationArea = all;
                //Visible = lPurchGroup;
                ToolTip = 'Specifies the Agent picked for shipment.';
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