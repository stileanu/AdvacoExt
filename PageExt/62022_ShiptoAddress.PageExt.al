pageextension 62022 ShiptoAddressExt extends "Ship-to Address"
{
    layout
    {
        // Add changes to page layout here
        addafter("Last Date Modified")
        {
            field("Inside Sales"; "Inside Sales")
            {
                ApplicationArea = all;
            }
            field(Rep; Rep)
            {
                ApplicationArea = all;
            }
            field("Shipment Approved"; "Shipment Approved")
            {
                ApplicationArea = all;
            }
            field("Freight include in Price"; "Freight include in Price")
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