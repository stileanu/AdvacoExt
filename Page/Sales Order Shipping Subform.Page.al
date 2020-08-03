page 50061 "Sales Order Shipping Subform"
{
    // 10/4/00 RJK HTCS
    //   Removed Purchaser Code from Form.
    // 10/24/00 RJK HTCS
    //   Added Commission Calculated to Form.

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;

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
                    Caption = 'Qty';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate;
                    end;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                }
                field("Shipped Qty."; "Shipped Qty.")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Visible = false;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    Visible = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        /*99999
        CALCFIELDS("Qty. Picked (Base)","Qty. Staged/Assembled (Base)");
        "Qty. Picked" := ("Qty. Picked (Base)" / "Qty. per Unit of Measure");
        "Qty. Staged/Assembled" := ("Qty. Staged/Assembled (Base)" / "Qty. per Unit of Measure");
        99999*/

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchLine: Record "Purchase Line";
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

    procedure ShowNonStocks()
    begin
        Rec.ShowDimensions;
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
}

