codeunit 50020 FSParts
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Field Service Number #1#########',FSN); 
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::FieldService, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(FSN);
        IF FSN <> '' THEN BEGIN
            IF FS.GET(FSN) THEN BEGIN
                BlockCheck;
                IF Continue = TRUE THEN BEGIN
                    IF FS.Complete THEN BEGIN
                        MESSAGE('The Field Service has been Completed');
                        OpenNextRecord;
                    END ELSE BEGIN
                        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                        WOS.SETRANGE(WOS."Order No.", FS."Field Service No.");
                        IF WOS.FIND('+') THEN BEGIN
                            Found;
                        END ELSE BEGIN
                            MESSAGE('This Field Service Order hasn''t been released for Parts, See Sales Department to change');
                            OpenNextRecord;
                        END;
                    END;
                END ELSE
                    OpenNextRecord;
            END ELSE BEGIN
                MESSAGE('Field Service No. %1 not found', FSN);
                NextRecord.RUN;
            END;
        END ELSE BEGIN
            MESSAGE('You must enter a number.');
            NextRecord.RUN;
        END;
    end;

    var
        FSN: Code[10];
        FS: Record FieldService;
        Customer: Record Customer;
        NextRecord: Codeunit FSParts;
        WOS: Record Status;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        //Window: Dialog;
        Open: Boolean;
        Parts: Record Parts;
        Continue: Boolean;
        FSincomplete: Record FieldService;

    procedure Found();
    begin
        Open := FALSE;

        PAGE.RUNMODAL(50152, FS);

        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
        WOS.SETRANGE(WOS."Order No.", FS."Field Service No.");
        IF WOS.FIND('+') THEN BEGIN
            Parts.SETCURRENTKEY("Work Order No.", "Part Type");
            Parts.SETRANGE(Parts."Work Order No.", WOS."Order No.");
            Parts.SETRANGE(Parts."Part Type", Parts."Part Type"::Item);
            IF Parts.FIND('-') THEN BEGIN
                REPEAT
                    Parts.CALCFIELDS(Parts."In-Process Quantity");
                    IF (Parts."Quantity Backorder" > 0) OR (Parts."Pulled Quantity" < Parts."In-Process Quantity") THEN
                        Open := TRUE;
                UNTIL Parts.NEXT = 0;
            END;

            IF Open THEN BEGIN
                MESSAGE('This Order has a Backorder or Parts not Pulled');
                FSincomplete.GET(FSN);
                FSincomplete."Incomplete Parts" := TRUE;
                FSincomplete.MODIFY;
                OpenNextRecord;
            END ELSE BEGIN
                MESSAGE('This Order is Complete');
                FSincomplete.GET(FSN);
                FSincomplete."Incomplete Parts" := FALSE;
                FSincomplete.MODIFY;
                OpenNextRecord;
            END;
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
        IF Customer.GET(FS.Customer) THEN BEGIN
            IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                MESSAGE('This Work Order Detail is currently Blocked.  Please see Accounting');
                Continue := FALSE;
            END;
        END;
    end;
}

