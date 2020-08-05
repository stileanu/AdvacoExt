page 50073 "Purchase Order Accounting"
{
    // //>> HEF Added RELEASE & REOPEN BUTTON CODE   2/27/01
    // 
    // />> HEF ADDED CODE TO UPDATE DOCUMENT DATE TO MATCH POSTING DATE
    // 
    // 04/30/2012 - Inactivate <Batch post> command from <Post> button. No code for ADVACO solution.
    //              If necessary, needs to write code to modify batch posting report.
    // 
    // 04/30/2012 - Added second control with Payment Terms from Purchasing side.
    //              Re-labeled <Payment Terms Code> to <AP Pyment Terms>
    // 
    // 12/13/19
    //   Added code to check and correct link to Blanket Order

    PageType = Card;
    SourceTable = "Purchase Header";
    SourceTableView = SORTING("Document Type", "Location Code", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060052)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                        Editable = false;
                    }
                    field("Buy-from Vendor No."; "Buy-from Vendor No.")
                    {
                    }
                    field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                    {
                    }
                    field("Buy-from Address"; "Buy-from Address")
                    {
                    }
                    field("Buy-from Address 2"; "Buy-from Address 2")
                    {
                    }
                    field("Buy-from City"; "Buy-from City")
                    {
                    }
                    field("Buy-from County"; "Buy-from County")
                    {
                    }
                    field("Buy-from Post Code"; "Buy-from Post Code")
                    {
                    }
                    field("Buy-from Contact"; "Buy-from Contact")
                    {
                    }
                    field(PurchPaymentTerms; PurchPaymentTerms)
                    {
                        Caption = 'Purch. Payment Terms';
                        Editable = false;
                    }
                    field(Notes; Notes)
                    {
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    field("Posting Date"; "Posting Date")
                    {
                    }
                    field("Order Date"; "Order Date")
                    {
                    }
                    field("Document Date"; "Document Date")
                    {
                    }
                    field("Placed By"; "Placed By")
                    {
                    }
                    field("Vendor Invoice No."; "Vendor Invoice No.")
                    {
                    }
                    field("Purchaser Code"; "Purchaser Code")
                    {
                    }
                    field("Quality Clause"; "Quality Clause")
                    {
                    }
                    field(Status; Status)
                    {
                    }
                    field(APPurchPaymentTerms; APPurchPaymentTerms)
                    {
                        Caption = 'AP Payment Terms Code';
                        Editable = false;
                    }
                }
            }
            part(PurchLines; "Purchase Order All Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                group(Control1220060054)
                {
                    ShowCaption = false;
                    field("Pay-to Vendor No."; "Pay-to Vendor No.")
                    {
                    }
                    field("Pay-to Name"; "Pay-to Name")
                    {
                    }
                    field("Pay-to Address"; "Pay-to Address")
                    {
                    }
                    field("Pay-to Address 2"; "Pay-to Address 2")
                    {
                    }
                    field("Pay-to City"; "Pay-to City")
                    {
                    }
                    field("Pay-to County"; "Pay-to County")
                    {
                    }
                    field("Pay-to Post Code"; "Pay-to Post Code")
                    {
                    }
                    field("Pay-to Contact"; "Pay-to Contact")
                    {
                    }
                    field("On Hold"; "On Hold")
                    {
                    }
                }
                group(Control1220060055)
                {
                    ShowCaption = false;
                    field("Due Date"; "Due Date")
                    {
                    }
                    field("Tax Liable"; "Tax Liable")
                    {
                    }
                    field("Tax Area Code"; "Tax Area Code")
                    {
                    }
                }
            }
            group(Shipping)
            {
                group(Control1220060056)
                {
                    ShowCaption = false;
                    field("Ship-to Name"; "Ship-to Name")
                    {
                    }
                    field("Ship-to Address"; "Ship-to Address")
                    {
                    }
                    field("Ship-to Address 2"; "Ship-to Address 2")
                    {
                    }
                    field("Ship-to City"; "Ship-to City")
                    {
                    }
                    field("Ship-to County"; "Ship-to County")
                    {
                    }
                    field("Ship-to Post Code"; "Ship-to Post Code")
                    {
                    }
                    field("Ship-to Contact"; "Ship-to Contact")
                    {
                    }
                    field("Ship-to UPS Zone"; "Ship-to UPS Zone")
                    {
                    }
                }
                group(Control1220060057)
                {
                    ShowCaption = false;
                    field("Location Code"; "Location Code")
                    {
                    }
                    field("Shipment Method Code"; "Shipment Method Code")
                    {
                    }
                    field("Shipping Agent"; "Shipping Agent")
                    {
                    }
                    field("Expected Receipt Date"; "Expected Receipt Date")
                    {
                    }
                    field("Sell-to Customer No."; "Sell-to Customer No.")
                    {
                    }
                    field("Ship-to Code"; "Ship-to Code")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    RunObject = Page "Purchase Order Statistics";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'F9';
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    Promoted = true;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    Promoted = true;
                    PromotedIsBig = false;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("Insert &Ext. Text")
                {
                    Caption = 'Insert &Ext. Text';
                    Image = Insert;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        CurrPage.PurchLines.PAGE.InsertExtendedText(true);
                    end;
                }
                action(Reserve)
                {
                    Caption = 'Reserve';
                    Image = Reserve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        ///--!
                        // not sure Reservation is used
                        //CurrPage.PurchLines.PAGE.ShowReservation;
                    end;
                }
            }
            action(Release)
            {
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                begin
                    //ReleasePurchDoc.PerformManualRelease(Rec);

                    // >> Distribution - start
                    if not UpdateAllowed then
                        exit;
                    // << Distribution - end

                    if Status = Status::Open then
                        Status := Status::Released
                    else
                        Message('This purchase order has already been released.');
                    PurchLine.SetRange(PurchLine."Document Type", "Document Type");
                    PurchLine.SetRange(PurchLine."Document No.", "No.");
                    PurchLine.SetRange(PurchLine.Type, PurchLine.Type::Item);
                    PurchLine.SetFilter(PurchLine."No.", '<>%1', '');
                    if PurchLine.Find('-') then
                        repeat
                            if PurchLine."Location Code" <> "Location Code" then
                                Error('You may not have multiple locations on this purchase order.');
                        until PurchLine.Next = 0;

                    if Status = Status::Released then begin
                        ReopenVisible := true;
                        ReleaseVisible := false;
                    end else begin
                        ReopenVisible := false;
                        ReleaseVisible := true;
                    end;

                    //12/13/19 start
                    // filter lines set
                    PurchHeadBO := Rec;
                    PurchLineBO.Reset;
                    PurchLineBO.SetRange("Document Type", PurchHeadBO."Document Type");
                    PurchLineBO.SetRange("Document No.", PurchHeadBO."No.");
                    // find if there is a BO
                    if PurchLineBO.Find('-') then
                        repeat
                            if PurchLineBO."Blanket Order No." <> '' then begin
                                BOCode := PurchLineBO."Blanket Order No.";
                            end;
                        until PurchLineBO.Next = 0;
                    // If BO, test for empty lines
                    if BOCode <> '' then begin
                        PurchLineBO.Reset;
                        PurchLineBO.SetRange(PurchLineBO."Document Type", "Document Type");
                        PurchLineBO.SetRange(PurchLineBO."Document No.", "No.");
                        if PurchLineBO.Find('-') then
                            repeat
                                if PurchLineBO."Blanket Order No." = '' then begin
                                    BOPurchLine.Reset;
                                    if BOPurchLine.Get("Document Type"::"Blanket Order", BOCode, PurchLineBO."Line No.") then
                                        // is same line type and no.?
                                        if (BOPurchLine.Type = PurchLineBO.Type) and (BOPurchLine."No." = PurchLineBO."No.") then begin
                                            PurchLineBO."Blanket Order Line No." := PurchLineBO."Line No.";
                                            PurchLineBO."Blanket Order No." := BOCode;
                                            PurchLineBO.Modify;
                                        end;
                                end;
                            until PurchLineBO.Next = 0;
                    end;
                    //12/13/19 end

                    CurrPage.Update;
                end;
            }
            action(Reopen)
            {
                Caption = 'Re&open';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                begin
                    //ReleasePurchDoc.PerformManualReopen(Rec);

                    // >> Distribution - start
                    if not UpdateAllowed then
                        exit;
                    // << Distribution - end

                    Status := Status::Open;
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
                    Image = "Report";
                    Promoted = true;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    ShortCutKey = 'F11';

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        CODEUNIT.Run(CODEUNIT::PurchPost_Yes_No_Act, Rec);
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        CODEUNIT.Run(CODEUNIT::PurchPost_Print_Act, Rec);
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Image = PostBatch;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                            exit;
                        // << Distribution - end

                        REPORT.RunModal(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
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

        // 04/30/12 ADV Start
        if PurchVendor.Get("Buy-from Vendor No.") then
            PurchPaymentTerms := PurchVendor."Payment Terms Code";
        if APPurchVendor.Get("Pay-to Vendor No.") then
            APPurchPaymentTerms := APPurchVendor."Payment Terms Code";
        // 04/30/12 ADV End
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

        // 04/30/12 ADV Start
        if PurchVendor.Get("Buy-from Vendor No.") then
            PurchPaymentTerms := PurchVendor."Payment Terms Code";
        if APPurchVendor.Get("Pay-to Vendor No.") then
            APPurchPaymentTerms := APPurchVendor."Payment Terms Code";
        // 04/30/12 ADV End
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchLine: Record "Purchase Line";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        PurchPaymentTerms: Code[10];
        APPurchPaymentTerms: Code[10];
        PurchVendor: Record Vendor;
        APPurchVendor: Record Vendor;
        PurchHeadBO: Record "Purchase Header";
        PurchLineBO: Record "Purchase Line";
        BOPurchLine: Record "Purchase Line";
        BOCode: Code[10];
        [InDataSet]
        ReopenVisible: Boolean;
        [InDataSet]
        ReleaseVisible: Boolean;

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
            Message('Unable to execute this function while in view only mode.');
            exit(false);
        end else
            exit(true);
    end;
}

