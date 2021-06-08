pageextension 62038 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field(State; Rec.County)
            {
                ApplicationArea = All;
            }
            field("ZIP Code"; Rec."Post Code")
            {
                ApplicationArea = All;
            }
            field("Cust. Since"; Rec."Customer Since")
            {
                ApplicationArea = All;
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