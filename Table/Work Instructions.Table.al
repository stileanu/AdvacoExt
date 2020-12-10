table 50004 WorkInstructions
{
    // version ADV

    // 10/28/10 ADV
    //   Added new field "Customer Part No." and included in the Primary Key.
    //   Added new field "Part Quality Ctrl Instructions".
    // 09/18/12 ADV
    //   Added new field to allow insert of a Customer Part No without validating it in the WOD table.
    // 04/01/13 ADV
    //   Added new Blocked field to implement block/active property.
    //   Added code to activate/block Work Instructions, do not allow deletion, except for a special user.
    //   Block/deletion can be done by a role each.
    // 05/14/14 ADV
    //   Added code to validate Intstruction field
    // 01/04/18
    //   Eliminate Part No test for OnRename trigger
    // 02/19/18
    //   Added filter for WI on Blocked field to do not show Blocked WI

    // To find commented code, use pattern <//--!>
    DrillDownPageId = "Work Order Instruction List";
    LookupPageId = "Work Order Instruction List";

    fields
    {
        field(5; "Customer Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = Customer."No.";
        }
        field(10; "Ship To Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer Code"));
        }
        field(40; Step; Enum DetailStep)
        {
            NotBlank = false;
            //OptionMembers = REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSH,PNT,QC,SHP;
            //ValuesAllowed = REC;DIS;QOT;CLN;ASM;TST;PNT;QC;SHP;
            // Careful with Data Imports!!!
        }
        field(45; Model; Code[20])
        {
            TableRelation = Item."No." WHERE(Class = CONST('MODEL'));
        }
        field(46; "Customer Part No."; Code[20])
        {
        }
        field(50; Instruction; Text[250])
        {
        }
        field(55; "Part Quality Ctrl Instructions"; Text[250])
        {
        }
        field(60; "Date Last Modified"; Date)
        {
        }
        field(65; "Last User Modified"; Code[50])
        {
        }
        field(70; "Date Created"; Date)
        {
        }
        field(80; NoConditionModify; Boolean)
        {
        }
        field(90; Blocked; Boolean)
        {

            trigger OnValidate();
            var
                UserSetup: Record "User Setup";
                ADV001: Label 'You are not authorized to block/unblock Work Instructions.';
            begin
                // 04/01/13 Start
                UserSetup.GET(USERID);
                IF NOT UserSetup."Allow WI Blocking" THEN
                    ERROR(ADV001);
                // 04/01/13 End
            end;
        }
    }

    keys
    {
        key(Key1; "Customer Code", "Ship To Code", Step, Model, "Customer Part No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        UserSetup: Record "User Setup";
        ADV001: Label '"Are you sure you want to delete the record? "';
        ADV002: Label 'You are not authorized to delete Work Instructions.';
    begin
        // 04/01/13 Start
        UserSetup.GET(USERID);
        IF NOT UserSetup."Allow WI Deletion" THEN
            ERROR(ADV002);

        IF CONFIRM(ADV001, FALSE) THEN
            DELETE;
        // 04/01/13 End
    end;

    trigger OnInsert();
    begin
        // 10/28/10 Start
        // Validate Customer Part No. against the WOD table
        //01/04/18 start
        /*
        IF "Customer Part No." <> '' THEN
          IF NOT ValidatePartNo THEN
            ERROR(NO_SUCH_PART);
        */
        //01/04/18 end
        // 10/28/10 End
        // 05/14/14 Start
        // Do not allow empty instruction text
        IF Instruction = '' THEN
            ERROR(NO_EMPTY_TEXT);
        // 05/14/14 End
        "Date Last Modified" := WORKDATE;
        "Date Created" := WORKDATE;
        "Last User Modified" := USERID;

    end;

    trigger OnModify();
    begin
        // 10/28/10 Start
        // Validate Customer Part No. against the WOD table
        //01/04/18 start
        /*
        IF "Customer Part No." <> '' THEN
          IF NOT ValidatePartNo THEN
            ERROR(NO_SUCH_PART);
        */
        //01/04/18 end
        // 10/28/10 End
        // 05/14/14 Start
        // Do not allow empty instruction text
        IF Instruction = '' THEN
            ERROR(NO_EMPTY_TEXT);
        // 05/14/14 End

        "Date Last Modified" := WORKDATE;
        "Last User Modified" := USERID;

    end;

    trigger OnRename();
    begin
        // 10/28/10 Start
        // Validate Customer Part No. against the WOD table
        //01/04/18 start
        /*
        IF "Customer Part No." <> '' THEN
          IF NOT ValidatePartNo THEN
            ERROR(NO_SUCH_PART);
        */
        //01/04/18 end
        "Date Last Modified" := WORKDATE;
        "Last User Modified" := USERID;
        // 10/28/10 End

    end;

    var
        NO_SUCH_PART: Label 'Cannot find Customer Part No.';
        NO_EMPTY_TEXT: Label 'Instruction Text cannot be empty.';

    procedure ValidatePartNo(): Boolean;
    var
        WOD: Record WorkOrderDetail;
    begin
        WOD.RESET;
        WOD.SETCURRENTKEY("Customer ID", Boxed);
        WOD.SETRANGE("Customer ID", "Customer Code");
        WOD.SETCURRENTKEY("Customer Part No.");
        WOD.SETRANGE("Customer Part No.", "Customer Part No.");
        // 09/18/12 Start
        // IF WOD.FIND('-') THEN BEGIN
        IF NoConditionModify OR (WOD.FIND('-')) THEN BEGIN
            NoConditionModify := FALSE;
            // 09/18/12 End
            EXIT(TRUE)
        END ELSE
            EXIT(FALSE);
    end;
}

