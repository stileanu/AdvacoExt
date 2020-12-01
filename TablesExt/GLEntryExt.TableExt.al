TableExtension 50101 GLEntryExt Extends "G/L Entry"

{
    fields
    {
        field(50000; Rep; Code[3])
        {
            TableRelation = "Outside Sales Reps"."Rep Code";
            Caption = 'Sales Rep';
        }
        field(50001; "Include For Commissions"; Boolean)
        {
            Caption = 'Include for Commissions';
        }
        field(50002; "Commission Dept. Code"; Code[20])
        {
            Caption = 'Commission Dept. Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50003; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50004; Open; Boolean)
        {
            Caption = 'Open';
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry".Open where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Customer No." = field("Source No.")));
        }
    }
}