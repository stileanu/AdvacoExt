page 50063 "Sales Order Sales Subform"
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
    SourceTableView = WHERE("Document Type"=FILTER(Order));

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
                field("Vendor No.";"Vendor No.")
                {
                }
                field("Vendor Item No.";"Vendor Item No.")
                {
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
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                    Visible = false;
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
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                }
                field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                }
                field("Commission Calculated";"Commission Calculated")
                {
                }
                field("Purchase Order No.";"Purchase Order No.")
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {

                    trigger OnValidate()
                    begin
                        QtyOnAfterValidate();
                    end;
                }
                field("Line Discount %";"Line Discount %")
                {
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                }
                field("Qty. to Ship";"Qty. to Ship")
                {
                }
                field("Quantity Shipped";"Quantity Shipped")
                {
                }
                field("Qty. to Invoice";"Qty. to Invoice")
                {
                }
                field("Quantity Invoiced";"Quantity Invoiced")
                {
                }
                field("Shipment Date";"Shipment Date")
                {
                    Visible = false;
                }
                field("Package Tracking No.";"Package Tracking No.")
                {
                    Visible = false;
                }
                field("Drop Shipment";"Drop Shipment")
                {
                    Visible = false;
                }
                field("Bin Code";"Bin Code")
                {
                    Visible = false;
                }
                field("Unit of Measure";"Unit of Measure")
                {
                    Visible = false;
                }
                field("Blanket Order No.";"Blanket Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order Line No.";"Blanket Order Line No.")
                {
                    Visible = false;
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
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

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
}

