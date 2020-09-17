page 50141 "Credit Memo Shipping"
{
    // 05/2/18
    //   ContainerType control set to field options in table 50001.

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Purchase Header";
    SourceTableView = SORTING("Document Type", "Location Code", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            group(Shipping)
            {
                group(Control1220060024)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Name"; "Ship-to Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Address"; "Ship-to Address")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Address 2"; "Ship-to Address 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to City"; "Ship-to City")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to County"; "Ship-to County")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Post Code"; "Ship-to Post Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Contact"; "Ship-to Contact")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Phone No."; "Phone No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to UPS Zone"; "Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Control1220060025)
                {
                    ShowCaption = false;
                    field(Shipper; Shipper)
                    {
                        ApplicationArea = All;
                        Caption = 'Shippers Initals';
                        TableRelation = Resource."No." WHERE(Type = CONST(Person));
                    }
                    field(ShippingTime; ShippingTime)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Time';
                    }
                    field(ShippingWeight; ShippingWeight)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment Weight';
                    }
                    field(ContainerQuantity; ContainerQuantity)
                    {
                        ApplicationArea = All;
                        Caption = 'Total Containers';
                    }
                    field(ContainerType; ContainerType)
                    {
                        ApplicationArea = All;
                        Caption = 'Container Type';
                    }
                    field(LabelCount; LabelCount)
                    {
                        ApplicationArea = All;
                        Caption = 'Label Quantity';
                    }
                    field("Shipping Agent"; "Shipping Agent")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipment Method Code"; "Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Account"; "Shipping Account")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Charge"; "Shipping Charge")
                    {
                        ApplicationArea = All;
                    }
                    field("Package Tracking No."; "Package Tracking No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill of Lading"; "Bill of Lading")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
            part(PurchLines; "Credit Memo Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print &BOL and Labels")
            {
                ApplicationArea = All;
                Caption = 'Print &BOL and Labels';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Ship: Codeunit Shipping;

                begin
                    WorkOrderCount := 0;

                    if "Your Reference" = '' then
                        Error('Customer PO Number must be Entered');

                    if Shipper = '' then
                        Error('Shippers Initials must be Entered');

                    if ShippingTime = 0 then
                        Error('Shipping Time must be Entered');

                    if ShippingWeight = 0 then
                        Error('Shipment Weight must be Entered');

                    if ContainerQuantity = 0 then
                        Error('Total Containers must be Entered');

                    if ContainerType = ContainerType::" " then
                        Error('Container Type must be Entered');

                    if "Shipping Agent" = '' then
                        Error('Shipping Agent must be Entered');

                    if "Shipment Method Code" = '' then
                        Error('Shipment Method Code must be Entered');

                    if "Shipping Charge" = "Shipping Charge"::" " then
                        Error('Shipping Charge must be Entered');

                    // Check Items with Serial Numbers because then it may be a pump on a Work Order which will need to be closed
                    PurchaseLine2.SetRange("Document Type", "Document Type");
                    PurchaseLine2.SetRange("Document No.", "No.");
                    PurchaseLine2.SetFilter(Quantity, '<>%1', 0);
                    if PurchaseLine2.Find('-') then begin
                        repeat
                            Defective := 0;
                            if Item2.Get(PurchaseLine2."No.") then begin
                                if Item2."Costing Method" = Item2."Costing Method"::Specific then begin
                                    //        IF PurchaseLine2."Serial No." = '' THEN BEGIN
                                    //          ERROR('Item %1 Serial No. is blank, so the Item can not be shipped, Contact Purchasing',PurchaseLine2."No.");
                                    //        END ELSE BEGIN
                                    ItemLedgerSerial.SetCurrentKey("Item No.", Open, "Serial No.", "Location Code");
                                    ItemLedgerSerial.SetRange("Item No.", Item2."No.");
                                    ItemLedgerSerial.SetRange(ItemLedgerSerial.Open, true);
                                    //          ItemLedgerSerial.SETRANGE("Serial No.",PurchaseLine2."Serial No.");
                                    if ItemLedgerSerial.Find('-') then begin
                                        //Search Work Orders for a Matching Serial Number
                                        //            WOD.SETRANGE(WOD."Serial No.",PurchaseLine2."Serial No.");
                                        WOD.SetRange(WOD.Complete, false);
                                        if WOD.Find('+') then begin
                                            WOD.CalcFields(WOD."Detail Step");
                                            //Verify Work Order Detail is in Shipping and ready to be closed
                                            if WOD."Detail Step" = WOD."Detail Step"::SHP then begin
                                                WorkOrderCount := WorkOrderCount + 1;
                                                WorkOrderNo[WorkOrderCount] := WOD."Work Order No.";
                                            end else begin
                                                Error('Work Order %1 isn''t currently in shipping, Please contact Shop Manager', WOD."Work Order No.");
                                            end;
                                            //SINCE WORK ORDER NOT FOUND THEN THE ITEM SHOULD BE IN DEFECTIVE
                                        end else begin
                                            if ItemLedgerSerial."Location Code" <> 'DEFECTIVE' then begin
                                                Error('Item %1 Serial No. %2 needs to be moved to Defective, Contact Purchasing', Item2."No.", DefectiveInventoryQty."Serial No.");
                                            end;
                                        end;
                                    end else begin
                                        //            ERROR('Item %1 with Serial NO. %2 isn''t on Inventory, Contact Purchasing',Item2."No.",PurchaseLine2."Serial No.");
                                    end;
                                end;

                                // If the item is not a Pump then it needs to be in Defective Inventory before it ships
                            end else begin
                                DefectiveInventoryQty.SetCurrentKey("Item No.", "Location Code", "Variant Code", "Document No.");
                                DefectiveInventoryQty.SetRange("Item No.", Item2."No.");
                                DefectiveInventoryQty.SetRange("Location Code", 'Defective');
                                if DefectiveInventoryQty.Find('-') then begin
                                    repeat
                                        Defective := Defective + DefectiveInventoryQty.Quantity;
                                    until DefectiveInventoryQty.Next = 0;
                                end;

                                if PurchaseLine2.Quantity > Defective then
                                    Error('Item %1 only has %2 in Defective Inventory, Contact Purchasing', Item2."No.", Defective);
                            end;
                        //    END;
                        until PurchaseLine2.Next = 0;
                    end;

                    PurchaseLine2.Reset;


                    //Create Bill of Lading Record
                    if BOL.Find('+') then
                        BLInteger := BOL."Bill of Lading" + 1
                    else
                        BLInteger := 100000;

                    BOL2.Init;
                    BOL2."Bill of Lading" := BLInteger;
                    BOL2.Type := BOL2.Type::"Credit Memo";
                    BOL2."Order No." := "No.";
                    BOL2."PO No." := "Your Reference";
                    BOL2.Customer := "Sell-to Customer No.";
                    BOL2."Ship To Name" := "Ship-to Name";
                    BOL2."Ship To Address" := "Ship-to Address";
                    BOL2."Ship To Address2" := "Ship-to Address 2";
                    BOL2."Ship To City" := "Ship-to City";
                    BOL2."Ship To State" := "Ship-to County";
                    BOL2."Ship To Zip Code" := "Ship-to Post Code";
                    BOL2.Attention := "Ship-to Contact";
                    BOL2."Phone No." := "Phone No.";
                    BOL2."Shipping Weight" := ShippingWeight;
                    BOL2."Container Quantity" := ContainerQuantity;
                    BOL2."Container Type" := Ship.ContainerToBOLContainer(ContainerType);
                    BOL2.Employee := Shipper;
                    BOL2."Shipment Date" := Today;
                    BOL2.Carrier := "Shipping Agent";
                    BOL2."Shipping Method" := "Shipment Method Code";
                    BOL2."Shipping Charge" := BOL2."Shipping Charge";
                    BOL2."Shipping Account" := "Shipping Account";
                    BOL2."Label Quantity" := LabelsToPrint;
                    BOL2.Insert;

                    //Update Credit Memo
                    "Bill of Lading" := BOL2."Bill of Lading";
                    "Shipment Date" := Today;
                    Modify;
                    Commit;


                    //Update Work Orders when Pumps are returned to Vendors
                    if WorkOrderCount > 0 then begin
                        WorkOrderCount2 := 0;
                        repeat
                            WorkOrderCount2 := WorkOrderCount2 + 1;
                            WorkOrderFind := WorkOrderNo[WorkOrderCount2];
                            "WOD UPDATE".Reset;
                            WOS.Reset;
                            PartsComplete.Reset;
                            "WOD UPDATE".SetRange("WOD UPDATE"."Work Order No.", WorkOrderFind);
                            if "WOD UPDATE".Find('-') then begin
                                WOP.Reset;
                                WOP.SetCurrentKey("Work Order No.", "Part No.");
                                WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
                                WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
                                if WOP.Find('-') then begin
                                    repeat
                                        //Return & Remove Parts and Move Defective Pumps to Defective Inventory
                                        if WOP."Pulled Quantity" > 0 then begin
                                            if Item.Get(WOP."Part No.") then begin
                                                WOP.CalcFields(WOP."In-Process Quantity");
                                                if Item."Costing Method" = Item."Costing Method"::Specific then begin
                                                    //IF the Pump was a Build Ahead Then the pump will be moved from In Process to Defective
                                                    if WOP."In-Process Quantity" > 0 then begin
                                                        MoveInventoryCM;
                                                        WOP."In-Process Quantity" := 0;
                                                        WOP.Modify;
                                                    end;
                                                end else begin
                                                    ReturnInventoryCM;
                                                    RemoveInventoryCM;
                                                    WOP."In-Process Quantity" := 0;
                                                    WOP.Modify;
                                                end;
                                            end;
                                            //Move Defective Pumps that weren't Build Aheads from Main to Defective
                                        end else begin
                                            if Item."Costing Method" = Item."Costing Method"::Specific then
                                                MoveInventoryDefective;
                                        end;
                                    until WOP.Next = 0;
                                end;

                                UpdateWODCM;
                                UpdatePartsCM;
                                UpdateWOSCM;

                            end else begin
                                Message('ORDER NOT FOUND %1', WorkOrderFind);
                            end;
                        until WorkOrderCount = WorkOrderCount2;
                    end;


                    //Print Bill of Lading and Shipping Labels
                    if not Confirm('Is Bill of Lading and Labels loaded in Printers?', false) then begin
                        if not Confirm('Last Chance, Is Bill of Lading and Labels loaded in Printers?', false) then begin
                            OK := true;
                        end else begin
                            BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                            REPORT.RunModal(50140, false, false, BOL2);               // BOL Document
                            BOL2."BOL Printed" := true;
                            BOL2.Modify;
                            LabelCount := LabelsToPrint;
                            repeat
                            begin
                                LabelCount := LabelCount - 1;
                                REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                            end;
                            until LabelCount = 0;
                            BOL2."Label Printed" := true;
                            BOL2.Modify;
                            ConfirmLabelsCM;
                        end;
                    end else begin
                        BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                        REPORT.RunModal(50140, false, false, BOL2);               // BOL Document
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
                        ConfirmLabelsCM;
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

    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchaseLine: Record "Purchase Line";
        ReservationEntry: Record "Reservation Entry";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        QuantityReserved: Decimal;
        OrderComplete: Boolean;
        OrderReserved: Boolean;
        Location: Record Location;
        PrintPick: Integer;
        PickComplete: Boolean;
        NothingPicked: Boolean;
        ShippingWeight: Decimal;
        ContainerQuantity: Integer;
        ContainerType: Enum Container;
        Shipper: Code[3];
        LabelsToPrint: Integer;
        Window: Dialog;
        LabelCount: Integer;
        ShippingTime: Decimal;
        BOL: Record BillofLading;
        BOL2: Record BillofLading;
        BLInteger: Integer;
        SerialNo: Code[20];
        OK: Boolean;
        PurchaseLine2: Record "Purchase Line";
        Item2: Record Item;
        ItemLedgerSerial: Record "Item Ledger Entry";
        DefectiveInventoryQty: Record "Item Ledger Entry";
        Defective: Decimal;
        WorkOrderNo: array[999] of Code[10];
        WorkOrderCount: Integer;
        WorkOrderCount2: Integer;
        WorkOrderFind: Code[10];
        WOD: Record WorkOrderDetail;
        "WOD UPDATE": Record WorkOrderDetail;
        ReturnInventoryQty: Decimal;
        RemoveInventoryQty: Decimal;
        MoveInventoryQty: Decimal;
        WOS: Record Status;
        WOP: Record Parts;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        PartsComplete: Record Parts;
        Item: Record Item;

    procedure ConfirmLabelsCM()
    begin
        if not Confirm('Did Bill of Lading & labels print correctly?', false) then begin
            BOL2."BOL Printed" := false;
            BOL2."Label Printed" := false;
            BOL2.Modify;
            if not Confirm('Do you want to reprint?', false) then begin
                OK := true;
            end else begin
                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                REPORT.RunModal(50140, false, false, BOL2);               // BOL Document
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
                ConfirmLabelsCM;
            end;
        end;
    end;

    procedure UpdateWODCM()
    begin
        "WOD UPDATE"."Vendor Carrier" := "Shipping Agent";
        "WOD UPDATE"."Vendor Shipping Method" := "Shipment Method Code";
        "WOD UPDATE"."Vendor Shipping Charge" := "Shipping Charge";
        "WOD UPDATE"."Vendor Shipping Account" := "Shipping Account";
        "WOD UPDATE"."Vendor Container" := ContainerType;
        "WOD UPDATE"."Vendor Container Quantity" := ContainerQuantity;
        "WOD UPDATE"."Vendor Ship Weight" := ShippingWeight;
        "WOD UPDATE"."RMA PO No." := "Your Reference";
        "WOD UPDATE"."Ship Date" := WorkDate;
        "WOD UPDATE".Complete := true;
        "WOD UPDATE"."Vendor Bill of Lading" := BLInteger;
        "WOD UPDATE"."Vendor Package Tracking No." := "Package Tracking No.";
        "WOD UPDATE"."Vendor Code" := "Ship-to Code";
        "WOD UPDATE"."Vendor Name" := "Ship-to Name";
        "WOD UPDATE"."Vendor Address" := "Ship-to Address";
        "WOD UPDATE"."Vendor Address2" := "Ship-to Address 2";
        "WOD UPDATE"."Vendor City" := "Ship-to City";
        "WOD UPDATE"."Vendor State" := "Ship-to County";
        "WOD UPDATE"."Vendor Zip" := "Ship-to Post Code";
        "WOD UPDATE"."Vendor Contact" := "Ship-to Contact";
        "WOD UPDATE"."Vendor Phone No." := "Phone No.";
        "WOD UPDATE".Modify;
    end;

    procedure UpdateWOSCM()
    begin
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", "WOD UPDATE"."Work Order No.");
        if WOS.Find('+') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS."Regular Hours" := ShippingTime;
            WOS.Employee := Shipper;
            WOS.Modify;
        end;
    end;

    procedure UpdatePartsCM()
    begin
        PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
        PartsComplete.SetRange(PartsComplete."Work Order No.", "WOD UPDATE"."Work Order No.");
        if PartsComplete.Find('-') then begin
            repeat
                PartsComplete.Complete := true;
                PartsComplete.Modify;
            until PartsComplete.Next = 0;
        end;
    end;

    procedure ReturnInventoryCM()
    begin
        ReturnInventoryQty := WOP."Pulled Quantity";
        if ReturnInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 4; //Transfer
                ItemJournalLine."Document No." := WOP."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := WOP."Work Order No." + ' ' + 'CREDIT RETURN PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := ReturnInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'MAIN';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure RemoveInventoryCM()
    begin
        RemoveInventoryQty := WOP."Pulled Quantity";
        if RemoveInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'WARRANTY';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 3; //Negative Adjustment
                ItemJournalLine."Document No." := "WOD UPDATE"."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "WOD UPDATE"."Work Order No." + ' ' + 'CREDIT MEMO';
                ItemJournalLine."Location Code" := 'MAIN';
                ItemJournalLine.Quantity := RemoveInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure MoveInventoryCM()
    begin
        MoveInventoryQty := WOP."Pulled Quantity";
        if MoveInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 4; //Transfer
                ItemJournalLine."Document No." := WOP."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := WOP."Work Order No." + ' ' + 'DEFECTIVE PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := MoveInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'DEFECTIVE';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure MoveInventoryDefective()
    begin
        MoveInventoryQty := WOP."Quoted Quantity";
        if MoveInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 4; //Transfer
                ItemJournalLine."Document No." := WOP."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := WOP."Work Order No." + ' ' + 'DEFECTIVE PARTS';
                ItemJournalLine."Location Code" := 'MAIN';

                ItemJournalLine.Quantity := MoveInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'DEFECTIVE';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;
}

