codeunit 50003 "Re-Quote"
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
            WOD.SETRANGE(WOD."Work Order No.", WODN);
            IF WOD.GET(WODN) THEN BEGIN
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
                    WOS.SETRANGE(WOS.Status, WOS.Status::Complete);
                    IF WOS.FIND('+') THEN BEGIN
                        WOS2.SETCURRENTKEY(WOS2."Order No.", WOS2."Line No.");
                        WOS2.SETRANGE(WOS2."Order No.", WOD."Work Order No.");
                        WOS2.SETRANGE(WOS2.Step, WOS.Step::SHP);
                        IF WOS2.FIND('+') THEN BEGIN
                            WOS2.DELETE;
                            COMMIT;
                            WOS2.RESET;
                            WOS2.SETCURRENTKEY(WOS2."Order No.", WOS2."Line No.");
                            WOS2.SETRANGE(WOS2."Order No.", WOD."Work Order No.");
                            WOS2.SETRANGE(WOS2.Status, WOS2.Status::Complete);
                            IF WOS2.FIND('+') THEN BEGIN
                                WOS2.Status := WOS2.Status::Waiting;
                                WOS2.MODIFY;
                            END;
                        END;

                        WOD.Quote := WOD.Quote::" ";
                        WOD."Unrepairable Reason" := WOD."Unrepairable Reason"::" ";
                        WOD."Unrepairable Handling" := WOD."Unrepairable Handling"::" ";
                        WOD."Unrepairable BuildAhead" := FALSE;
                        WOD."Build Ahead" := TRUE;
                        WOD."Order Adj." := 0;
                        WOD."Released USERID" := '';
                        WOD.MODIFY;

                        OQP.SETRANGE(OQP."Work Order No.", WOD."Work Order No.");
                        IF OQP.FIND('-') THEN BEGIN
                            REPEAT
                                OQP.DELETE;
                            UNTIL OQP.NEXT = 0;
                        END;

                        WOS.Status := WOS.Status::Waiting;
                        WOS.MODIFY;
                        COMMIT;
                        MESSAGE('Work Order Detail %1 is Ready to Be Re-Quoted', WODN);
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
            END ELSE BEGIN
                MESSAGE('Work Order Detail %1 not found', WODN);
                //NextRecord.RUN;
                OpenNextRecord;
            END;
        END ELSE BEGIN
            //MESSAGE('You must enter a number.');
            //NextRecord.RUN;
            OpenNextRecord;
        END;
    end;

    var
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        WOSTEP: Record Status;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WODN: Code[50];
        NextRecord: Codeunit "Re-Quote";
        OQP: Record OriginalQuotedParts;
        CurrentStep: Enum DetailStep;
    //CurrentStep : Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;

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
}

