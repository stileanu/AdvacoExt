page 50074 "Purchase Order Purchasing"
{
    // 02/27/01 HEF Added Release and Reopen Buttons to Form
    // 
    // 02/27/01 HEF Changed Code Units Called when Posting Orders to allow Modifications
    // 
    // 01/23/02 HEF Adding Code to Push Command of Post, and Post & Print to Check Receiving Lines
    //              for Receiving Inspection Criteria
    // 
    // 08/27/12 ADV
    //   Added code in OnTimer() trigger and set the Time Interval Property to 20000 (20s) to refresh
    //   the Header Data in Quality Clause.
    //   Took out the code because of disrupting the keyboard input onj other forms.
    // 
    // 02/27/14 ADV
    //   Added Email command to Print Menu.
    // 
    // 7/20/19
    //   Added tagged code to update subform after header modifications
    // 
    // 12/13/19
    //   Added code to check and correct link to Blanket Order

    ///--! Email issue
    // 08/05/20 ICE SII
    //   Temporary commented NewMessage email function not working in Cloud 

    ///--! Report not converted yet
    // 08/05/20 ICE SII
    //   Temporary commented out call to "Bill of Lading" Report    

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
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Buy-from Vendor No."; "Buy-from Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address"; "Buy-from Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address 2"; "Buy-from Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from City"; "Buy-from City")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from County"; "Buy-from County")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Post Code"; "Buy-from Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Contact"; "Buy-from Contact")
                    {
                        ApplicationArea = All;
                    }
                    field(Notes; Notes)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    field("Posting Date"; "Posting Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Order Date"; "Order Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Document Date"; "Document Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Purchaser Code"; "Purchaser Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Placed By"; "Placed By")
                    {
                        ApplicationArea = All;
                    }
                    field("Quality Clause"; "Quality Clause")
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Terms Code"; "Payment Terms Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Vendor.""Phone No."""; Vendor."Phone No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone No.';
                        Editable = false;
                    }
                    field("Vendor.""Fax No."""; Vendor."Fax No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Fax No.';
                        Editable = false;
                    }
                    field("Vendor Repair"; "Vendor Repair")
                    {
                        ApplicationArea = All;
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = All;
                    }
                    field("Order Acknowledgement"; "Order Acknowledgement")
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                    }
                    field("Pay-to Name"; "Pay-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Address"; "Pay-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Address 2"; "Pay-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to City"; "Pay-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to County"; "Pay-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Post Code"; "Pay-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Contact"; "Pay-to Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("On Hold"; "On Hold")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060055)
                {
                    ShowCaption = false;
                    field("Tax Liable"; "Tax Liable")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Area Code"; "Tax Area Code")
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
                    field("Ship-to Name"; "Ship-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address"; "Ship-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address 2"; "Ship-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to City"; "Ship-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to County"; "Ship-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Post Code"; "Ship-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Contact"; "Ship-to Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to UPS Zone"; "Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060057)
                {
                    ShowCaption = false;
                    field("Shipment Method Code"; "Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Agent"; "Shipping Agent")
                    {
                        ApplicationArea = All;
                    }
                    field("Expected Receipt Date"; "Expected Receipt Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Sell-to Customer No."; "Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Code"; "Ship-to Code")
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
            action("Print Labels")
            {
                ApplicationArea = All;
                Caption = 'Print Labels';

                trigger OnAction()
                begin
                    PrintLabels;
                end;
            }
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

                        CurrPage.PurchLines.PAGE.ShowReservation2;
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

                        //>> HEF INSERT
                        if Vendor."Receiving Inspection" then begin   // checks to see if Inspection Required
                            POLine.SetRange(POLine."Document Type", "Document Type");
                            POLine.SetRange(POLine."Document No.", "No.");
                            POLine.SetFilter(POLine."Qty. to Receive", '<>%1', 0);  // Finds only items being Received
                            if POLine.Find('-') then begin
                                repeat
                                    if (POLine.Inspector = '') or (POLine."Inspection Date" = 0D) then
                                        Error('Item %1 can''t be Received Until the Inspector and Inspection Date our both Completed', POLine."No.");
                                until POLine.Next = 0;
                            end;
                        end;
                        //<< HEF END INSERT

                        //>> HEF INSERT
                        CODEUNIT.Run(CODEUNIT::PurchPost_Yes_No_, Rec);
                        //<< END INSERT

                        //CODEUNIT.RUN(CODEUNIT::"Purch Post (Yes/No) Act",Rec);
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

                        //>> HEF INSERT
                        if Vendor."Receiving Inspection" then begin   // checks to see if Inspection Required
                            POLine.SetRange(POLine."Document Type", "Document Type");
                            POLine.SetRange(POLine."Document No.", "No.");
                            POLine.SetFilter(POLine."Qty. to Receive", '<>%1', 0);  // Finds only items being Received
                            if POLine.Find('-') then begin
                                repeat
                                    if (POLine.Inspector = '') or (POLine."Inspection Date" = 0D) then
                                        Error('Item %1 can''t be Received Until the Inspector and Inspection Date our both Completed', POLine."No.");
                                until POLine.Next = 0;
                            end;
                        end;
                        //<< HEF END INSERT


                        //>> HEF INSERT
                        CODEUNIT.Run(CODEUNIT::PurchPost_Print, Rec);
                        //<< END INSERT

                        //>> Original Code Unit Called
                        //CODEUNIT.RUN(CODEUNIT::"Purch Post + Print Act",Rec);
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
            group(Print)
            {
                Caption = 'Print';
                action("&Print")
                {
                    ApplicationArea = All;
                    Caption = '&Print';
                    Image = Print;

                    trigger OnAction()
                    begin
                        //>> HEF INSERT Removed Original Report Run with New Code to Prevent Request Printer Screen from Showing
                        // DocPrint.PrintPurchHeader(Rec);
                        POHeader.SetRange("No.", "No.");
                        REPORT.Run(10122, false, false, POHeader);

                        //<< HEF END INSERT
                    end;
                }
                action("PDF & Email...")
                {
                    ApplicationArea = All;
                    Caption = 'PDF & Email...';

                    trigger OnAction()
                    begin
                        Vendor1.Get("Buy-from Vendor No.");
                        if not Vendor1."Email Invoice" then
                            Error('Vendor %1 is not set to email Orders', "Buy-from Vendor No.");
                        if Vendor1."Invoicing Email" = '' then
                            Error('Address for Email Orders to Vendor %1 is not set.', "Buy-from Vendor No.");
                        if Vendor1."Path to PDF" = '' then
                            Error('Path to storage for PDF files not set.');

                        if Confirm('Do you want to print to PDF and email this order?', true) then
                            PrintPOPDFEmail(Rec, Vendor1)
                        else begin
                            POHeader.SetRange("No.", "No.");
                            REPORT.Run(10122, false, false, POHeader);
                        end;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>> HEF INSERT
        if Status = Status::Open then begin
            ReopenVisible := false;
            ReleaseVisible := true;
        end else begin
            ReopenVisible := true;
            ReleaseVisible := false;
        end;

        if Vendor.Get("Buy-from Vendor No.") then
            Ok := true
        else
            Clear(Vendor);

        //<< HEF END INSERT
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
        PurchSetup: Record "Purchases & Payables Setup";
        PurchLine: Record "Purchase Line";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        Labels: Record "Order Defects";
        LoopCounter: Integer;
        LabelCounter: Integer;
        Item: Record Item;
        Ok: Boolean;
        Vendor: Record Vendor;
        POLine: Record "Purchase Line";
        POHeader: Record "Purchase Header";
        Vendor1: Record Vendor;
        EmailForm: Page "Email Dialog 2";
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

    procedure PrintLabels()
    begin
        if Confirm('Are you ready to print Labels?') then begin
            PurchLine.Reset;
            PurchLine.SetRange(PurchLine."Document Type", "Document Type");
            PurchLine.SetRange(PurchLine."Document No.", "No.");
            PurchLine.SetRange(PurchLine."Labels to Print", 0, 9999);
            if PurchLine.Find('-') then begin
                Labels.DeleteAll;
                repeat
                    if Item.Get(PurchLine."No.") then
                        Ok := true;
                    LabelCounter := 0;
                    LoopCounter := PurchLine."Labels to Print";
                    begin
                        repeat
                            Labels.Init;
                            Labels.Occurrence := Labels.Occurrence + 10000;
                            Labels."Order No." := PurchLine."Document No.";
                            Labels."Defect Code" := PurchLine."No.";
                            //Labels.Department := PurchLine.Description;
                            //Labels."Failure Item" := Item."Shelf/Bin No.";
                            LabelCounter := LabelCounter + 1;
                            Labels.Insert;
                        until LabelCounter >= LoopCounter;
                    end;
                until PurchLine.Next = 0;
                ///--! Report not converted yet
                // 08/05/20 ICE SII
                //REPORT.Run(REPORT::"Bill of Lading Report");
            end;
        end;
    end;

    procedure PrintPOPDFEmail(PurchaseOrder: Record "Purchase Header"; BuyFromVendor: Record Vendor): Boolean
    var
        UserSetup: Record "User Setup";
        PDFPrinter: Codeunit ExportInvoicesToPDF;
        EmailToVendor: Codeunit Mail;
        UserSignature: array[8] of Text[120];
        AttachmentName: Text[250];
        SubjectLine: Text[250];
        BodyText: Text[500];
        MailTo: Text[100];
        MailCC: Text[100];
        CRLF: Text[2];
        LFChar: Char;
        CRChar: Char;
        i: Integer;
        bCancel: Boolean;
    begin
        LFChar := 10;
        CRChar := 13;
        CRLF[1] := LFChar;
        CRLF[2] := CRChar;

        // Print to PDF

        if not PDFPrinter.PrintPOToPDF(PurchaseOrder."No.", BuyFromVendor."No.", AttachmentName) then
            Error('');

        // Build strings
        MailTo := BuyFromVendor."Invoicing Email";
        SubjectLine := StrSubstNo('Purchase Order %1', PurchaseOrder."No.");
        BodyText := 'Attached please find the Purchase Order #' + PurchaseOrder."No." + '.';

        // Launch email form and email it
        Clear(EmailForm);
        EmailForm.SetEmailValues(MailTo, MailCC, SubjectLine, AttachmentName, BodyText);
        EmailForm.RunModal;
        EmailForm.GetEmailValues(bCancel, MailTo, MailCC, SubjectLine, AttachmentName, BodyText, UserSignature);

        if not bCancel then begin
            // Add Signature to body
            BodyText += CRLF + CRLF;
            i := 1;
            repeat
                if UserSignature[i] <> '' then
                    BodyText += UserSignature[i] + CRLF;
                i += 1;
            until i > 8;
            ///--! Email issue
            // 08/05/20 ICE SII 
            //EmailToVendor.NewMessage(MailTo, MailCC, SubjectLine, BodyText, AttachmentName, '', false);
        end;
    end;
}

