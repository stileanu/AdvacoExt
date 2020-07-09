table 50005 QuoteMechanicsParts
{

    fields
    {
        field(10; "Work Order No."; Code[10])
        {
            NotBlank = true;
        }
        field(20; Sequence; Integer)
        {
        }
        field(30; "Part No."; Code[30])
        {
            NotBlank = true;
        }
        field(40; "Part Description"; Text[80])
        {
        }
        field(50; "Part Quantity"; Decimal)
        {
        }
        field(60; Entered; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Work Order No.", Sequence, "Part No.")
        {
        }
        key(Key2; "Work Order No.", "Part No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        Mechanics.SETRANGE(Mechanics."Work Order No.", "Work Order No.");
        IF Mechanics.FIND('+') THEN BEGIN
            Value := Mechanics.Sequence + 10;
        END;
        Sequence := Value;
    end;

    var
        Mechanics: Record QuoteMechanicsParts;
        Value: Integer;
}

