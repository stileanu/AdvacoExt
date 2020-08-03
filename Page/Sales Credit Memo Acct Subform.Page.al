page 50069 "Sales Credit Memo Acct Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER("Credit Memo"));

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
                        NoOnAfterValidate();
                    end;
                }
                field(Description; Description)
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field(Quantity; Quantity)
                {
                    Caption = 'Qty';

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate();
                    end;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate();
                    end;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                }
                field(Amount; Amount)
                {
                    Editable = false;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
    end;

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesHeader: Record "Sales Header";

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Calc. Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Explode BOM", Rec);
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        if not "Drop Shipment" then
            Error('The current sales line is not a drop shipment.');
        PurchHeader.SetRange("No.", "Purchase Order No.");
        PurchOrder.SetTableView(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            CurrPage.Update;
    end;

    procedure ShowReservation2()
    begin
        Find;
        Rec.ShowReservation;
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;

    procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
    end;

    procedure QtyOnAfterValidate()
    begin
        if Reserve = Reserve::Always then begin
            CurrPage.SaveRecord;
            AutoReserve();
        end;
    end;

    procedure CrossRefItemOnAfterValidate()
    begin
        //>> CrossReference - start
        InsertExtendedText(false);
        //<< CrossReference - end
    end;
}

