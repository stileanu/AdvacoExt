pageextension 62039 PurchCreditMemoExt extends "Purchase Credit Memo"
{
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval,Credit Memo,Release,Posting,Navigate,Print';

    layout
    {
        modify("Vendor Authorization No.")
        {
            Visible = false;
        }

        addafter("Document Date")
        {
            field("Shipment Date Acct"; "Shipment Date")
            {
                ApplicationArea = All;
                Caption = 'Shipment Date';
                Visible = lAcct;
                Editable = false;
                ToolTip = 'Specifies if Credit Memo is posted.';
            }
        }
        addbefore("Vendor Cr. Memo No.")
        {
            field("Credit Memo Posted"; "Credit Memo Posted")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if Credit Memo is posted.';
            }
            field("Your Reference"; "Your Reference")
            {
                ApplicationArea = All;
                Caption = 'Our P.O. No.';
                Visible = lPurch;
                Importance = Additional;
                ToolTip = 'Specifies original P.O. in our system.';
            }
            field("Vendor Invoice No."; "Vendor Invoice No.")
            {
                ApplicationArea = All;
                Visible = lPurch;
                Importance = Additional;
                ToolTip = 'Specifies the Purchase Invoice No. for which thsi document was created for.';
            }

        }
        addafter("Vendor Cr. Memo No.")
        {
            field("Authorized By"; "Authorized By")
            {
                ApplicationArea = All;
                Visible = lPurch;
                Importance = Additional;
                ToolTip = 'Specifies Vendor contact authorizing the credit/return.';
            }
        }
        addafter("Purchaser Code")
        {
            field("Credit Memo Action"; "Credit Memo Action")
            {
                ApplicationArea = All;
                Visible = lPurch;
                Importance = Additional;
                ToolTip = 'Specifies the action to be taken: return, issue credit, repair.';
            }
            field("Return Reason"; "Return Reason")
            {
                ApplicationArea = All;
                Caption = 'Defective Reason';
                Visible = lPurch;
                MultiLine = true;
                Importance = Additional;
                ToolTip = 'Specifies reason for return.';
            }
            field("Return to Vendor"; "Return to Vendor")
            {
                ApplicationArea = All;
                Visible = lPurch;
                Importance = Additional;
                ToolTip = 'Specifies if parts are to be returned to the vendor.';
            }
        }
        modify(Status)
        {
            Caption = 'Credit Memo Status';
        }

        modify("Shipping and Payment")
        {
            Visible = lPurch;
        }

        addbefore("Pay-to")
        {
            field("RMA No."; "RMA No.")
            {
                ApplicationArea = All;
                Visible = lPurch;
                ToolTip = 'Specifies Return Authorization from the vendor.';
            }
            field("Shipping Agent"; "Shipping Agent")
            {
                ApplicationArea = All;
                Visible = lPurch;
                ToolTip = 'Specifies Shipping Agent for the return.';
            }
            field("Shipment Method Code"; "Shipment Method Code")
            {
                ApplicationArea = All;
                Visible = lPurch;
                ToolTip = 'Specifies Shipping Method for the return.';
            }
            field("Shipping Charge"; "Shipping Charge")
            {
                ApplicationArea = All;
                Visible = lPurch;
                ToolTip = 'Specifies Shipping Charge for the return.';
            }
            field("Shipping Account"; "Shipping Account")
            {
                ApplicationArea = All;
                Visible = lPurch;
                ToolTip = 'Specifies Shipping Account for the return.';
            }
            field("Package Tracking No."; "Package Tracking No.")
            {
                ApplicationArea = All;
                Visible = lPurch;
                ToolTip = 'Specifies Tracking No. for the return.';
            }
            field("Bill of Lading"; "Bill of Lading")
            {
                ApplicationArea = All;
                Visible = lPurch;
                Editable = false;
                ToolTip = 'Specifies BOL No. for the return.';
            }
            field("Shipment Date"; "Shipment Date")
            {
                ApplicationArea = All;
                Visible = lPurch;
                Editable = false;
                ToolTip = 'Specifies Shipment Date for the return.';
            }
        }
        modify(Application)
        {
            Visible = lAcct;
        }
    }

    actions
    {
        modify(CalculateInvoiceDiscount)
        {
            Visible = lAcct;
        }
        modify(ApplyEntries)
        {
            Visible = lAcct;
        }
        modify(IncomingDocument)
        {
            Visible = lAcct;
        }
        modify("P&osting")
        {
            Visible = lAcct;
        }
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }
        modify("Remove From Job Queue")
        {
            Visible = false;
        }
        modify(Preview)
        {
            Promoted = false;
        }

        addafter("&Credit Memo")
        {
            group(Print)
            {
                Image = Print;

                action(PrintPickTicket)
                {
                    ApplicationArea = All;
                    Visible = lPurch;
                    Caption = 'Print Pick Ticket';
                    Image = PrintDocument;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    ToolTip = 'Prints the Pick Ticket for this Document';

                    trigger OnAction()
                    begin
                        CM.SetRange(CM."Document Type", "Document Type"::"Credit Memo");
                        CM.SetRange(CM."No.", "No.");
                        Report.RunModal(50141, true, false, CM);
                    end;
                }

                action(PrintPackingSlip)
                {
                    ApplicationArea = All;
                    Visible = lPurch;
                    Caption = 'Print Packing Slip';
                    Image = PrintDocument;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    ToolTip = 'Prints the Packing Slip for this Document';

                    trigger OnAction()
                    begin
                        CM.SetRange(CM."Document Type", "Document Type"::"Credit Memo");
                        CM.SetRange(CM."No.", "No.");
                        Report.RunModal(50142, True, false, CM);
                    end;
                }

                action(PrintCreditMemo)
                {
                    ApplicationArea = All;
                    Visible = lAcct;
                    Caption = 'Print Credit Memo';
                    Image = PrintDocument;
                    Promoted = true;
                    PromotedCategory = Category10;
                    PromotedIsBig = true;
                    ToolTip = 'Prints the Credit Memo Document';

                    trigger OnAction()
                    begin
                        CM.SetRange(CM."Document Type", "Document Type"::"Credit Memo");
                        CM.SetRange(CM."No.", "No.");
                        Report.RunModal(50057, true, false, CM);
                    end;
                }
            }
        }

        addbefore("Get St&d. Vend. Purchase Codes")
        {
            action(CloseCreditMemo)
            {
                ApplicationArea = Basic, Suite;
                Visible = lPurch;
                Caption = 'Close Credit Memo';
                Image = CloseDocument;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Marks current document as closed.';

                trigger OnAction()
                begin
                    IF not Confirm('Are you sure you want to Close this Credit Memo', false) then begin
                        Message('Close Credit Memo has been Aborted');
                    end else begin
                        if "Credit Memo Action" = "Credit Memo Action"::"Issue Full Credit" then begin
                            Message('This Credit Memo is setup up as "Issue Full Credit" and must be processed by Accounting');
                        end else begin
                            if "Return to Vendor" then begin
                                if "Bill of Lading" = 0 then begin
                                    Message('This Credit Memo can''t be closed because it is setup as a Return to Vendor and it hasn''t been shipped yet');
                                end else begin
                                    "Credit Memo Posted" := true;
                                    "Completion Date" := Today;
                                    "Completion USERID" := UserId;
                                    Modify();
                                end;
                            end else begin
                                "Credit Memo Posted" := TRUE;
                                "Completion Date" := Today;
                                "Completion USERID" := UserId;
                                Modify();
                            end;
                        end;
                    end;
                end;
            }
        }
        addbefore(Post)
        {
            action(AdvPost)
            {
                ApplicationArea = All;
                Visible = lAcct;
                Caption = 'P&ost Credit';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    PCreditMemo: Page "Purchase Credit Memo";

                begin
                    if Rec."Return to Vendor" then begin
                        if Rec."Bill of Lading" = 0 then
                            Message('The Credit Memo hasn''t be shipped yet, Please Contact Shipping')
                        else
                            PCreditMemo.CallPostDocument(Codeunit::"Purch.-Post (Yes/No)", NavigateAfterPost::"Posted Document");
                    end else begin
                        PCreditMemo.CallPostDocument(Codeunit::"Purch.-Post (Yes/No)", NavigateAfterPost::"Posted Document");
                    end;
                end;
            }
            action(AdvPostAndPrint)
            {
                ApplicationArea = Basic, Suite;
                Visible = lAcct;
                Caption = 'Post and &Print Credit';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';
                ToolTip = 'Finalize and prepare to print the document or journal. The values and quantities are posted to the related accounts. A report request window where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PCreditMemo: Page "Purchase Credit Memo";

                begin
                    if Rec."Return to Vendor" then begin
                        if Rec."Bill of Lading" = 0 then
                            Message('The Credit Memo hasn''t be shipped yet, Please Contact Shipping')
                        else
                            PCreditMemo.CallPostDocument(Codeunit::"Purch.-Post + Print", NavigateAfterPost::"Do Nothing");
                    end else begin
                        PCreditMemo.CallPostDocument(Codeunit::"Purch.-Post + Print", NavigateAfterPost::"Do Nothing");
                    end;
                end;
            }
        }
    }

    var
        CM: Record "Purchase Header";
        lPurch: Boolean;
        lAcct: Boolean;
        txtAnswer: Text[120];
        AcctCode: Label 'ADVACO ACCOUNTING';
        PurchCode: Label 'ADVACO PURCHASING';
        Permiss: Label 'SUPER';
        SysFunctions: Codeunit systemFunctionalLibrary;
        Member: Record "User Group Member";
        PurchPost: Codeunit "Purch.-Post (Yes/No)";
        PurchPostPrint: Codeunit "Purch.-Post + Print";
        NavigateAfterPost: Enum "Navigate After Posting";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        DocumentIsPosted: Boolean;
        IsOfficeAddin: Boolean;
        OpenPostedPurchCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Purchase Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
        GLSetup: Record "General Ledger Setup";

    begin
        // initialize group flag
        lPurch := false;
        lAcct := false;

        ///--! Permission level check code. 
        User.Get(UserSecurityId);
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");
        // Member.SetRange("User Security ID", User."User Security ID");

        lPurch := SysFunctions.getIfSingleGroupId(PurchCode, txtAnswer);
        //if not lPurch then
        lAcct := SysFunctions.getIfSingleGroupId(AcctCode, txtAnswer);
        if not (lAcct or lPurch) then begin
            lPurch := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);
            lAcct := lPurch;
        end;

        if not (lAcct or lPurch) then begin
            Error('You must be member of Accounting or Purchasing to open this page.');
        end;

    end;

    /*
        local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Option)
        var
            PurchaseHeader: Record "Purchase Header";
            PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
            ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
            InstructionMgt: Codeunit "Instruction Mgt.";
            IsScheduledPosting: Boolean;
        begin
            if ApplicationAreaMgmtFacade.IsFoundationEnabled then
                LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

            SendToPosting(PostingCodeunitID);

            IsScheduledPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
            DocumentIsPosted := (not PurchaseHeader.Get("Document Type", "No.")) or IsScheduledPosting;

            if IsScheduledPosting then
                CurrPage.Close;
            CurrPage.Update(false);

            if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
                exit;

            case Navigate of
                NavigateAfterPost::"Posted Document".AsInteger():
                    begin
                        if IsOfficeAddin then begin
                            PurchCrMemoHdr.SetRange("Pre-Assigned No.", "No.");
                            if PurchCrMemoHdr.FindFirst then
                                PAGE.Run(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
                        end else
                            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                                ShowPostedConfirmationMessage;
                    end;
                NavigateAfterPost::"New Document".AsInteger():
                    if DocumentIsPosted then begin
                        Clear(PurchaseHeader);
                        PurchaseHeader.Init();
                        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::"Credit Memo");
                        //OnPostDocumentOnBeforePurchaseHeaderInsert(PurchaseHeader);
                        PurchaseHeader.Insert(true);
                        PAGE.Run(PAGE::"Purchase Credit Memo", PurchaseHeader);
                    end;
            end;
        end;

        local procedure ShowPostedConfirmationMessage()
        var
            PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
            InstructionMgt: Codeunit "Instruction Mgt.";
        begin
            PurchCrMemoHdr.SetRange("Pre-Assigned No.", "No.");
            if PurchCrMemoHdr.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchCrMemoQst, PurchCrMemoHdr."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Purchase Credit Memo", PurchCrMemoHdr);
        end;
        */
}