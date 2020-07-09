table 50006 OriginalQuotedParts
{

    fields
    {
        field(10; "Work Order No."; Code[7])
        {
        }
        field(20; "Part No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Item."No.";
        }
        field(30; Description; Text[30])
        {
        }
        field(90; "Quantity Backorder"; Decimal)
        {
        }
        field(100; "Quoted Price"; Decimal)
        {
        }
        field(110; "Part Type"; Option)
        {
            OptionMembers = ,Item,Resource;
        }
        field(120; "Part Cost"; Decimal)
        {
        }
        field(130; "BOM Quantity"; Decimal)
        {
        }
        field(140; "Quoted Quantity"; Decimal)
        {
        }
        field(150; "Committed Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE("Document No." = FIELD("Work Order No."), "Item No." = FIELD("Part No."), "Location Code" = CONST('COMMITTED')));

        }
        field(160; "In-Process Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE("Document No." = FIELD("Work Order No."), "Item No." = FIELD("Part No."), "Location Code" = CONST('IN PROCESS')));
        }
        field(170; "Pulled Quantity"; Decimal)
        {
        }
        field(180; Stage; Option)
        {
            OptionMembers = Default,Quote,Accepted,"In Process",Complete;
        }
        field(190; Special; Boolean)
        {
        }
        field(200; "After Quote Quantity"; Decimal)
        {
        }
        field(205; Reason; Option)
        {
            OptionMembers = " ",LOST,"MISSED QUOTE",BROKEN,"FAILED AT TEST","OVER QUOTED","PART EXCHANGED","EXTRA PART",UNREPAIRABLE;
        }
        field(210; "Serial No."; Code[20])
        {
        }
        field(1000; "Total Price"; Decimal)
        {
        }
        field(1001; "Total Cost"; Decimal)
        {
        }
        field(2000; "Total Quote Price"; Decimal)
        {
        }
        field(2001; "Total Quote Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Work Order No.", "Part No.")
        {
            SumIndexFields = "Total Quote Price", "Total Quote Cost";
        }
        key(Key2; "Work Order No.", "Part Type")
        {
            SumIndexFields = "Total Quote Price", "Total Quote Cost", "Quoted Quantity";
        }
        key(Key3; "Part No.")
        {
        }
        key(Key4; "BOM Quantity")
        {
        }
        key(Key5; "Work Order No.", "After Quote Quantity")
        {
            SumIndexFields = "Total Quote Cost";
        }
    }

    fieldgroups
    {
    }
}

