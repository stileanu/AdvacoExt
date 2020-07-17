pageextension 50018 CustomerCardExt extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shipment Method")
        {
            field(Rep; Rep)
            {
                ApplicationArea = All;
                Caption = 'Representant';
            }
        }
        addafter(Statistics)
        {
            group(Advaco)
            {
                Caption = 'Advanced Vacuum';
                field("Shipping Account"; "Shipping Account")
                {
                    //Importance = Standard;
                    ApplicationArea = All;
                    Caption = 'Shipping Acct.';
                }
                field("Exempt Organization"; "Exempt Organization")
                {
                    ApplicationArea = All;
                }
                field("Customer Since"; "Customer Since")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    Caption = 'Last modified by';
                }
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