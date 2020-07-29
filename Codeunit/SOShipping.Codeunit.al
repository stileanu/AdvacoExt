codeunit 50011 SOShipping
{
    // version ADV

    // ADV 8/1/2015
    //   Added code to correct the issue of empty record in WOD table


    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Sales Order No. #1#########', SO);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(SO);
        IF SO <> '' THEN BEGIN
            SalesHeader.SETCURRENTKEY("Document Type", "No.");
            SalesHeader.SETRANGE("No.", SO);
            IF SalesHeader.FIND('-') THEN BEGIN
                IF Customer.GET(SalesHeader."Bill-to Customer No.") THEN BEGIN
                    IF Customer.Blocked <> Customer.Blocked::" " THEN
                        ERROR('Customer Blocked, Contact Accounting');
                END;
                WOD.SETCURRENTKEY(WOD."Work Order No.");
                WOD.SETRANGE("Work Order No.", SalesHeader."Work Order No.");
                // ADV 08/01/15 Start
                //IF WOD.FIND('-') THEN BEGIN
                IF (WOD.FIND('-')) AND (WOD."Work Order No." <> '') THEN BEGIN
                    // ADV 08/01/15 End
                    WO := WOD."Work Order No.";
                    IF WOD.Complete = FALSE THEN BEGIN
                        IF WOD.Boxed = TRUE THEN BEGIN
                            Terms := COPYSTR(SalesHeader."Payment Terms Code", 1, 3);
                            IF Terms <> 'NET' THEN BEGIN
                                IF SalesHeader."Approval Code" = '' THEN BEGIN
                                    IF SalesHeader."Payment Terms Code" = 'CC' THEN
                                        MESSAGE('Contact Accounting to enter Credit Card Approval Code before Shipping, Carrier: %1 Type: %2 Charge: %3',
                                                 SalesHeader."Shipping Agent Code", SalesHeader."Shipment Method Code", SalesHeader."Shipping Charge")
                                    ELSE
                                        MESSAGE('Verify Payment Terms on SO, Contact Accounting for Approval Code ,Carrier: %1 Type: %2 Charge: %3',
                                                 SalesHeader."Shipping Agent Code", SalesHeader."Shipment Method Code", SalesHeader."Shipping Charge");

                                END ELSE
                                    Page.RUNMODAL(50060, SalesHeader);
                            END ELSE BEGIN
                                Page.RUNMODAL(50060, SalesHeader);
                            END;
                        END ELSE BEGIN
                            MESSAGE('This Sales Order is Linked to Work Order No. %1 that hasn''t been Boxed', WO);
                        END;
                    END ELSE BEGIN
                        MESSAGE('This Sales Order is Linked to Work Order No. %1 that is Closed, Please Contact the Sales Department', WO);
                    END;
                END ELSE BEGIN
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    IF SalesLine.FIND('-') THEN BEGIN
                        ///--!
                        // ,Account (G/L),Item,Resource
                        IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN BEGIN
                            MESSAGE('The Sales Order hasn''t been linked to a Work Order, Contact Sales to Update Order');
                        END ELSE BEGIN
                            IF (SalesHeader."Payment Terms Code" = 'CC') OR (SalesHeader."Payment Terms Code" = 'COD') THEN BEGIN
                                IF SalesHeader."Payment Terms Code" = 'CC' THEN BEGIN
                                    IF SalesHeader."Approval Code" = '' THEN
                                        MESSAGE('Contact Accounting to enter Credit Card Approval Code before Shipping, Carrier: %1 Type: %2 Charge: %3',
                                                 SalesHeader."Shipping Agent Code", SalesHeader."Shipment Method Code", SalesHeader."Shipping Charge")
                                    ELSE
                                        Page.RUNMODAL(50060, SalesHeader);
                                END;
                                IF SalesHeader."Payment Terms Code" = 'COD' THEN BEGIN
                                    IF SalesHeader."Approval Code" = '' THEN
                                        MESSAGE('Contact Accounting to Calculate COD Charges before Shipping, Carrier: %1 Type: %2 Charge: %3',
                                                  SalesHeader."Shipping Agent Code", SalesHeader."Shipment Method Code", SalesHeader."Shipping Charge")
                                    ELSE
                                        Page.RUNMODAL(50060, SalesHeader);
                                END;
                            END ELSE
                                Page.RUNMODAL(50060, SalesHeader);
                        END;
                    END ELSE BEGIN
                        MESSAGE('This Sales Order doesn''t have anything to Ship, Contact Sales to Check Order');
                    END;
                END;
            END ELSE BEGIN
                MESSAGE('Sales Order %1 not found', SO);
            END;
        END;
        OpenNextRecord;
    end;

    var
        NextRecord: Codeunit SOShipping;
        Ok: Boolean;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        SO: Code[20];
        SalesHeader: Record "Sales Header";
        WOD: Record WorkOrderDetail;
        WO: Code[10];
        SalesLine: Record "Sales Line";
        Terms: Code[10];
        Customer: Record Customer;

    procedure OpenNextRecord();
    begin
        IF NOT CONFIRM('Do you want to ship another Sales Order', FALSE) THEN BEGIN
            COMMIT;
            EXIT;
        END ELSE BEGIN
            COMMIT;
            NextRecord.RUN
        END;
    end;
}

