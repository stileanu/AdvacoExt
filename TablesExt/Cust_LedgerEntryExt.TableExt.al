TableExtension 50102 Cust_LedgerEntryExt Extends "Cust. Ledger Entry"

{
    fields
    {
        field(50000; REP; Code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";
        }
        field(50001; "Ship-To Code"; Code[10])
        {
            Caption = 'Ship-To Code';
            TableRelation = "Ship-to Address" where ("Customer No." = field("Customer No."));
        }
        //field(50002; "Customer Name"; text[50])
        //Customer Name is now part of base application no longer needed
        field(50003; "Work Order No."; Code[20])
        {
            Caption = 'Work Order No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Order No." where("No." = field("Customer No.")));
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(50004; "Sales Order No."; code[20])
        {
            Caption = 'Sales Order No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Pre-Assigned No." where("No." = field("Document No.")));
        }
        field(50005; "Bill of Lading No."; Integer)
        {
            Caption = 'Bill of Lading No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."Bill of Lading" where("No." = field("Document No.")));
        }
    }
}