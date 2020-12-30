page 50010 "Parts Allocation"
{
    //     //

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Parts;

    layout
    {
        area(content)
        {
            group(Control1000000009)
            {
                ShowCaption = false;
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Item.Inventory - Item.""Reserved Qty. on Inventory"""; Item.Inventory - Item."Reserved Qty. on Inventory")
                {
                    ApplicationArea = All;
                    Caption = 'Current Qty Available';
                }
            }
            repeater(Group)
            {
                field("<PartNo.>"; "Part No.")
                {
                    ApplicationArea = All;
                    Caption = 'Part No.';
                }
                field("<Description`>"; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Committed Quantity"; "Committed Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    ApplicationArea = All;
                    Caption = 'Backorder Quantity';
                    Editable = false;
                }
                field("In-Process Quantity"; "In-Process Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pulled Quantity"; "Pulled Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Allocate All")
            {
                ApplicationArea = All;
                Caption = 'Allocate All';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Message('This Function is Still in Testing ');


                    /*
                    WOS.SETCURRENTKEY("Work Order No.","Line No.");
                    WOS.SETRANGE(WOS."Work Order No.","Work Order No.");
                    IF WOS.FIND('+') THEN BEGIN
                       IF WOS.Step <= WOS.Step :: QOT THEN
                       ERROR('You can''t allocate parts until the Quote is Released');
                    END;
                    
                    IF CONFIRM('This Code will attempt to allocated all back Ordered Items. \'+
                                   'You will have to manually unallocate if this is incorrect.\'+
                                   'Are you Sure you wish to continue?', FALSE) THEN BEGIN
                    
                      QtyBelowZero := 'No';
                    
                      Parts2.SETCURRENTKEY("Work Order No.","Part Type","Part No.");
                      Parts2.SETRANGE(Parts2."Work Order No.","Work Order No.");
                      Parts2.SETRANGE(Parts2."Part Type",Parts2."Part Type" :: Item);
                      Parts2.SETFILTER(Parts2."Quantity Backorder",'>0');
                      IF Parts2.FIND('-') THEN BEGIN
                         REPEAT
                           BackorderParts.INIT;
                           BackorderParts.TRANSFERFIELDS(Parts2);
                           BackorderParts."In-Process Quantity" := Parts2."In-Process Quantity";
                           BackorderParts.INSERT;
                         UNTIL Parts2.NEXT = 0;
                      END;
                    
                    {    REPEAT
                          Item.GET("Part No.");
                          Item."Location Filter" := 'MAIN';
                          Item.CALCFIELDS(Item."Quantity on Hand",Item."Reserved Qty. on Inventory",Item."Qty. on Purch. Order");
                          QtyOnHand := (Item."Quantity on Hand" - Item."Reserved Qty. on Inventory" - Item."Qty. on Purch. Order");
                    
                           IF QtyOnHand < 0 THEN
                             QtyBelowZero := 'YES';
                    
                           IF QtyOnHand >= 0 THEN BEGIN
                               IF Parts2."Quantity Backorder" > QtyOnHand THEN BEGIN
                                 Item2.GET(Item."No.");
                                 Item2.SETRANGE(Item2."Location Filter",'MAIN');
                                 Item2.CALCFIELDS(Item2."Quantity on Hand",Item2."Reserved Qty. on Inventory",Item2."Qty. on Purch. Order");
                                 QOH := (Item2."Quantity on Hand" - Item2."Reserved Qty. on Inventory" - Item2."Qty. on Purch. Order");
                                 QtyNeeded := "Quantity Backorder" - QOH;
                                 PN := QOH;
                                 AllocateSingle;
                               LocateParts;
                               StealParts;
                                 IF QtyNotFound < 0 THEN
                                    QtyNotFound := 0;
                                 IF QtyNotFound > 0 THEN
                                   "Quantity Backorder" := QtyNotFound
                                 ELSE
                                   "Quantity Backorder" := 0;
                                 PN := QtyNeeded - QtyNotFound;
                                 MODIFY;
                                 AllocateSingle;
                    
                                 CurrentRecord := Rec;
                                 ReturnParts;
                                 COMMIT;
                                 Rec := CurrentRecord;
                                 QOH := 0;
                                 QtyNeeded := 0;
                                 QtyFound := 0;
                                 QtyNotFound := 0;
                                 QtyBO := 0;
                                 PN := 0;
                                 QtyOnHand := 0;
                                 QtyQuoted := 0;
                                 COMMIT;
                    
                    
                            END ELSE IF Parts2."Quantity Backorder" <= QtyOnHand THEN BEGIN
                                 PN :=  Parts2."Quantity Backorder";
                                 Parts2."Quantity Backorder" := 0;
                                 COMMIT;
                                 Allocate;
                                 Parts2.MODIFY;
                               END;
                            END;
                         //  IF Item."Quantity on Hand" > 0 THEN BEGIN
                          //   IF Item."Quantity on Hand" >= Parts2."Quantity Backorder" THEN BEGIN
                             //   PN := Parts2."Quantity Backorder";
                            //    Parts2."Quantity Backorder" := 0;
                          //      COMMIT;
                             //   Allocate;
                            //    Parts2.MODIFY;
                          //   END ELSE IF Item."Quantity on Hand" < Parts2."Quantity Backorder" THEN BEGIN
                    
                          //      PN := Item."Quantity on Hand";
                           //     Parts2."Quantity Backorder" := Parts2."Quantity Backorder" - PN;
                          //      Allocate;
                          //      Parts2.MODIFY;
                    
                        //     END;
                       //   END;
                         //
                    
                        UNTIL Parts2.NEXT = 0;
                    
                       END;
                    END;
                    
                      QtyOnHand := 0;
                        IF QtyBelowZero = 'YES' THEN
                           MESSAGE('Couldn''t Allocate All the Parts Because Negative Quantity Available, Please Notify Manager');
                    }
                    
                    
                    END;
                    */

                end;
            }
            action("&Allocate")
            {
                ApplicationArea = All;
                Caption = '&Allocate';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TempPartsFound.DeleteAll;
                    Commit;

                    WOS.SetCurrentKey("Order No.", "Line No.");
                    WOS.SetRange(WOS."Order No.", "Work Order No.");
                    if WOS.Find('+') then begin
                        if WOS.Step.AsInteger() <= WOS.Step::QOT.AsInteger() then
                            Error('You can''t allocate parts until the Quote is Released');
                    end;

                    ///--!
                    //Window.Open('Enter the amount to Allocate #1#########', PN);
                    //Window.Input();
                    //Window.Close;
                    //vPN := PN;
                    Clear(InValDialog);
                    InValDialog.SetValueType(InValType::IntegerType, 'Enter the amount to Allocate:');
                    if InValDialog.RunModal() = Action::OK then
                        InValDialog.GetIntegerValue(PN);
                    //PN := vPN;

                    QtyOnHand := (Item.Inventory - Item."Reserved Qty. on Inventory");

                    if QtyOnHand < 0 then
                        Error('Can''t Auto Allocate with Negative Quantity Available, Please Contact Purchasing Manager');

                    if PN <= 0 then
                        Error('Can''t Allocate A Negative or Zero Quantity');

                    if PN > QtyOnHand then begin
                        if "Quantity Backorder" < PN then
                            Error('There are currently %1 backordered, you are trying to allocate %2', "Quantity Backorder", PN);

                        if "Quantity Backorder" > PN then begin
                            QtyBO := "Quantity Backorder" - PN;
                            Item2.Get(Item."No.");
                            Item2.SetRange(Item2."Location Filter", 'MAIN');
                            Item2.CalcFields(Item2.Inventory, Item2."Reserved Qty. on Inventory", Item2."Qty. on Purch. Order");
                            QOH := (Item2.Inventory - Item2."Reserved Qty. on Inventory");
                            if QOH <= 0 then begin
                                QtyNeeded := PN;
                            end else begin
                                QtyNeeded := PN - QOH;
                                PN := QOH;
                                AllocateSingle;
                            end;
                            LocateParts;
                            StealParts;
                            if QtyNotFound < 0 then
                                QtyNotFound := 0;
                            if QtyNotFound > 0 then
                                "Quantity Backorder" := QtyBO + QtyNotFound
                            else
                                "Quantity Backorder" := QtyBO;
                            PN := QtyNeeded - QtyNotFound;
                            Modify;
                            AllocateSingle;
                        end;

                        if "Quantity Backorder" = PN then begin
                            Item2.Get(Item."No.");
                            Item2.SetRange(Item2."Location Filter", 'MAIN');
                            Item2.CalcFields(Item2.Inventory, Item2."Reserved Qty. on Inventory", Item2."Qty. on Purch. Order");
                            QOH := (Item2.Inventory - Item2."Reserved Qty. on Inventory");
                            if QOH <= 0 then begin
                                QtyNeeded := PN;
                            end else begin
                                QtyNeeded := PN - QOH;
                                PN := QOH;
                                AllocateSingle;
                            end;
                            LocateParts;
                            StealParts;
                            if QtyNotFound < 0 then
                                QtyNotFound := 0;
                            if QtyNotFound > 0 then
                                "Quantity Backorder" := QtyNotFound
                            else
                                "Quantity Backorder" := 0;
                            PN := QtyNeeded - QtyNotFound;
                            Modify;
                            AllocateSingle;
                        end;

                        // RETURNING QUOTED QTY TO WORK ORDERS PARTS STOLEN FROM AND RESETING VARIABLES

                        CurrentRecord := Rec;
                        ReturnParts;
                        Commit;
                        Rec := CurrentRecord;
                        QOH := 0;
                        QtyNeeded := 0;
                        QtyFound := 0;
                        QtyNotFound := 0;
                        QtyBO := 0;
                        PN := 0;
                        QtyOnHand := 0;
                        QtyQuoted := 0;
                        Commit;

                    end else begin
                        if "Quantity Backorder" < PN then
                            Error('There are currently %1 backordered, you are trying to allocate %2', "Quantity Backorder", PN);
                        if "Quantity Backorder" > PN then begin
                            "Quantity Backorder" := "Quantity Backorder" - PN;
                            Modify;
                            AllocateSingle;
                        end;

                        if "Quantity Backorder" = PN then begin
                            "Quantity Backorder" := 0;
                            Modify;
                            AllocateSingle;
                        end;
                    end;

                    // REMOVED 06/15/01 HEF
                    // CODE REMOVED BUT SAVED IF EVER NEEDED FOR ALLOCATION OF PARTS IN QUOTE
                    /*
                        IF WOS.Step = WOS.Step :: QOT THEN BEGIN
                          IF "Quantity Backorder" < PN THEN
                            ERROR('There are currently %1 backordered, you are trying to allocate %2',"Quantity Backorder",PN)
                          ELSE
                            IF "Quantity Backorder" < PN THEN BEGIN
                              "Quantity Backorder" := "Quantity Backorder" - PN;
                              MODIFY;
                              CommitAllocateSingle;
                            END ELSE
                              IF "Quantity Backorder" > PN THEN BEGIN
                              "Quantity Backorder" :=  "Quantity Backorder" - PN;
                              MODIFY;
                              CommitAllocateSingle;
                            END ELSE
                              IF "Quantity Backorder" = PN THEN BEGIN
                              "Quantity Backorder" := 0;
                              MODIFY;
                              CommitAllocateSingle;
                         END;
                     */
                    // END REMOVE HEF

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if Item.Get("Part No.") then begin
            Item.SetRange(Item."Location Filter", 'MAIN');
            Item.CalcFields(Item.Inventory, Item."Reserved Qty. on Inventory", Item."Qty. on Purch. Order");
        end;
    end;

    trigger OnOpenPage()
    begin
        if Item.Get("Part No.") then
            Ok := true;
    end;

    var
        vPN: Variant;
        InValDialog: Page InputValueDialog;
        InValType: Enum InValueType;
        Parts: Record Parts;
        Parts2: Record Parts;
        WOD: Record WorkOrderDetail;
        TempPartsFound: Record "Temp Parts Found";
        Item2: Record Item;
        PN: Integer;
        Item: Record Item;
        Ok: Boolean;
        Window: Dialog;
        WOS: Record Status;
        QOH: Decimal;
        QtyNeeded: Decimal;
        QtyFound: Decimal;
        QtyNotFound: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        QtyOnHand: Decimal;
        PartsSteal: Record Parts;
        TempPartsUsed: Record "Temp Parts Found";
        PartsLocate: Record Parts;
        QtyBO: Integer;
        CurrentRecord: Record Parts;
        PartsReturn: Record Parts;
        QtyQuoted: Decimal;
        QtyBelowZero: Code[30];
        GetInput: Page GetValueDialog;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    procedure Allocate()
    begin
        ItemJournalLine.Init;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
        ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Document No." := "Work Order No.";
        ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
        ItemJournalLine."Item No." := Parts2."Part No.";
        ItemJournalLine.Validate(ItemJournalLine."Item No.");
        ItemJournalLine."Posting Date" := WorkDate;
        ItemJournalLine.Description := "Work Order No." + ' ' + 'PA IN PROCESS PARTS';
        ItemJournalLine."Location Code" := 'MAIN';
        ItemJournalLine.Quantity := PN;
        ItemJournalLine.Validate(ItemJournalLine.Quantity);
        ItemJournalLine."New Location Code" := 'IN PROCESS';
        ItemJournalLine.Validate(ItemJournalLine."New Location Code");
        ItemJournalLine.Insert;

        PostLine.Run(ItemJournalLine);

        ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        if ItemJournalClear.Find('-') then
            repeat
                ItemJournalClear.Delete;
            until ItemJournalClear.Next = 0;
    end;

    procedure CommitAllocate()
    begin
        // NOT BEING USED

        ItemJournalLine.Init;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Journal Batch Name" := 'COMMITTED';
        ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Document No." := "Work Order No.";
        ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
        ItemJournalLine."Item No." := Parts2."Part No.";
        ItemJournalLine.Validate(ItemJournalLine."Item No.");
        ItemJournalLine."Posting Date" := WorkDate;
        ItemJournalLine.Description := "Work Order No." + ' ' + 'COMMIT PARTS';
        ItemJournalLine."Location Code" := 'MAIN';
        ItemJournalLine.Quantity := PN;
        ItemJournalLine.Validate(ItemJournalLine.Quantity);
        ItemJournalLine."New Location Code" := 'COMMITTED';
        ItemJournalLine.Validate(ItemJournalLine."New Location Code");
        ItemJournalLine.Insert;

        PostLine.Run(ItemJournalLine);

        ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        if ItemJournalClear.Find('-') then
            repeat
                ItemJournalClear.Delete;
            until ItemJournalClear.Next = 0;
    end;

    procedure CreatePurchaseOrderHeader()
    begin
    end;

    procedure CreatePurchaseOrderLines()
    begin
        Item.Get(Parts2."Part No.");
        Item."Location Filter" := 'MAIN';
        Item.CalcFields(Item.Inventory);
        if Item.Inventory > 0 then begin
            if Item.Inventory >= Parts2."Quantity Backorder" then begin
                PN := Parts2."Quantity Backorder";
                Parts2."Quantity Backorder" := 0;
                Parts2.Modify;
                Allocate;
            end else
                if Item.Inventory < Parts2."Quantity Backorder" then begin
                    PN := Item.Inventory;
                    Parts2."Quantity Backorder" := Parts2."Quantity Backorder" - PN;
                    Parts2.Modify;
                    Allocate;
                end;
        end;
    end;

    procedure AllocateSingle()
    begin
        if PN > 0 then begin
            ItemJournalLine.Init;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
            ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Document No." := "Work Order No.";
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Item No." := Item."No.";
            ItemJournalLine.Validate(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WorkDate;
            ItemJournalLine.Description := "Work Order No." + ' ' + 'PA IN PROCESS PARTS';
            ItemJournalLine."Location Code" := 'MAIN';
            ItemJournalLine.Quantity := PN;
            ItemJournalLine.Validate(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'IN PROCESS';
            ItemJournalLine.Validate(ItemJournalLine."New Location Code");
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

    procedure CommitAllocateSingle()
    begin
        // NOT BEINNG USED

        ItemJournalLine.Init;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Journal Batch Name" := 'COMMITTED';
        ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Document No." := "Work Order No.";
        ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
        ItemJournalLine."Item No." := Item."No.";
        ItemJournalLine.Validate(ItemJournalLine."Item No.");
        ItemJournalLine."Posting Date" := WorkDate;
        ItemJournalLine.Description := "Work Order No." + ' ' + 'COMMIT PARTS';
        ItemJournalLine."Location Code" := 'MAIN';
        ItemJournalLine.Quantity := PN;
        ItemJournalLine.Validate(ItemJournalLine.Quantity);
        ItemJournalLine."New Location Code" := 'COMMITTED';
        ItemJournalLine.Validate(ItemJournalLine."New Location Code");
        ItemJournalLine.Insert;

        PostLine.Run(ItemJournalLine);

        ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        if ItemJournalClear.Find('-') then
            repeat
                ItemJournalClear.Delete;
            until ItemJournalClear.Next = 0;
    end;

    procedure LocateParts()
    begin
        QtyNotFound := QtyNeeded;
        WOD.SetFilter(WOD."Detail Step", 'REC');
        if WOD.Find('-') then begin
            repeat
                WOD.CalcFields(WOD."Detail Step");
                if PartsLocate.Get(WOD."Work Order No.", "Part Type", "Part No.") then begin
                    PartsLocate.CalcFields(PartsLocate."Committed Quantity");
                    if PartsLocate."Committed Quantity" > 0 then begin
                        if QtyNotFound > 0 then begin
                            QtyFound := QtyFound + PartsLocate."Committed Quantity";
                            TempPartsFound.Init;
                            TempPartsFound.TransferFields(PartsLocate);
                            TempPartsFound."Committed Quantity" := PartsLocate."Committed Quantity";
                            TempPartsFound."Detail Step" := Format(WOD."Detail Step");
                            TempPartsFound.Insert;
                        end;
                    end;
                end
            until WOD.Next = 0;
            QtyNotFound := QtyNotFound - QtyFound;
        end;
        if QtyNotFound > 0 then begin
            WOD.SetFilter(WOD."Detail Step", 'DIS');
            if WOD.Find('-') then begin
                repeat
                    WOD.CalcFields(WOD."Detail Step");
                    if PartsLocate.Get(WOD."Work Order No.", "Part Type", "Part No.") then begin
                        PartsLocate.CalcFields(PartsLocate."Committed Quantity");
                        if PartsLocate."Committed Quantity" > 0 then begin
                            QtyFound := QtyFound + PartsLocate."Committed Quantity";
                            TempPartsFound.Init;
                            TempPartsFound.TransferFields(PartsLocate);
                            TempPartsFound."Committed Quantity" := PartsLocate."Committed Quantity";
                            TempPartsFound."Detail Step" := Format(WOD."Detail Step");
                            TempPartsFound.Insert;
                        end;
                    end;
                until WOD.Next = 0;
                QtyNotFound := QtyNotFound - QtyFound;
            end;
        end;
        if QtyNotFound > 0 then begin
            WOD.SetFilter(WOD."Detail Step", 'QOT');
            if WOD.Find('-') then begin
                repeat
                    WOD.CalcFields(WOD."Detail Step");
                    if PartsLocate.Get(WOD."Work Order No.", "Part Type", "Part No.") then begin
                        PartsLocate.CalcFields(PartsLocate."Committed Quantity");
                        if PartsLocate."Committed Quantity" > 0 then begin
                            QtyFound := QtyFound + PartsLocate."Committed Quantity";
                            TempPartsFound.Init;
                            TempPartsFound.TransferFields(PartsLocate);
                            TempPartsFound."Committed Quantity" := PartsLocate."Committed Quantity";
                            TempPartsFound."Detail Step" := Format(WOD."Detail Step");
                            TempPartsFound.Insert;
                        end;
                    end;
                until WOD.Next = 0;
                QtyNotFound := QtyNotFound - QtyFound;
            end;
        end;
    end;

    procedure StealParts()
    begin
        // Searches TempPartsFound for Parts in Receiving
        TempPartsFound.Reset;
        TempPartsFound.SetCurrentKey(TempPartsFound."Detail Step", TempPartsFound."Work Order No.");
        TempPartsFound.SetFilter(TempPartsFound."Detail Step", 'REC');
        TempPartsFound.Ascending(false);
        if TempPartsFound.Find('-') then begin
            repeat
                if QtyNeeded > 0 then begin
                    if PartsSteal.Get(TempPartsFound."Work Order No.", TempPartsFound."Part Type", TempPartsFound."Part No.") then begin
                        QtyQuoted := PartsSteal."Quoted Quantity";
                        PartsSteal."Quoted Quantity" := 0;
                        CreatePartsPA;
                        Commit;
                        if TempPartsFound."Committed Quantity" > QtyNeeded then begin
                            PN := TempPartsFound."Committed Quantity" - QtyNeeded;
                            QtyNeeded := 0;
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                            AllocateSingle;
                        end;
                        if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                            PN := TempPartsFound."Committed Quantity";
                            QtyNeeded := 0;
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                            AllocateSingle;
                        end;
                        if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                            QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                            PN := TempPartsFound."Committed Quantity";
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                            AllocateSingle;
                        end;
                    end;
                end;
            until TempPartsFound.Next = 0;
        end;


        if QtyNeeded > 0 then begin
            TempPartsFound.Reset;
            TempPartsFound.SetCurrentKey(TempPartsFound."Detail Step", TempPartsFound."Work Order No.");
            TempPartsFound.SetFilter(TempPartsFound."Detail Step", 'DIS');
            TempPartsFound.Ascending(false);
            if TempPartsFound.Find('-') then begin
                repeat
                    if QtyNeeded > 0 then begin
                        if PartsSteal.Get(TempPartsFound."Work Order No.", TempPartsFound."Part Type", TempPartsFound."Part No.") then begin
                            QtyQuoted := PartsSteal."Quoted Quantity";
                            PartsSteal."Quoted Quantity" := 0;
                            CreatePartsPA;
                            Commit;
                            if TempPartsFound."Committed Quantity" > QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity" - QtyNeeded;
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                AllocateSingle;
                            end;
                            if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity";
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                AllocateSingle;
                            end;
                            if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                                QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                                PN := TempPartsFound."Committed Quantity";
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                AllocateSingle;
                            end;
                        end;
                    end;
                until TempPartsFound.Next = 0;
            end;
        end;

        if QtyNeeded > 0 then begin
            TempPartsFound.Reset;
            TempPartsFound.SetCurrentKey(TempPartsFound."Detail Step", TempPartsFound."Work Order No.");
            TempPartsFound.SetFilter(TempPartsFound."Detail Step", 'QOT');
            TempPartsFound.Ascending(false);
            if TempPartsFound.Find('-') then begin
                repeat
                    if QtyNeeded > 0 then begin
                        if PartsSteal.Get(TempPartsFound."Work Order No.", TempPartsFound."Part Type", TempPartsFound."Part No.") then begin
                            QtyQuoted := PartsSteal."Quoted Quantity";
                            PartsSteal."Quoted Quantity" := 0;
                            CreatePartsPA;
                            Commit;
                            if TempPartsFound."Committed Quantity" > QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity" - QtyNeeded;
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                AllocateSingle;
                            end;
                            if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity";
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                AllocateSingle;
                            end;
                            if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                                QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                                PN := TempPartsFound."Committed Quantity";
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                AllocateSingle;
                            end;
                        end;
                    end;
                until TempPartsFound.Next = 0;
            end;
        end;
    end;

    procedure CreatePartsPA()
    begin
        PartsSteal.CalcFields(PartsSteal."Committed Quantity", PartsSteal."In-Process Quantity");
        ReturnInventoryPA;
        PartsSteal.CalcFields(PartsSteal."Committed Quantity");
        PartsSteal."Quantity Backorder" := QtyQuoted;
        PartsSteal.Modify;
    end;

    procedure ReturnInventoryPA()
    begin
        ItemJournalLine.Init;
        ItemJournalLine."Location Code" := 'COMMITTED';
        ItemJournalLine.Description := "Work Order No." + ' ' + 'PA RETURN PARTS';
        WriteitemJournalLinePA;
        ItemJournalLine.Validate(ItemJournalLine.Quantity, PartsSteal."Committed Quantity");
        ItemJournalLine.Validate(ItemJournalLine."New Location Code", 'MAIN');
        ItemJournalLine.Insert;

        PostJournalLinePA;
    end;

    procedure WriteitemJournalLinePA()
    begin
        LineNumber := LineNumber + 10000;
        ItemJournalLine.Validate("Journal Template Name", 'TRANSFER');
        ItemJournalLine.Validate("Journal Batch Name", 'TRANSFER');
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
        ItemJournalLine."Document No." := PartsSteal."Work Order No.";
        ItemJournalLine.Validate("Item No.", Item2."No.");
        ItemJournalLine."Posting Date" := WorkDate;
        if "Serial No." <> '' then begin
            ItemJournalLine."Serial No." := PartsSteal."Serial No.";
            ItemJournalLine."New Serial No." := PartsSteal."Serial No.";
        end else begin
            ItemJournalLine."Serial No." := '';
            ItemJournalLine."New Serial No." := '';
        end;
    end;

    procedure PostJournalLinePA()
    begin
        PostLine.Run(ItemJournalLine);

        ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        if ItemJournalClear.Find('-') then
            repeat
                ItemJournalClear.Delete;
            until ItemJournalClear.Next = 0;
    end;

    procedure ReturnParts()
    begin
        TempPartsUsed.SetCurrentKey(TempPartsUsed."Work Order No.", TempPartsUsed."Part Type", TempPartsUsed."Part No.");
        TempPartsUsed.SetFilter(TempPartsUsed."Record Used", 'YES');

        if TempPartsUsed.Find('-') then begin
            repeat
                if PartsReturn.Get(TempPartsUsed."Work Order No.", TempPartsUsed."Part Type", TempPartsUsed."Part No.") then begin
                    Rec := PartsReturn;
                    "Quoted Quantity" := TempPartsUsed."Quoted Quantity";
                    //  VALIDATE("Quoted Quantity");
                    "Quantity Backorder" := TempPartsUsed."Quoted Quantity";
                    Modify;

                end;
            until TempPartsUsed.Next = 0;
        end;

        TempPartsFound.DeleteAll;
    end;

    procedure StealPartsALL()
    begin
        // Searches TempPartsFound for Parts in Receiving
        TempPartsFound.Reset;
        TempPartsFound.SetCurrentKey(TempPartsFound."Detail Step", TempPartsFound."Work Order No.");
        TempPartsFound.SetFilter(TempPartsFound."Detail Step", 'REC');
        TempPartsFound.Ascending(false);
        if TempPartsFound.Find('-') then begin
            repeat
                if QtyNeeded > 0 then begin
                    if PartsSteal.Get(TempPartsFound."Work Order No.", TempPartsFound."Part Type", TempPartsFound."Part No.") then begin
                        QtyQuoted := PartsSteal."Quoted Quantity";
                        PartsSteal."Quoted Quantity" := 0;
                        CreatePartsPA;
                        Commit;
                        if TempPartsFound."Committed Quantity" > QtyNeeded then begin
                            PN := TempPartsFound."Committed Quantity" - QtyNeeded;
                            QtyNeeded := 0;
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                            Allocate;
                        end;
                        if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                            PN := TempPartsFound."Committed Quantity";
                            QtyNeeded := 0;
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                            Allocate;
                        end;
                        if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                            QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                            PN := TempPartsFound."Committed Quantity";
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                            Allocate;
                        end;
                    end;
                end;
            until TempPartsFound.Next = 0;
        end;


        if QtyNeeded > 0 then begin
            TempPartsFound.Reset;
            TempPartsFound.SetCurrentKey(TempPartsFound."Detail Step", TempPartsFound."Work Order No.");
            TempPartsFound.SetFilter(TempPartsFound."Detail Step", 'DIS');
            TempPartsFound.Ascending(false);
            if TempPartsFound.Find('-') then begin
                repeat
                    if QtyNeeded > 0 then begin
                        if PartsSteal.Get(TempPartsFound."Work Order No.", TempPartsFound."Part Type", TempPartsFound."Part No.") then begin
                            QtyQuoted := PartsSteal."Quoted Quantity";
                            PartsSteal."Quoted Quantity" := 0;
                            CreatePartsPA;
                            Commit;
                            if TempPartsFound."Committed Quantity" > QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity" - QtyNeeded;
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                Allocate;
                            end;
                            if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity";
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                Allocate;
                            end;
                            if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                                QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                                PN := TempPartsFound."Committed Quantity";
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                Allocate;
                            end;
                        end;
                    end;
                until TempPartsFound.Next = 0;
            end;
        end;

        if QtyNeeded > 0 then begin
            TempPartsFound.Reset;
            TempPartsFound.SetCurrentKey(TempPartsFound."Detail Step", TempPartsFound."Work Order No.");
            TempPartsFound.SetFilter(TempPartsFound."Detail Step", 'QOT');
            TempPartsFound.Ascending(false);
            if TempPartsFound.Find('-') then begin
                repeat
                    if QtyNeeded > 0 then begin
                        if PartsSteal.Get(TempPartsFound."Work Order No.", TempPartsFound."Part Type", TempPartsFound."Part No.") then begin
                            QtyQuoted := PartsSteal."Quoted Quantity";
                            PartsSteal."Quoted Quantity" := 0;
                            CreatePartsPA;
                            Commit;
                            if TempPartsFound."Committed Quantity" > QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity" - QtyNeeded;
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                Allocate;
                            end;
                            if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity";
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                Allocate;
                            end;
                            if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                                QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                                PN := TempPartsFound."Committed Quantity";
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                                Allocate;
                            end;
                        end;
                    end;
                until TempPartsFound.Next = 0;
            end;
        end;
    end;
}

