page 50032 "Work Order Vendor Shipping"
{
    // 05/2/18
    //   Container Type control set to field options in table 50001. Make it editable.

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
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'WOD';
                    Editable = false;
                }
                field("Model No."; "Model No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Carrier"; "Vendor Carrier")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }
                field("Vendor Shipping Charge"; "Vendor Shipping Charge")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Charge';
                }
                field("Vendor Shipping Method"; "Vendor Shipping Method")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Method';
                }
                field("Vendor Shipping Account"; "Vendor Shipping Account")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Account';
                }
            }
            group(Control1220060018)
            {
                ShowCaption = false;
                field("Vendor Code"; "Vendor Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address"; "Vendor Address")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address2"; "Vendor Address2")
                {
                    ApplicationArea = All;
                }
                field("Vendor City"; "Vendor City")
                {
                    ApplicationArea = All;
                }
                field("Vendor State"; "Vendor State")
                {
                    ApplicationArea = All;
                }
                field("Vendor Zip"; "Vendor Zip")
                {
                    ApplicationArea = All;
                }
                field("Vendor Ship Weight"; "Vendor Ship Weight")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Container Quantity"; "Vendor Container Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Packaging Location"; "Packaging Location")
                {
                    ApplicationArea = All;
                }
                field("Vendor Package Tracking No."; "Vendor Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field(Packaging; Packaging)
                {
                    ApplicationArea = All;
                }
                field(Accessories; Accessories)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
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
            action("&Ship")
            {
                ApplicationArea = All;
                Caption = '&Ship';
                Promoted = true;

                trigger OnAction()
                begin
                    if ShipmentWeight = 0 then
                        Error('Shipment Weight must be entered.');

                    if Shipper = '' then
                        Error('Shipper must be entered.');

                    if ShippingTime = 0 then
                        Error('Shipping Time must be entered.');

                    if ("Vendor Name" = '') or ("Vendor Address" = '') or ("Vendor City" = '') or ("Vendor Zip" = '') then
                        Error('All the Shipping information isn''t entered, Please Contact Sales');

                    WOD.SetCurrentKey(WOD."Work Order No.");
                    WOD.SetRange(WOD."Work Order No.", "Work Order No.");

                    if WOD.Find('-') then begin
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
                            PrintBOL;
                        end;
                    end;

                    CurrPage.Close;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        LabelsToPrint := 1;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        WorkOrderDetail.Reset;
        WorkOrderDetail.SetCurrentKey("Work Order Master No.");
        WorkOrderDetail.SetRange(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
        if WorkOrderDetail.Find('-') then begin
            repeat
                WorkOrderDetail.Ship := false;
                WorkOrderDetail.Modify;
                Commit;
            until WorkOrderDetail.Next = 0;
        end;
    end;

    var
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
        Commit;
        if not Confirm('Is Bill of Lading and Labels loaded in Printers?', false) then begin
            if not Confirm('Last Chance, Is Bill of Lading and Labels loaded in Printers?', false) then begin
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
