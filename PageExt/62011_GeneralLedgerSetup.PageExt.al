pageextension 62011 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        Addafter(Application)
        {
            group("Credit Card")
            {
                field("Credit Card Payment Code"; Rec."Credit Card Payment Code")
                {
                    ApplicationArea = all;

                }
                field("Credit Card Fee Account"; Rec."Credit Card Fee Account")
                {
                    ApplicationArea = all;
                }
                field("Credit Card Fee %"; Rec."Credit Card Fee %")
                {
                    ApplicationArea = all;
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