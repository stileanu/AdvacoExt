page 50079 "Purch. Invoice Subform Act"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER(Invoice));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                }
                field("Quantity Received"; "Quantity Received")
                {
                }
                field("Qty. to Receive"; "Qty. to Receive")
                {
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("Tax Liable"; "Tax Liable")
                {
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchaseHeader: Record "Purchase Header";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure GetReceipt()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Get Receipt", Rec);
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            CurrPage.Update;
    end;

    procedure ShowReservation2()
    begin
        Find;
        Rec.ShowReservation;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
    end;
}

