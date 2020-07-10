table 50021 "Field Service Parts Shipment"
{

    fields
    {
        field(5; "Bill of Lading"; Integer)
        {
        }
        field(10; "Work Order No."; Code[7])
        {
        }
        field(15; "Part Type"; Option)
        {
            OptionMembers = ,Item,Resource;
        }
        field(20; "Part No."; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Part Type" = CONST(Resource)) Resource."No." WHERE(Type = CONST(Machine)) ELSE
            IF ("Part Type" = CONST(Item)) Item."No." WHERE(Blocked = CONST(false));
        }
        field(30; Description; Text[30])
        {
        }
        field(40; "Serial No."; Code[20])
        {
        }
        field(50; "Qty. Shipped"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'Field Service Only';
        }
    }

    keys
    {
        key(Key1; "Bill of Lading", "Work Order No.", "Part No.")
        {
        }
    }

    fieldgroups
    {
    }
}

