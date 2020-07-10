table 50002 Status
{
    // To find commented code, use pattern <//--!>
    fields
    {
        field(10; "Order No."; Code[7])
        {
            //--!TR
            /*
            TableRelation = IF (Type = CONST(FieldService)) FieldService."Field Service No."
            ELSE
            IF (Type = CONST(WorkOrder)) WorkOrderDetail."Work Order No.";
            */
        }
        field(12; Type; Enum DocType)
        {
            //OptionMembers = "Work Order","Field Service";
        }
        field(15; "Line No."; Integer)
        {
        }
        field(20; Step; Enum DetailStep)
        {
            //OptionMembers = REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        }
        field(30; "Date In"; Date)
        {
        }
        field(40; "Date Out"; Date)
        {

            trigger OnValidate();
            begin
                IF "Date Out" < "Date In" THEN BEGIN
                    ERROR('Date Out can''t be before Date In');
                END;
            end;
        }
        field(50; "Regular Hours"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "Regular Hours" >= 25 THEN BEGIN
                    MESSAGE('Regular Hours can''t be 25 Hours or greater');
                    "Regular Hours" := 0;
                END;
            end;
        }
        field(60; "Overtime Hours"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "Regular Hours" >= 25 THEN BEGIN
                    MESSAGE('Overtime Hours can''t be 25 Hours or greater');
                    "Regular Hours" := 0;
                END;
            end;
        }
        field(70; Employee; Code[30])
        {
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(80; Status; Option)
        {
            OptionMembers = Waiting,Complete;

            trigger OnValidate();
            begin
                IF WOD.GET("Order No.") THEN BEGIN
                    IF Status = Status::Complete THEN BEGIN
                        IF (WOD."Serial No." = '') THEN
                            ERROR('You must enter a Serial Number before changing the Status to Complete');

                        IF Employee = '' THEN
                            ERROR('You must enter an Employee before changing the Status to Complete');

                        IF (WOD."Model No." = '') OR (WOD."Model Verified" = FALSE) THEN
                            ERROR('A Model must be entered and Verified to change Status to Complete');

                        IF "Date Out" = 0D THEN
                            ERROR('You must enter a Finish Date before changng the Status to Complete');

                        IF ("Regular Hours" = 0) AND ("Overtime Hours" = 0) THEN
                            ERROR('You must enter Time Worked before changing Status to Complete');

                        IF Step = Step::RCV THEN BEGIN
                            IF (WOD."Safety Form" = FALSE) THEN
                                ERROR('Safety Form must be Checked before changing status to Complete');
                        END;
                    END;
                END;
            end;
        }
        field(90; Passed; Boolean)
        {
        }
        field(100; User; Code[10])
        {
        }
        field(200; "File Exists"; Boolean)
        {
        }
        field(201; "Skip Step"; Boolean)
        {
        }
        field(202; "Serial No"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Order No.", "Line No.")
        {
            SumIndexFields = "Regular Hours", "Overtime Hours";
        }
        key(Key2; "Order No.", Step)
        {
        }
        key(Key3; Step)
        {
        }
        key(Key4; "Order No.", Type, "Line No.")
        {
        }
        key(Key5; Employee)
        {
        }
    }

    fieldgroups
    {
    }

    var
        WOD: Record WorkOrderDetail;
}

