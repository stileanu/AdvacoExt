page 50055 "Return Committed Parts"
{
    SourceTable = Item;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                group(Control1000000002)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
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

                    Parts.SetRange(Parts."Part No.", "No.");
                    if Parts.Find('-') then begin
                        ///--!
                        //Window.Open('Enter the amount to Allocate #1#########', PN);
                        //Window.Input();
                        //Window.Close;
                        vPN := PN;
                        InValDialog.SetValueType(InValType::IntegerType, 'Enter the amount to Allocate:');
                        if InValDialog.RunModal() = Action::OK then
                            InValDialog.GetIntegerValue(PN);
                        PN := vPN;
                        if PN <= 0 then
                            Error('Can''t Allocate A Negative or Zero Quantity');

                        QtyNeeded := PN;
                        LocateParts;
                        StealParts;


                        // HEF RETURNING QTY QUOTED TO WORK ORDERS PARTS STOLEN FROM AND RESETING VARIABLES
                        // CurrentRecord := Rec;
                        ReturnParts;
                        Commit;
                        // Rec := CurrentRecord;
                        QtyNeeded := 0;
                        QtyFound := 0;
                        QtyNotFound := 0;
                        PN := 0;
                        QtyQuoted := 0;
                        Commit;
                        TempPartsUsed.DeleteAll;
                    end else
                        Error('No Parts Committed');
                end;
            }
        }
    }

    var
        vPN: Variant;
        InValDialog: Page InputValueDialog;
        InValType: Enum InValueType;
        Parts: Record Parts;
        WOD: Record WorkOrderDetail;
        TempPartsFound: Record "Temp Parts Found";
        Item2: Record Item;
        PN: Integer;
        Item: Record Item;
        Ok: Boolean;
        Window: Dialog;
        QtyNeeded: Decimal;
        QtyFound: Decimal;
        QtyNotFound: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        PartsSteal: Record Parts;
        TempPartsUsed: Record "Temp Parts Found";
        PartsLocate: Record Parts;
        CurrentRecord: Record Parts;
        PartsReturn: Record Parts;
        QtyQuoted: Decimal;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    procedure LocateParts()
    begin
        QtyNotFound := QtyNeeded;
        WOD.SetFilter(WOD."Detail Step", 'REC');
        if WOD.Find('-') then begin
            repeat
                WOD.CalcFields(WOD."Detail Step");
                if PartsLocate.Get(WOD."Work Order No.", Parts."Part Type", "No.") then begin
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
                    if PartsLocate.Get(WOD."Work Order No.", Parts."Part Type", "No.") then begin
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
                    if PartsLocate.Get(WOD."Work Order No.", Parts."Part Type", "No.") then begin
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
                        end;
                        if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                            PN := TempPartsFound."Committed Quantity";
                            QtyNeeded := 0;
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                        end;
                        if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                            QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                            PN := TempPartsFound."Committed Quantity";
                            TempPartsFound."Record Used" := 'YES';
                            TempPartsFound.Modify;
                        end;
                    end;
                end;
            until TempPartsFound.Next = 0;
        end;

        // Searches TempPartsFound for Parts in Disassembly
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
                            end;
                            if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity";
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                            end;
                            if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                                QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                                PN := TempPartsFound."Committed Quantity";
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                            end;
                        end;
                    end;
                until TempPartsFound.Next = 0;
            end;
        end;

        // Searches TempPartsFound for Parts in Quote
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
                            end;
                            if TempPartsFound."Committed Quantity" = QtyNeeded then begin
                                PN := TempPartsFound."Committed Quantity";
                                QtyNeeded := 0;
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
                            end;
                            if TempPartsFound."Committed Quantity" < QtyNeeded then begin
                                QtyNeeded := QtyNeeded - TempPartsFound."Committed Quantity";
                                PN := TempPartsFound."Committed Quantity";
                                TempPartsFound."Record Used" := 'YES';
                                TempPartsFound.Modify;
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
        ItemJournalLine.Description := TempPartsFound."Work Order No." + ' ' + 'INV ADJ RETURN PARTS';
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
        ItemJournalLine.Validate("Item No.", TempPartsFound."Part No.");
        ItemJournalLine."Posting Date" := WorkDate;
        if PartsSteal."Serial No." <> '' then begin
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
                    // Rec := PartsReturn;
                    PartsReturn."Quoted Quantity" := TempPartsUsed."Quoted Quantity";
                    PartsReturn."Quantity Backorder" := TempPartsUsed."Quoted Quantity";
                    PartsReturn.Modify;

                end;
            until TempPartsUsed.Next = 0;
        end;

        TempPartsFound.DeleteAll;
    end;
}

