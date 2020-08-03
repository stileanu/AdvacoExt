page 50068 "Sales Credit Memo Accounting"
{
    // 07/21/20
    //   Code in OnOpenPage and OnAfterGetRecord triggers is removed because it's based on obsolete AD functionality

    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type","Location Code","No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060035)
                {
                    ShowCaption = false;
                    field("No.";"No.")
                    {
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                              CurrPage.Update;
                        end;
                    }
                    field("Sell-to Customer No.";"Sell-to Customer No.")
                    {
                    }
                    field("Sell-to Customer Name";"Sell-to Customer Name")
                    {
                        Editable = false;
                    }
                    field("Sell-to Address";"Sell-to Address")
                    {
                        Editable = false;
                    }
                    field("Sell-to Address 2";"Sell-to Address 2")
                    {
                        Editable = false;
                    }
                    field("Sell-to City";"Sell-to City")
                    {
                        Editable = false;
                    }
                    field("Sell-to Post Code";"Sell-to Post Code")
                    {
                        Editable = false;
                    }
                    field("Sell-to County";"Sell-to County")
                    {
                        Editable = false;
                    }
                    field("Sell-to Contact";"Sell-to Contact")
                    {
                        Editable = false;
                    }
                }
                group(Control1220060059)
                {
                    ShowCaption = false;
                    field("Posting Date";"Posting Date")
                    {
                    }
                    field("Document Date";"Document Date")
                    {
                    }
                    field("Salesperson Code";"Salesperson Code")
                    {
                        Caption = 'Inside Sales';
                    }
                    field(Rep;Rep)
                    {
                    }
                    field(Status;Status)
                    {
                    }
                }
            }
            part(SalesLines;"Sales Credit Memo Acct Subform")
            {
                SubPageLink = "Document No."=FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                group(Control1220060038)
                {
                    ShowCaption = false;
                    field("Bill-to Customer No.";"Bill-to Customer No.")
                    {
                    }
                    field("Bill-to Name";"Bill-to Name")
                    {
                    }
                    field("Bill-to Address";"Bill-to Address")
                    {
                    }
                    field("Bill-to Address 2";"Bill-to Address 2")
                    {
                    }
                    field("Bill-to City";"Bill-to City")
                    {
                    }
                    field("Bill-to County";"Bill-to County")
                    {
                    }
                    field("Bill-to Post Code";"Bill-to Post Code")
                    {
                    }
                    field("Bill-to Contact";"Bill-to Contact")
                    {
                    }
                }
                group(Control1220060028)
                {
                    ShowCaption = false;
                    field("Your Reference";"Your Reference")
                    {
                        Caption = 'Customer P.O Number';
                    }
                    field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                    {
                        Caption = 'Project Code';
                    }
                }
                field("Applies-to Doc. Type";"Applies-to Doc. Type")
                {
                }
                field("Applies-to Doc. No.";"Applies-to Doc. No.")
                {
                }
                field("Applies-to ID";"Applies-to ID")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                }
                field("Tax Area Code";"Tax Area Code")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    RunObject = Page "Sales Statistics";
                    RunPageLink = "Document Type"=FIELD("Document Type"),
                                  "No."=FIELD("No.");
                    ShortCutKey = 'F9';
                }
                action(Card)
                {
                    Caption = 'Card';
                    RunObject = Page "Customer Card";
                    RunPageLink = "No."=FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type"=FIELD("Document Type"),
                                  "No."=FIELD("No.");
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
                group("Credit &Memo")
                {
                    Caption = 'Credit &Memo';
                    Image = ReleaseDoc;
                }
                action("Calculate &Invoice Discount")
                {
                    AccessByPermission = TableData "Cust. Invoice Disc."=R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action(CopyDocument)
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RunModal;
                        Clear(CopySalesDoc);
                    end;
                }
                action("Insert &Ext. Text")
                {
                    AccessByPermission = TableData "Cust. Invoice Disc."=R;
                    Caption = 'Insert &Ext. Text';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.InsertExtendedText(true);
                    end;
                }
                action("Apply Entries")
                {
                    Caption = 'Apply Entries';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Sales Header Apply",Rec);
                    end;
                }
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReleaseVisible;

                trigger OnAction()
                begin
                    // >> Distribution - start
                    if not UpdateAllowed then
                      exit;
                    // << Distribution - end

                    //>>  Whse. Management - start
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    //<<  Whse. Management - end

                    if Status = Status::Released then begin
                      ReopenVisible := true;
                      ReleaseVisible := false;
                    end else begin
                      ReopenVisible := false;
                      ReleaseVisible := true;
                    end;
                    CurrPage.Update;
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReopenVisible;

                trigger OnAction()
                begin
                    // >> Distribution - start
                    if not UpdateAllowed then
                      exit;
                    // << Distribution - end

                    //>>  Warehouse Management - start
                    //Released := FALSE;
                    //"Order Status" := "Order Status"::Open;
                    ReleaseSalesDoc.PerformManualReopen(Rec);
                    //<<  Warehouse Management - end

                    if Status = Status::Open then begin
                      ReopenVisible := false;
                      ReleaseVisible := true;
                    end else begin
                      ReopenVisible := true;
                      ReleaseVisible := false;
                    end;
                    CurrPage.Update;
                end;
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    RunObject = Codeunit "Sales-Post (Yes/No)";
                    ShortCutKey = 'F11';
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    RunObject = Codeunit "Sales-Post + Print";
                    ShortCutKey = 'Shift+F11';
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';

                    trigger OnAction()
                    begin
                        REPORT.RunModal(REPORT::"Batch Post Sales Credit Memos",true,true,Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>> HEF 2/27/01
        if Status = Status::Open then begin
          ReopenVisible := false;
          ReleaseVisible := true;
        end else begin
          ReopenVisible := true;
          ReleaseVisible := false;
        end;
        //<< HEF 2/27/01
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    trigger OnOpenPage()
    begin
        //>> HEF
        if Status = Status::Open then begin
          ReopenVisible := false;
          ReleaseVisible := true;
        end else begin
          ReopenVisible := true;
          ReleaseVisible := false;
        end;
        //<< END INSERT
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        ReqLine: Record "Requisition Line";
        ReqName: Record "Requisition Wksh. Name";
        GetSalesOrder: Report "Get Sales Orders";
        SalesLine: Record "Sales Line";
        ReservSalesLine: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
        ReservEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        Cust: Record Customer;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ReservMgt: Codeunit "Reservation Management";
        CopySalesDoc: Report "Copy Sales Document";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ReserveComplete: Boolean;
        NotPicked: Boolean;
        PickComplete: Boolean;
        PartialPick: Boolean;
        QuantityReserved: Decimal;
        OK: Boolean;
        PrintPick: Integer;
        WhseDocExists: Boolean;
        CCFeeCode: Codeunit CreditCardFeeFunctions;
        GLSetup: Record "General Ledger Setup";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        [InDataSet]
        ReopenVisible: Boolean;
        [InDataSet]
        ReleaseVisible: Boolean;
        ReleaseSalesDoc: Codeunit "Release Sales Document";

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
          Message('Unable to execute this function while in view only mode.');
          exit(false);
        end else
          exit(true);
    end;
}

