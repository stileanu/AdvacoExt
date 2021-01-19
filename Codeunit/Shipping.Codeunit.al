codeunit 50006 Shipping
{
    // version ADV

    // ADV 12/16/2015 
    //   Corrected logic error on Open trigger with ApprovalCode for
    // 04/17/18
    //   Message about Saved Container before launching PAGE


    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Work Order No. #1#########', WODNo);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODNo)
        else
            exit;

        Continue := TRUE;
        WONo := COPYSTR(WODNo, 1, 5) + '00';
        IF WODNo <> '' THEN BEGIN
            IF WOD.GET(WODNo) THEN BEGIN
                //Check for Blocked Customers
                IF Cust.GET(WOD."Customer ID") THEN BEGIN
                    IF Cust.Blocked <> Cust.Blocked::" " THEN
                        Continue := FALSE;
                END;

                //Check for Exchange Pump OR Vendor Return
                IF (WOD."Exchange Pump") OR (WOD."Vendor Return") THEN BEGIN
                    IF WOD."Exchange Pump" THEN BEGIN
                        WOD.RESET;
                        WOD.SETRANGE(WOD."Work Order No.", WODNo);
                        WOD.SETRANGE(WOD.Complete, FALSE);
                        IF WOD.FIND('-') THEN BEGIN
                            IF (WOD."Vendor Carrier" = '') OR (WOD."Vendor Name" = '') OR (WOD."Vendor City" = '') THEN
                                MESSAGE('Work Order %1 doesn''t have all the necessary Vendor Information completed', WODNo)
                            ELSE
                                PAGE.RUNMODAL(50032, WOD);
                        END ELSE
                            MESSAGE('Work Order %1 is Complete', WODNo);
                    END ELSE BEGIN
                        MESSAGE('Work Order %1 is setup as a Vendor Return and needs to be shipped through Credit Memo Shipping', WODNo);
                    END;
                END;
                //Check for Work Released from Quote as Return to Vendors
                IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return to Vendor" THEN BEGIN
                    MESSAGE('Work Order %1 is setup as a Vendor Return and needs to be shipped through Credit Memo Shipping', WODNo);
                END ELSE BEGIN
                    IF (WOD."Exchange Pump" = FALSE) AND (WOD."Vendor Return" = FALSE) THEN
                        OpenForm;
                END;
            END ELSE BEGIN
                MESSAGE('Work Order Detail %1 doesn''t Exist.', WODNo);
            END;

        END ELSE BEGIN
            MESSAGE('You must enter Work Order Detail No.');
            OpenNextRecord;
        END;
    end;

    var
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WOD: Record WorkOrderDetail;
        Cust: Record Customer;
        Ok: Boolean;
        NextRecord: Codeunit Shipping;
        Continue: Boolean;
        WONo: Code[10];
        ApprovalCode: Boolean;
        WODNo: Code[10];
        Unrep: Boolean;
        Terms: Code[10];
        DetailCount: Integer;
        Found: Boolean;

    procedure OpenNextRecord();
    begin
        IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
            //COMMIT;
            EXIT;
        END ELSE BEGIN
            //COMMIT;
            NextRecord.RUN
        END;
    end;

    procedure OpenForm();
    begin

        // DEBUG: Comment for production
        //WOD.Complete := false;
        //WOD.Modify();
        //Commit();

        WOD.RESET;
        WOD.SETCURRENTKEY(WOD."Work Order Master No.");
        WOD.SETRANGE(WOD."Detail Step", WOD."Detail Step"::SHP);
        WOD.SETRANGE(WOD.Complete, FALSE);
        IF Continue = FALSE THEN  // Checks Blocked Customers for Individual Orders Released
            WOD.SETRANGE(WOD."Unblocked SHP", TRUE);
        WOD.SETFILTER(WOD."Work Order Master No.", WONo);
        // ADV 12/16/2015 Start
        IF WOD."Payment Terms" = 'CC' THEN
            WOD.SETFILTER(WOD."Approval Code", '<>''''');
        // ADV 12/16/2015 End

        // Checks for Credit Card Order
        ApprovalCode := TRUE;
        Found := FALSE;
        Terms := '';
        IF WOD.FIND('-') THEN BEGIN
            REPEAT
                // ADV 12/16/2015 Start
                IF WOD."Payment Terms" = 'CC' THEN
                    WOD.SETFILTER(WOD."Approval Code", '<>''''');
                // ADV 12/16/2015 End
                DetailCount := DetailCount + 1;
                Terms := COPYSTR(WOD."Payment Terms", 1, 3);
                IF Terms <> 'NET' THEN BEGIN
                    IF (WOD.Quote = WOD.Quote::Accepted) OR (WOD."Unrepairable Charge" > 0) THEN BEGIN
                        IF (WOD."Approval Code" = '') AND (WOD."Work Order No." = WODNo) THEN
                            ApprovalCode := FALSE;
                    END;
                END;
                // Check to See if Entered Work Order Detail will be displayed
                IF WOD."Work Order No." = WODNo THEN
                    Found := TRUE;
            UNTIL WOD.NEXT = 0;
            // ADV 12/16/2015 Start
            //END;
        END ELSE
            ApprovalCode := FALSE;
        // ADV 12/16/2015 End

        IF ApprovalCode = FALSE THEN BEGIN
            IF WOD."Payment Terms" = 'CC' THEN
                MESSAGE('Contact Accounting for Credit Card Approval Code before Shipping, Carrier: %1 Type: %2 Charge: %3',
                         WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge")
            ELSE
                IF WOD."Payment Terms" = 'COD' THEN
                    MESSAGE('Contact Accounting to Calculate COD Charges before Shipping,Carrier: %1 Type: %2 Charge: %3',
                             WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge")
                ELSE
                    MESSAGE('Locate Payment Terms on WO, Contact Acct. with Terms before Shipping,Carrier: %1 Type: %2 Charge: %3',
                             WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge");
        END ELSE BEGIN
            IF Cust."Ship on Sales Order" THEN BEGIN
                WOD.SETFILTER(WOD."Work Order No.", WODNo);
                IF WOD.FIND('+') THEN BEGIN
                    // 04/17/18 start
                    IF WOD."Container Saved" THEN
                        MESSAGE(STRSUBSTNO('Ship with Saved Customer''s Container [%1] saved from Receiving',
                                            FORMAT(WOD."Container Type")));
                    // 04/17/18 end
                    IF (WOD.Quote = WOD.Quote::"Not Repairable") AND (WOD."Unrepairable Handling".AsInteger() < 3) THEN BEGIN
                        PAGE.RUNMODAL(50033, WOD);
                    END ELSE BEGIN
                        IF WOD.Boxed = FALSE THEN BEGIN
                            IF (WOD."Customer ID" = 'ADV-01') AND (WOD."Inventory Cost Adjusted" = FALSE) THEN BEGIN
                                MESSAGE('Contact Purchase Manager to Adjust Inventory Cost Prior to Boxing the Order');
                            END ELSE BEGIN
                                PAGE.RUNMODAL(50034, WOD)
                            END;
                        END ELSE BEGIN
                            MESSAGE('Boxed and Ready to Ship on Sales Order');
                        END;
                    END;
                END;
            END ELSE BEGIN
                IF DetailCount > 0 THEN BEGIN
                    IF Found THEN BEGIN
                        // 04/17/18 start
                        IF WOD."Container Saved" THEN
                            MESSAGE(STRSUBSTNO('Ship with Saved Customer''s Container [%1] saved from Receiving',
                                                FORMAT(WOD."Container Type")));
                        // 04/17/18 end
                        PAGE.RUNMODAL(50033, WOD);
                    END ELSE BEGIN
                        MESSAGE('Work Order Detail %1 is not ready to ship', WODNo);
                        // 04/17/18 start
                        IF WOD."Container Saved" THEN
                            MESSAGE(STRSUBSTNO('Ship with Saved Customer''s Container [%1] saved from Receiving',
                                                FORMAT(WOD."Container Type")));
                        // 04/17/18 end
                        PAGE.RUNMODAL(50033, WOD);
                    END;
                END ELSE BEGIN
                    IF Continue THEN BEGIN
                        IF WOD.Complete THEN
                            MESSAGE('Work Order Detail %1 is Complete', WODNo)
                        ELSE
                            MESSAGE('Work Order Detail %1 is not ready to Ship', WODNo);
                    END ELSE BEGIN
                        MESSAGE('The Customer is Blocked, and the Work Order Detail %1 has not been individually released to Ship', WODNo);
                    END;
                END;
            END;
        END;
    end;

    procedure ContainerToBOLContainer(ContVal: Enum Container): Enum BOLContainer
    var
        BOLCont: Enum BOLContainer;
    begin
        case ContVal of
            ContVal::Skid:
                BOLCont := BOLCont::Skid;
            ContVal::Crate:
                BOLCont := BOLCont::Crate;
            ContVal::Drum:
                BOLCont := BOLCont::Drum;
            ContVal::"Skid Box":
                BOLCont := BOLCont::"Skid Box";
            ContVal::Loose:
                BOLCont := BOLCont::Loose;
            else
                BOLCont := BOLContainer.FromInteger(ContVal.AsInteger());
        end;

        exit(BOLCont);
    end;

    procedure ShipChrgToBOLShipChrg(ShCharge: Enum ShippingCharge): Enum BOLShipCharge
    var
        BOLShpCrg: Enum BOLShipCharge;
    begin
        exit(BOLShipCharge.FromInteger(ShCharge.AsInteger()));
    end;
}

