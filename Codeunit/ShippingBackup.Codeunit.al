codeunit 50015 ShippingBackup
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Work Order No. #1#########', CustNo);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(CustNo);

        Ok := TRUE;

        IF CustNo <> '' THEN BEGIN


            WONo := COPYSTR(CustNo, 1, 5) + '00';
            WODNo := CustNo;

            IF Cust.GET(CustNo) THEN BEGIN

                IF (CustNo = 'HEW-01') OR (CustNo = 'HEW-04') OR (CustNo = 'TJA-01') OR (CustNo = 'ADV-01') THEN BEGIN
                    MESSAGE('You must enter a specific Work Order Detail for this Customer.');
                    Ok := FALSE;
                END;

                IF Ok = TRUE THEN
                    CheckCustomer
                ELSE
                    OpenNextRecord;

            END ELSE
                IF WOM.GET(WONo) THEN BEGIN

                    IF WOD.GET(WODNo) THEN BEGIN
                        IF WOD."Exchange Pump" THEN BEGIN
                            Ok := FALSE;
                            WOD.RESET;
                            WOD.SETCURRENTKEY(WOD."Work Order Master No.");
                            WOD.SETRANGE(WOD."Work Order No.", WODNo);
                            WOD.SETRANGE(WOD.Complete, FALSE);
                            IF WOD.FIND('-') THEN BEGIN
                                IF (WOD."Vendor Carrier" = '') OR (WOD."Vendor Name" = '') OR (WOD."Vendor City" = '') THEN
                                    MESSAGE('Work Order %1 doesn''t have all the necessary Vendor Information completed', WODNo)
                                ELSE
                                    Page.RUNMODAL(50032, WOD);
                            END ELSE
                                MESSAGE('Work Order %1 is Complete', WODNo);
                        END ELSE BEGIN
                            Ok := FALSE;
                            OpenForm;
                        END;
                    END ELSE BEGIN
                        MESSAGE('You must enter a specific Work Order Detail for this Customer.');
                        Ok := FALSE;
                    END;

                    IF Ok = TRUE THEN BEGIN
                        CheckWOM;
                    END ELSE BEGIN
                        IF Unrep = FALSE THEN
                            OpenNextRecord;
                    END;
                END;


        END ELSE BEGIN
            MESSAGE('You must enter either a Customer or Work Order Master No.');
            OpenNextRecord;
        END;

        IF NOT (Cust.GET(CustNo)) THEN BEGIN
            IF NOT (WOM.GET(WONo)) THEN BEGIN
                MESSAGE('%1 does not match either a Customer or a Work Order Master No.', CustNo);
                OpenNextRecord;
            END;
        END;
    end;

    var
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        Cust: Record Customer;
        ItemJournalLine: Record "Item Journal Line";
        WOP: Record Parts;
        Item: Record Item;
        Item2: Record Item;
        ItemUOM: Record "Item Unit of Measure";
        Location: Record Location;
        //LocationItem : Record Table99002570;
        Ok: Boolean;
        CustNo: Code[20];
        CustNo2: Code[20];
        NextRecord: Codeunit Shipping;
        DetailFilter: Text[200];
        DetailLength: Integer;
        TotalCost: Decimal;
        Continue: Boolean;
        ShipContinue: Boolean;
        WOMCount: Integer;
        WoTrack: Boolean;
        SerialNo: Code[20];
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        OldPartNo: Code[20];
        RepairPartNo: Code[20];
        TempPartNo: Code[20];
        NewDesc: Code[40];
        WONo: Code[10];
        ApprovalCode: Boolean;
        WODNo: Code[10];
        Unrep: Boolean;
        Terms: Code[10];

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
        IF Cust.GET(CustNo) THEN BEGIN
            IF Cust.Blocked <> Cust.Blocked::" " THEN BEGIN
                Continue := FALSE
            END;
        END;
        Continue := TRUE;
        IF Cust.GET(WOM.Customer) THEN BEGIN
            IF Cust.Blocked <> Cust.Blocked::" " THEN BEGIN
                Continue := FALSE;
            END;
        END;
    end;

    procedure SelectRecords();
    begin
        WOM.SETRANGE(WOM."Work Order Master No.", WONo);
        IF WOM.FIND('-') THEN BEGIN
            //    REPEAT   //Remove
            //      WOMCount := WOMCount + 1;  //Remove
            //    UNTIL WOM.NEXT = 0;                   //Remove
            //    IF WOMCount > 29 THEN BEGIN                    //Remove
            //      WOM.SETRANGE(WOM.Customer,WOM.Customer);              //Remove
            //        WoTrack := TRUE;                                         //Remove
            //        OpenForm;                                                    //Remove
            //    END ELSE BEGIN                                                            //Remove
            //      REPEAT                                                                           //Remove
            DetailFilter := DetailFilter + WOM."Work Order Master No." + '|';
            //      UNTIL WOM.NEXT = 0;
            DetailLength := STRLEN(DetailFilter) - 1;
            DetailFilter := COPYSTR(DetailFilter, 1, DetailLength);
            //        WoTrack := TRUE;                                                                   //Remove
            IF Unrep = TRUE THEN BEGIN
                Page.RUNMODAL(50033, WOD);
            END ELSE BEGIN
                OpenForm;
            END;
            //    END;                                                                                    //Remove
        END ELSE BEGIN
            WOM.RESET;
            WOM.SETRANGE(WOM.Customer, CustNo);
            IF WOM.FIND('-') THEN BEGIN
                REPEAT                                          //Remove
                    WOMCount := WOMCount + 1;                              //Remove
                UNTIL WOM.NEXT = 0;                                               //Remove
                IF WOMCount > 1 THEN                                                     //Remove
                  BEGIN                                                                           //Remove
                    MESSAGE('There are multiple Work Order Master open for this Customer. \' +              //Remove
                            'You must enter a unique Work Order Master number for this Customer.');                 //Remove
                    COMMIT;                         //Remove
                    EXIT;                                    //Remove
                END ELSE                                            //Remove
                    BEGIN                                                      //Remove
                    OpenForm;
                END;                                                                //Remove
            END ELSE BEGIN
                MESSAGE('No Work Order Masters for this customer where found.');
                EXIT;
            END;
        END;
    end;

    procedure CheckCustomer();
    begin
        BlockCheck;
        IF Continue = TRUE THEN BEGIN
            WOM.SETRANGE(WOM.Customer, CustNo);
            SelectRecords;
            COMMIT;
            OpenNextRecord;
        END ELSE BEGIN
            WOM.SETRANGE(WOM.Customer, CustNo);
            SelectRecords;
            WOD.SETRANGE(WOD."Unblocked SHP", TRUE);
            COMMIT;
            OpenNextRecord;
        END;
    end;

    procedure CheckWOM();
    begin
        BlockCheck;
        IF Continue = TRUE THEN BEGIN
            CustNo := WOM.Customer;
            WOM.SETRANGE(WOM.Customer, CustNo);
            SelectRecords;
            COMMIT;
            OpenNextRecord;
        END ELSE BEGIN
            CustNo := WOM.Customer;
            WOM.SETRANGE(WOM.Customer, CustNo);
            SelectRecords;
            WOD.SETRANGE(WOD."Unblocked SHP", TRUE);
            COMMIT;
            OpenNextRecord;
        END;
    end;

    procedure OpenForm();
    begin
        WOD.RESET;
        WOD.SETCURRENTKEY(WOD."Work Order Master No.");
        WOD.SETRANGE(WOD."Detail Step", WOD."Detail Step"::SHP);
        WOD.SETRANGE(WOD.Complete, FALSE);

        //IF WOTrack = FALSE THEN                                  //Remove
        WOD.SETRANGE(WOD."Customer ID", WOM.Customer);
        //ELSE                                                                  //Remove
        // WOD.SETFILTER(WOD."Work Order Master No.",DetailFilter);   //Remove
        WOD.SETFILTER(WOD."Work Order Master No.", WONo);

        // Checks for Credit Card Order
        ApprovalCode := TRUE;
        Terms := '';
        IF WOD.FIND('-') THEN BEGIN
            REPEAT
                Terms := COPYSTR(WOD."Payment Terms", 1, 3);
                IF Terms <> 'NET' THEN BEGIN
                    IF (WOD.Quote.AsInteger() < 2) AND (WOD."Unrepairable Charge" = 0) THEN BEGIN  // NO Charge Unrepairable
                        IF WOD."Approval Code" = '' THEN
                            ApprovalCode := FALSE;
                    END;
                END;
            UNTIL WOD.NEXT = 0;
        END;

        IF ApprovalCode = FALSE THEN BEGIN
            IF WOD."Payment Terms" = 'CC' THEN
                MESSAGE('Contact Accounting to enter Credit Card Approval Code before Shipping')
            ELSE
                IF WOD."Payment Terms" = 'COD' THEN
                    MESSAGE('Contact Accounting to Calculate COD Charges, and to enter COD Approval before Shipping')
                ELSE
                    MESSAGE('Locate Payment Terms on the Work Order, then Contact Accounting with Terms to enter Approval Code before Shipping');
        END ELSE BEGIN
            IF (WOD."Customer ID" = 'HEW-01') OR (WOD."Customer ID" = 'HEW-04') OR
            (WOD."Customer ID" = 'TJA-01') OR (WOD."Customer ID" = 'ADV-01') THEN BEGIN
                WOD.SETFILTER(WOD."Work Order No.", CustNo);
                IF WOD.FIND('+') THEN BEGIN
                    IF (WOD.Quote = WOD.Quote::"Not Repairable") AND (WOD."Unrepairable Handling".AsInteger() < 3) THEN BEGIN
                        Unrep := TRUE;
                        CheckWOM;
                    END ELSE BEGIN
                        IF WOD.Boxed = FALSE THEN
                            Page.RUNMODAL(50034, WOD)
                        ELSE
                            MESSAGE('Boxed and Ready to Ship on Sales Order');
                    END;
                END;
            END ELSE BEGIN
                Page.RUNMODAL(50033, WOD);
            END;
        END;
    end;
}

