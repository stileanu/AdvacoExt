codeunit 50004 "Quote Entry"
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########', WODN);
        //Window.INPUT();
        ///Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN);
        IF WODN <> '' THEN BEGIN
            WOD.SETCURRENTKEY(WOD."Work Order No.");
            WOD.SETRANGE(WOD."Work Order No.", WODN);
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
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return to Vendor" THEN BEGIN
                            MESSAGE('The Pump was Returned to the Vendor');
                            OpenNextRecord;
                        END;
                    END ELSE BEGIN
                        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                        WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                        WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                        WOS.SETRANGE(WOS.Status, WOS.Status::Waiting);
                        IF WOS.FIND('+') THEN BEGIN
                            Found;
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
        WOS3: Record Status;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;

        WODN: Code[50];
        NextRecord: Codeunit "Quote Entry";
        Ok: Boolean;
        Parts: Record Parts;
        Parts2: Record Parts;
        //CurrentStep: Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        CurrentStep: Enum DetailStep;
        NewStep: Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        Mechanics: Record QuoteMechanicsParts;
        Customer: Record Customer;
        Continue: Boolean;
        WOSTEP: Record Status;
        SerialNO: Code[10];
        NotChecked: Code[10];
        QuotedQty: Code[10];
        ShopLabor: Boolean;
        Quote3Parts: Record Parts;
        ZERO: Boolean;
        EmptyQuotePrice: Code[10];
        EmptyPO: Code[10];

    procedure Found();
    begin
        IF WOD."Quote Phase" = WOD."Quote Phase"::" " THEN
            Phase0
        ELSE
            IF WOD."Quote Phase" = WOD."Quote Phase"::"Phase 1" THEN
                Phase1
            ELSE
                IF WOD."Quote Phase" = WOD."Quote Phase"::"Phase 2" THEN
                    Phase2
                ELSE
                    IF WOD."Quote Phase" = WOD."Quote Phase"::"Phase 3" THEN
                        Phase3
                    // INSERTED BY HEF
                    ELSE
                        IF (WOS.Step <> WOS.Step::QOT) THEN
                            StepEntry;
    end;

    procedure Phase0();
    begin
        //Check for Pump Modules and Prevent from opening Quote Program
        IF WOD."Pump Module" THEN BEGIN
            ERROR('Work Order %1 is Quoted for a Pump Module and Need to be processed by the Parts Department', WOD."Work Order No.");
        END ELSE BEGIN
            IF WOD.ReQuoted THEN BEGIN
                Ok := TRUE;
            END ELSE BEGIN
                WOD."Quote Phase" := WOD."Quote Phase"::"Phase 1";
                WOD.VALIDATE("Model No.");
                WOD.MODIFY;
                COMMIT;
            END;
        END;

        PAGE.RUNMODAL(50013, WOS);
        ShopLabor := FALSE;

        IF NOT CONFIRM('Is Phase 1 of the Quote Complete?', FALSE) THEN BEGIN
            OpenNextRecord;
        END ELSE BEGIN

            // Checks for Labor Hours BEING GREATER THAN ZERO
            Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
            Parts.SETRANGE(Parts."Part Type", 2);   //Resource
            Parts.SETRANGE(Parts."Part No.", '1');  //Shop Labor
            IF Parts.FIND('-') THEN BEGIN
                IF Parts."Quoted Quantity" > 0 THEN
                    ShopLabor := TRUE;
            END ELSE BEGIN
                ShopLabor := TRUE;
            END;

            IF ShopLabor = TRUE THEN BEGIN
                WOD.RESET;
                WOD.GET(WOS."Order No.");
                IF WOD."Order Type" = WOD."Order Type"::Warranty THEN BEGIN
                    IF (WOD."Warranty Type" = WOD."Quote Phase"::" ") OR (WOD."Warranty Reason" = '') THEN BEGIN
                        MESSAGE('Warranty Type and Reason must be completed before Completing Quote Phase 1');
                        OpenNextRecord;
                    END ELSE BEGIN
                        TestComplete;
                        COMMIT;
                        WOD."Quote Phase" := WOD."Quote Phase"::"Phase 2";
                        WOD.MODIFY;
                        COMMIT;
                        IF WOD."Build Ahead Report" = TRUE THEN BEGIN
                            WOD.SETRECFILTER;
                            REPORT.RUNMODAL(50039, FALSE, FALSE, WOD);
                            OpenNextRecord;
                        END ELSE BEGIN
                            OpenNextRecord;
                        END;
                    END;
                END ELSE BEGIN
                    TestComplete;
                    COMMIT;
                    WOD."Quote Phase" := WOD."Quote Phase"::"Phase 2";
                    WOD.MODIFY;
                    COMMIT;
                    IF WOD."Build Ahead Report" = TRUE THEN BEGIN
                        WOD.SETRECFILTER;
                        REPORT.RUNMODAL(50039, FALSE, FALSE, WOD);
                        OpenNextRecord;
                    END ELSE BEGIN
                        OpenNextRecord;
                    END;
                END;
            END ELSE BEGIN
                MESSAGE('Shop Labor Hours must be Entered before Completing Quote Phase 1');
                OpenNextRecord;
            END;
        END;
    end;

    procedure Phase1();
    begin
        //Check for Pump Modules and Prevent from opening Quote Program
        IF WOD."Pump Module" THEN BEGIN
            ERROR('Work Order %1 is Quoted for a Pump Module and Need to be processed by the Parts Department', WOD."Work Order No.");
        END ELSE BEGIN
            Parts2.SETRANGE(Parts2."Work Order No.", WOS."Order No.");
            Parts2.SETRANGE(Parts2."Part Type", 1);
            IF Parts2.FIND('-') THEN BEGIN
                Ok := TRUE;
            END ELSE BEGIN
                WOD.VALIDATE("Model No.");
                COMMIT;
            END;
        END;

        PAGE.RUNMODAL(50013, WOS);
        ShopLabor := FALSE;

        IF NOT CONFIRM('Is Phase 1 of the Quote Complete?', FALSE) THEN BEGIN
            COMMIT;
            OpenNextRecord;
        END ELSE BEGIN
            // Checks for Labor Hours BEING GREATER THAN ZERO
            Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
            Parts.SETRANGE(Parts."Part Type", 2);
            Parts.SETRANGE(Parts."Part No.", '1');
            IF Parts.FIND('-') THEN BEGIN
                IF Parts."Quoted Quantity" > 0 THEN
                    ShopLabor := TRUE;
            END ELSE BEGIN
                ShopLabor := TRUE;
            END;

            IF ShopLabor = TRUE THEN BEGIN
                WOD.RESET;
                WOD.GET(WOS."Order No.");
                IF WOD."Order Type" = WOD."Order Type"::Warranty THEN BEGIN
                    IF (WOD."Warranty Type" = WOD."Warranty Type"::" ") OR (WOD."Warranty Reason" = '') THEN BEGIN
                        MESSAGE('Warranty Type and Reason must be completed before Completing Quote Phase 1');
                        OpenNextRecord;
                    END ELSE BEGIN
                        TestComplete;
                        COMMIT;
                        WOD."Quote Phase" := WOD."Quote Phase"::"Phase 2";
                        WOD.MODIFY;
                        COMMIT;
                        IF WOD."Build Ahead Report" = TRUE THEN BEGIN
                            WOD.SETRECFILTER;
                            REPORT.RUNMODAL(50039, FALSE, FALSE, WOD);
                            OpenNextRecord;
                        END ELSE BEGIN
                            OpenNextRecord;
                        END;
                    END;
                END ELSE BEGIN
                    TestComplete;
                    COMMIT;
                    Parts.RESET;
                    Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
                    Parts.SETRANGE(Parts."Quoted Quantity", 0);
                    IF Parts.FIND('-') THEN BEGIN
                        REPEAT
                            Parts.DELETE;
                        UNTIL Parts.NEXT = 0;
                    END;
                    WOD."Quote Phase" := WOD."Quote Phase"::"Phase 2";
                    WOD.MODIFY;
                    COMMIT;
                    IF WOD."Build Ahead Report" = TRUE THEN BEGIN
                        WOD.SETRECFILTER;
                        REPORT.RUNMODAL(50039, FALSE, FALSE, WOD);
                        OpenNextRecord;
                    END ELSE BEGIN
                        OpenNextRecord;
                    END;
                END;
            END ELSE BEGIN
                MESSAGE('Shop Labor Hours must be Entered before Completing Quote Phase 1');
                OpenNextRecord;
            END;
        END;
    end;

    procedure Phase2();
    begin
        PAGE.RUNMODAL(50015, WOD);

        SerialNO := '';
        NotChecked := '';
        QuotedQty := '';
        EmptyQuotePrice := '';
        EmptyPO := '';

        IF NOT CONFIRM('Is Phase 2 of the Quote Complete?', FALSE) THEN BEGIN
            OpenNextRecord;
        END ELSE BEGIN
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

                        IF Parts."Pre-Release PO" THEN BEGIN
                            IF Parts."Purchase Order No." = '' THEN
                                EmptyPO := 'TRUE';
                        END;

                    UNTIL Parts.NEXT = 0;
                END;

                IF SerialNO = '' THEN
                    MESSAGE('The ADVACO Pump must be included in the QUOTE, Unable to complete Phase 2.');

                IF (SerialNO <> '') AND (QuotedQty <> '') THEN
                    MESSAGE('Quoted Qty is Zero for Pump with Serial Number, Unable to Complete Phase 2');

                IF EmptyQuotePrice <> '' THEN
                    MESSAGE('Quoted Price is Zero for Atleast one Item or Resource, Unable to Complete Phase 2');

                IF EmptyPO <> '' THEN
                    MESSAGE('A Purchase Order has been Requested for Atleast one Item or Resource, Unable to Complete Phase 2');


                Mechanics.SETRANGE(Mechanics."Work Order No.", WOD."Work Order No.");
                Mechanics.SETRANGE(Mechanics.Entered, FALSE);
                IF Mechanics.FIND('-') THEN BEGIN
                    MESSAGE('All Mechanics Parts must be checked as Entered, Unable to Complete Phase 2.');
                    NotChecked := 'NotChecked';
                END;

                IF (NotChecked = '') AND (SerialNO = 'FOUND') AND (QuotedQty = '') AND (EmptyQuotePrice = '') AND (EmptyPO = '') THEN BEGIN
                    WOD."Quote Phase" := WOD."Quote Phase"::"Phase 3";
                    WOD.MODIFY;
                    COMMIT;
                    OpenNextRecord;
                END ELSE BEGIN
                    OpenNextRecord
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

                        IF Parts."Pre-Release PO" THEN BEGIN
                            IF Parts."Purchase Order No." = '' THEN
                                EmptyPO := 'TRUE';
                        END;

                    UNTIL Parts.NEXT = 0;
                END;

                IF (QuotedQty <> '') THEN
                    MESSAGE('Quoted Qty is Zero for Pump with Serial Number, Unable to Complete Phase 2');

                IF EmptyQuotePrice <> '' THEN
                    MESSAGE('Quoted Price is Zero for Atleast one Item or Resource, Unable to Complete Phase 2');

                IF EmptyPO <> '' THEN
                    MESSAGE('A Purchase Order has been Requested for Atleast one Item or Resource, Unable to Complete Phase 2');

                Mechanics.SETRANGE(Mechanics."Work Order No.", WOD."Work Order No.");
                Mechanics.SETRANGE(Mechanics.Entered, FALSE);
                IF Mechanics.FIND('-') THEN BEGIN
                    MESSAGE('All Mechanics Parts must be checked as Entered, Unable to Complete Phase 2.');
                    NotChecked := 'NotChecked';
                END;

                IF (NotChecked = '') AND (QuotedQty = '') AND (EmptyQuotePrice = '') AND (EmptyPO = '') THEN BEGIN
                    WOD."Quote Phase" := WOD."Quote Phase"::"Phase 3";
                    WOD.MODIFY;
                    COMMIT;
                    OpenNextRecord;
                END ELSE BEGIN
                    OpenNextRecord;
                END;
            END;
        END;
    end;

    procedure Phase3();
    begin
        // Checks for Resources with Zero Value
        ZERO := FALSE;
        Quote3Parts.SETRANGE(Quote3Parts."Work Order No.", WOD."Work Order No.");
        Quote3Parts.SETRANGE(Quote3Parts."Part Type", 2);
        IF Quote3Parts.FIND('-') THEN BEGIN
            REPEAT
                IF Quote3Parts."Quoted Quantity" > 0 THEN BEGIN
                    IF Quote3Parts."Quoted Price" = 0 THEN
                        ZERO := TRUE;
                END;
            UNTIL Quote3Parts.NEXT = 0;
        END;

        IF ZERO = TRUE THEN BEGIN
            MESSAGE('Work Order %1 has a Zero Price for atleast one Resource, Contact the Purchasing Department', WODN);
            OpenNextRecord;
        END ELSE BEGIN
            PAGE.RUNMODAL(50017, WOD);
            OpenNextRecord;
        END;
    end;

    procedure TestComplete();
    begin
        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF WOS2.Employee = '' THEN BEGIN
            MESSAGE('You must enter an Employee before changing the Status to Complete');
            PAGE.RUNMODAL(50013, WOS2);
            COMMIT;
            TestComplete;
        END;

        IF WOS2."Date Out" = 0D THEN BEGIN
            MESSAGE('You must enter a Finish Date before changng the Status to Complete');
            PAGE.RUNMODAL(50013, WOS2);
            COMMIT;
            TestComplete
        END;

        IF (WOS2."Regular Hours" = 0) AND (WOS2."Overtime Hours" = 0) THEN BEGIN
            MESSAGE('You must enter Time Worked before changing Status to Complete');
            PAGE.RUNMODAL(50013, WOS2);
            COMMIT;
            TestComplete;
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
}

