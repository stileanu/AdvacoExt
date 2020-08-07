page 50080 "Purchase Credit Memo Act"
{
    // Function Menu Items Post & Post and Print have been replaced with a new ones that check for Return to Vendor first

    Caption = 'Purchase Credit Memo';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval,Credit Memo,Release,Posting,Navigate';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = SORTING("Document Type", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = DocNoVisible;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor No.';
                    Importance = Additional;
                    NotBlank = true;
                    ToolTip = 'Specifies the number of the vendor who delivers the products.';
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor Name';
                    Importance = Promoted;
                    QuickEntry = false;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';

                    trigger OnValidate()
                    var
                        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
                    begin
                    end;
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Address';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the address of the vendor who ships the items.';
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Address 2';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies additional address information.';
                }
                field("Buy-from City"; "Buy-from City")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'City';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the city of the vendor on the purchase document.';
                }
                field("Buy-from County"; "Buy-from County")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'State';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ZIP Code';
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the ZIP code.';
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                    Editable = "Buy-from Vendor No." <> '';
                    ToolTip = 'Specifies the name of the person to contact about shipment of the item from this vendor.';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    Importance = Additional;
                    ToolTip = 'Specifies a code for the location where you want the items to be placed when they are received.';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the posting of the purchase document will be recorded.';
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    QuickEntry = false;
                    ToolTip = 'Specifies the date when the related document was created.';
                }
                field("Vendor Cr. Memo No."; "Vendor Cr. Memo No.")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = VendorCreditMemoNoMandatory;
                    ToolTip = 'Specifies the document number of the original document you received from the vendor. You can require the document number for posting, or let it be optional. By default, it''s required, so that this document references the original. Making document numbers optional removes a step from the posting process. For example, if you attach the original invoice as a PDF, you might not need to enter the document number. To specify whether document numbers are required, in the Purchases & Payables Setup window, select or clear the Ext. Doc. No. Mandatory field.';
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the type of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the posted document that this document or journal line will be applied to when you post, for example to register payment.';
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purch. Cr. Memo Act Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Credit Memo")
            {
                Caption = '&Credit Memo';
                Image = CreditMemo;
                action(Statistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

                    trigger OnAction()
                    begin
                        CalcInvDiscForHeader;
                        Commit;
                        if "Tax Area Code" = '' then
                            PAGE.RunModal(PAGE::"Purchase Statistics", Rec)
                        else
                            PAGE.RunModal(PAGE::"Purchase Stats.", Rec);
                        PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendor';
                    Enabled = "Buy-from Vendor No." <> '';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Category9;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the vendor on the purchase document.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category6;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                group(ActionGroup9)
                {
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    action(Release)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Re&lease';
                        Image = ReleaseDoc;
                        Promoted = true;
                        PromotedCategory = Category7;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ShortCutKey = 'Ctrl+F9';
                        ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                        trigger OnAction()
                        var
                            ReleasePurchDoc: Codeunit "Release Purchase Document";
                        begin
                            ReleasePurchDoc.PerformManualRelease(Rec);
                        end;
                    }
                    action(Dimensions)
                    {
                        AccessByPermission = TableData Dimension = R;
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        Enabled = "No." <> '';
                        Image = Dimensions;
                        Promoted = true;
                        PromotedCategory = Category6;
                        PromotedIsBig = true;
                        ShortCutKey = 'Shift+Ctrl+D';
                        ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                        trigger OnAction()
                        begin
                            ShowDocDim;
                            CurrPage.SaveRecord;
                        end;
                    }
                }
                action(CalculateInvoiceDiscount)
                {
                    AccessByPermission = TableData "Vendor Invoice Disc." = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ToolTip = 'Calculate the invoice discount for the entire document.';

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action("Copy Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Enabled = "No." <> '';
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                        if Get("Document Type", "No.") then;
                    end;
                }
                action("Insert &Ext. Text")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Text';

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.InsertExtendedText(true);
                    end;
                }
                action(ApplyEntries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Apply Entries';
                    Ellipsis = true;
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F11';
                    ToolTip = 'Apply open entries for the relevant account type.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Purchase Header Apply", Rec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action(TestReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ToolTip = 'View a test report so that you can find and correct any errors before you perform the actual posting of the journal or document.';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                }
                action(Preview)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    Promoted = true;
                    PromotedCategory = Category8;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';
                    Visible = false;

                    trigger OnAction()
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                action(PostAndPrint)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';
                    ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        //Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    ToolTip = 'Remove the scheduled processing of this record from the job queue.';
                    Visible = false;

                    trigger OnAction()
                    begin
                        CancelBackgroundPosting;
                    end;
                }
                action("Post Credit")
                {
                    ApplicationArea = All;
                    Caption = 'Post Credit';

                    trigger OnAction()
                    begin
                        /*99999
                        IF "Return to Vendor" THEN BEGIN
                          IF "Bill of Lading" = 0 THEN
                            MESSAGE('The Credit Memo hasn''t be shipped yet, Please Contact Shipping')
                          ELSE
                            PurchPostPrint.RUN(Rec);
                        END ELSE BEGIN
                          PurchPostPrint.RUN(Rec);
                        END;
                        99999*/

                    end;
                }
                action("Post and Print Credit")
                {
                    ApplicationArea = All;
                    Caption = 'Post and Print Credit';

                    trigger OnAction()
                    begin
                        /*99999
                        IF "Return to Vendor" THEN BEGIN
                          IF "Bill of Lading" = 0 THEN
                            MESSAGE('The Credit Memo hasn''t be shipped yet, Please Contact Shipping')
                          ELSE
                            PurchPostPrint.RUN(Rec);
                        END ELSE BEGIN
                          PurchPostPrint.RUN(Rec);
                        END;
                        99999*/

                    end;
                }
            }
            action("&Print")
            {
                ApplicationArea = All;
                Caption = '&Print';

                trigger OnAction()
                begin
                    CM.SetRange(CM."Document Type", "Document Type"::"Credit Memo");
                    CM.SetRange(CM."No.", "No.");
                    REPORT.RunModal(50057, true, false, CM);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    trigger OnInit()
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
    end;

    trigger OnOpenPage()
    var
        OfficeMgt: Codeunit "Office Management";
        PermissionManager: Codeunit "Permission Manager";
    begin
    end;

    var
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        UserMgt: Codeunit "User Setup Management";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        FormatAddress: Codeunit "Format Address";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ShipToOptions: Option "Default (Vendor Address)","Alternate Vendor Address","Custom Address";
        [InDataSet]
        JobQueueVisible: Boolean;
        [InDataSet]
        JobQueueUsed: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorCreditMemoNoMandatory: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ShowWorkflowStatus: Boolean;
        IsOfficeAddin: Boolean;
        CanCancelApprovalForRecord: Boolean;
        DocumentIsPosted: Boolean;
        OpenPostedPurchCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        IsSaaS: Boolean;
        IsBuyFromCountyVisible: Boolean;
        IsPayToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;
        CM: Record "Purchase Header";
}

