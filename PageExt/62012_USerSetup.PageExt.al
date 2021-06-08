pageextension 62012 UserSEtupExt extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Time Sheet Admin.")
        {
            field("Allow WI Blocking"; Rec."Allow WI Blocking")
            {
                ApplicationArea = all;
            }
            field("Allow WI Deletion"; Rec."Allow WI Deletion")
            {
                ApplicationArea = all;
            }
            field("PDF Path to Documents"; Rec."PDF Path to Documents")
            {
                ApplicationArea = all;
            }
            field(Signature1; Rec.Signature1)
            {
                ApplicationArea = all;
            }
            field(Signature2; Rec.Signature2)
            {
                ApplicationArea = all;
            }
            field(Signature3; Rec.Signature3)
            {
                ApplicationArea = all;
            }
            field(Signature4; Rec.Signature4)
            {
                ApplicationArea = all;
            }
            field(Signature5; Rec.Signature5)
            {
                ApplicationArea = all;
            }
            field(Signature6; Rec.Signature6)
            {
                ApplicationArea = all;
            }
            field(Signature7; Rec.Signature7)
            {
                ApplicationArea = all;
            }
            field(Signature8; Rec.Signature8)
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