pageextension 62038 CustomerListExt extends "Customer List"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field(Address; Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; "Address 2")
            {
                ApplicationArea = All;
            }
            field(City; City)
            {
                ApplicationArea = All;
            }
            field(State; County)
            {
                ApplicationArea = All;
            }
            field("ZIP Code"; "Post Code")
            {
                ApplicationArea = All;
            }
            field("Cust. Since"; "Customer Since")
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