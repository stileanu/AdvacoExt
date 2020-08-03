page 50067 "Sales Invoice Acct Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Document Type"=FILTER(Invoice));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type;Type)
                {
                }
                field("No.";"No.")
                {

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate();
                    end;
                }
                field(Description;Description)
                {
                }
                field(Quantity;Quantity)
                {
                    Caption = 'Qty';

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate();
                    end;
                }
                field("Quantity Invoiced";"Quantity Invoiced")
                {
                }
                field("Qty. to Invoice";"Qty. to Invoice")
                {
                }
                field("Quantity Shipped";"Quantity Shipped")
                {
                }
                field("Qty. to Ship";"Qty. to Ship")
                {
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                }
                field("Unit Price";"Unit Price")
                {
                }
                field(Amount;Amount)
                {
                    Editable = false;
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                }
                field("Reserved Quantity";"Reserved Quantity")
                {
                }
                field(Reserve;Reserve)
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate();
                    end;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Visible = false;
                }
                field("Tax Group Code";"Tax Group Code")
                {
                }
                field("Line Discount %";"Line Discount %")
                {
                }
                field("Allow Invoice Disc.";"Allow Invoice Disc.")
                {
                }
                field("Inv. Discount Amount";"Inv. Discount Amount")
                {
                }
                field("Appl.-to Item Entry";"Appl.-to Item Entry")
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
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location=R;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromSalesLine(Rec,ItemAvailFormsMgt.ByLocation)
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
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        SalesHeader: Record "Sales Header";

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Calc. Discount",Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Sales-Explode BOM",Rec);
    end;

    procedure OpenPurchOrderForm()
    var
        PurchHeader: Record "Purchase Header";
        PurchOrder: Page "Purchase Order";
    begin
        if not "Drop Shipment" then
          Error('The current sales line is not a drop shipment.');
        PurchHeader.SetRange("No.","Purchase Order No.");
        PurchOrder.SetTableView(PurchHeader);
        PurchOrder.Editable := false;
        PurchOrder.Run;
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) then begin
          CurrPage.SaveRecord;
          TransferExtendedText.InsertSalesExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
          CurrPage.Update;
    end;

    procedure ShowReservation()
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

