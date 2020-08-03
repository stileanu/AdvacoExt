pageextension 62014 PostedSalesShipmentExt extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
        {
            field(Rep; Rep)
            {
                ApplicationArea = all;
            }
            field("Bill of Lading"; "Bill of Lading")
            {
                ApplicationArea = all;
            }
        }
        addafter("External Document No.")
        {
            field("Payment Terms Code"; "Payment Terms Code")
            {
                ApplicationArea = all;
            }
            field("Card Type"; "Card Type")
            {
                ApplicationArea = all;
            }
            field("Credit Card No."; "Credit Card No.")
            {
                ApplicationArea = all;
            }
            field("Credit Card Exp."; "Credit Card Exp.")
            {
                ApplicationArea = all;
            }
            field("Approval Code"; "Approval Code")
            {
                ApplicationArea = all;
            }
            field("Due Date"; "Due Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("Package Tracking No.")
        {
            field("Exempt Organization"; "Exempt Organization")
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