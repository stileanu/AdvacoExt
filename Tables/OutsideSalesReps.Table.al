table 50011 "Outside Sales Reps"
{
    // version US2.60,CS


    fields
    {
        field(10; "Rep Code"; Code[3])
        {
        }
        field(20; "Rep Name"; Text[50])
        {
        }
        field(30; "Rep Company"; Text[30])
        {
        }
        field(40; "Rep Address 1"; Text[50])
        {
        }
        field(50; "Rep City"; Text[50])
        {
        }
        field(60; "Rep State"; Code[10])
        {
        }
        field(70; "Rep Zip"; Code[10])
        {
        }
        field(80; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(90; "Commission %"; Decimal)
        {
        }
        field(200; "Sales Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - Sum ("G/L Entry".Amount WHERE("Include for Commissions" = CONST(True), Rep = FIELD("Rep Code"), "Posting Date" = FIELD("Date Filter")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Rep Code")
        {
        }
    }

    fieldgroups
    {
    }
}

