table 50017 IDRHeader
{
    // version US2.60.05,LDUS2.60.05.22.,HEF
    // To find commented code, use pattern <//--!>

    fields
    {
        field(10; "No."; Code[10])
        {
        }
        field(20; "Document Type"; Enum IDRDocType)
        {
            //OptionMembers = " ",Receiving,Production;
        }
        field(30; "Document Date"; Date)
        {
        }
        field(50; "Inspector Code"; Code[5])
        {
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(95; Notes; Code[75])
        {
        }
        field(100; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate();
            begin
                IF Vend.GET("Vendor No.") THEN
                    OK := TRUE;

                "Vendor Name" := Vend.Name;
                MODIFY;
            end;
        }
        field(101; "Purchase Order No."; Code[20])
        {
        }
        field(102; "Invoice No."; Text[30])
        {
        }
        field(105; "Vendor Name"; Text[30])
        {
        }
        field(200; "Order No."; Code[7])
        {
            TableRelation = WorkOrderDetail."Work Order No.";
        }
        field(210; "Serial No."; Text[30])
        {
        }
        field(220; "Model No."; Text[30])
        {
            TableRelation = Item."No." WHERE(Class = CONST('MODEL'));
        }
        field(230; "Process Code"; Code[10])
        {
        }
        field(300; "Rework Operator"; Code[5])
        {
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(310; "Rework Date"; Date)
        {
        }
        field(320; "ReTest Operator"; Code[5])
        {
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(330; "ReTest Date"; Date)
        {
        }
        field(400; "Return to Vendor"; Boolean)
        {
        }
        field(405; "RMA No."; Code[20])
        {
        }
        field(410; Scrap; Boolean)
        {
        }
        field(415; "Scrap Cost"; Decimal)
        {
        }
        field(420; Restock; Boolean)
        {
        }
        field(430; "Rework/Repair"; Boolean)
        {
        }
        field(500; "Kit Part No."; Code[30])
        {
        }
        field(510; "Kit Vendor No."; Code[30])
        {
            TableRelation = Vendor."No.";
        }
        field(900; "Completion Date"; Date)
        {
        }
        field(910; "QA Approval"; Code[20])
        {
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(980; "No. Series"; Code[10])
        {
        }
        field(990; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(995; "IDR Closed"; Boolean)
        {
        }
        field(1000; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist ("ADVACO Comment Line" WHERE("Table Name" = CONST(IDRHeader), "No." = FIELD("No.")));

        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        IF "No." = '' THEN BEGIN
            InvtSetup.GET;
            InvtSetup.TESTFIELD("IDR Nos.");
            NoSeriesMgt.InitSeries(InvtSetup."IDR Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Document Date" := TODAY;
        END;
    end;

    var
        Vend: Record Vendor;
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InvtSetup: Record "Inventory Setup";
        OK: Boolean;
}

