codeunit 50000 "Check Availablility"
{
    TableNo = 50003;

    trigger OnRun();
    begin
        CurrentRecord := Rec;
        LineNumber := LineNumber + 10000;
        CALCFIELDS("Committed Quantity");
        IF "BOM Quantity" > "Committed Quantity" THEN BEGIN
            OrderAmount := "BOM Quantity" - "Committed Quantity";
            IF Item.GET("Part No.") THEN BEGIN
                Item.SETRANGE(Item."Location Filter", 'MAIN');
                Item.CALCFIELDS(Item.Inventory);
                IF Item.Inventory <> 0 THEN BEGIN
                    IF Item.Inventory < OrderAmount THEN BEGIN
                        BackOrder;
                    END ELSE BEGIN
                        FillOrder;
                    END;
                END;
            END;
        END ELSE BEGIN
            IF "BOM Quantity" < "Committed Quantity" THEN BEGIN
                IF Item.GET("Part No.") THEN BEGIN
                    ReturnStock;
                END;
            END;
        END;
    end;

    var
        PartList: Record Parts;
        Item: Record Item;
        LineNumber: Integer;
        OrderAmount: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        CurrentRecord: Record Parts;
        PostLine: Codeunit "Item Jnl.-Post Line";
        ItemJournalClear: Record "Item Journal Line";

    procedure BackOrder();
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Journal Batch Name" := 'COMMITTED';
        ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name");
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Entry Type" := 4; //Transfer
        ItemJournalLine."Document No." := CurrentRecord."Work Order No.";
        ItemJournalLine."Item No." := Item."No.";
        ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
        ItemJournalLine."Posting Date" := WORKDATE;
        ItemJournalLine.Description := CurrentRecord."Work Order No." + ' ' + 'COMMIT PARTS';
        ItemJournalLine."Location Code" := 'MAIN';
        ItemJournalLine."Inventory Posting Group" := 'SERVICE';
        ItemJournalLine.Quantity := OrderAmount - CurrentRecord."Quantity Backorder";
        ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
        ItemJournalLine."New Location Code" := 'COMMITTED';
        ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code");
        ItemJournalLine.INSERT;

        PostLine.RUN(ItemJournalLine);

        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        IF ItemJournalClear.FIND('-') THEN
            REPEAT
                ItemJournalClear.DELETE;
            UNTIL ItemJournalClear.NEXT = 0;
    end;

    procedure FillOrder();
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Journal Batch Name" := 'COMMITTED';
        ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name");
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Entry Type" := 4; //Transfer
        ItemJournalLine."Document No." := CurrentRecord."Work Order No.";
        ItemJournalLine."Item No." := Item."No.";
        ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
        ItemJournalLine."Posting Date" := WORKDATE;
        ItemJournalLine.Description := CurrentRecord."Work Order No." + ' ' + 'COMMIT PARTS';
        ItemJournalLine."Location Code" := 'MAIN';
        ItemJournalLine."Inventory Posting Group" := 'SERVICE';
        ItemJournalLine.Quantity := OrderAmount;
        ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
        ItemJournalLine."New Location Code" := 'COMMITTED';
        ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code");
        ItemJournalLine.INSERT;

        PostLine.RUN(ItemJournalLine);

        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        IF ItemJournalClear.FIND('-') THEN
            REPEAT
                ItemJournalClear.DELETE;
            UNTIL ItemJournalClear.NEXT = 0;
    end;

    procedure ReturnStock();
    begin
        ItemJournalLine.INIT;
        ItemJournalLine."Journal Template Name" := 'TRANSFER';
        ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name");
        ItemJournalLine."Journal Batch Name" := 'COMMITTED';
        ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name");
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Entry Type" := 4; //Transfer
        ItemJournalLine."Document No." := CurrentRecord."Work Order No.";
        ItemJournalLine."Item No." := Item."No.";
        ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
        ItemJournalLine."Posting Date" := WORKDATE;
        ItemJournalLine.Description := CurrentRecord."Work Order No." + ' ' + 'RETURN PARTS';
        ItemJournalLine."Location Code" := 'COMMITTED';
        ItemJournalLine."Inventory Posting Group" := 'SERVICE';
        ItemJournalLine.Quantity := CurrentRecord."Committed Quantity" - CurrentRecord."BOM Quantity";
        ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
        ItemJournalLine."New Location Code" := 'MAIN';
        ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code");
        ItemJournalLine.INSERT;

        PostLine.RUN(ItemJournalLine);

        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        IF ItemJournalClear.FIND('-') THEN
            REPEAT
                ItemJournalClear.DELETE;
            UNTIL ItemJournalClear.NEXT = 0;
    end;
}

