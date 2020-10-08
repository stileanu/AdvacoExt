pageextension 62015 PostedSalesInvoiceExt extends "Posted Sales Invoice"
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

        }
        addafter("Package Tracking No.")
        {
            field("Exempt Organization"; Rec."Exempt Organization")
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