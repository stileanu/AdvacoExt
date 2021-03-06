#pragma implicitwith disable
page 50060 "Sales Order Shipping"
{
    // 2021_01_11 Intelice  
    //    Added logic to test for processed shipped orders to stop reprocess and allow printing BOL and Address labels
    //

    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "Location Code", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Order),
                            "Shortcut Dimension 2 Code" = FILTER('' | 'SO'));

    layout
    {
        area(content)
        {
            group(Shipping)
            {
                group(Control1220060030)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            if Rec.AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field("Work Order No."; Rec."Work Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Code"; Rec."Ship-to Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to County"; Rec."Ship-to County")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Your Reference"; Rec."Your Reference")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer P.O Number';
                        Editable = false;
                    }
                }
                group(Control1220060031)
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
                    field(LabelsToPrint; LabelsToPrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Label Quantity';
                    }
                    field("Shipping Agent Code"; Rec."Shipping Agent Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipment Method Code"; Rec."Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Account"; Rec."Shipping Account")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Charge"; Rec."Shipping Charge")
                    {
                        ApplicationArea = All;
                    }
                    field("Package Tracking No."; Rec."Package Tracking No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill of Lading"; Rec."Bill of Lading")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(SalesLines; "Sales Order Shipping Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            //action("Print &BOL and Labels")
            action(ProcessOrder)
            {
                ApplicationArea = All;
                Caption = 'Process Order for Shipping';
                //Visible = true;

                trigger OnAction()
                var
                    Ship: Codeunit Shipping;
                    PurchLine: Record "Purchase Line";

                begin

                    // 2021_01_11 Intelice Start
                    // Test for processed order
                    if Rec."Shipping Processed" then begin
                        Message('Current Order %1 is already processed. You cannot process it.', Rec."No.");
                        exit;
                    end;
                    if Rec."Bill of Lading" <> 0 then
                        Error('Order %1 was already processed for shipping.', Rec."No.");
                    // 2021_01_11 Intelice End

                    if Rec."Your Reference" = '' then
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

                    if Rec."Shipping Agent Code" = '' then
                        Error('Shipping Agent Code must be Entered');

                    if Rec."Shipment Method Code" = '' then
                        Error('Shipment Method Code must be Entered');

                    if Rec."Shipping Charge" = Rec."Shipping Charge"::" " then
                        Error('Shipping Charge must be Entered');

                    QtyOil := 0;
                    SalesSetup.Get;
                    CurrPage.Update(true);

                    //99999
                    // Check for Serial No for Pumps
                    SalesLine2.SetRange("Document Type", Rec."Document Type");
                    SalesLine2.SetRange("Document No.", Rec."No.");
                    SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);

                    IF SalesLine2.FIND('-') THEN BEGIN
                        REPEAT
                            Main := 0;
                            IF Item2.GET(SalesLine2."No.") THEN BEGIN
                                IF Item2."Costing Method" = Item."Costing Method"::Specific THEN BEGIN
                                    /// 1/19/2021 ICE Start
                                    /// FindReservEntry(SalesLine: Record "Sales Line"; var ReservEntry: Record "Reservation Entry"): Boolean
                                    TrackingSpecificationExists :=
                                        ReserveSalesLine.FindReservEntry(SalesLine2, ReservationEntry);
                                    if not TrackingSpecificationExists then
                                        //if not WOD.GetSerialNo_(Database::"Item Ledger Entry", SalesLine2, PurchLine, SerialNo_) then
                                        ERROR('Item %1 Serial No. is missing, so the Item can not be shipped', SalesLine2."No.");
                                    SerialNo_ := ReservationEntry."Serial No.";
                                    /// 1/19/2021 ICE End
                                    IF SerialNo_ = '' THEN
                                        ERROR('Item %1 Serial No. is empty, so the Item can not be shipped', SalesLine2."No.");
                                    /// 1/19/2021 ICE Start
                                    /*   
                                    IF SerialNo_ <> '' THEN BEGIN
                                        ItemLedgerSerial.SETCURRENTKEY("Item No.", Open, "Location Code");
                                        ItemLedgerSerial.SETRANGE("Item No.", Item2."No.");
                                        ItemLedgerSerial.SETRANGE(ItemLedgerSerial.Open, TRUE);
                                        ItemLedgerSerial.SETRANGE("Serial No.", SerialNo_);
                                        ItemLedgerSerial.SETRANGE("Location Code", 'MAIN');
                                        IF ItemLedgerSerial.FIND('-') THEN BEGIN
                                            OK := TRUE;
                                        END ELSE BEGIN
                                            ERROR('Item %1 Serial No. %2 hasn''t been received, Contact Purchasing', Item2."No.", SerialNo_);
                                        END;
                                    END;
                                    */
                                    /// 1/19/2021 ICE End
                                END ELSE BEGIN
                                    /* -- ADV 11/30/15
                                    MainInventoryQty.SETCURRENTKEY("Item No.", "Location Code", "Variant Code", "Document No.");
                                            MainInventoryQty.SETRANGE("Item No.", Item2."No.");
                                            MainInventoryQty.SETRANGE("Location Code", 'Main');
                                            IF MainInventoryQty.FIND('-') THEN BEGIN
                                                REPEAT
                                                    Main := Main + MainInventoryQty.Quantity;
                                                UNTIL MainInventoryQty.NEXT = 0;
                                            END;
                                    */
                                    Item2."Location Filter" := 'MAIN';
                                    Item2.CALCFIELDS(Inventory);

                                    //IF SalesLine2."Qty. to Ship" > Main THEN
                                    IF SalesLine2."Qty. to Ship" > Item2.Inventory THEN
                                        ERROR('Item %1 only has %2 in Inventory, Contact Purchasing', Item2."No.", Main);
                                END;
                            END;
                        UNTIL SalesLine2.NEXT = 0;
                    END;

                    SalesLine2.RESET;

                    // Checks Serial No for Work Orders Sold on Sales Orders
                    IF Rec."Work Order No." <> '' THEN BEGIN
                        SalesLine2.SETRANGE("Document Type", Rec."Document Type");
                        SalesLine2.SETRANGE("Document No.", Rec."No.");
                        if SalesLine2.FIND('-') THEN BEGIN
                            /// 1/19/2021 ICE Start
                            TrackingSpecificationExists :=
                                ReserveSalesLine.FindReservEntry(SalesLine2, ReservationEntry);
                            if not TrackingSpecificationExists then
                                //if not WOD.GetSerialNo_(Database::"Sales Line", SalesLine2, PurchLine, SerialNo_) then
                                //IF SalesLine2.FIND('-') THEN BEGIN
                                //    IF SerialNo = '' THEN
                                ERROR('Item %1 Serial No. is blank, so the Item can not be shipped', SalesLine2."Cross Reference Item");
                            SerialNo_ := ReservationEntry."Serial No.";
                            /// 1/19/2021 ICE End
                            if SerialNo_ = '' then
                                ERROR('Item %1 Serial No. is blank, so the Item can not be shipped', SalesLine2."Cross Reference Item");
                        end;
                    END;

                    // Check Qty to Ship against Order Quantiy and Shipped Qty
                    SalesLine2.Reset;
                    SalesLine2.SetRange("Document Type", Rec."Document Type");
                    SalesLine2.SetRange("Document No.", Rec."No.");
                    SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                    if SalesLine2.Find('-') then begin
                        repeat
                            if Item2.Get(SalesLine2."No.") then begin
                                if SalesLine2."Qty. to Ship" + SalesLine2."Shipped Qty." > SalesLine2.Quantity then begin
                                    QtyOver := 0;
                                    QtyOver := SalesLine2."Shipped Qty." + SalesLine2."Qty. to Ship" - SalesLine2.Quantity;
                                    Error('Item %1 Current Qty. to Ship and Shipped Qty. exceeds the Order Quantity by %2, Contact Sales or reduce Shipment Qty'
                                         , Item2."No.", QtyOver);
                                end;

                            end;
                        until SalesLine2.Next = 0;
                    end;

                    // Check for UPS Shipping Surcharge Items
                    if Rec."Shipping Agent Code" = 'UPS' then begin
                        //Removed "Pre-Paid" 11/1/04 per Darleen
                        if (Rec."Shipping Charge" = Rec."Shipping Charge"::"Pre-Paid & Add") then begin
                            SalesLine2.Reset;
                            SalesLine2.SetRange("Document Type", Rec."Document Type");
                            SalesLine2.SetRange("Document No.", Rec."No.");
                            SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                            if SalesLine2.Find('-') then begin
                                repeat
                                    if Item2.Get(SalesLine2."No.") then begin
                                        if Item2."UPS Shipping Surcharge" = true then begin
                                            QtyOil := QtyOil + SalesLine2."Qty. to Ship"
                                        end;
                                    end;
                                until SalesLine2.Next = 0;
                            end;
                        end;
                    end;

                    // Update Shipped Qty
                    SalesLine2.Reset;
                    SalesLine2.SetRange("Document Type", Rec."Document Type");
                    SalesLine2.SetRange("Document No.", Rec."No.");
                    SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                    if SalesLine2.Find('-') then begin
                        repeat
                            if Item2.Get(SalesLine2."No.") then begin
                                SalesLine2."Shipped Qty." := SalesLine2."Qty. to Ship" + SalesLine2."Shipped Qty.";
                                SalesLine2.Modify;
                            end;
                        until SalesLine2.Next = 0;
                    end;

                    // Find the last Sales Line
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    if SalesLine.Find('+') then
                        SalesLineNo := SalesLine."Line No.";

                    //UPS HANDLING
                    if Rec."Shipping Agent Code" = 'UPS' then begin
                        //Removed "Pre-Paid" 11/1/04 per Darleen
                        if (Rec."Shipping Charge" = Rec."Shipping Charge"::"Pre-Paid & Add") then begin
                            LineLoop;
                            SalesLine.Type := SalesLine.Type::"G/L Account";
                            SalesLine.Validate("No.", '311');   //Sales Account
                            SalesLine.Validate(Quantity, 1);
                            SalesLine.Description := 'Handling Charge';
                            SalesLine.Validate("Unit Price", SalesSetup."UPS Handling Charge");
                            SalesLine."Commission Calculated" := false;
                            SalesLine.Insert;
                        end;
                    end;

                    //UPS SHIPPING
                    if Rec."Shipping Agent Code" = 'UPS' then begin
                        if (Rec."Shipping Charge" = Rec."Shipping Charge"::"Pre-Paid & Add") then begin
                            LineLoop;
                            SalesLine.Type := SalesLine.Type::"G/L Account";
                            SalesLine.Validate("No.", '312');   //Sales Account
                            SalesLine.Validate(Quantity, 1);
                            SalesLine.Description := 'UPS Shipping Charge';
                            SalesLine."Commission Calculated" := false;
                            SalesLine.Insert;
                        end;
                    end;

                    //UPS Oil SHIPPING
                    if QtyOil > 0 then begin
                        LineLoop;
                        SalesLine.Type := SalesLine.Type::"G/L Account";
                        SalesLine.Validate("No.", '312');   //Sales Account
                        SalesLine.Validate(SalesLine."Unit Price", SalesSetup."UPS Shipping Surcharge");
                        SalesLine.Validate(Quantity, QtyOil);
                        SalesLine.Description := 'UPS Container Surcharge';
                        SalesLine."Commission Calculated" := false;
                        SalesLine.Insert;
                    end;

                    //>> Credit Card Approval Code
                    if Rec."Approval Code" <> '' then begin
                        LineLoop;
                        SalesLine.Type := SalesLine.Type::" ";
                        SalesLine.Validate("No.", '');
                        SalesLine.Description := 'Approval Code No.' + ' ' + Rec."Approval Code";
                        SalesLine."Commission Calculated" := false;
                        SalesLine.Insert;
                    end;

                    if BOL.Find('+') then
                        BLInteger := BOL."Bill of Lading" + 1
                    else
                        BLInteger := 100000;

                    WOD.SetCurrentKey(WOD."Work Order No.");
                    WOD.SetRange("Work Order No.", Rec."Work Order No.");
                    if WOD.Find('-') then begin
                        if WOD."Work Order No." <> '' then begin
                            Rec."Shortcut Dimension 2 Code" := 'WO';
                            Rec.Modify;
                            CreateLines;
                            CreateShippingLine;
                            ///--! Not necessary,already inserted Resevation ENtry
                            //Reservation;  // Commit 
                            UpdateWOD;
                            UpdateWOS;
                            UpdateParts;
                        end;
                    end;

                    //Rec.Get(Rec."No.");

                    if Rec."Bill of Lading" = 0 then begin
                        BOL2.Init;
                        BOL2."Bill of Lading" := BLInteger;
                        BOL2."Order No." := Rec."No.";
                        BOL2."PO No." := Rec."Your Reference";
                        BOL2.Customer := Rec."Sell-to Customer No.";
                        BOL2."Ship To Name" := Rec."Ship-to Name";
                        BOL2."Ship To Address" := Rec."Ship-to Address";
                        BOL2."Ship To Address2" := Rec."Ship-to Address 2";
                        BOL2."Ship To City" := Rec."Ship-to City";
                        BOL2."Ship To State" := Rec."Ship-to County";
                        BOL2."Ship To Zip Code" := Rec."Ship-to Post Code";
                        BOL2.Attention := Rec."Ship-to Contact";
                        BOL2."Phone No." := Rec."Phone No.";
                        BOL2."Shipping Weight" := ShippingWeight;
                        BOL2."Container Quantity" := ContainerQuantity;
                        BOL2."Container Type" := Ship.ContainerToBOLContainer(ContainerType);
                        BOL2.Employee := Shipper;
                        BOL2."Shipment Date" := Today;
                        BOL2.Carrier := Rec."Shipping Agent Code";
                        BOL2."Shipping Method" := Rec."Shipment Method Code";
                        BOL2."Shipping Charge" := Ship.ShipChrgToBOLShipChrg(Rec."Shipping Charge");
                        BOL2."Shipping Account" := Rec."Shipping Account";
                        BOL2."Label Quantity" := LabelsToPrint;
                        BOL2.Insert;
                    end else
                        Error('Order %1 was already processed for shipping.', Rec."No.");

                    Rec."Bill of Lading" := BOL2."Bill of Lading";
                    Rec.Modify;
                    ////Commit;
                    /*
                    if not Confirm('Is Bill of Lading and Labels loaded in Printers?', false) then begin
                        if not Confirm('Last Chance, Is Bill of Lading and Labels loaded in Printers?', false) then begin
                            OK := true;
                        end else begin
                            BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                            REPORT.RunModal(50017, false, false, BOL2);               // BOL Document
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
                            ConfirmLabels;
                        end;
                    end else begin
                        BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                        REPORT.RunModal(50017, false, false, BOL2);               // BOL Document
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

                    // 2021_01_11 Intelice Start
                    // Mark current WOD as processed
                    Rec."Shipping Processed" := true;
                    Rec.Modify();
                    // 2021_01_11 Intelice End

                    //CurrPage.Close;

                end;
            }
            group(PrintDocs)
            {
                Caption = 'Print Documents';

                action(PrintBillOfLading)
                {
                    Caption = 'Print BOL';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // 2021_01_11 Intelice Start
                        if not Rec."Shipping Processed" then begin
                            Message('You nedd to <Process> this order to be able to print BOL.');
                            exit;
                        end;
                        // 2021_01_11 Intelice End
                        PrintBOL;
                    end;
                }

                action(PrintAddressLabels)
                {
                    Caption = 'Print Address Labels';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // 2021_01_11 Intelice Start
                        if not Rec."Shipping Processed" then begin
                            Message('You nedd to <Process> this order to be able to print Address Labels.');
                            exit;
                        end;
                        // 2021_01_11 Intelice End
                        PrintLabels;
                    end;
                }
            }
            action(Release)
            {
                ApplicationArea = all;
                caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                trigger OnAction()
                begin

                    IF NOT UpdateAllowed THEN
                        EXIT;
                    // << Distribution - end

                    //>>  Whse. Management - start
                    SalesOrderRelease.PerformManualRelease(Rec);
                    //<<  Whse. Management - end



                end;

            }
            Action(Reopen)
            {
                ApplicationArea = all;
                caption = 'Reopen';
                Enabled = Rec.Status <> Rec.Status::Open;
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';


                trigger OnAction()
                begin


                    // >> Distribution - start
                    IF NOT UpdateAllowed THEN
                        EXIT;
                    // << Distribution - end

                    //>>  Warehouse Management - start
                    //Released := FALSE;
                    //"Order Status" := "Order Status"::Open;
                    salesorderrelease.PerformManualReopen(Rec);
                    //<<  Warehouse Management - end

                end;
            }
            /*action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';

                trigger OnAction()
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
            */
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnOpenPage()
    begin
        LabelsToPrint := 1;
    end;

    var
        ReservEntry: Record "Reservation Entry" temporary;
        TrackingSpecificationExists: Boolean;
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        ReqLine: Record "Requisition Line";
        ReqName: Record "Requisition Wksh. Name";
        GetSalesOrder: Report "Get Sales Orders";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        CopySalesDoc: Report "Copy Sales Document";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ReserveComplete: Boolean;
        NotPicked: Boolean;
        PickComplete: Boolean;
        PartialPick: Boolean;
        QuantityReserved: Decimal;
        OK: Boolean;
        PrintPick: Integer;
        BOL: Record BillofLading;
        BOL2: Record BillofLading;
        ShippingWeight: Decimal;
        ContainerQuantity: Integer;
        ContainerType: Enum Container;
        Shipper: Code[3];
        LabelsToPrint: Integer;
        Window: Dialog;
        BLInteger: Integer;
        LabelCount: Integer;
        WOD: Record WorkOrderDetail;
        WOP: Record Parts;
        WOS: Record Status;
        SalesLineNo: Integer;
        GPS: Record "General Posting Setup";
        Item: Record Item;
        Item2: Record Item;
        ItemLedgerSerial: Record "Item Ledger Entry";
        MainInventoryQty: Record "Item Ledger Entry";
        Main: Decimal;
        SerialNo: Code[20];
        ReturnInventoryQty: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        PostLine: Codeunit "Item Jnl.-Post Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        ShippingTime: Decimal;
        QtyOver: Decimal;
        PartsComplete: Record Parts;
        ItemNoLength: Integer;
        ItemStartPosition: Integer;
        OilPartNumber: Text[30];
        QtyOil: Integer;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";
        salesorderrelease: Codeunit "Release Sales Document";
        SerialNo_: Code[20];

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
            Message('Unable to execute this function while in view only mode.');
            exit(false);
        end else
            exit(true);
    end;

    procedure ConfirmLabels()
    begin
        if not Confirm('Did Bill of Lading & labels print correctly?', false) then begin
            BOL2."BOL Printed" := false;
            BOL2."Label Printed" := false;
            BOL2.Modify;
            if not Confirm('Do you want to reprint?', false) then begin
                OK := true;
            end else begin
                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                REPORT.RunModal(50017, false, false, BOL2);               // BOL Document
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

    procedure CreateLines()
    var
        PurchLine: Record "Purchase Line";

    begin
        //>>Create Resources Line
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Resource);
        if WOP.Find('-') then begin
            repeat
                LineLoop;
                SalesLine.Type := SalesLine.Type::Resource;
                SalesLine.Validate("No.", WOP."Part No.");
                SalesLine.Validate(Quantity, WOP."Quoted Quantity");
                SalesLine.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                SalesLine."Commission Calculated" := true;
                SalesLine.Insert;
            until WOP.Next = 0;
        end;

        //>>Create Parts Lines
        WOP.Reset;
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
        WOP.SetFilter(WOP."Pulled Quantity", '>0');
        if WOP.Find('-') then begin
            repeat
                if Item.Get(WOP."Part No.") then begin
                    WOP.CalcFields(WOP."In-Process Quantity");
                    if Item."Costing Method" = Item."Costing Method"::Specific then begin
                        SerialNo := WOP."Serial No."
                    end else begin
                        SerialNo := ''
                    end
                end;

                ReturnInventory;
                LineLoop;
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", WOP."Part No.");

                IF Item."Costing Method" = Item."Costing Method"::Specific THEN BEGIN
                    SerialNo_ := SerialNo
                END;

                SalesLine.Validate(Reserve, SalesLine.Reserve::Always);
                SalesLine.Validate(Quantity, WOP."Pulled Quantity");
                SalesLine.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                if SalesLine."VAT Prod. Posting Group" = '' then
                    SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
                SalesLine."Commission Calculated" := true;
                SalesLine.Insert;

                /// Create Reservation Entry for Parts
                if not WOD.SetSerialNo_(37, SalesLine, PurchLine, SerialNo) then
                    Error('Serial No. %1 not saved for the line %2.', SerialNo, SalesLine."Line No.");
                ////Commit;
                WOP."In-Process Quantity" := 0;
                WOP.Modify;
            until WOP.Next = 0;
        end;
    end;

    procedure LineLoop()
    begin
        Clear(SalesLine);
        SalesLineNo := SalesLineNo + 10000;
        SalesLine.Init;
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Line No." := SalesLineNo;
        SalesLine.Validate(SalesLine."Document No.", Rec."No.");
    end;

    procedure GPSLoopNoGLEntry()
    begin
        // ,SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO
        if (WOD."Income Code".AsInteger() = 1) then begin
            GPS.Get('', 'REPAIR');
        end;
        if (WOD."Income Code".AsInteger() = 2) then begin
            GPS.Get('', 'PP SALES');
        end;
        if (WOD."Income Code".AsInteger() = 3) then begin
            GPS.Get('', 'TURBO');
        end;
        if (WOD."Income Code".AsInteger() = 4) then begin
            GPS.Get('', 'ELECTRONIC');
        end;
        if (WOD."Income Code".AsInteger() = 5) then begin
            GPS.Get('', 'DRY PUMP');
        end;
        if (WOD."Income Code".AsInteger() = 6) then begin
            GPS.Get('', 'CRYO');
        end;
    end;

    procedure ReturnInventory()
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
                ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
                ItemJournalLine."Document No." := Rec."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := Rec."Work Order No." + ' ' + 'SHIP RETURN PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := ReturnInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'MAIN';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                //>
                ///--! Serial No. issue
                //if SerialNo <> '' then begin
                //    ItemJournalLine."Serial No." := SerialNo;
                //    ItemJournalLine."New Serial No." := SerialNo;
                //end;
                if SerialNo <> '' then begin
                    WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;
                //<

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

    procedure UpdateWOD()
    begin
        WOD.Carrier := Rec."Shipping Agent Code";
        WOD."Shipping Method" := Rec."Shipment Method Code";
        WOD."Shipping Charge" := Rec."Shipping Charge";
        WOD."Shipping Account" := Rec."Shipping Account";
        WOD."Ship Date" := WorkDate;
        WOD.Complete := true;
        WOD."Bill of Lading" := BLInteger;
        WOD.Modify;
    end;

    procedure UpdateWOS()
    begin
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", WOD."Work Order No.");
        if WOS.Find('+') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS."Regular Hours" := ShippingTime;
            WOS.Employee := Shipper;
            WOS.Modify;
        end;
    end;

    procedure UpdateParts()
    begin
        PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
        PartsComplete.SetRange(PartsComplete."Work Order No.", WOD."Work Order No.");
        if PartsComplete.Find('-') then begin
            repeat
                PartsComplete.Complete := true;
                PartsComplete.Modify;
            until PartsComplete.Next = 0;
        end;
    end;

    procedure CreateShippingLine()
    begin
        //>> Shippment Information
        LineLoop;
        SalesLine.Type := SalesLine.Type::" ";
        SalesLine.Description := 'Total Shipment Weight is ' + Format(ShippingWeight) + ' lbs';
        SalesLine.Insert;
    end;

    /*
    procedure Reservation()
    begin
        // Reservation Entry
        //Commit;
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.SetRange("Document No.", "No.");
        if SalesLine.Find('-') then begin
            repeat
                if (SalesLine.Reserve = SalesLine.Reserve::Always) and (SalesLine."Outstanding Qty. (Base)" <> 0) then
                    SalesLine.AutoReserve();
            until
              SalesLine.Next = 0;
        end;
    end;
    */
    procedure PrintBOL()
    begin
        if not Confirm('Is Bill of Lading loaded in Printer?', false) then begin
            if not Confirm('Last Chance, Is Bill of Lading loaded in Printer?', false) then begin
                exit;
            end else begin
                BOL2.Reset();
                BOL2.SetRange(BOL2."Bill of Lading", Rec."Bill of Lading");
                if BOL2.FindFirst() then begin
                    REPORT.RunModal(50017, false, false, BOL2);                 // BOL Document
                    BOL2."BOL Printed" := true;
                    BOL2.Modify;
                end else
                    Error('Cannot find BOL %1', Rec."Bill of Lading");
            end;
        end else begin
            BOL2.Reset();
            BOL2.SetRange(BOL2."Bill of Lading", Rec."Bill of Lading");
            if BOL2.FindFirst() then begin
                REPORT.RunModal(50017, false, false, BOL2);                     // BOL Document
                BOL2."BOL Printed" := true;
                BOL2.Modify;
            end else
                Error('Cannot find BOL %1', Rec."Bill of Lading");
        end;
    end;

    procedure PrintLabels()
    var
        Printed: Boolean;

    begin
        if not BOL2.Get(Rec."Bill of Lading") then
            Error('Cannot find BOL %1', Rec."Bill of Lading");
        if not Confirm('Are Address Labels loaded in Printers?', false) then begin
            if not Confirm('Last Chance, are Address Labels loaded in Printers loaded in Printers?', false) then begin
                exit;
            end else begin
                LabelCount := LabelsToPrint;
                BOL2.Reset();
                BOL2.SetRange(BOL2."Bill of Lading", Rec."Bill of Lading");
                if BOL2.FindFirst() then begin
                    repeat begin
                        LabelCount := LabelCount - 1;
                        REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                    end until LabelCount = 0;

                    Printed := true;
                    BOL2.Get(Rec."Bill of Lading");
                    BOL2."Label Printed" := Printed;
                    BOL2.Modify;
                end;
            end
        end else begin
            BOL2.Reset();
            BOL2.SetRange(BOL2."Bill of Lading", Rec."Bill of Lading");
            if not BOL2.FindFirst() then begin
                Error('Cannot find BOL %1', Rec."Bill of Lading");
                exit;
            end;

            LabelCount := LabelsToPrint;
            if LabelCount > 0 then begin
                repeat begin
                    LabelCount := LabelCount - 1;
                    REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                end until LabelCount = 0;
                Printed := true;
            end else begin
                Printed := false;
            end;
            BOL2.Get(Rec."Bill of Lading");
            BOL2."Label Printed" := Printed;
            BOL2.Modify;
        end;
    end;

}

#pragma implicitwith restore

