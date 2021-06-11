#pragma implicitwith disable
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
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from County"; Rec."Buy-from County")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Contact"; Rec."Buy-from Contact")
                    {
                        ApplicationArea = All;
                    }
                    field(PurchPaymentTerms; PurchPaymentTerms)
                    {
                        ApplicationArea = All;
                        Caption = 'Purch. Payment Terms';
                        Editable = false;
                    }
                    field(Notes; Rec.Notes)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    field("Posting Date"; Rec."Posting Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Order Date"; Rec."Order Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Document Date"; Rec."Document Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Placed By"; Rec."Placed By")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purchaser Code"; Rec."Purchaser Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Quality Clause"; Rec."Quality Clause")
                    {
                        ApplicationArea = All;
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = All;
                    }
                    field(APPurchPaymentTerms; APPurchPaymentTerms)
                    {
                        ApplicationArea = All;
                        Caption = 'AP Payment Terms Code';
                        Editable = false;
                    }
                }
            }
            part(PurchLines; "Purchase Order All Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                group(Control1220060054)
                {
                    ShowCaption = false;
                    field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Name"; Rec."Pay-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Address"; Rec."Pay-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Address 2"; Rec."Pay-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to City"; Rec."Pay-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to County"; Rec."Pay-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Post Code"; Rec."Pay-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("On Hold"; Rec."On Hold")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060055)
                {
                    ShowCaption = false;
                    field("Due Date"; Rec."Due Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Liable"; Rec."Tax Liable")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Area Code"; Rec."Tax Area Code")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Shipping)
            {
                group(Control1220060056)
                {
                    ShowCaption = false;
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to County"; Rec."Ship-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060057)
                {
                    ShowCaption = false;
                    field("Location Code"; Rec."Location Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipment Method Code"; Rec."Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Agent"; Rec."Shipping Agent")
                    {
                        ApplicationArea = All;
                    }
                    field("Expected Receipt Date"; Rec."Expected Receipt Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Code"; Rec."Ship-to Code")
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
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    Promoted = true;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
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

                    if Rec.Status = Rec.Status::Open then
                        Rec.Status := Rec.Status::Released
                    else
                        Message('This purchase order has already been released.');
                    PurchLine.SetRange(PurchLine."Document Type", Rec."Document Type");
                    PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
                    PurchLine.SetRange(PurchLine.Type, PurchLine.Type::Item);
                    PurchLine.SetFilter(PurchLine."No.", '<>%1', '');
                    if PurchLine.Find('-') then
                        repeat
                            if PurchLine."Location Code" <> Rec."Location Code" then
                                Error('You may not have multiple locations on this purchase order.');
                        until PurchLine.Next = 0;

                    if Rec.Status = Rec.Status::Released then begin
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
                        PurchLineBO.SetRange(PurchLineBO."Document Type", Rec."Document Type");
                        PurchLineBO.SetRange(PurchLineBO."Document No.", Rec."No.");
                        if PurchLineBO.Find('-') then
                            repeat
                                if PurchLineBO."Blanket Order No." = '' then begin
                                    BOPurchLine.Reset;
                                    if BOPurchLine.Get(Rec."Document Type"::"Blanket Order", BOCode, PurchLineBO."Line No.") then
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
                ApplicationArea = All;
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

                    Rec.Status := Rec.Status::Open;
                    if Rec.Status = Rec.Status::Open then begin
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
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
        if Rec.Status = Rec.Status::Open then begin
            ReopenVisible := false;
            ReleaseVisible := true;
        end else begin
            ReopenVisible := true;
            ReleaseVisible := false;
        end;
        //<< HEF 2/27/01

        // 04/30/12 ADV Start
        if PurchVendor.Get(Rec."Buy-from Vendor No.") then
            PurchPaymentTerms := PurchVendor."Payment Terms Code";
        if APPurchVendor.Get(Rec."Pay-to Vendor No.") then
            APPurchPaymentTerms := APPurchVendor."Payment Terms Code";
        // 04/30/12 ADV End
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnOpenPage()
    begin
        //>> HEF
        if Rec.Status = Rec.Status::Open then begin
            ReopenVisible := false;
            ReleaseVisible := true;
        end else begin
            ReopenVisible := true;
            ReleaseVisible := false;
        end;
        //<< END INSERT

        // 04/30/12 ADV Start
        if PurchVendor.Get(Rec."Buy-from Vendor No.") then
            PurchPaymentTerms := PurchVendor."Payment Terms Code";
        if APPurchVendor.Get(Rec."Pay-to Vendor No.") then
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

#pragma implicitwith restore

