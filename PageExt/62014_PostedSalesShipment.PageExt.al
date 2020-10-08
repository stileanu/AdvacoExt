pageextension 62014 PostedSalesShipmentExt extends "Posted Sales Shipment"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
        {
            field(Rep; Rec.Rep)
            {
                ApplicationArea = all;
            }
            field("Bill of Lading"; Rec."Bill of Lading")
            {
                ApplicationArea = all;
            }
        }
        addafter("External Document No.")
        {
            field("Payment Terms Code"; Rec."Payment Terms Code")
            {
                ApplicationArea = all;
            }
            field("Card Type"; Rec."Card Type")
            {
                ApplicationArea = all;
            }
            field("Credit Card No."; Rec."Credit Card No.")
            {
                ApplicationArea = all;
            }
            field("Credit Card Exp."; Rec."Credit Card Exp.")
            {
                ApplicationArea = all;
            }
            field("Approval Code"; Rec."Approval Code")
            {
                ApplicationArea = all;
            }
            field("Due Date"; Rec."Due Date")
            {
                ApplicationArea = all;
            }
        }
        addafter("Package Tracking No.")
        {
            field("Exempt Organization"; Rec."Exempt Organization")
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