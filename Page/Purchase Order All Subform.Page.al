page 50075 "Purchase Order All Subform"
{
    // 04/26/16
    //   Added control for field <Orig. Expected Receipt Date> for Vendor Responsiveness report
    // 07/21/19
    //   Update Form when activated.

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
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
                        NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                }
                field(Description;Description)
                {
                }
                field(Quantity;Quantity)
                {
                    Caption = 'Qty. Ordered';
                }
                field("Quantity Invoiced";"Quantity Invoiced")
                {
                    Caption = 'Qty. Invoiced';
                }
                field("Qty. to Invoice";"Qty. to Invoice")
                {
                }
                field("Quantity Received";"Quantity Received")
                {
                    Caption = 'Qty. Received';
                }
                field("Qty. to Receive";"Qty. to Receive")
                {
                }
                field("Direct Unit Cost";"Direct Unit Cost")
                {
                }
                field(Amount;Amount)
                {
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                }
                field("Order No.";"Order No.")
                {
                }
                field("Code";Code)
                {
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                }
                field("Labels to Print";"Labels to Print")
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Unit of Measure";"Unit of Measure")
                {
                }
                field("Receiving Inspection";"Receiving Inspection")
                {
                }
                field(Inspector;Inspector)
                {
                }
                field("Inspection Date";"Inspection Date")
                {
                }
                field("Indirect Cost %";"Indirect Cost %")
                {
                }
                field("Unit Cost (LCY)";"Unit Cost (LCY)")
                {
                }
                field("Line Discount Amount";"Line Discount Amount")
                {
                }
                field("Expected Receipt Date";"Expected Receipt Date")
                {
                }
                field("Orig. Expected Receipt Date";"Orig. Expected Receipt Date")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                }
                field("Tax Group Code";"Tax Group Code")
                {
                }
                field("Tax Area Code";"Tax Area Code")
                {
                }
                field("Unit Price (LCY)";"Unit Price (LCY)")
                {
                }
                field("Bin Code";"Bin Code")
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
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchaseHeader: Record "Purchase Header";

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Calc.Discount",Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM",Rec);
    end;

    procedure OpenSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        SalesHeader.SetRange("No.","Sales Order No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run;
    end;

    procedure OpenSpecOrderSalesOrderForm()
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        //<<  Distribution - start
        SalesHeader.SetRange("No.","Special Order Sales No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run;
        //>>  Distribution - end
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) then begin
          CurrPage.SaveRecord;
          TransferExtendedText.InsertPurchExtText(Rec);
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

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
    end;
}

