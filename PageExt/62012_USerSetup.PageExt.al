pageextension 62012 UserSEtupExt extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Time Sheet Admin.")
        {
            field("Allow WI Blocking"; "Allow WI Blocking")
            {
                ApplicationArea = all;
            }
            field("Allow WI Deletion"; "Allow WI Deletion")
            {
                ApplicationArea = all;
            }
            field("PDF Path to Documents"; "PDF Path to Documents")
            {
                ApplicationArea = all;
            }
            field(Signature1; Signature1)
            {
                ApplicationArea = all;
            }
            field(Signature2; Signature2)
            {
                ApplicationArea = all;
            }
            field(Signature3; Signature3)
            {
                ApplicationArea = all;
            }
            field(Signature4; Signature4)
            {
                ApplicationArea = all;
            }
            field(Signature5; Signature5)
            {
                ApplicationArea = all;
            }
            field(Signature6; Signature6)
            {
                ApplicationArea = all;
            }
            field(Signature7; Signature7)
            {
                ApplicationArea = all;
            }
            field(Signature8; Signature8)
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