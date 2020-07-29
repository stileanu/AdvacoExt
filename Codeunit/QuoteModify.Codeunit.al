codeunit 50009 "Quote Modify"
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########', WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::FieldService, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN);
        IF WODN <> '' THEN BEGIN
            WOD.SETCURRENTKEY(WOD."Work Order No.");
            IF WOD.GET(WODN) THEN BEGIN
                WOM.GET(WOD."Work Order Master No.");
                BlockCheck;
                ReverseBuildAhead;
                IF Continue = TRUE THEN BEGIN
                    IF WOD.Complete THEN BEGIN
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::" " THEN BEGIN
                            MESSAGE('The Work Order was shipped');
                            OpenNextRecord;
                        END;
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Un-Assembled" THEN BEGIN
                            MESSAGE('The Work Order was shipped Un-Assembled');
                            OpenNextRecord;
                        END;
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Assembled" THEN BEGIN
                            MESSAGE('The Work Order was shipped Assembled');
                            OpenNextRecord;
                        END;
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Save Parts & Scrap" THEN BEGIN
                            MESSAGE('The Pump was Scrapped & Parts Saved');
                            OpenNextRecord;
                        END;
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::Scrap THEN BEGIN
                            MESSAGE('The Pump was Scrapped');
                            OpenNextRecord;
                        END;
                    END ELSE BEGIN
                        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                        WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                        WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                        WOS.SETRANGE(WOS.Status, WOS.Status::Waiting);
                        IF WOS.FIND('+') THEN BEGIN
                            Found;
                            OpenNextRecord;
                        END ELSE BEGIN
                            WOSTEP.SETCURRENTKEY(WOSTEP."Order No.", WOSTEP."Line No.");
                            WOSTEP.SETRANGE(WOSTEP."Order No.", WOD."Work Order No.");
                            WOSTEP.SETRANGE(WOSTEP.Status, WOSTEP.Status::Waiting);
                            IF WOSTEP.FIND('+') THEN BEGIN
                                CurrentStep := WOSTEP.Step;
                                MESSAGE('Work Order Detail is in %1', CurrentStep);
                                OpenNextRecord;
                            END ELSE BEGIN
                                MESSAGE('Pump has not been Received');
                                OpenNextRecord;
                            END;
                        END;
                    END;
                END ELSE
                    OpenNextRecord;
            END ELSE BEGIN
                MESSAGE('Work Order Detail %1 not found', WODN);
                NextRecord.RUN;
            END;
        END ELSE BEGIN
            MESSAGE('You must enter a number.');
            NextRecord.RUN;
        END;
    end;

    var
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WODN: Code[50];
        NextRecord: Codeunit "Quote Modify";
        Ok: Boolean;
        Parts: Record Parts;
        CurrentStep: Enum DetailStep;
        //CurrentStep: Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        NewStep: Enum DetailStep;
        //NewStep: Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        Mechanics: Record QuoteMechanicsParts;
        Customer: Record Customer;
        Continue: Boolean;
        WOSTEP: Record Status;
        SerialNO: Code[10];
        NotChecked: Code[10];
        QuotedQty: Code[10];
        ShopLabor: Boolean;
        Phase: Text[10];
        Complete: Boolean;
        EmptyQuotePrice: Code[10];

    procedure Found();
    begin
        IF WOD."Quote Phase" = WOD."Quote Phase"::"Phase 3" THEN BEGIN
            IF WOD."Build Ahead" = FALSE THEN
                MESSAGE('Work Order %1 isn''t a Build Ahead, Requote the Pump to make Changes', WODN)
            ELSE
                Phase3;
        END ELSE BEGIN
            IF (WOD."Quote Phase" = WOD."Quote Phase"::" ") OR (WOD."Quote Phase" = WOD."Quote Phase"::"Phase 1") THEN
                Phase := 'Phase 1';
            IF WOD."Quote Phase" = WOD."Quote Phase"::"Phase 2" THEN
                Phase := 'Phase 2';

            IF WOD."Pump Module" THEN
                MESSAGE('Work Order %1 is Quoted for a Pump Module and Need to be processed by the Parts Department', WODN)
            ELSE
                MESSAGE('Work Order Detail %1 is in %2', WODN, Phase);
        END;
    end;

    procedure BlockCheck();
    begin
        Continue := TRUE;
        IF Customer.GET(WOM.Customer) THEN BEGIN
            IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                IF WOD.Unblocked = FALSE THEN BEGIN
                    MESSAGE('This Work Order Detail is currently Blocked.  Please see Accounting');
                    Continue := FALSE;
                END;
            END;
        END;
    end;

    procedure ReverseBuildAhead();
    begin
        IF WOD."Reverse Build Ahead" THEN BEGIN
            MESSAGE('Work Order %1 is now a Vendor Repair, Please Notify the Parts Department to Return Parts.', WODN);
            Continue := FALSE;
        END;
    end;

    procedure OpenNextRecord();
    begin
        IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
            COMMIT;
            EXIT;
        END ELSE BEGIN
            COMMIT;
            NextRecord.RUN
        END;
    end;

    procedure StepEntry();
    begin
        CurrentStep := WOS.Step;
        MESSAGE('This Work Order Detail is Currently in %1', CurrentStep);
        COMMIT;
        NextRecord.RUN;
    end;

    procedure Phase3();
    begin

        PAGE.RUNMODAL(50019, WOS);
        TestComplete;
        SerialNO := '';
        NotChecked := '';
        QuotedQty := '';
        EmptyQuotePrice := '';
        Complete := TRUE;

        IF WOD."Customer ID" = 'ADV-01' THEN BEGIN
            Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
            IF Parts.FIND('-') THEN BEGIN
                REPEAT
                    IF Parts."Serial No." <> '' THEN BEGIN
                        SerialNO := 'FOUND';
                        IF Parts."Quoted Quantity" = 0 THEN
                            QuotedQty := 'ZERO';
                    END;
                    IF Parts."Quoted Quantity" > 0 THEN BEGIN
                        IF Parts."Quoted Price" = 0 THEN
                            EmptyQuotePrice := 'TRUE';
                    END;
                UNTIL Parts.NEXT = 0;
            END;
            IF SerialNO = '' THEN BEGIN
                MESSAGE('The ADVACO Pump must be included in the QUOTE');
                Complete := FALSE;
            END;
            IF (SerialNO <> '') AND (QuotedQty <> '') THEN BEGIN
                MESSAGE('Quoted Qty is Zero for Pump with Serial Number');
                Complete := FALSE;
            END;
            IF EmptyQuotePrice <> '' THEN
                MESSAGE('Quoted Price is Zero for Atleast one Item or Resource, Unable to Complete Phase 2');
            Mechanics.SETRANGE(Mechanics."Work Order No.", WOD."Work Order No.");
            Mechanics.SETRANGE(Mechanics.Entered, FALSE);
            IF Mechanics.FIND('-') THEN BEGIN
                MESSAGE('All Mechanics Parts must be checked as Entered');
                NotChecked := 'NotChecked';
                Complete := FALSE;
            END;

        END ELSE BEGIN
            Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
            IF Parts.FIND('-') THEN BEGIN
                REPEAT
                    IF Parts."Serial No." <> '' THEN BEGIN
                        IF Parts."Quoted Quantity" = 0 THEN
                            QuotedQty := 'ZERO';
                    END;
                    IF Parts."Quoted Quantity" > 0 THEN BEGIN
                        IF Parts."Quoted Price" = 0 THEN
                            EmptyQuotePrice := 'TRUE';
                    END;
                UNTIL Parts.NEXT = 0;
            END;
            IF (QuotedQty <> '') THEN BEGIN
                MESSAGE('Quoted Qty is Zero for Pump with Serial Number');
                Complete := FALSE;
            END;
            IF EmptyQuotePrice <> '' THEN
                MESSAGE('Quoted Price is Zero for Atleast one Item or Resource, Unable to Complete Phase 2');
            Mechanics.SETRANGE(Mechanics."Work Order No.", WOD."Work Order No.");
            Mechanics.SETRANGE(Mechanics.Entered, FALSE);
            IF Mechanics.FIND('-') THEN BEGIN
                MESSAGE('All Mechanics Parts must be checked as Entered');
                Complete := FALSE;
                NotChecked := 'NotChecked';
            END;
        END;

        IF Complete = FALSE THEN
            Phase3;
    end;

    procedure TestComplete();
    begin
        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF WOS2.Employee = '' THEN BEGIN
            MESSAGE('You must enter an Employee');
            PAGE.RUNMODAL(50019, WOS2);
            COMMIT;
            TestComplete;
        END;

        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF WOS2."Date Out" = 0D THEN BEGIN
            MESSAGE('You must enter a Finish Date');
            PAGE.RUNMODAL(50019, WOS2);
            COMMIT;
            TestComplete
        END;

        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF (WOS2."Regular Hours" = 0) AND (WOS2."Overtime Hours" = 0) THEN BEGIN
            MESSAGE('You must enter Time Worked');
            PAGE.RUNMODAL(50019, WOS2);
            COMMIT;
            TestComplete;
        END;
    end;
}

