codeunit 50021 FSShipping
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
                IF Continue = true THEN BEGIN
                    IF FS.Complete THEN BEGIN
                        MESSAGE('The Field Service has been Completed');
                        OpenNextRecord;
                    END ELSE BEGIN
                        IF FS."Parts Required" THEN BEGIN
                            WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                            WOS.SETRANGE(WOS."Order No.", FS."Field Service No.");
                            IF WOS.FIND('+') THEN BEGIN
                                Found;
                            END ELSE BEGIN
                                MESSAGE('This Field Service Order hasn''t been released for Parts to be Shipped, See Sales Department to change');
                                OpenNextRecord;
                            END;
                        END ELSE BEGIN
                            MESSAGE('The Field Service Doesn''t have Parts to Ship');
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
        NextRecord: Codeunit FSShipping;
        WOS: Record Status;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        Open: Boolean;
        MissingReason: Boolean;
        Continue: Boolean;

    procedure Found();
    begin
        PAGE.RUNMODAL(50156, FS);
        OpenNextRecord;
    end;

    procedure OpenNextRecord();
    begin
        IF not CONFIRM('Do you want to update another record?', false) THEN BEGIN
            COMMIT;
            EXIT;
        END ELSE BEGIN
            COMMIT;
            NextRecord.RUN
        END;
    end;

    procedure BlockCheck();
    begin
        Continue := true;
        IF Customer.GET(FS.Customer) THEN BEGIN
            IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                MESSAGE('This Work Order Detail is currently Blocked.  Please see Accounting');
                Continue := false;
            END;
        END;
    end;
}

