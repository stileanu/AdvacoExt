tableextension 50127 Purch_Rcpt_LineExt extends "Purch. Rcpt. Line"
{
    // 04/26/16 ADV
    // Added field <Orig. Expected Receipt Date> for Vendor Responsiveness report

    fields
    {
        field(50002; Inspector; Code[20])
        {
            Caption = 'Inspector';
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(50003; "Inspection Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Inspection Date';
        }
        field(50007; "Orig. Expected Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Orig. Expected Receipt Date';
            Description = '4/26/16 ADV';
        }
    }

    var
        myInt: Integer;
}