table 50003 Parts
{

    // 2016_04_05 ADV
    //   Reverse differntial factor for Parts Markup and Quoted Price calculation
    // To find commented code, use pattern <//--!>

    //--!MK
    // Missing key -- WOS.SETCURRENTKEY("Order No.", Step);
    // Coomented code, as we do not have access to main table fields.

    // 2021_02_21 ICE SII
    // Expanded Description field to 100 chars to match base table "BOM Component" field

    fields
    {
        field(10; "Work Order No."; Code[7])
        {
        }
        field(20; "Part No."; Code[20])
        {
            NotBlank = true;
            TableRelation = IF ("Part Type" = CONST(Resource)) Resource."No." WHERE(Type = CONST(Machine)) ELSE
            IF ("Part Type" = CONST(Item)) Item."No." WHERE(Blocked = CONST(false));

            trigger OnValidate();
            begin
                PartsMarkup := 1.86;
                IF Item.GET("Part No.") THEN BEGIN
                    Description := Item.Description;
                    "Part Cost" := Item."Last Direct Cost";
                    "Part Type" := "Part Type"::Item;
                    /// 2016_04_05 ADV: Start
                    /*IF Item."Vendor No." = 'LEY-01' THEN
                      "Quoted Price" := Item."Last Direct Cost" * 1.94;
                    IF Item."Vendor No." = 'PPV-01' THEN BEGIN
                      PartCode := COPYSTR(Item."No.",1,3);
                      IF PartCode = 'EBD' THEN
                        "Quoted Price" := Item."Last Direct Cost" * 1.86
                      ELSE
                        "Quoted Price" := Item."Last Direct Cost" * 1.98;
                    END ELSE*/
                    /// 2016_04_05 ADV: End
                    "Quoted Price" := Item."Last Direct Cost" * PartsMarkup;
                END ELSE BEGIN
                    IF Resource.GET("Part No.") THEN BEGIN
                        Description := Resource.Name;
                        "Part Cost" := Resource."Unit Cost";
                        "Part Type" := "Part Type"::Resource;
                        "Quoted Price" := Resource."Unit Price";
                    END;
                END;

            end;
        }

        //2021_02_21 ICE
        //field(30; Description; Text[30])
        field(30; Description; Text[100])
        {
        }
        field(90; "Quantity Backorder"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "Quantity Backorder" < 0 THEN
                    MESSAGE('URGENT! CONTACT HARLEN IMMEDIATELY, BACKORDER QUANTITY IS NEGATIVE');
            end;
        }
        field(100; "Quoted Price"; Decimal)
        {

            trigger OnValidate();
            begin
                WOS.RESET;
                //WOS.SETCURRENTKEY("Order No.", Step);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.FIND('+');
                IF WOS.Step.AsInteger() > WOS.Step::QOT.AsInteger() THEN BEGIN   // Reasons Not Entered Until Parts In Process
                    IF (Reason = Reason::"PART EXCHANGED") OR (Reason = Reason::"EXTRA PART") THEN BEGIN
                        "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                        "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                        "Total Price" := "Quoted Quantity" * "Quoted Price";
                        "Total Cost" := "Quoted Quantity" * "Part Cost";
                    END ELSE BEGIN
                        IF "After Quote Quantity" > 0 THEN BEGIN
                            "Total Quote Price" := ("Quoted Quantity" - "After Quote Quantity") * "Quoted Price";
                            "Total Quote Cost" := ("Quoted Quantity" - "After Quote Quantity") * "Part Cost";
                            "Total Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Cost" := "Quoted Quantity" * "Part Cost";
                        END ELSE BEGIN
                            "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                            "Total Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Cost" := "Quoted Quantity" * "Part Cost";
                        END;
                    END;
                END ELSE BEGIN
                    "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                    "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                    "Total Price" := "Quoted Quantity" * "Quoted Price";
                    "Total Cost" := "Quoted Quantity" * "Part Cost";
                END;
                MODIFY;
            end;
        }
        field(110; "Part Type"; Option)
        {
            OptionMembers = ,Item,Resource;
        }
        field(120; "Part Cost"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "Part Type" = "Part Type"::Resource THEN
                    ERROR('This is a resource and cost must be $0.00.');
            end;
        }
        field(130; "BOM Quantity"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "BOM Quantity" <> xRec."BOM Quantity" THEN BEGIN
                    ItemAvailability.RUN(Rec);
                END;

                "Quantity Backorder" := "BOM Quantity" - "Committed Quantity";
                MODIFY;
            end;
        }
        field(140; "Quoted Quantity"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "Part Type" = "Part Type"::Item THEN BEGIN
                    IF "Quoted Quantity" < 0 THEN
                        ERROR('Quoted Quantity Must be Greater than Zero');
                    IF "Pulled Quantity" > "Quoted Quantity" THEN
                        ERROR('Quoted Pulled Must be Reduced to Adjusted Quoted Quantity First');

                    IF "Quoted Quantity" <> xRec."Quoted Quantity" THEN BEGIN
                        CreateParts;
                    END;
                    IF "Pulled Quantity" > 0 THEN BEGIN
                        "Pulled Quantity" := 0;
                        MODIFY;
                        MESSAGE('Pulled Quantity Reduced to Zero, Please update Pulled Quantity');
                    END;

                    IF "Quoted Quantity" = 0 THEN
                        "Serial No." := '';
                    MODIFY;
                END ELSE BEGIN
                    IF "Quoted Quantity" < 0 THEN
                        ERROR('Quoted Quantity Must be Greater than Zero');

                    IF "Quoted Quantity" <> xRec."Quoted Quantity" THEN BEGIN
                        IF Resource.GET("Part No.") THEN BEGIN
                            WOS.RESET;
                            //--!MK
                            //WOS.SETCURRENTKEY("Order No.", Step);
                            WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                            WOS.FIND('+');
                            IF WOS.Step.AsInteger() > WOS.Step::QOT.AsInteger() THEN BEGIN
                                "After Quote Quantity" := "After Quote Quantity" + ("Quoted Quantity" - xRec."Quoted Quantity");
                                "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                                "Total Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Cost" := "Quoted Quantity" * "Part Cost";
                                MODIFY;
                            END ELSE BEGIN
                                "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                                "Total Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Cost" := "Quoted Quantity" * "Part Cost";
                                MODIFY;
                            END;
                        END;
                    END;
                END;

                // Auto Sets Reason to Extra Part, so the Prices are updated
                IF FS.GET("Work Order No.") THEN BEGIN
                    Reason := Reason::"EXTRA PART";
                    MODIFY;
                    VALIDATE(Reason);
                END;

                // CHECK TO SEE IF IT IS A PUMP MODULE AND MAKE ITS REASON EXTRA PART IF IT ISN'T RELEASED FROM QUOTE YET.
                // THIS MAKES SURE THE PRICES ARE UPDATED
                IF WOD.GET("Work Order No.") THEN BEGIN
                    IF WOD."Pump Module Processed" THEN BEGIN
                        //--!MK
                        //QuoteStatus.SETCURRENTKEY("Order No.", Step);
                        QuoteStatus.SETRANGE(QuoteStatus."Order No.", "Work Order No.");
                        QuoteStatus.SETRANGE(QuoteStatus.Step, QuoteStatus.Step::QOT);
                        QuoteStatus.SETRANGE(QuoteStatus.Status, QuoteStatus.Status::Waiting);
                        IF WOS.FIND('-') THEN BEGIN
                            Reason := Reason::"EXTRA PART";
                            MODIFY;
                            VALIDATE(Reason);
                        END;
                    END;
                END;

                VALIDATE("After Quote Quantity");
                IF "After Quote Quantity" = 0 THEN BEGIN
                    Reason := 0;
                    MODIFY;
                END;
            end;
        }
        field(150; "Committed Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Document No." = FIELD("Work Order No."), "Item No." = FIELD("Part No."), "Location Code" = CONST('COMMITTED')));
        }
        field(160; "In-Process Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Document No." = FIELD("Work Order No."), "Item No." = FIELD("Part No."), "Location Code" = CONST('IN PROCESS')));

        }
        field(170; "Pulled Quantity"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "Pulled Quantity" > "In-Process Quantity" THEN
                    ERROR('You cannot Pull more than the amount in the In-Process Warehouse');

                IF "Pulled Quantity" < xRec."Pulled Quantity" THEN BEGIN
                    AdjustmentAmount := "In-Process Quantity" - "Pulled Quantity";
                    IF "Quantity Backorder" > 0 THEN BEGIN
                        "Quantity Backorder" := "Quantity Backorder" + AdjustmentAmount;
                        MODIFY;
                    END ELSE BEGIN
                        IF "Serial No." <> '' THEN BEGIN
                            "Quantity Backorder" := 0;
                            "Quoted Quantity" := 0;
                            "After Quote Quantity" := -1;
                            MODIFY;
                        END ELSE BEGIN
                            "Quantity Backorder" := AdjustmentAmount;
                            MODIFY;
                        END;
                    END;

                    //Field Service Returned Parts that where shipped
                    IF FS.GET("Work Order No.") THEN BEGIN
                        IF "Qty. Shipped" > "Pulled Quantity" THEN BEGIN
                            "Qty. Returned" := "Qty. Shipped" - "Pulled Quantity";
                            MODIFY;
                        END;
                    END;

                    //Return Items to Main Inventory
                    IF Item2.GET("Part No.") THEN
                        ReturnInventory3;
                END;

                IF ("Serial No." <> '') AND ("Pulled Quantity" = 0) THEN
                    MESSAGE('Quoted Quantity was Reduced to Zero');
            end;
        }
        field(180; Stage; Option)
        {
            OptionMembers = Default,Quote,Accepted,"In Process",Complete;
        }
        field(190; Special; Boolean)
        {
        }
        field(200; "After Quote Quantity"; Decimal)
        {

            trigger OnValidate();
            begin
                IF "After Quote Quantity" <> 0 THEN BEGIN
                    IF Reason = 0 THEN
                        MESSAGE('Total Quantity Adjusted, Please Enter Reason for Adjustment');
                END;
            end;
        }
        field(205; Reason; Option)
        {
            OptionMembers = " ",LOST,"MISSED QUOTE",BROKEN,"FAILED AT TEST","OVER QUOTED","PART EXCHANGED","EXTRA PART",UNREPAIRABLE,"MACHINE SHOP",OTHER;

            trigger OnValidate();
            begin
                IF "After Quote Quantity" = 0 THEN BEGIN
                    Reason := 0;
                    MODIFY;
                    MESSAGE('Reason Not Allowed for Parts with out Quantity Adjustments');
                END;

                IF "After Quote Quantity" <> 0 THEN BEGIN
                    WOS.RESET;
                    //--!MK
                    //WOS.SETCURRENTKEY("Order No.", Step);
                    WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                    WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                    WOS.FIND('-');
                    IF WOS.Status = WOS.Status::Complete THEN BEGIN
                        IF Reason = Reason::"EXTRA PART" THEN BEGIN
                            Reason := 0;
                            MODIFY;
                            MESSAGE('EXTRA PART Reason Not Allowed Once Quote Completed');
                        END;
                    END ELSE BEGIN
                        IF Reason = Reason::"MISSED QUOTE" THEN BEGIN
                            Reason := 0;
                            MODIFY;
                            MESSAGE('MISSED QUOTE Reason Not Allowed Until Quote Released');
                        END;
                    END;
                END;

                WOS.RESET;
                //--!MK
                //WOS.SETCURRENTKEY("Order No.", Step);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.FIND('+');
                IF WOS.Step.AsInteger() > WOS.Step::QOT.AsInteger() THEN BEGIN   // Reasons Not Entered Until Parts In Process
                    IF (Reason = Reason::"PART EXCHANGED") OR (Reason = Reason::"EXTRA PART") THEN BEGIN
                        "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                        "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                        "Total Price" := "Quoted Quantity" * "Quoted Price";
                        "Total Cost" := "Quoted Quantity" * "Part Cost";
                    END ELSE BEGIN
                        IF "After Quote Quantity" > 0 THEN BEGIN
                            "Total Quote Price" := ("Quoted Quantity" - "After Quote Quantity") * "Quoted Price";
                            "Total Quote Cost" := ("Quoted Quantity" - "After Quote Quantity") * "Part Cost";
                            "Total Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Cost" := "Quoted Quantity" * "Part Cost";
                        END ELSE BEGIN
                            "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                            "Total Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Cost" := "Quoted Quantity" * "Part Cost";
                        END;
                    END;
                END;
                MODIFY;
            end;
        }
        field(210; "Serial No."; Code[20])
        {

            trigger OnValidate();
            begin
                IF (Item."Costing Method" <> Item."Costing Method"::Specific) AND ("Serial No." <> '') THEN
                    "Serial No." := '';
                MODIFY;
                MESSAGE('This Item doesn''t have a Serial Number');

                IF (xRec."Serial No." <> '') AND ("Quoted Quantity" > 0) THEN
                    "Serial No." := xRec."Serial No.";
                MODIFY;
                MESSAGE('Can''t Delete Serial No. without Reducing Quoted Qty to Zero First');
            end;
        }
        field(500; "Purchase Order No."; Code[20])
        {
            FieldClass = Normal;
            Numeric = true;
            TableRelation = "Purchase Line"."Document No." WHERE("Document Type" = FILTER(Order), Type = FILTER(<> ' '), "Document No." = FIELD("Purchase Order No."), "No." = FIELD("Part No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(510; "Pre-Release PO"; Boolean)
        {
        }
        field(700; "Qty. to Ship"; Decimal)
        {
            Description = 'Field Service Only';

            trigger OnValidate();
            begin
                CLEAR(QtytoShip);
                IF "Qty. to Ship" > "Pulled Quantity" THEN BEGIN
                    MESSAGE('Qty. to Ship can''t be greater than the Pulled Qty');
                    "Qty. to Ship" := 0;
                END;
                QtytoShip := "Pulled Quantity" + "Qty. Returned" - "Qty. Shipped";
                IF "Qty. to Ship" > QtytoShip THEN BEGIN
                    MESSAGE('Qty. to Ship can''t be greater than %1', QtytoShip);
                    "Qty. to Ship" := 0;
                END;
            end;
        }
        field(710; "Qty. Shipped"; Decimal)
        {
            Description = 'Field Service Only';
        }
        field(720; "Qty. Returned"; Decimal)
        {
            Description = 'Field Service Only';
        }
        field(1000; "Total Price"; Decimal)
        {
            Description = 'Actual Total Price of Part * Quantity';
        }
        field(1001; "Total Cost"; Decimal)
        {
            Description = 'Actual Total Cost of Part * Quantity';
        }
        field(2000; "Total Quote Price"; Decimal)
        {
            Description = 'Price used to Quote Customer';
        }
        field(2001; "Total Quote Cost"; Decimal)
        {
            Description = 'Cost of Parts Quoted to the Customer';
        }
        field(3000; Complete; Boolean)
        {
            BlankZero = true;
            Editable = true;
            Enabled = true;
        }
    }


    keys
    {
        key(Key1; "Work Order No.", "Part Type", "Part No.")
        {
            SumIndexFields = "Total Quote Price", "Total Quote Cost", "Quoted Price", "Quoted Quantity", "Total Cost", "Total Price";
        }
        key(Key2; "Part No.")
        {
        }
        key(Key3; "BOM Quantity")
        {
        }
        key(Key4; "Work Order No.", "After Quote Quantity")
        {
            SumIndexFields = "Total Quote Cost";
        }
        key(Key5; "Work Order No.", "Part No.")
        {
        }
        key(Key6; "Work Order No.", Reason)
        {
        }
    }

    trigger OnDelete();
    begin
        CALCFIELDS("Committed Quantity");
        CALCFIELDS("In-Process Quantity");

        IF ("Committed Quantity" = 0) AND ("In-Process Quantity" = 0) THEN
            Ok := TRUE
        ELSE
            ERROR('You must reduce the quoted quantity to 0 before deleting the record');
    end;

    trigger OnInsert();
    begin
        WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
        WOS.SETRANGE(WOS."Order No.", "Work Order No.");
        WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
        IF WOS.FIND('-') THEN
            Special := TRUE;
    end;

    trigger OnRename();
    begin
        IF "Quoted Quantity" > 0 THEN
            ERROR('Quoted Quantity Must be Reduced to Zero before Renaming');
    end;

    var

        Item: Record Item;
        Ok: Boolean;
        ItemAvailability: Codeunit "Check Availablility";
        CurrentRecord: Record Parts;
        WOS: Record Status;
        ExistingParts: Record Parts;
        Item2: Record Item;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        AdjustmentAmount: Decimal;
        Resource: Record Resource;
        ///--!
        //Window: Dialog;
        GetItemNo: Page GetValueDialog;
        SetValType: Enum ValueType;
        NewPart: Code[20];
        NewPartRecord: Record Parts;
        OriginalRecord: Record Parts;
        "Qty Available": Decimal;
        BackOrderQty: Decimal;
        FillOrderQty: Decimal;
        ReturnInventoryQty: Decimal;
        BackOrder2Qty: Decimal;
        FillOrder2Qty: Decimal;
        ReturnInventory2Qty: Decimal;
        ReturnInventory3Qty: Decimal;
        PartCode: Code[10];
        FS: Record FieldService;
        QtytoShip: Decimal;
        WOD: Record WorkOrderDetail;
        QuoteStatus: Record Status;
        PartsMarkup: Decimal;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    procedure CreateParts();
    begin
        PartsMarkup := 1.86;
        IF Item2.GET("Part No.") THEN BEGIN
            IF Item2.Blocked THEN BEGIN
                MESSAGE('Quoted Quantity Can''t be changed for Blocked Parts');
            END ELSE BEGIN
                /// 2016_04_05 ADV: Start
                /*IF Item2."Vendor No." = 'LEY-01' THEN
                  "Quoted Price" := Item2."Last Direct Cost" * 1.94;
                IF Item2."Vendor No." = 'PPV-01' THEN BEGIN
                  PartCode := COPYSTR(Item2."No.",1,3);
                  IF PartCode = 'EBD' THEN
                    "Quoted Price" := Item2."Last Direct Cost" * 1.86
                  ELSE
                    "Quoted Price" := Item2."Last Direct Cost" * 1.98;
                END ELSE*/
                /// 2016_04_05 ADV: End
                "Quoted Price" := Item2."Last Direct Cost" * PartsMarkup;
                "Part Cost" := Item2."Last Direct Cost";
                CALCFIELDS("Committed Quantity", "In-Process Quantity");
                WOS.RESET;
                WOS.SETCURRENTKEY("Order No.", Step);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.FIND('+');
                IF WOS.Step.AsInteger() > WOS.Step::QOT.AsInteger() THEN BEGIN
                    // IF Reason already Exist then Update Price otherwise updated on Reason Validate
                    IF Reason > 0 THEN BEGIN
                        IF (Reason = Reason::"PART EXCHANGED") OR (Reason = Reason::"EXTRA PART") THEN BEGIN
                            "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                            "Total Price" := "Quoted Quantity" * "Quoted Price";
                            "Total Cost" := "Quoted Quantity" * "Part Cost";
                        END ELSE BEGIN
                            IF "After Quote Quantity" > 0 THEN BEGIN
                                "Total Quote Price" := ("Quoted Quantity" - "After Quote Quantity") * "Quoted Price";
                                "Total Quote Cost" := ("Quoted Quantity" - "After Quote Quantity") * "Part Cost";
                                "Total Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Cost" := "Quoted Quantity" * "Part Cost";
                            END ELSE BEGIN
                                "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                                "Total Price" := "Quoted Quantity" * "Quoted Price";
                                "Total Cost" := "Quoted Quantity" * "Part Cost";
                            END;
                        END;
                    END;
                    "After Quote Quantity" := "After Quote Quantity" + ("Quoted Quantity" - xRec."Quoted Quantity");
                    IF "Quoted Quantity" > "In-Process Quantity" THEN BEGIN
                        Item2.SETRANGE(Item2."Location Filter", 'MAIN');
                        Item2.CALCFIELDS(Item2.Inventory, Item2."Reserved Qty. on Inventory", Item2."Qty. on Purch. Order");
                        "Qty Available" := (Item2.Inventory - Item2."Reserved Qty. on Inventory");
                        IF "Qty Available" > 0 THEN BEGIN
                            IF "Qty Available" < "Quoted Quantity" - "In-Process Quantity" THEN BEGIN
                                "Quantity Backorder" := "Quoted Quantity" - "Qty Available" - "In-Process Quantity";
                                BackOrder2;
                                MODIFY;
                            END ELSE BEGIN
                                "Quantity Backorder" := 0;
                                FillOrder2;
                                MODIFY;
                            END;
                        END ELSE BEGIN
                            "Quantity Backorder" := "Quoted Quantity" - "In-Process Quantity";
                            MODIFY;
                        END;
                    END ELSE BEGIN
                        ReturnInventory2;
                        CALCFIELDS("In-Process Quantity");
                        "Quantity Backorder" := "In-Process Quantity" - "Quoted Quantity";
                        MODIFY;
                    END;
                END ELSE BEGIN
                    "Total Quote Price" := "Quoted Quantity" * "Quoted Price";
                    "Total Quote Cost" := "Quoted Quantity" * "Part Cost";
                    "Total Price" := "Quoted Quantity" * "Quoted Price";
                    "Total Cost" := "Quoted Quantity" * "Part Cost";
                    IF "Quoted Quantity" > "Committed Quantity" THEN BEGIN
                        Item2.SETRANGE(Item2."Location Filter", 'MAIN');
                        Item2.CALCFIELDS(Item2.Inventory, Item2."Reserved Qty. on Inventory", Item2."Qty. on Purch. Order");
                        "Qty Available" := (Item2.Inventory - Item2."Reserved Qty. on Inventory");
                        IF "Qty Available" > 0 THEN BEGIN
                            IF "Qty Available" < "Quoted Quantity" - "Committed Quantity" THEN BEGIN
                                "Quantity Backorder" := "Quoted Quantity" - "Committed Quantity" - "Qty Available";
                                BackOrder;
                                MODIFY;
                            END ELSE BEGIN
                                "Quantity Backorder" := 0;
                                FillOrder;
                                MODIFY;
                            END;
                        END ELSE BEGIN
                            "Quantity Backorder" := ("Quoted Quantity" - "Committed Quantity");
                            MODIFY;
                        END;
                    END ELSE BEGIN
                        ReturnInventory;
                        CALCFIELDS("Committed Quantity");
                        "Quantity Backorder" := "Committed Quantity" - "Quoted Quantity";
                        MODIFY;
                    END;
                END;
            END;
        END;

    end;

    procedure BackOrder();
    begin
        BackOrderQty := ("Quoted Quantity" - "Quantity Backorder" - "Committed Quantity");
        IF BackOrderQty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'MAIN';
            WriteItemJournalLine;
            ItemJournalLine.Description := "Work Order No." + ' ' + 'COMMIT PARTS';
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, BackOrderQty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'COMMITTED');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure FillOrder();
    begin
        FillOrderQty := ("Quoted Quantity" - "Committed Quantity");
        IF FillOrderQty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'MAIN';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'COMMIT PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, FillOrderQty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'COMMITTED');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure ReturnInventory();
    begin
        ReturnInventoryQty := ("Committed Quantity" - "Quoted Quantity");
        IF ReturnInventoryQty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'COMMITTED';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'RETURN PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, ReturnInventoryQty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'MAIN');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure BackOrder2();
    begin
        BackOrder2Qty := ("Quoted Quantity" - "Quantity Backorder" - "In-Process Quantity");
        IF BackOrder2Qty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'MAIN';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'IN PROCESS PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, BackOrder2Qty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'IN PROCESS');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure FillOrder2();
    begin
        FillOrder2Qty := "Quoted Quantity" - "In-Process Quantity";
        IF FillOrder2Qty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'MAIN';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'IN PROCESS PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, FillOrder2Qty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'IN PROCESS');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure ReturnInventory2();
    begin
        ReturnInventory2Qty := ("In-Process Quantity" - "Quoted Quantity");
        IF ReturnInventory2Qty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'IN PROCESS';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'RETURN PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, ReturnInventory2Qty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'MAIN');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure ReturnInventory3();
    begin
        ReturnInventory3Qty := AdjustmentAmount;
        IF ReturnInventory3Qty <> 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'IN PROCESS';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'RETURN PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, ReturnInventory3Qty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'MAIN');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure WriteItemJournalLine();
    var
        WOD: Record WorkOrderDetail;
    begin
        LineNumber := LineNumber + 10000;
        ItemJournalLine.VALIDATE("Journal Template Name", 'TRANSFER');
        ItemJournalLine.VALIDATE("Journal Batch Name", 'TRANSFER');
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
        ItemJournalLine."Document No." := "Work Order No.";
        ItemJournalLine.VALIDATE("Item No.", Item2."No.");
        ItemJournalLine.Validate(Quantity, Rec."Quoted Quantity");
        ItemJournalLine."Posting Date" := WORKDATE;
        IF Rec."Serial No." <> '' THEN BEGIN
            WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, Rec."Serial No.");
            ItemJournalLine."Serial No." := Rec."Serial No.";
            ItemJournalLine."New Serial No." := Rec."Serial No.";
        END ELSE BEGIN
            ItemJournalLine."Serial No." := '';
            ItemJournalLine."New Serial No." := '';
        END;
    end;

    procedure PostJournalLine();
    begin
        PostLine.RUN(ItemJournalLine);

        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        IF ItemJournalClear.FIND('-') THEN
            REPEAT
                ItemJournalClear.DELETE;
            UNTIL ItemJournalClear.NEXT = 0;
    end;

    procedure PartsAllocation();
    begin
        Page.RUN(50010, Rec);
    end;

    procedure ReplacePart();
    begin
        BEGIN
            OriginalRecord := Rec;
            NewPart := '';
            ///--!
            //Window.OPEN('Enter the new part number #1#########', NewPart);
            //Window.INPUT();
            //Window.CLOSE;
            GetItemNo.SetDialogValueType(SetValType::Item, false);
            if GetItemNo.RunModal() = Action::OK then
                GetItemNo.GetWorkOrderNo_(NewPart);
            IF NewPart <> '' THEN BEGIN
                Item.RESET;
                IF Item.GET(NewPart) THEN BEGIN
                    NewPartRecord.INIT;
                    NewPartRecord."Work Order No." := "Work Order No.";
                    NewPartRecord."Part Type" := NewPartRecord."Part Type"::Item;
                    NewPartRecord.VALIDATE("Part No.", NewPart);
                    NewPartRecord.INSERT;
                    COMMIT;
                    Rec := NewPartRecord;
                    xRec := Rec;
                    "Quoted Quantity" := OriginalRecord."Quoted Quantity";
                    VALIDATE("Quoted Quantity");
                    MODIFY;
                END ELSE BEGIN
                    ERROR('Item No. %1 not found', NewPart);
                END;
            END ELSE BEGIN
                ERROR('You must enter a new part number.');
            END;

            BEGIN
                Rec := OriginalRecord;
                xRec := Rec;
                "Quoted Quantity" := 0;
                VALIDATE("Quoted Quantity");
            END;
        END;
    end;

    procedure DeletePart();
    begin
        xRec := Rec;
        "Quoted Quantity" := 0;
        VALIDATE("Quoted Quantity");
        "Pulled Quantity" := 0;
        DELETE;
    end;

    procedure AddPart();
    begin
    end;

    procedure DeletePartPA();
    begin
        IF "Quoted Quantity" > 0 THEN
            ERROR('Quoted Quantity Must Be Zero to Delete Part');
        "Pulled Quantity" := 0;
        DELETE;
    end;

    procedure AdjResource();
    begin
    end;
}

