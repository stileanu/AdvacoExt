tableextension 50129 Purch_Inv_LineExt extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "Work Order No."; Code[20])
        {
            Caption = 'Work Order No.';
        }
        field(50001; "Labels To Print"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Labels To Print';
        }
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
}