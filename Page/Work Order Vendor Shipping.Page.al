#pragma implicitwith disable
page 50032 "Work Order Vendor Shipping"
{
    // 05/2/18
    //   Container Type control set to field options in table 50001. Make it editable.  
    // 
    // 2021_01_11 Intelice  
    //    Added logic to test for processed shipped orders to stop reprocess and allow printing BOL and Address labels
    //

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1220060011)
            {
                ShowCaption = false;
                field(ShipmentWeight; ShipmentWeight)
                {
                    ApplicationArea = All;
                    Caption = 'Total Shipment Weight';
                }
                field(LabelsToPrint; LabelsToPrint)
                {
                    ApplicationArea = All;
                    Caption = 'Label Quantity';
                }
                field(ContainerType; ContainerType)
                {
                    ApplicationArea = All;
                    Caption = 'Container Type';
                }
                field(TotalContainerQuantity; TotalContainerQuantity)
                {
                    ApplicationArea = All;
                    Caption = 'Total Container Qty';
                }
                field(Shipper; Shipper)
                {
                    ApplicationArea = All;
                    Caption = 'Shippers Initals';
                    TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''));
                }
                field(ShippingTime; ShippingTime)
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Time';
                }
            }
            repeater(Group)
            {
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'WOD';
                    Editable = false;
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Carrier"; Rec."Vendor Carrier")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }
                field("Vendor Shipping Charge"; Rec."Vendor Shipping Charge")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Charge';
                }
                field("Vendor Shipping Method"; Rec."Vendor Shipping Method")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Method';
                }
                field("Vendor Shipping Account"; Rec."Vendor Shipping Account")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Account';
                }
            }
            group(Control1220060018)
            {
                ShowCaption = false;
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address"; Rec."Vendor Address")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address2"; Rec."Vendor Address2")
                {
                    ApplicationArea = All;
                }
                field("Vendor City"; Rec."Vendor City")
                {
                    ApplicationArea = All;
                }
                field("Vendor State"; Rec."Vendor State")
                {
                    ApplicationArea = All;
                }
                field("Vendor Zip"; Rec."Vendor Zip")
                {
                    ApplicationArea = All;
                }
                field("Vendor Ship Weight"; Rec."Vendor Ship Weight")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Container Quantity"; Rec."Vendor Container Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Packaging Location"; Rec."Packaging Location")
                {
                    ApplicationArea = All;
                }
                field("Vendor Package Tracking No."; Rec."Vendor Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field(Packaging; Rec.Packaging)
                {
                    ApplicationArea = All;
                }
                field(Accessories; Rec.Accessories)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print All BOL's")
            {
                ApplicationArea = All;
                Caption = 'Print All BOL''s';
                Enabled = false;
                Visible = false;

                trigger OnAction()
                begin
                    //HEF REMOVED BECAUSE SHOULDN'T NEED

                    /*
                    
                    IF NOT CONFIRM('Do you want to print labels now?',FALSE) THEN BEGIN
                      EXIT;
                    END ELSE BEGIN
                      BOL3.SETRANGE(BOL3."BOL Printed",FALSE);
                      IF BOL3.FIND('-') THEN BEGIN
                        REPEAT
                          BOL3."BOL Printed" := TRUE;
                          BOL3."Label Printed" := TRUE;
                          BOL3.SETRANGE(BOL3."Bill of Lading",BOL3."Bill of Lading");
                          REPORT.RUNMODAL(50016,FALSE,FALSE,BOL3);               // BOL Document
                    
                          LabelCount := BOL3."Label Quantity";
                            REPEAT
                              BEGIN
                                LabelCount := LabelCount -1;
                                REPORT.RUNMODAL(50015,FALSE,FALSE,BOL3);               // Shipping Label
                              END;
                            UNTIL LabelCount = 0;
                    
                          ConfirmBatchLabels;
                       UNTIL BOL3.NEXT = 0;
                      END;
                    END;
                    */

                end;
            }
            group("Print")
            {
                Caption = 'Print';
                Image = PrintForm;

                action(BillOfLading)
                {
                    Caption = 'Bill of Lading';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        // 2021_01_11 Intelice Start
                        if not Rec."Vendor Shipping Processed" then begin
                            Message('You nedd to <Ship> this order to be able to print BOL.');
                            exit;
                        end;
                        // 2021_01_11 Intelice End                        
                        PrintBOL;
                    end;
                }

                action(AddrLabels)
                {
                    Caption = 'Address Labels';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        // 2021_01_11 Intelice Start
                        if not Rec."Vendor Shipping Processed" then begin
                            Message('You nedd to <Ship> this order to be able to print Address Labels.');
                            exit;
                        end;
                        // 2021_01_11 Intelice End                        
                        PrintLabels;
                    end;

                }

            }

            action("&Ship")
            {
                ApplicationArea = All;
                Caption = '&Ship';
                Promoted = true;

                trigger OnAction()
                begin

                    // 2021_01_11 Intelice Start
                    // Test for processed order
                    if Rec."Vendor Shipping Processed" then begin
                        Message('Current Order %1 is already shipped.', Rec."Work Order No.");
                        exit;
                    end;
                    // 2021_01_11 Intelice End

                    if ShipmentWeight = 0 then
                        Error('Shipment Weight must be entered.');

                    if Shipper = '' then
                        Error('Shipper must be entered.');

                    if ShippingTime = 0 then
                        Error('Shipping Time must be entered.');

                    if (Rec."Vendor Name" = '') or (Rec."Vendor Address" = '') or (Rec."Vendor City" = '') or (Rec."Vendor Zip" = '') then
                        Error('All the Shipping information isn''t entered, Please Contact Sales');

                    // Update current record in the DB
                    CurrPage.Update(true);

                    WOD.SetCurrentKey(WOD."Work Order No.");
                    WOD.SetRange(WOD."Work Order No.", Rec."Work Order No.");

                    if WOD.Find('-') then begin
                        NothingToShip := false;
                        if Confirm('Carrier is %1, Method is %2, \' +
                                   'Charge is %3, Account is %4, \' +
                                   'are these correct?', false, WOD."Vendor Carrier", WOD."Vendor Shipping Method",
                                    WOD."Vendor Shipping Charge", WOD."Vendor Shipping Account")
                        then begin
                            if BOL.Find('+') then
                                BLInteger := BOL."Bill of Lading" + 1
                            else
                                BLInteger := 100000;

                            TempCarrier := WOD."Vendor Carrier";
                            TempMethod := WOD."Vendor Shipping Method";
                            TempCharge := WOD."Vendor Shipping Charge";
                            TempAccount := WOD."Vendor Shipping Account";

                            UpdateWOD;
                            UpdateWOS;
                            UpdateParts;
                            CreateBOLRecords;
                            //PrintBOL;
                        end;
                    end;

                    // get the current record
                    //Commit();
                    Rec.Get(Rec."Work Order No.");

                    // 2021_01_11 Intelice Start
                    // Reset WOS Status to Waiting
                    /*
                    WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
                    WOS.Reset();
                    WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
                    if WOS.Find('+') then begin
                        if WOS.Status = WOS.Status::Complete then begin
                            WOS.Status := WOS.Status::Waiting;
                            WOS.Modify(false);
                        end;
                    end;
                    */
                    // Clean Complete Status on WOD to allow page to stay on
                    if not NothingToShip then begin
                        Rec.Complete := false;
                        // Mark current WOD as processed
                        Rec."Vendor Shipping Processed" := true;
                        Rec.Modify();
                    end;
                    // 2021_01_11 Intelice End

                    //CurrPage.Close;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        LabelsToPrint := 1;
    end;

    trigger OnAfterGetRecord()
    begin
        NothingToShip := true;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        WorkOrderDetail.RESET;
        WorkOrderDetail.SETCURRENTKEY("Work Order Master No.");
        WorkOrderDetail.SETRANGE(WorkOrderDetail."Work Order Master No.", Rec."Work Order Master No.");
        IF WorkOrderDetail.FIND('-') THEN BEGIN
            REPEAT
                WorkOrderDetail.Ship := FALSE;
                WorkOrderDetail.MODIFY;
            ///COMMIT;
            UNTIL WorkOrderDetail.NEXT = 0;
        END;
    end;

    var
        NothingToShip: Boolean;
        Window: Dialog;
        WorkOrderDetail: Record WorkOrderDetail;
        Customer: Record Customer;
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOD2: Record WorkOrderDetail;
        PlaceOnLine: Boolean;
        WOS: Record Status;
        Ok: Boolean;
        WOP: Record Parts;
        ShipTo: Record "Ship-to Address";
        ShipmentWeight: Integer;
        Tracking: Text[30];
        Shipper: Code[3];
        ShippingTime: Decimal;
        TempCarrier: Code[20];
        TempMethod: Code[10];
        TempAccount: Code[30];
        TempCharge: Enum ShippingCharge;
        //TempCharge: Option;
        TotalContainerQuantity: Integer;
        POTest: Code[30];
        BOL: Record BillOfLading;
        BOL2: Record BillOfLading;
        BOL3: Record BillOfLading;
        BOLNo: Integer;
        LabelsToPrint: Integer;
        LabelCount: Integer;
        PrintNow: Boolean;
        ContainerType: Enum Container;
        //ContainerType: Option " ",Skid,Box,Crate,Drum,"Skid Box",Loose;
        Item: Record Item;
        SerialNo: Code[20];
        BL: Code[10];
        BLInteger: Integer;
        PartsComplete: Record Parts;

    procedure UpdateWOD()
    begin
        WOD."Vendor Carrier" := TempCarrier;
        WOD."Vendor Shipping Method" := TempMethod;
        WOD."Vendor Shipping Charge" := TempCharge;
        WOD."Vendor Shipping Account" := TempAccount;
        WOD."RMA Ship Date" := WorkDate;
        WOD."Vendor Bill of Lading" := BLInteger;
        WOD."Vendor Package Tracking No." := Tracking;
        WOD."Vendor Ship Weight" := ShipmentWeight;
        WOD."Vendor Container Quantity" := TotalContainerQuantity;
        WOD."Vendor Container" := ContainerType;
        if WOD."Exchange Pump" then begin
            WOD.Complete := true;
            WOD."Ship Date" := WorkDate;
        end else
            WOD."Quote Phase" := WOD."Quote Phase"::"Phase 2";
        WOD.Modify;
    end;

    procedure UpdateWOS()
    begin
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", WOD."Work Order No.");
        if WOD."Exchange Pump" then begin
            WOS.SetRange(WOS.Step, WOS.Step::SHP);
            if WOS.Find('+') then begin
                WOS.Status := WOS.Status::Complete;
                WOS."Date Out" := WorkDate;
                WOS."Regular Hours" := ShippingTime;
                WOS.Employee := Shipper;
            end;
        end else begin
            WOS.SetRange(WOS.Step, WOS.Step::DIS);
            if WOS.Find('+') then begin
                WOS.Status := WOS.Status::Complete;
                WOS."Date Out" := WorkDate;
                WOS."Regular Hours" := ShippingTime;
                WOS.Employee := Shipper;
            end;
        end;
        WOS.Modify;
    end;

    procedure UpdateParts()
    begin
        if WOD."Exchange Pump" then begin
            PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
            PartsComplete.SetRange(PartsComplete."Work Order No.", WOD."Work Order No.");
            if PartsComplete.Find('-') then begin
                repeat
                    PartsComplete.Complete := true;
                    PartsComplete.Modify;
                until PartsComplete.Next = 0;
            end;
        end;
    end;

    procedure CreateBOLRecords()
    begin
        BOL2.Init;
        BOL2."Bill of Lading" := BLInteger;
        BOL2.Type := BOL2.Type::Vendor;
        BOL2."Order No." := WOD."Work Order No.";
        BOL2.Customer := WOD."Customer ID";
        BOL2."PO No." := '';
        BOL2."Ship To Name" := WOD."Vendor Name";
        BOL2."Ship To Address" := WOD."Vendor Address";
        BOL2."Ship To Address2" := WOD."Vendor Address2";
        BOL2."Ship To City" := WOD."Vendor City";
        BOL2."Ship To State" := WOD."Vendor State";
        BOL2."Ship To Zip Code" := WOD."Vendor Zip";
        BOL2.Attention := WOD."Vendor Contact";
        BOL2."Phone No." := WOD."Vendor Phone No.";
        BOL2."Shipping Weight" := ShipmentWeight;
        BOL2."Container Quantity" := TotalContainerQuantity;
        BOL2.Employee := Shipper;
        BOL2."Container Type" := ConvertBOLContainer(ContainerType);
        BOL2.Carrier := TempCarrier;
        BOL2."Shipping Method" := TempMethod;
        BOL2."Shipping Charge" := ConvertBOLShipCharge(TempCharge);
        BOL2."Shipping Account" := TempAccount;
        BOL2."Shipment Date" := WorkDate;
        BOL2."Label Quantity" := LabelsToPrint;
        BOL2."RMA No." := WOD."RMA No.";
        BOL2.Insert;
    end;

    procedure PrintBOL()
    begin
        ///--!
        //Commit;
        if not Confirm('Is Bill of Lading loaded in Printer?', false) then
            if not Confirm('Last Chance, Is Bill of Lading loaded in Printer?', false) then
                //Ok := true;
                Exit;
        //end else begin
        BOL2.Reset;
        BOL2.SetRange("Bill of Lading", Rec."Vendor Bill of Lading");
        if not BOL2.FindFirst() then
            Error('Cannot find BOL %1', Rec."Vendor Bill of Lading");
        ///--! Report
        BOL2."BOL Printed" := false;
        BOL2.Modify(false);
        REPORT.RunModal(50016, false, false, BOL2);               // BOL Document Print 
        BOL2."BOL Printed" := true;
        BOL2.Modify(false);
        /*
        end else begin
            BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
            REPORT.RunModal(50016, false, false, BOL2);               // BOL Document
            BOL2."BOL Printed" := true;
            BOL2.Modify;
            LabelCount := LabelsToPrint;
            if LabelCount > 0 then begin
                repeat
                begin
                    LabelCount := LabelCount - 1;
                    REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                end;
                until LabelCount = 0;
                BOL2."Label Printed" := true;
            end else begin
                BOL2."Label Printed" := false;
            end;
            BOL2.Modify;
            ConfirmLabels;
        end;
        */
    end;

    procedure PrintLabels()
    var
        LabelsPrinted: Boolean;
    begin
        BOL2.Reset();
        BOL2.SetRange("Bill of Lading", Rec."Vendor Bill of Lading");
        if not BOL2.FindFirst() then
            Error('Cannot find BOL %1', Rec."Vendor Bill of Lading");
        BOL2."Label Printed" := false;
        BOL2.Modify(false);

        LabelCount := LabelsToPrint;
        if LabelCount > 0 then begin
            if not Confirm('Is Label Printer ready?', false) then
                if not Confirm('Last Chance, is Label Printer ready?', false) then
                    Exit;
            repeat begin
                LabelCount := LabelCount - 1;
                ///--! Report
                REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
            end until LabelCount = 0;
            LabelsPrinted := true;
        end else
            LabelsPrinted := false;
        BOL2.Get(Rec."Vendor Bill of Lading");
        BOL2."Label Printed" := LabelsPrinted;
        BOL2.Modify;

        //ConfirmLabels;
    end;

    procedure ConfirmLabels()
    begin
        if not Confirm('Did labels print correctly?', false) then begin
            BOL2."BOL Printed" := false;
            BOL2."Label Printed" := false;
            BOL2.Modify;
            if not Confirm('Do you want to reprint?', false) then begin
                Ok := true;
            end else begin
                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                REPORT.RunModal(50016, false, false, BOL2);               // BOL Document
                BOL2."BOL Printed" := true;
                BOL2.Modify;
                LabelCount := LabelsToPrint;
                if LabelCount > 0 then begin
                    repeat
                    begin
                        LabelCount := LabelCount - 1;
                        REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                    end;
                    until LabelCount = 0;
                    BOL2."Label Printed" := true;
                end else begin
                    BOL2."Label Printed" := false;
                end;
                BOL2.Modify;
                ConfirmLabels;
            end;
        end;
    end;

    procedure ConvertBOLContainer(ContainerValue: Enum Container): Enum BOLContainer
    var
        ExitContainer: Enum BOLContainer;
    begin
        case ContainerValue of
            ContainerValue::Skid:
                Exit(ExitContainer::Skid);

            ContainerValue::Box:
                Exit(ExitContainer::Box);

            ContainerValue::Crate:
                Exit(ExitContainer::Crate);

            ContainerValue::Drum:
                Exit(ExitContainer::Drum);

            ContainerValue::"Skid Box":
                Exit(ExitContainer::"Skid Box");

            ContainerValue::Loose:
                Exit(ExitContainer::Loose);
        end;

    end;

    local procedure ConvertBOLShipCharge(ShipCharge: Enum ShippingCharge): Enum BOLShipCharge
    var
        ExitShCharge: Enum BOLShipCharge;
    begin
        ExitShCharge := BOLShipCharge.FromInteger(ShipCharge.AsInteger());
        exit(ExitShCharge);
    end;
}

#pragma implicitwith restore

