table 50016 "ADVACO Comment Line"
{
    // version US2.60
    Caption = 'Advaco Comment Line';
    DrillDownPageId = "ADVACO Comment List"; //ICE RSK 12/13/20
    LookupPageId = "ADVACO Comment List"; //ICE RSK 12/13/20

    fields
    {
        field(1; "Table Name"; Enum TableName)
        {
            //OptionMembers = "Work Order Master","Work Order Detail","IDR Header";
        }
        field(2; "No."; Code[20])
        {
            TableRelation = IF ("Table Name" = CONST(WorkOrderMaster)) WorkOrderMaster."Work Order Master No." ELSE
            IF ("Table Name" = CONST(WorkOrderDetail)) WorkOrderDetail."Work Order No." ELSE
            IF ("Table Name" = CONST(IDRHeader)) IDRHeader."No.";
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; "Code"; Code[10])
        {
        }
        field(6; Comment; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetUpNewLine();
    var
        CommentLine: Record "Comment Line";
    begin
        CommentLine.SETRANGE("Table Name", "Table Name");
        CommentLine.SETRANGE("No.", "No.");
        IF NOT CommentLine.FIND('-') THEN
            Date := WORKDATE;
    end;
}

