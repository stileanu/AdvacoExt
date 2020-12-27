page 50060 "Sales Order Shipping"
{
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
                    field("No."; "No.")
                    {
                        ApplicationArea = All;
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field("Work Order No."; "Work Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to Customer No."; "Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship-to Code"; "Ship-to Code")
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
                    field("Your Reference"; "Your Reference")
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
                    field("Shipping Agent Code"; "Shipping Agent Code")
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
                    field(Status; Status)
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
        area(creation)
        {
            action("Print &BOL and Labels")
            {
                ApplicationArea = All;
                Caption = 'Print &BOL and Labels';
                Visible = false;

                trigger OnAction()
                var
                    Ship: Codeunit Shipping;

                begin
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

                    if "Shipping Agent Code" = '' then
                        Error('Shipping Agent Code must be Entered');

                    if "Shipment Method Code" = '' then
                        Error('Shipment Method Code must be Entered');

                    if "Shipping Charge" = "Shipping Charge"::" " then
                        Error('Shipping Charge must be Entered');

                    QtyOil := 0;
                    SalesSetup.Get;

                    //99999
                    // Check for Serial No for Pumps
                    SalesLine2.SetRange("Document Type", "Document Type");
                    SalesLine2.SetRange("Document No.", "No.");
                    SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                    /*99999IF SalesLine2.FIND('-') THEN BEGIN
                      REPEAT
                        Main := 0;
                        IF Item2.GET(SalesLine2."No.") THEN BEGIN
                          IF Item2."Costing Method" = Item."Costing Method" :: Specific THEN BEGIN
                            IF SalesLine2."Serial No." = '' THEN
                              ERROR('Item %1 Serial No. is blank, so the Item can not be shipped',SalesLine2."No.");
                            IF SalesLine2."Serial No." <> '' THEN BEGIN
                              ItemLedgerSerial.SETCURRENTKEY("Item No.",Open,"Serial No.","Location Code");
                              ItemLedgerSerial.SETRANGE("Item No.",Item2."No.");
                              ItemLedgerSerial.SETRANGE(ItemLedgerSerial.Open,TRUE);
                              ItemLedgerSerial.SETRANGE("Serial No.",SalesLine2."Serial No.");
                              ItemLedgerSerial.SETRANGE("Location Code",'MAIN');
                              IF ItemLedgerSerial.FIND('-') THEN BEGIN
                                OK := TRUE;
                              END ELSE BEGIN
                                ERROR('Item %1 Serial No. %2 hasn''t been received, Contact Purchasing',Item2."No.",SalesLine2."Serial No.");
                              END;
                            END;
                          END ELSE BEGIN
                            { -- ADV 11/30/15
                            MainInventoryQty.SETCURRENTKEY("Item No.","Location Code", "Variant Code","Document No.");
                            MainInventoryQty.SETRANGE("Item No.",Item2."No.");
                            MainInventoryQty.SETRANGE("Location Code",'Main');
                            IF MainInventoryQty.FIND('-') THEN BEGIN
                              REPEAT
                                Main := Main + MainInventoryQty.Quantity;
                              UNTIL MainInventoryQty.NEXT = 0;
                            END;
                            }
                            Item2."Location Filter" := 'Main';
                            Item2.CALCFIELDS("Quantity on Hand");
                    
                            //IF SalesLine2."Qty. to Ship" > Main THEN
                            IF SalesLine2."Qty. to Ship" > Item2."Quantity on Hand" THEN
                              ERROR('Item %1 only has %2 in Inventory, Contact Purchasing',Item2."No.",Main);
                          END;
                        END;
                      UNTIL SalesLine2.NEXT = 0;
                    END;
                    
                    SalesLine2.RESET;
                    
                    // Checks Serial No for Work Orders Sold on Sales Orders
                    IF "Work Order No." <> '' THEN BEGIN
                      SalesLine2.SETRANGE("Document Type","Document Type");
                      SalesLine2.SETRANGE("Document No.","No.");
                      IF SalesLine2.FIND('-') THEN BEGIN
                        IF SalesLine2."Serial No." = '' THEN
                          ERROR('Item %1 Serial No. is blank, so the Item can not be shipped',SalesLine2."Cross Reference Item");
                      END;
                    END;
                    99999*/

                    // Check Qty to Ship against Order Quantiy and Shipped Qty
                    SalesLine2.Reset;
                    SalesLine2.SetRange("Document Type", "Document Type");
                    SalesLine2.SetRange("Document No.", "No.");
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
                    if "Shipping Agent Code" = 'UPS' then begin
                        //Removed "Pre-Paid" 11/1/04 per Darleen
                        if ("Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
                            SalesLine2.Reset;
                            SalesLine2.SetRange("Document Type", "Document Type");
                            SalesLine2.SetRange("Document No.", "No.");
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
                    SalesLine2.SetRange("Document Type", "Document Type");
                    SalesLine2.SetRange("Document No.", "No.");
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
                    SalesLine.SetRange("Document Type", "Document Type");
                    SalesLine.SetRange("Document No.", "No.");
                    if SalesLine.Find('+') then
                        SalesLineNo := SalesLine."Line No.";

                    //UPS HANDLING
                    if "Shipping Agent Code" = 'UPS' then begin
                        //Removed "Pre-Paid" 11/1/04 per Darleen
                        if ("Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
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
                    if "Shipping Agent Code" = 'UPS' then begin
                        if ("Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
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
                    if "Approval Code" <> '' then begin
                        LineLoop;
                        SalesLine.Type := SalesLine.Type::" ";
                        SalesLine.Validate("No.", '');
                        SalesLine.Description := 'Approval Code No.' + ' ' + "Approval Code";
                        SalesLine."Commission Calculated" := false;
                        SalesLine.Insert;
                    end;

                    if BOL.Find('+') then
                        BLInteger := BOL."Bill of Lading" + 1
                    else
                        BLInteger := 100000;

                    WOD.SetCurrentKey(WOD."Work Order No.");
                    WOD.SetRange("Work Order No.", "Work Order No.");
                    if WOD.Find('-') then begin
                        if WOD."Work Order No." <> '' then begin
                            "Shortcut Dimension 2 Code" := 'WO';
                            Modify;
                            CreateLines;
                            CreateShippingLine;
                            Reservation;  // Commit
                            UpdateWOD;
                            UpdateWOS;
                            UpdateParts;
                        end;
                    end;


                    BOL2.Init;
                    BOL2."Bill of Lading" := BLInteger;
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
                    BOL2.Carrier := "Shipping Agent Code";
                    BOL2."Shipping Method" := "Shipment Method Code";
                    BOL2."Shipping Charge" := Ship.ShipChrgToBOLShipChrg("Shipping Charge");
                    BOL2."Shipping Account" := "Shipping Account";
                    BOL2."Label Quantity" := LabelsToPrint;
                    BOL2.Insert;

                    "Bill of Lading" := BOL2."Bill of Lading";
                    Modify;
                    Commit;

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
                    //99999

                    CurrPage.Close;

                end;
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
                Enabled = Status <> Status::Open;
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
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';

                trigger OnAction()
                begin
                    DocPrint.PrintSalesHeader(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    trigger OnOpenPage()
    begin
        LabelsToPrint := 1;
    end;

    var
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

                //    IF Item."Costing Method" = Item."Costing Method" :: Specific THEN BEGIN
                //      SalesLine."Serial No." := SerialNo
                //    END;

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
        SalesLine.Validate(SalesLine."Document No.", "No.");
    end;

    procedure GPSLoopNoGLEntry()
    begin
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
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'SHIP RETURN PARTS';
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

    procedure UpdateWOD()
    begin
        WOD.Carrier := "Shipping Agent Code";
        WOD."Shipping Method" := "Shipment Method Code";
        WOD."Shipping Charge" := "Shipping Charge";
        WOD."Shipping Account" := "Shipping Account";
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

    procedure Reservation()
    begin
        // Reservation Entry
        Commit;
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
}

