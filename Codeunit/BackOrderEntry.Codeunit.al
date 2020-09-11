codeunit 50005 "Back Order Entry"
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########', WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN)
        else
            exit;

        IF WODN <> '' THEN BEGIN
            WOD.SETCURRENTKEY(WOD."Work Order No.");
            IF WOD.GET(WODN) THEN BEGIN
                WOM.GET(WOD."Work Order Master No.");
                BlockCheck;
                IF Continue = TRUE THEN BEGIN
                    IF WOD.Complete THEN BEGIN
                        IF WOD."Unrepairable Handling".AsInteger() = 0 THEN
                            MESSAGE('The Work Order was shipped');
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Un-Assembled" THEN
                            MESSAGE('The Work Order was shipped Un-Assembled');
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Assembled" THEN
                            MESSAGE('The Work Order was shipped Assembled');
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Save Parts & Scrap" THEN
                            MESSAGE('The Pump was Scrapped & Parts Saved');
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::Scrap THEN
                            MESSAGE('The Pump was Scrapped');
                        IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return to Vendor" THEN
                            MESSAGE('The Pump was Returned to the Vendor');
                    END ELSE BEGIN
                        IF WOD."Pump Module" THEN BEGIN
                            MESSAGE('Work Order %1 is Quoted for a Pump Module', WODN);
                            NextRecord.RUN;
                        END ELSE BEGIN
                            WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                            WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                            WOS.SETRANGE(WOS.Step, WOS.Step::"B-O");
                            WOS.SETRANGE(WOS.Status, WOS.Status::Waiting);
                            IF WOS.FIND('+') THEN BEGIN
                                Found;
                            END ELSE BEGIN
                                WOStep.SETCURRENTKEY(WOStep."Order No.", WOStep."Line No.");
                                WOStep.SETRANGE(WOStep."Order No.", WOD."Work Order No.");
                                WOStep.SETRANGE(WOStep.Status, WOStep.Status::Waiting);
                                IF WOStep.FIND('+') THEN BEGIN
                                    Currentstep := WOStep.Step;
                                    MESSAGE('Work Order Detail is in %1', Currentstep);
                                    NextRecord.RUN;
                                END ELSE BEGIN
                                    MESSAGE('Pump has not been Received');
                                    NextRecord.RUN;
                                END;
                            END;
                        END;
                    END;
                END;
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
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        WOS3: Record Status;
        Window: Dialog;
        WODN: Code[50];
        NextRecord: Codeunit "Back Order Entry";
        Ok: Boolean;
        Parts: Record Parts;
        Open: Boolean;
        Complete: Boolean;
        WOStep: Record Status;
        CurrentStep: Enum DetailStep;
        //Currentstep: Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        Continue: Boolean;
        Customer: Record Customer;
        WOM: Record WorkOrderMaster;

    procedure Found();
    begin
        Open := FALSE;
        Complete := FALSE;

        WOS.SETRANGE(WOS.Step, WOS.Step);
        PAGE.RUNMODAL(50021, WOS);

        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
        WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
        IF WOS.FIND('+') THEN BEGIN
            Parts.SETCURRENTKEY("Work Order No.", "Part Type");
            Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
            Parts.SETRANGE(Parts."Part Type", Parts."Part Type"::Item);
            IF Parts.FIND('-') THEN BEGIN
                REPEAT
                    Parts.CALCFIELDS(Parts."In-Process Quantity");
                    IF (Parts."Quantity Backorder" > 0) OR (Parts."Pulled Quantity" < Parts."In-Process Quantity") THEN
                        Open := TRUE
                    ELSE
                        Complete := TRUE;
                UNTIL Parts.NEXT = 0;
            END;

            // Checks to see if only Resources Quouted
            IF (Open = FALSE) AND (Complete = FALSE) THEN BEGIN
                Parts.SETCURRENTKEY("Work Order No.", "Part Type");
                Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
                Parts.SETRANGE(Parts."Part Type", Parts."Part Type"::Resource);
                IF Parts.FIND('-') THEN BEGIN
                    Complete := TRUE;
                END;
            END;


            // Checks to see if nothing is Quoted
            IF (Open = FALSE) AND (Complete = FALSE) THEN BEGIN
                Parts.SETCURRENTKEY("Work Order No.", "Part Type");
                Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
                IF Parts.FIND('-') THEN BEGIN
                END ELSE
                    Complete := TRUE;
            END;



            IF Open THEN BEGIN
                MESSAGE('This Order is not complete');
                IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
                    COMMIT;
                    EXIT;
                END ELSE BEGIN
                    COMMIT;
                    NextRecord.RUN
                END;
            END ELSE
                IF Complete THEN BEGIN
                    IF NOT CONFIRM('Is Back Order Step Complete?') THEN BEGIN
                        IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
                            COMMIT;
                            EXIT;
                        END ELSE BEGIN
                            COMMIT;
                            NextRecord.RUN
                        END;
                    END ELSE BEGIN
                        // INSERT CODE HERE FOR CHECKING TESTCOMPLETE HEF
                        TestComplete;
                        WOD.BackorderText := '';
                        WOD.MODIFY;
                        WOS2.Status := WOS2.Status::Complete;
                        WOS2.MODIFY;
                        IF WOD."Vendor Repair" THEN BEGIN
                            WOS3.INIT;
                            WOS3."Order No." := WOS2."Order No.";
                            WOS3."Line No." := WOS2."Line No." + 10000;
                            WOS3.Step := WOS3.Step::QC;
                            WOS3."Date In" := WOS2."Date Out";
                            WOS3.Status := WOS2.Status::Waiting;
                            WOS3.INSERT;
                        END ELSE BEGIN
                            WOS3.INIT;
                            WOS3."Order No." := WOS2."Order No.";
                            WOS3."Line No." := WOS2."Line No." + 10000;
                            WOS3.Step := DetailStep.FromInteger(WOS2.Step.AsInteger() + 1); //?????
                            WOS3."Date In" := WOS2."Date Out";
                            WOS3.Status := WOS2.Status::Waiting;
                            WOS3.INSERT;
                        END;
                        IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
                            COMMIT;
                            EXIT;
                        END ELSE BEGIN
                            COMMIT;
                            NextRecord.RUN
                        END;
                    END;
                END;
        END;
    end;

    procedure TestComplete();
    begin
        // HEF STILL WORKING ON GETTING IT TO TEST FIELDS BEFORE EXIT

        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF WOS2.Employee = '' THEN BEGIN
            MESSAGE('You must enter an Employee before changing the Status to Complete');
            PAGE.RUNMODAL(50021, WOS2);
            COMMIT;
            TestComplete;
        END;

        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF WOS2."Date Out" = 0D THEN BEGIN
            MESSAGE('You must enter a Finish Date before changng the Status to Complete');
            COMMIT;
            PAGE.RUNMODAL(50021, WOS2);
            COMMIT;
            TestComplete
        END;

        WOS2.GET(WOS."Order No.", WOS."Line No.");
        IF (WOS2."Regular Hours" = 0) AND (WOS2."Overtime Hours" = 0) THEN BEGIN
            MESSAGE('You must enter Time Worked before changing Status to Complete');
            COMMIT;
            PAGE.RUNMODAL(50021, WOS2);
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
                    MESSAGE('This Work Order Detail is currently Blocked.  Please contact Accounting');
                    Continue := FALSE;
                END;
            END;
        END;
    end;
}

