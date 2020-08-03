page 50025 "Parts Adjustment"
{
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1220060007)
            {
                ShowCaption = false;
                grid(Control1220060008)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060005)
                    {
                        ShowCaption = false;
                        field("Work Order No."; "Work Order No.")
                        {
                            Editable = false;
                        }
                        field("WOM.Customer"; WOM.Customer)
                        {
                            Caption = 'Customer';
                            Editable = false;
                        }
                        field("WOM.""Date Ordered"""; WOM."Date Ordered")
                        {
                            Caption = 'Order Date';
                            Editable = false;
                        }
                    }
                }
            }
            group(Control1220060011)
            {
                ShowCaption = false;
                grid(Control1220060010)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060009)
                    {
                        ShowCaption = false;
                        field("Model No."; "Model No.")
                        {
                            Editable = false;
                        }
                        field(Description; Description)
                        {
                            Editable = false;
                        }
                        field("Serial No."; "Serial No.")
                        {
                            Editable = false;
                        }
                    }
                }
            }
            part(Partslines; "Parts Adjustment Parts List")
            {
                SubPageLink = "Work Order No." = FIELD("Work Order No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Pump Module Repair")
            {
                Caption = 'Pump Module Repair';
                Visible = PumpModuleVisible;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Remove the Pulled Parts from Inventory & Convert to Pump Module Repair?', false) then begin
                        OK := true;
                    end else begin
                        WOP.Reset;
                        WOP.SetCurrentKey("Work Order No.", "Part No.");
                        WOP.SetRange(WOP."Work Order No.", "Work Order No.");
                        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
                        if WOP.Find('-') then begin
                            repeat
                                if Item.Get(WOP."Part No.") then begin
                                    WOP.CalcFields(WOP."In-Process Quantity");
                                    ReturnInventoryQty := WOP."In-Process Quantity";
                                    RemoveInventoryQty := 0;
                                    if Item."Costing Method" = Item."Costing Method"::Specific then
                                        SerialNo := WOP."Serial No."
                                    else
                                        SerialNo := '';

                                    if ReturnInventoryQty > 0 then begin
                                        ReturnInventoryPM;
                                        if WOP."Pulled Quantity" > 0 then begin
                                            RemoveInventoryQty := WOP."Pulled Quantity";
                                            RemoveInventoryPM;
                                        end;
                                    end;
                                    WOP."In-Process Quantity" := 0;
                                    WOP."Quantity Backorder" := 0;
                                    WOP.Modify;
                                end;
                            until WOP.Next = 0;
                        end;

                        PartsDelete.SetCurrentKey("Work Order No.", "Part No.");
                        PartsDelete.SetRange(PartsDelete."Work Order No.", WOS."Order No.");
                        if PartsDelete.Find('-') then begin
                            PartsDelete.DeleteAll;
                        end;
                        Commit;

                        PartsInsert.Init;
                        PartsInsert."Work Order No." := WOS."Order No.";
                        PartsInsert."Part Type" := PartsInsert."Part Type"::Resource;
                        PartsInsert.Validate("Part No.", '1');
                        PartsInsert.Insert;
                        Commit;

                        PartsInsert.Init;
                        PartsInsert."Work Order No." := WOS."Order No.";
                        PartsInsert."Part Type" := PartsInsert."Part Type"::Resource;
                        PartsInsert.Validate("Part No.", 'PUMP MODULE');
                        PartsInsert."Quoted Quantity" := 1;
                        PartsInsert.Insert;

                        Commit;

                        "Pump Module Processed" := true;
                        "Quote Phase" := "Quote Phase"::"Phase 3";
                        Modify;


                        //Find Shop Labor and Update the Hours Quoted from BOM
                        PartsInsert.Reset;
                        PartsInsert.SetCurrentKey(PartsInsert."Work Order No.", PartsInsert."Part No.");
                        PartsInsert.SetRange(PartsInsert."Work Order No.", "Work Order No.");
                        PartsInsert.SetRange(PartsInsert."Part Type", PartsInsert."Part Type"::Resource);
                        PartsInsert.SetRange(PartsInsert."Part No.", '1');
                        if PartsInsert.Find('-') then begin
                            BOM.SetRange(BOM."Parent Item No.", "Model No.");
                            BOM.SetRange(BOM."No.", '1');
                            if BOM.Find('-') then begin
                                PartsInsert."Quoted Quantity" := BOM."Quantity per";
                                PartsInsert.Modify;
                                PartsInsert.Validate(PartsInsert."Quoted Price");
                            end;
                        end;


                        Message('Pump Module Processed, Please forward Order to Purchasing to Quote the Pump Module');
                        CurrPage.Close;

                    end;
                end;
            }
            action("Reverse Build Ahead for Vendor Repair")
            {
                Caption = 'Reverse Build Ahead for Vendor Repair';
                Visible = VendorRepairVisible;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Remove the Pulled Parts from Inventory?', false) then begin
                        OK := true;
                    end else begin
                        WOP.Reset;
                        WOP.SetCurrentKey("Work Order No.", "Part No.");
                        WOP.SetRange(WOP."Work Order No.", "Work Order No.");
                        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
                        if WOP.Find('-') then begin
                            repeat
                                if Item.Get(WOP."Part No.") then begin
                                    WOP.CalcFields(WOP."In-Process Quantity");
                                    ReturnInventoryQty := WOP."In-Process Quantity";
                                    RemoveInventoryQty := 0;
                                    if Item."Costing Method" = Item."Costing Method"::Specific then
                                        SerialNo := WOP."Serial No."
                                    else
                                        SerialNo := '';

                                    if ReturnInventoryQty > 0 then begin
                                        ReturnInventory;
                                        if WOP."Pulled Quantity" > 0 then begin
                                            PartsConsumed := PartsConsumed + (WOP."Pulled Quantity" * WOP."Quoted Price");
                                            RemoveInventoryQty := WOP."Pulled Quantity";
                                            RemoveInventory;
                                        end;
                                    end;
                                    WOP.Delete;
                                end;
                            until WOP.Next = 0;
                        end;

                        WOP.Reset;
                        WOP.SetCurrentKey("Work Order No.", "Part No.");
                        WOP.SetRange(WOP."Work Order No.", "Work Order No.");
                        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Resource);
                        if WOP.Find('-') then begin
                            repeat
                                WOP.Delete;
                            until WOP.Next = 0;
                        end;

                        WOS.Reset;
                        WOS.SetCurrentKey("Order No.", Step);
                        WOS.SetRange(WOS."Order No.", "Work Order No.");
                        if WOS.Find('-') then begin
                            repeat
                                if WOS.Step.AsInteger() > 1 then begin
                                    "Current Extra Time Used" := "Current Extra Time Used" + WOS."Regular Hours" + WOS."Overtime Hours";
                                    WOS.Delete;
                                end else begin
                                    if WOS.Step = WOS.Step::DIS then begin
                                        WOS."Date Out" := 0D;
                                        WOS."Regular Hours" := 0;
                                        WOS."Overtime Hours" := 0;
                                        WOS.Employee := '';
                                        WOS.Status := WOS.Status::Waiting;
                                        WOS.Modify;
                                    end;
                                end;
                            until WOS.Next = 0;
                        end;

                        if PartsConsumed > 0 then begin
                            PartAdd.Init;
                            PartAdd."Work Order No." := "Work Order No.";
                            PartAdd."Part Type" := PartAdd."Part Type"::Resource;
                            PartAdd."Part No." := 'REQUOTE PARTS';
                            PartAdd."Quoted Quantity" := 1;
                            PartAdd."Quoted Price" := PartsConsumed;
                            PartAdd.Insert;
                        end;

                        "Build Ahead" := false;
                        "Build Ahead Report" := false;
                        "ReUsable Parts Returned" := true;
                        "Quote Phase" := "Quote Phase"::" ";
                        BackorderText := '';
                        "Pump Module No." := '';
                        "Pump Module" := false;
                        "Pump Module Processed" := false;
                        Modify;
                        "Reverse Build Ahead" := false;
                        "Vendor Repair" := true;
                        Validate("Pump Module No.");
                        Modify;
                        CurrPage.Close;
                    end;
                end;
            }
            action("Unrepairable Parts Remove")
            {
                Caption = 'Unrepairable Parts Remove';
                Visible = UnrepairableVisible;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Remove the Pulled Parts from Inventory?', false) then begin
                        OK := true;
                    end else begin
                        WOP.Reset;
                        WOP.SetCurrentKey("Work Order No.", "Part No.");
                        WOP.SetRange(WOP."Work Order No.", "Work Order No.");
                        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
                        if WOP.Find('-') then begin
                            repeat
                                if Item.Get(WOP."Part No.") then begin
                                    WOP.CalcFields(WOP."In-Process Quantity");
                                    ReturnInventoryQty := WOP."In-Process Quantity";
                                    RemoveInventoryQty := 0;
                                    if Item."Costing Method" = Item."Costing Method"::Specific then
                                        SerialNo := WOP."Serial No."
                                    else
                                        SerialNo := '';

                                    if ReturnInventoryQty > 0 then begin
                                        ReturnInventory;
                                        if WOP."Pulled Quantity" > 0 then begin
                                            RemoveInventoryQty := WOP."Pulled Quantity";
                                            RemoveInventory;
                                        end;
                                    end;
                                    WOP."In-Process Quantity" := 0;
                                    WOP."Quantity Backorder" := 0;
                                    WOP.Modify;
                                end;
                            until WOP.Next = 0;
                        end;

                        if ("Unrepairable Handling".AsInteger() < 3) or ("Unrepairable Handling" = "Unrepairable Handling"::"Return to Vendor") then begin
                            if WOS.Status = WOS.Status::Waiting then
                                WOS.Delete;
                            WOS.Reset;
                            WOS.SetCurrentKey("Order No.", Step);
                            WOS.SetRange(WOS."Order No.", "Work Order No.");
                            if WOS.Find('+') then begin
                                WOSSHIP.Init;
                                WOSSHIP."Order No." := WOS."Order No.";
                                WOSSHIP."Line No." := WOS."Line No." + 10000;
                                WOSSHIP.Step := WOS.Step::SHP;
                                WOSSHIP."Date In" := WOS."Date Out";
                                WOSSHIP.Status := WOS.Status::Waiting;
                                WOSSHIP.Insert;
                            end;
                            "ReUsable Parts Returned" := true;
                            Modify;
                        end else begin
                            if WOS.Status = WOS.Status::Waiting then
                                WOS.Delete;
                            UpdateParts;
                            "ReUsable Parts Returned" := true;
                            if ("Unrepairable Charge" <> 0) or ("Freightin Bill Customer" = true) then begin
                                SalesLineNo := 10000;
                                CreateOrder;
                                URCreatelines;
                            end;
                            Complete := true;
                            Modify;
                        end;

                        CurrPage.Close;

                    end;
                end;
            }
            action("Allocate Parts")
            {
                Caption = 'Allocate Parts';

                trigger OnAction()
                begin
                    Parts.SetRange(Parts."Work Order No.", "Work Order No.");
                    PAGE.RunModal(PAGE::"Parts Allocation", Parts);
                end;
            }
            action("Pull Parts")
            {
                Caption = 'Pull Parts';

                trigger OnAction()
                begin
                    Parts.SetCurrentKey("Work Order No.", "Part Type", "Part No.");
                    Parts.SetRange(Parts."Work Order No.", "Work Order No.");
                    if Parts.Find('-') then begin
                        repeat
                            Parts.CalcFields(Parts."In-Process Quantity");
                            if Parts."In-Process Quantity" > 0 then begin
                                Parts."Pulled Quantity" := Parts."In-Process Quantity";
                                Parts.Modify;
                            end;
                        until Parts.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MasterNo := CopyStr("Work Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        WOS.SetCurrentKey("Order No.", Step);
        WOS.SetRange(WOS."Order No.", "Work Order No.");
        if WOS.Find('+') then begin
            if ("Unrepairable BuildAhead" = true) and ("ReUsable Parts Returned" = false) then
                UnrepairableVisible := true
            else
                UnrepairableVisible := false;

            if "Reverse Build Ahead" then
                VendorRepairVisible := true
            else
                VendorRepairVisible := false;
        end;

        if ("Pump Module" = true) and ("Pump Module Processed" = false) then
            PumpModuleVisible := true
        else
            PumpModuleVisible := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        MissingReason := false;
        Parts.Reset;
        Parts.SetCurrentKey("Work Order No.", "Part Type");
        Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
        if Parts.Find('-') then begin
            repeat
                if (Parts."After Quote Quantity" <> 0) and (Parts.Reason = 0) then
                    MissingReason := true;
            until Parts.Next = 0;
        end;

        if MissingReason then begin
            Error('Reason Codes Must be Added Before Exiting Parts Adjustment');
        end;
    end;

    var
        WOM: Record WorkOrderMaster;
        WOS: Record Status;
        WOSSHIP: Record Status;
        MasterNo: Code[7];
        OK: Boolean;
        CustFile: Text[250];
        Parts: Record Parts;
        WOP: Record Parts;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        GPS: Record "General Posting Setup";
        Item: Record Item;
        SerialNo: Code[20];
        RemoveInventoryQty: Decimal;
        ReturnInventoryQty: Decimal;
        PIPQty: Decimal;
        MissingReason: Boolean;
        PartsConsumed: Decimal;
        PartAdd: Record Parts;
        PartsComplete: Record Parts;
        PartsDelete: Record Parts;
        PartsInsert: Record Parts;
        BOM: Record "BOM Component";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        SO: Code[10];
        ShipTo: Record "Ship-to Address";
        Customer: Record Customer;
        SalesLineNo: Integer;
        [InDataSet]
        UnrepairableVisible: Boolean;
        [InDataSet]
        VendorRepairVisible: Boolean;
        [InDataSet]
        PumpModuleVisible: Boolean;

    procedure RemoveInventory()
    begin
        if RemoveInventoryQty > 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'UNREPAIR';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 3; //Negative Adjustment
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'UNREPAIRABLE REMOVE';
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

    procedure RemoveInventoryPM()
    begin
        if RemoveInventoryQty > 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'UNREPAIR';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 3; //Negative Adjustment
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'PUMP MODULE REMOVE';
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

    procedure ReturnInventory()
    begin
        if ReturnInventoryQty > 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'UNREPAIR';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 4; //Transfer
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'UNREPAIRABLE RETURN';
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

    procedure ReturnInventoryPM()
    begin
        if ReturnInventoryQty > 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'UNREPAIR';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := 4; //Transfer
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'PUMP MODULE RETURN';
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

    procedure UpdateParts()
    begin
        PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
        PartsComplete.SetRange(PartsComplete."Work Order No.", WOS."Order No.");
        if PartsComplete.Find('-') then begin
            repeat
                PartsComplete.Complete := true;
                PartsComplete.Modify;
            until PartsComplete.Next = 0;
        end;
    end;

    procedure InitSalesHeaderRecord()
    begin
        if (SalesHeader."No. Series" <> '') and
           (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
        then
            SalesHeader."Posting No. Series" := SalesHeader."No. Series"
        else
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
        if SalesSetup."Shipment on Invoice" then
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
    end;

    procedure CreateOrder()
    begin
        WOM.Get("Work Order Master No.");
        Clear(SalesHeader);

        SalesHeader.Init;
        SalesSetup.Get;

        if SalesHeader."No." = '' then begin
            // INSERTED 3/21/01 HEF
            if SO <> '' then
                SalesHeader."No." := SO
            else
                SalesHeader."No." := "Work Order No.";
        end;

        // BOL FIX
        // HEF  NoSeriesMgt.InitSeries
        // HEF  (SalesSetup."Order Nos.",SalesHeader."No. Series",TODAY,SalesHeader."No.",SalesHeader."No. Series");

        InitSalesHeaderRecord;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Validate("Sell-to Customer No.", WOM.Customer);
        ShipTo.Get(SalesHeader."Sell-to Customer No.", WOM."Ship To Code");
        SalesHeader.Validate("Posting Date", Today);
        SalesHeader."Order Date" := "Work Order Date";
        SalesHeader."Ship-to Code" := WOM."Ship To Code";
        SalesHeader."Ship-to Name" := "Ship To Name";
        SalesHeader."Ship-to Address" := "Ship To Address 1";
        SalesHeader."Ship-to Address 2" := "Ship To Address 2";
        SalesHeader."Ship-to City" := "Ship To City";
        SalesHeader."Ship-to County" := "Ship To State";
        SalesHeader."Ship-to Post Code" := "Ship To Zip Code";
        SalesHeader."Ship-to Contact" := Attention;
        SalesHeader."Document Date" := Today;
        SalesHeader."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
        SalesHeader."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
        //SalesHeader.Rep := ShipTo.Rep;
        SalesHeader."Salesperson Code" := ShipTo."Inside Sales";
        SalesHeader."Payment Terms Code" := "Payment Terms";
        //SalesHeader."Card Type" := "Card Type";
        //SalesHeader."Credit Card No." := "Credit Card No.";
        //SalesHeader."Credit Card Exp." := "Credit Card Exp.";
        //SalesHeader."Approval Code" := "Approval Code";
        SalesHeader."Shipment Date" := Today;
        SalesHeader."Shipment Method Code" := '';
        SalesHeader."Shipping Agent Code" := '';
        //SalesHeader."Shipping Charge" := 0;
        //SalesHeader."Shipping Account" := '';
        SalesHeader."Package Tracking No." := '';
        //SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice" :: "Ship Complete";
        SalesHeader."Your Reference" := "Customer PO No.";

        if "Tax Liable" = true then begin
            SalesHeader."Tax Liable" := true;
            SalesHeader."Tax Area Code" := 'MD';
        end else begin
            SalesHeader."Tax Liable" := false;
            SalesHeader."Tax Area Code" := '';
        end;

        if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
            if "Tax Liable" = false then begin
                SalesHeader."Tax Exemption No." := Customer."Tax Exemption No.";
                //SalesHeader."Exempt Organization" :=  Customer."Exempt Organization";
            end;
        end else begin
            SalesHeader."Tax Exemption No." := '';
            //SalesHeader."Exempt Organization" :=  '';
        end;

        SalesHeader."Shortcut Dimension 2 Code" := 'WO';
        SalesHeader.Insert;
    end;

    procedure URCreatelines()
    begin
        if ("Unrepairable Charge" > 0) or ("Freightin Bill Customer" = true) then begin

            //>> Work Order No. & Order Type
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.Validate("No.", '');
            SalesLine.Description := "Work Order No." + ' ' + Format("Order Type");
            // + 'Total Price: ' + FORMAT(ROUND("Quote Price")); //REMOVED PER BLF 6/12/01
            //SalesLine."Commission Calculated" := FALSE;
            //SalesLine."Cross Reference Item" := "Model No.";
            SalesLine.Insert;

            //>> Description
            if Description <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := Description;
                //SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;

            //>> Serial No. Info
            if "Serial No." <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := 'S/N' + ' ' + "Serial No.";
                //SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;

            //>>Customer Part Number
            if "Customer Part No." <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := 'Customer P/N' + ' ' + "Customer Part No.";
                //SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;


            //UnRepairable Charge
            if "Unrepairable Charge" > 0 then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                GPSLoop;
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'UnRepairable Charge';
                SalesLine."Unit Price" := "Unrepairable Charge";
                SalesLine.Validate("Unit Price");
                //SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
            end;

            //InBound Freight Charge
            if "Freightin Bill Customer" = true then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine.Validate("No.", '312');   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Inbound Freight Charge';
                SalesLine.Validate("Unit Price", Freightin);
                //SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;
        end;
    end;

    procedure LineLoop()
    begin
        Clear(SalesLine);
        SalesLineNo := SalesLineNo + 10000;
        SalesLine.Init;
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Line No." := SalesLineNo;
        SalesLine.Validate(SalesLine."Document No.", SalesHeader."No.");
    end;

    procedure GPSLoop()
    begin
        if ("Income Code".AsInteger() = 1) then begin
            GPS.Get('', 'REPAIR');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if ("Income Code".AsInteger() = 2) then begin
            GPS.Get('', 'PP SALES');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if ("Income Code".AsInteger() = 3) then begin
            GPS.Get('', 'TURBO');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if ("Income Code".AsInteger() = 4) then begin
            GPS.Get('', 'ELECTRONIC');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if ("Income Code".AsInteger() = 5) then begin
            GPS.Get('', 'DRY PUMP');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if ("Income Code".AsInteger() = 6) then begin
            GPS.Get('', 'CRYO');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
    end;
}

