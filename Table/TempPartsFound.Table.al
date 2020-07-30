table 50025 "Temp Parts Found"
{

    fields
    {
        field(10; "Work Order No."; Code[7])
        {
        }
        field(20; "Part No."; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Part Type" = CONST(Resource)) Resource."No." ELSE
            IF ("Part Type" = CONST(Item)) Item."No.";
        }
        field(30; Description; Text[30])
        {
        }
        field(40; "Order Code"; Code[1])
        {
        }
        field(50; "PO Date"; Date)
        {
        }
        field(60; "PO Received"; Boolean)
        {
        }
        field(80; "Quantity Used"; Decimal)
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
        }
        field(160; "In-Process Quantity"; Decimal)
        {
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
        field(200; "After Quote Part"; Decimal)
        {
        }
        field(210; "Serial No."; Code[20])
        {
        }
        field(500; "Purchase Order No."; Code[20])
        {
        }
        field(2000; "Extended Price"; Decimal)
        {
        }
        field(2001; "Extended Cost"; Decimal)
        {
        }
        field(2002; "Detail Step"; Text[3])
        {
        }
        field(2003; "Record Used"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Work Order No.", "Part Type", "Part No.")
        {
            SumIndexFields = "Extended Price", "Extended Cost", "Quoted Price", "Quoted Quantity";
        }
        key(Key2; "Part No.")
        {
        }
        key(Key3; "BOM Quantity")
        {
        }
        key(Key4; "Work Order No.", "After Quote Part")
        {
            SumIndexFields = "Extended Cost";
        }
        key(Key5; "Work Order No.", "Part No.")
        {
        }
        key(Key6; "Detail Step", "Work Order No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Ok: Boolean;
        ItemAvailability: Codeunit "Check Availablility";
        CurrentRecord: Record Parts;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        ExistingParts: Record Parts;
        Item2: Record Item;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        AdjustmentAmount: Decimal;
        Resource: Record Resource;
        Window: Dialog;
        NewPart: Code[20];
        NewPartRecord: Record Parts;
        OriginalRecord: Record Parts;
        "Qty Available": Decimal;

    procedure CreateParts();
    begin
    end;

    procedure BackOrder();
    begin
    end;

    procedure FillOrder();
    begin
    end;

    procedure ReturnInventory();
    begin
    end;

    procedure BackOrder2();
    begin
    end;

    procedure FillOrder2();
    begin
    end;

    procedure ReturnInventory2();
    begin
    end;

    procedure ReturnInventory3();
    begin
    end;

    procedure WriteItemJournalLine();
    begin
    end;

    procedure PostJournalLine();
    begin
    end;

    procedure PartsAllocation();
    begin
    end;

    procedure ReplacePart();
    begin
    end;

    procedure DeletePart();
    begin
    end;
}

