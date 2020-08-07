page 50031 "Special Inquiry"
{
    // 2011_06_09 ADV
    //   Added "Tool ID" field to the form.
    // 2011_08_25 ADV
    //   Added "Order Adjustment" and "Quote Price" controls
    // 2011_09_01 ADV
    //   Allow only sales to see those two fields
    // 2016_02_27 ADV
    //   Added new control for field 32 <Initial Order Type>. Included in F7 functionality

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group("SEARCH BY:")
            {
                Caption = 'SEARCH BY:';
            }
            group("Click in Field to search")
            {
                Caption = 'Click in Field to search';
                group("Press F7 and enter Criteria")
                {
                    Caption = 'Press F7 and enter Criteria';
                    field("Customer ID"; "Customer ID")
                    {
                        ApplicationArea = All;
                    }
                    field("Work Order Date"; "Work Order Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Work Order No."; "Work Order No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Model No."; "Model No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Serial No."; "Serial No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Customer PO No."; "Customer PO No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Customer Part No."; "Customer Part No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Work Order Master No."; "Work Order Master No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Complete; Complete)
                    {
                        ApplicationArea = All;
                    }
                    field("Order Adj."; "Order Adj.")
                    {
                        ApplicationArea = All;
                        Caption = 'Order Adjustment';
                        Visible = OrderAdjVisible;
                    }
                    field(QuotePrice; QuotePrice)
                    {
                        ApplicationArea = All;
                        Caption = 'Quote Price';
                        Visible = QuotePriceVisible;
                    }
                    field("Initial Order Type"; "Initial Order Type")
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
            action("&Detail Screen")
            {
                ApplicationArea = All;
                Caption = '&Detail Screen';
                Enabled = DetailEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", "Work Order No.");
                    PAGE.Run(50002, WOD);
                end;
            }
            action("Current &Status")
            {
                ApplicationArea = All;
                Caption = 'Current &Status';
                Promoted = true;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", "Work Order No.");
                    PAGE.Run(50007, WOD);
                end;
            }
            action("&Parts List")
            {
                ApplicationArea = All;
                Caption = '&Parts List';
                Promoted = true;

                trigger OnAction()
                begin
                    Parts.SetRange(Parts."Work Order No.", "Work Order No.");
                    PAGE.Run(50014, Parts);
                end;
            }
            action("Detail &List")
            {
                ApplicationArea = All;
                Caption = 'Detail &List';
                Promoted = true;
                RunObject = Page "Work Order Vendor Shipping";
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPage.Editable(false);

        // 2011_08_25 ADV: Start
        QuotePrice := 0;

        CalcFields("Original Parts Price", "Original Labor Price");
        if Quote = Quote::Accepted then
            QuotePrice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";

        if Quote = Quote::"Not Repairable" then
            QuotePrice := "Unrepairable Charge";
        // 2011_08_25 ADV: End
    end;

    trigger OnOpenPage()
    begin
        Member.CalcFields(Member."User Name");
        OK := true;
        Member.SetRange(Member."User Name", UserId);
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALES') or (Member."Role ID" = 'SUPER') then
                    OK := false;
            until Member.Next = 0;
        end;

        if OK then begin
            DetailEnabled := false;
            // 2011_09_01 - Start
            //END;
        end else begin
            OrderAdjVisible := true;
            QuotePriceVisible := true;
        end;
        // 2011_09_01 - End
    end;

    var
        WOD: Record WorkOrderDetail;
        Parts: Record Parts;
        Member: Record "Access Control";
        OK: Boolean;
        QuotePrice: Decimal;
        WOS: Record Status;
        [InDataSet]
        DetailEnabled: Boolean;
        [InDataSet]
        OrderAdjVisible: Boolean;
        [InDataSet]
        QuotePriceVisible: Boolean;
}

