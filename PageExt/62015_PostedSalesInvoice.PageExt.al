pageextension 62015 PostedSalesInvoiceExt extends "Posted Sales Invoice"
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

        }
        addafter("Package Tracking No.")
        {
            field("Exempt Organization"; "Exempt Organization")
            {
                ApplicationArea = all;
            }
        }
        modify("Salesperson Code")
        {
            Caption = 'Inside Sales';
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}