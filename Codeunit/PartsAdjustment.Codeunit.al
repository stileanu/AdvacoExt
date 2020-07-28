codeunit 50008 "Parts Adjustment"
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########', WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN);
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
                        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                        WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                        IF WOS.FIND('+') THEN BEGIN
                            Found;
                        END ELSE BEGIN
                            MESSAGE('Pump has not been Received');
                            OpenNextRecord;
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
        NextRecord: Codeunit "Parts Adjustment";
        Parts: Record Parts;
        Customer: Record Customer;
        Continue: Boolean;
        Open: Boolean;
        MissingReason: Boolean;
        WOD2Backorder: Record WorkOrderDetail;
        OK: Boolean;

    procedure Found();
    begin
        IF (WOS.Step = WOS.Step::RCV) OR (WOS.Step = WOS.Step::DIS) OR (WOS.Step = WOS.Step::QOT) THEN
            PreBackorder;
        IF (WOS.Step = WOS.Step::SHP) AND (WOD."Customer ID" <> 'ADV-01') THEN
            Shipping;
        IF WOS.Step = WOS.Step::ASM THEN
            Assembly;


        Open := FALSE;
        MissingReason := FALSE;

        PAGE.RUNMODAL(50025, WOD);

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
                        Open := TRUE;
                    IF (Parts."After Quote Quantity" <> 0) AND (Parts.Reason = 0) THEN
                        MissingReason := TRUE;
                UNTIL Parts.NEXT = 0;
            END;


            IF Open THEN BEGIN
                IF MissingReason THEN BEGIN
                    WOD2Backorder.GET(WODN);
                    WOD2Backorder.BackorderText := 'BACK ORDER & MISSING REASON CODE';
                    WOD2Backorder.MODIFY;
                    MESSAGE('This Order is NOT COMPLETE');
                    OpenNextRecord;
                END ELSE BEGIN
                    WOD2Backorder.GET(WODN);
                    WOD2Backorder.BackorderText := 'BACK ORDER';
                    WOD2Backorder.MODIFY;
                    MESSAGE('This Order is NOT COMPLETE');
                    OpenNextRecord;
                END;
            END ELSE BEGIN
                IF MissingReason THEN BEGIN
                    WOD2Backorder.GET(WODN);
                    WOD2Backorder.BackorderText := 'MISSING REASON CODE';
                    WOD2Backorder.MODIFY;
                    MESSAGE('This Order is NOT Complete');
                    OpenNextRecord;
                END ELSE BEGIN
                    WOD2Backorder.GET(WODN);
                    WOD2Backorder.BackorderText := '';
                    WOD2Backorder.MODIFY;
                    MESSAGE('This Order is Complete');
                END;
            END;
        END;
    end;

    procedure PreBackorder();
    begin
        ERROR('This Work Order Detail Hasn''t Been Released from Quote');
    end;

    procedure Shipping();
    begin
        ERROR('This Work Order Detail is in Shipping');
    end;

    procedure Assembly();
    begin
        IF WOD.Quote = WOD.Quote::"Not Repairable" THEN BEGIN
            IF WOD."Build Ahead" THEN
                OK := TRUE
            ELSE
                ERROR('Work Ordre %1 has been Quoted Not Repairable and parts can''t be Adjusted', WODN);
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

