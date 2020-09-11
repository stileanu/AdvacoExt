codeunit 50013 PumpModule
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
                        IF WOD."Pump Module" THEN BEGIN
                            MESSAGE('Work Order %1 is already setup for a Pump Module', WODN);
                            OpenNextRecord;
                        END ELSE BEGIN
                            WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                            WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                            IF WOS.FIND('+') THEN BEGIN
                                Found;
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
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WODN: Code[50];
        NextRecord: Codeunit PumpModule;
        Parts: Record Parts;
        Customer: Record Customer;
        Continue: Boolean;

    procedure Found();
    begin
        IF (WOS.Step = WOS.Step::RCV) OR (WOS.Step = WOS.Step::DIS) THEN
            PreQuote
        ELSE
            IF WOS.Step = WOS.Step::SHP THEN
                Shipping
            ELSE
                Page.RUNMODAL(50027, WOD);
    end;

    procedure PreQuote();
    begin
        ERROR('This Work Order hasn''t been Quoted yet');
    end;

    procedure QuoteComplete();
    begin
    end;

    procedure Shipping();
    begin
        ERROR('This Work Order Detail is in Shipping');
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
}

