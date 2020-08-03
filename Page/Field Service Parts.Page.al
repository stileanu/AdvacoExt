page 50152 "Field Service Parts"
{
    SourceTable = FieldService;

    layout
    {
        area(content)
        {
            group(Control1220060008)
            {
                ShowCaption = false;
                grid(Control1220060007)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060006)
                    {
                        ShowCaption = false;
                        field("Field Service No.";"Field Service No.")
                        {
                            Editable = false;
                        }
                        field(Customer;Customer)
                        {
                            Editable = false;
                        }
                        field("Date Ordered";"Date Ordered")
                        {
                            Caption = 'Order Date';
                            Editable = false;
                        }
                    }
                }
            }
            part(Partsline;"Field Service Parts List")
            {
                SubPageLink = "Work Order No."=FIELD("Field Service No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Allocate Parts")
            {
                Caption = 'Allocate Parts';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // CurrForm.Partslines.FORM.PartsAllocation

                    Parts.SetRange(Parts."Work Order No.","Field Service No.");
                    PAGE.RunModal(PAGE :: "Parts Allocation",Parts);
                end;
            }
            action("Pull Parts")
            {
                Caption = 'Pull Parts';
                Image = Allocations;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Parts.SetCurrentKey("Work Order No.","Part Type","Part No.");
                    Parts.SetRange(Parts."Work Order No.","Field Service No.");
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        MissingReason := false;
        Parts.Reset;
        Parts.SetCurrentKey("Work Order No.","Part Type");
        Parts.SetRange(Parts."Work Order No.",WOS."Order No.");
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
        WOS: Record Status;
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
        CustFile: Text[250];

    procedure RemoveInventory()
    begin

        if RemoveInventoryQty > 0 then begin
         if WOP."Part Type" = WOP."Part Type" :: Item then begin
          ItemJournalLine.Init;
          ItemJournalLine."Journal Template Name" := 'ITEM';
          ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
          ItemJournalLine."Journal Batch Name" := 'UNREPAIR';
          ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
          ItemJournalLine."Line No." := LineNumber;
          ItemJournalLine."Entry Type" := 3; //Negative Adjustment
          ItemJournalLine."Document No." := "Field Service No.";
          ItemJournalLine."Item No." := WOP."Part No.";
          ItemJournalLine.Validate(ItemJournalLine."Item No.");
          ItemJournalLine."Posting Date" := WorkDate;
          ItemJournalLine.Description := "Field Service No." + ' ' + 'UNREPAIRABLE REMOVE';
          ItemJournalLine."Location Code" := 'MAIN';
          ItemJournalLine.Quantity := RemoveInventoryQty;
          ItemJournalLine.Validate(ItemJournalLine.Quantity);

          if SerialNo <> '' then begin
            ItemJournalLine."Serial No." := SerialNo;
            ItemJournalLine."New Serial No." := SerialNo;
          end;

          ItemJournalLine.Insert;

          PostLine.Run(ItemJournalLine);

          ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name",ItemJournalLine."Journal Template Name");
          ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name",ItemJournalLine."Journal Batch Name");
          if ItemJournalClear.Find('-') then
            repeat
              ItemJournalClear.Delete;
            until ItemJournalClear.Next =0;
         end;
        end;
    end;

    procedure ReturnInventory()
    begin
        if ReturnInventoryQty > 0 then begin
          if WOP."Part Type" = WOP."Part Type" :: Item then begin
            ItemJournalLine.Init;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'UNREPAIR';
            ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Entry Type" := 4; //Transfer
            ItemJournalLine."Document No." := "Field Service No.";
            ItemJournalLine."Item No." := WOP."Part No.";
            ItemJournalLine.Validate(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WorkDate;
            ItemJournalLine.Description :=  "Field Service No." + ' ' + 'UNREPAIRABLE RETURN';
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

            ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name",ItemJournalLine."Journal Template Name");
            ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name",ItemJournalLine."Journal Batch Name");
            if ItemJournalClear.Find('-') then
              repeat
                ItemJournalClear.Delete;
              until ItemJournalClear.Next =0;
          end;
        end;
    end;
}

