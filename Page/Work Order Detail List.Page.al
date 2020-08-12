page 50001 "Work Order Detail List"
{
    // 2011_06_09 ADV
    //   Added "Tool ID" field to the form.
    // 2011_08_25 ADV
    //   Added "Order Adjustment" and "Quote Price" controls
    // 2011_09_01 ADV
    //   Allow only sales to see those two fields
    // 2011_11_25 ADV
    //   Added "Labor Hours Quoted" and "Current Reg Hours Used" fields to the form. (Warren's Req.)
    // 2012_02_13 ADV
    //   Created a second Tablebox for power users (Kaye, Admin) to display certain fields.
    // 2012_02_29 ADV
    //   Eliminated second box. It do not allow Copy and Paste from second TableBox.
    //   Rewritten the code to use one TableBox and hide the columns.
    // 2012_08_26 ADV
    //   Made Diagnosis field visible for everyone.
    // 2016_02_27 ADV
    //   Added new column - <Initial Order Type> to show the original Order Type field.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Customer ID"; "Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                    TableRelation = WorkOrderDetail."Work Order No.";
                }
                field("Work Order Master No."; "Work Order Master No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Model No."; "Model No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Part No."; "Customer Part No.")
                {
                    ApplicationArea = All;
                }
                field("Customer PO No."; "Customer PO No.")
                {
                    ApplicationArea = All;
                }
                field("Work Order Date"; "Work Order Date")
                {
                    ApplicationArea = All;
                }
                field("Order Type"; "Order Type")
                {
                    ApplicationArea = All;
                }
                field("Initial Order Type"; "Initial Order Type")
                {
                    ApplicationArea = All;
                }
                field("Ship Date"; "Ship Date")
                {
                    ApplicationArea = All;
                }
                field("Tool ID"; "Tool ID")
                {
                    ApplicationArea = All;
                }
                field(QuotePrice; QuotePrice)
                {
                    ApplicationArea = All;
                    Caption = 'Quote Price';
                    Visible = QuotePriceVisible;
                }
                field("Order Adj."; "Order Adj.")
                {
                    ApplicationArea = All;
                    Visible = OrderAdjVisible;
                }
                field("Labor Hours Quoted"; "Labor Hours Quoted")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Current Reg Hours Used"; "Current Reg Hours Used")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Notes; Notes)
                {
                    ApplicationArea = All;
                    Visible = NotesVisible;
                }
                field(Diagnosis; Diagnosis)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Current &Status")
            {
                ApplicationArea = All;
                Caption = 'Current &Status';

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

                trigger OnAction()
                begin
                    Parts.SetRange(Parts."Work Order No.", "Work Order No.");
                    PAGE.Run(50005, Parts);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        //IF NOT ((USERID = 'KAYE') OR (USERID = 'ADMIN')) THEN BEGIN
        if not (UserId = 'KAYE') then begin
            NotesVisible := false;
            // 2013_08_26 Start
            //CurrForm.Diagnosis.VISIBLE := FALSE;
            // 2013_08_26 End
        end;

        // 2011_09_01 - Start
        if OK then begin
            QuotePriceVisible := false;
            OrderAdjVisible := false;
        end;
        // 2011_08_25 ADV: Start
    end;

    trigger OnAfterGetRecord()
    begin
        //IF NOT ((USERID = 'KAYE') OR (USERID = 'ADMIN')) THEN BEGIN
        if not (UserId = 'KAYE') then begin
            NotesVisible := false;
            // 2013_08_26 Start
            //CurrForm.Diagnosis.VISIBLE := FALSE;
            // 2013_08_26 End
        end;

        // 2011_09_01 - Start
        if OK then begin
            QuotePriceVisible := false;
            OrderAdjVisible := false;
        end else begin
            // 2011_08_25 ADV: Start
            QuotePrice := 0;

            CalcFields("Original Parts Price", "Original Labor Price");
            if Quote = Quote::Accepted then
                QuotePrice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";

            if Quote = Quote::"Not Repairable" then
                QuotePrice := "Unrepairable Charge";
            // 2011_08_25 ADV: End
        end;
        // 2011_09_01 - End
    end;

    trigger OnOpenPage()
    begin
        // 2011_09_01 - Start
        OK := true;
        Member.CalcFields("User Name");
        Member.SetRange(Member."User Name", UserId);

        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALES') or (Member."Role ID" = 'SUPER') then
                    OK := false;
            until Member.Next = 0;
        end;

        //IF NOT ((USERID = 'KAYE') OR (USERID = 'ADMIN')) THEN BEGIN
        if not (UserId = 'KAYE') then begin
            NotesVisible := false;
            // 2013_08_26 Start
            //CurrForm.Diagnosis.VISIBLE := FALSE;
            // 2013_08_26 End
        end;

        if not OK then begin
            OrderAdjVisible := true;
            QuotePriceVisible := true;
        end;
        // 2011_09_01 - End
    end;

    var
        Parts: Record Parts;
        WOD: Record WorkOrderDetail;
        QuotePrice: Decimal;
        Member: Record "Access Control";
        OK: Boolean;
        [InDataSet]
        NotesVisible: Boolean;
        [InDataSet]
        OrderAdjVisible: Boolean;
        [InDataSet]
        QuotePriceVisible: Boolean;
}

