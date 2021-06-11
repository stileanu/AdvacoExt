#pragma implicitwith disable
page 50015 "Quote Phase 2"
{
    ///--! FileMgmt issue
    // 08/05/20 ICE SII
    //   Temporary commented File.Exist function not working in cloud

    ///--! Email issue
    // 08/05/20 ICE SII
    //   Temporary commented NewMessage email function not working in Cloud     

    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1220060007)
            {
                ShowCaption = false;
                grid(Control1220060008)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060005)
                    {
                        ShowCaption = false;
                        field("Work Order No."; Rec."Work Order No.")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("WOM.Customer"; WOM.Customer)
                        {
                            ApplicationArea = All;
                            Caption = 'Customer';
                            Editable = false;
                        }
                        field("WOM.""Date Ordered"""; WOM."Date Ordered")
                        {
                            ApplicationArea = All;
                            Caption = 'Order Date';
                            Editable = false;
                        }
                    }
                }
            }
            group(Control1220060011)
            {
                ShowCaption = false;
                grid(Control1220060010)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060009)
                    {
                        ShowCaption = false;
                        field("Model No."; Rec."Model No.")
                        {
                            ApplicationArea = All;
                            Editable = false;

                            trigger OnValidate()
                            begin
                                WOD.Validate(WOD."Model No.");
                                WOD.Modify;
                                Message('The Quoted Parts have been Reset, But You Must Click on one of the Parts to Update all the Quantities');
                            end;
                        }
                        field(Description; Rec.Description)
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Serial No."; Rec."Serial No.")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }
                }
            }
            part(Control1220060004; "Quote Phase 2 Parts List")
            {
                ApplicationArea = All;
                SubPageLink = "Work Order No." = FIELD("Work Order No.");
            }
            part(Control1220060015; "Mechanics Parts Phase 2")
            {
                ApplicationArea = All;
                SubPageLink = "Work Order No." = FIELD("Work Order No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Instructions)
            {
                Caption = 'Instructions';
                action("&PrintParts")
                {
                    ApplicationArea = All;
                    Caption = '&Print Parts';

                    trigger OnAction()
                    begin
                        SerialNo := '';
                        NotChecked := '';
                        QuotedQty := '';
                        EmptyQuotePrice := '';

                        if Rec."Customer ID" = 'ADV-01' then begin
                            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
                            if Parts.Find('-') then begin
                                repeat
                                    if Parts."Serial No." <> '' then begin
                                        SerialNo := 'FOUND';
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                    end;

                                    if Parts."Quoted Quantity" > 0 then begin
                                        if Parts."Quoted Price" = 0 then
                                            EmptyQuotePrice := 'TRUE';
                                    end;
                                until Parts.Next = 0;
                            end;

                            if SerialNo = '' then
                                Message('The ADVACO Pump must be included in the QUOTE, Unable to Print');
                            if (SerialNo <> '') and (QuotedQty <> '') then
                                Message('Quoted Qty is Zero for Pump with Serial Number, Unable to Print');
                            if EmptyQuotePrice <> '' then
                                Message('Quoted Price is Zero for Atleast one Item or Resource, Unable to Print');

                            Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                            Mechanics.SetRange(Mechanics.Entered, false);
                            if Mechanics.Find('-') then begin
                                Message('All Mechanics Parts must be checked as Entered, Unable to Print');
                                NotChecked := 'NotChecked';
                            end;

                            if (NotChecked = '') and (SerialNo = 'FOUND') and (QuotedQty = '') and (EmptyQuotePrice = '') then begin
                                WOD.Reset;
                                WOD.Get(Rec."Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", Rec."Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50040, false, false, WOD);
                                ///--!
                                /*
                                Message('Do you want Quote Review?');

                                WOD.Reset;
                                WOD.Get("Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50041, false, false, WOD);
                                */
                                WOD.Reset;
                            end;

                        end else begin
                            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
                            if Parts.Find('-') then begin
                                repeat
                                    if Parts."Serial No." <> '' then begin
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                    end;

                                    if Parts."Quoted Quantity" > 0 then begin
                                        if Parts."Quoted Price" = 0 then
                                            EmptyQuotePrice := 'TRUE';
                                    end;
                                until Parts.Next = 0;
                            end;

                            if (QuotedQty <> '') then
                                Message('Quoted Qty is Zero for Pump with Serial Number, Unable to Print');

                            if EmptyQuotePrice <> '' then
                                Message('Quoted Price is Zero for at least one Item or Resource, Unable to Print');

                            Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                            Mechanics.SetRange(Mechanics.Entered, false);
                            if Mechanics.Find('-') then begin
                                Message('All Mechanics Parts must be checked as Entered, Unable to Print');
                                NotChecked := 'NotChecked';
                            end;

                            if (NotChecked = '') and (QuotedQty = '') and (EmptyQuotePrice = '') then begin
                                WOD.Reset;
                                WOD.Get(Rec."Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", Rec."Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50040, false, false, WOD);
                                ///--!
                                /*
                                Message('Do you want Quote Review?');
                                WOD.Reset;
                                WOD.Get("Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50041, false, false, WOD);
                                */
                                WOD.Reset;
                            end;
                        end;
                    end;
                }

                action("&PrintQuote")
                {
                    ApplicationArea = All;
                    Caption = '&Print Quote Review';

                    trigger OnAction()
                    begin
                        SerialNo := '';
                        NotChecked := '';
                        QuotedQty := '';
                        EmptyQuotePrice := '';

                        if Rec."Customer ID" = 'ADV-01' then begin
                            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
                            if Parts.Find('-') then begin
                                repeat
                                    if Parts."Serial No." <> '' then begin
                                        SerialNo := 'FOUND';
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                    end;

                                    if Parts."Quoted Quantity" > 0 then begin
                                        if Parts."Quoted Price" = 0 then
                                            EmptyQuotePrice := 'TRUE';
                                    end;
                                until Parts.Next = 0;
                            end;

                            if SerialNo = '' then
                                Message('The ADVACO Pump must be included in the QUOTE, Unable to Print');
                            if (SerialNo <> '') and (QuotedQty <> '') then
                                Message('Quoted Qty is Zero for Pump with Serial Number, Unable to Print');
                            if EmptyQuotePrice <> '' then
                                Message('Quoted Price is Zero for Atleast one Item or Resource, Unable to Print');

                            Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                            Mechanics.SetRange(Mechanics.Entered, false);
                            if Mechanics.Find('-') then begin
                                Message('All Mechanics Parts must be checked as Entered, Unable to Print');
                                NotChecked := 'NotChecked';
                            end;

                            if (NotChecked = '') and (SerialNo = 'FOUND') and (QuotedQty = '') and (EmptyQuotePrice = '') then begin
                                /*
                                WOD.Reset;
                                WOD.Get("Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50040, false, false, WOD);
                                */
                                ///--!
                                //Message('Do you want Quote Review?');

                                WOD.Reset;
                                WOD.Get(Rec."Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", Rec."Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50041, false, false, WOD);
                                WOD.Reset;
                            end;

                        end else begin
                            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
                            if Parts.Find('-') then begin
                                repeat
                                    if Parts."Serial No." <> '' then begin
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                    end;

                                    if Parts."Quoted Quantity" > 0 then begin
                                        if Parts."Quoted Price" = 0 then
                                            EmptyQuotePrice := 'TRUE';
                                    end;
                                until Parts.Next = 0;
                            end;

                            if (QuotedQty <> '') then
                                Message('Quoted Qty is Zero for Pump with Serial Number, Unable to Print');

                            if EmptyQuotePrice <> '' then
                                Message('Quoted Price is Zero for at least one Item or Resource, Unable to Print');

                            Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                            Mechanics.SetRange(Mechanics.Entered, false);
                            if Mechanics.Find('-') then begin
                                Message('All Mechanics Parts must be checked as Entered, Unable to Print');
                                NotChecked := 'NotChecked';
                            end;

                            if (NotChecked = '') and (QuotedQty = '') and (EmptyQuotePrice = '') then begin
                                /*
                                WOD.Reset;
                                WOD.Get("Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Work Order No.");
                                WOD.SetRecFilter;
                                */
                                //REPORT.RunModal(50040, false, false, WOD);
                                ///--!
                                //Message('Do you want Quote Review?');
                                WOD.Reset;
                                WOD.Get(Rec."Work Order No.");
                                WOD.SetFilter(WOD."Work Order No.", Rec."Work Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50041, false, false, WOD);
                                WOD.Reset;
                            end;
                        end;
                    end;
                }
                action("&Email...")
                {
                    ApplicationArea = All;
                    Caption = '&Email...';

                    trigger OnAction()
                    var
                        User: Record User;

                    begin
                        User.Get(UserSecurityId);
                        //UserSetup.Get(UserId);
                        UserSetup.Get(User."User Name");
                        if UserSetup."PDF Path to Documents" = '' then
                            Error('Call Administrator. Path to storage for PDF files not set for User %1.', UserSetup."User ID");
                        WOD.Get(Rec."Work Order No.");
                        Customer.Get(WOD."Customer ID");

                        SerialNo := '';
                        NotChecked := '';
                        QuotedQty := '';
                        EmptyQuotePrice := '';


                        if Rec."Customer ID" = 'ADV-01' then begin
                            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
                            if Parts.Find('-') then begin
                                repeat
                                    if Parts."Serial No." <> '' then begin
                                        SerialNo := 'FOUND';
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                    end;

                                    if Parts."Quoted Quantity" > 0 then begin
                                        if Parts."Quoted Price" = 0 then
                                            EmptyQuotePrice := 'TRUE';
                                    end;
                                until Parts.Next = 0;
                            end;

                            if SerialNo = '' then
                                Message('The ADVACO Pump must be included in the QUOTE, Unable to Print');
                            if (SerialNo <> '') and (QuotedQty <> '') then
                                Message('Quoted Qty is Zero for Pump with Serial Number, Unable to Print');
                            if EmptyQuotePrice <> '' then
                                Message('Quoted Price is Zero for Atleast one Item or Resource, Unable to Print');

                            Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                            Mechanics.SetRange(Mechanics.Entered, false);
                            if Mechanics.Find('-') then begin
                                Message('All Mechanics Parts must be checked as Entered, Unable to Print');
                                NotChecked := 'NotChecked';
                            end;

                            if (NotChecked = '') and (SerialNo = 'FOUND') and (QuotedQty = '') and (EmptyQuotePrice = '') then begin
                                if Confirm('Do you want to print to PDF and email this order?', true) then
                                    QuoteToPDFEmail(WOD, Customer)
                                else begin
                                    WOD.SetFilter(WOD."Work Order No.", Rec."Work Order No.");
                                    WOD.SetRecFilter;
                                    REPORT.Run(50041, false, true, WOD);
                                    WOD.Reset;
                                end;
                            end;

                        end else begin
                            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
                            if Parts.Find('-') then begin
                                repeat
                                    if Parts."Serial No." <> '' then begin
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                    end;

                                    if Parts."Quoted Quantity" > 0 then begin
                                        if Parts."Quoted Price" = 0 then
                                            EmptyQuotePrice := 'TRUE';
                                    end;
                                until Parts.Next = 0;
                            end;

                            if (QuotedQty <> '') then
                                Message('Quoted Qty is Zero for Pump with Serial Number, Unable to Print');

                            if EmptyQuotePrice <> '' then
                                Message('Quoted Price is Zero for Atleast one Item or Resource, Unable to Print');

                            Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                            Mechanics.SetRange(Mechanics.Entered, false);
                            if Mechanics.Find('-') then begin
                                Message('All Mechanics Parts must be checked as Entered, Unable to Print');
                                NotChecked := 'NotChecked';
                            end;

                            if (NotChecked = '') and (QuotedQty = '') and (EmptyQuotePrice = '') then begin
                                if Confirm('Do you want to print to PDF and email this order?', true) then
                                    QuoteToPDFEmail(WOD, Customer)
                                else begin
                                    WOD.SetFilter(WOD."Work Order No.", Rec."Work Order No.");
                                    WOD.SetRecFilter;
                                    REPORT.Run(50041, false, true, WOD);
                                    WOD.Reset;
                                end;
                            end;
                        end;
                    end;
                }
            }
            action("Customer Info")
            {
                ApplicationArea = All;
                Caption = 'Customer Info';
                Visible = CustInfoVisible;

                trigger OnAction()
                begin
                    if WOM."Work Order Master No." <> '' then begin
                        CustFile := 'C:\Windows\Desktop\' + WOM.Customer + '-' + WOM."Ship To Code" + '.doc';
                        HyperLink(CustFile);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MasterNo := CopyStr(Rec."Work Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        WOS.SetCurrentKey("Order No.", Step);
        WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
        if WOS.Find('+') then begin
            WOS."File Exists" := false;

            ///--! FileMgmt issue
            // 08/05/20 ICE SII
            /*
            CustFile := 'C:\Windows\Desktop\' + WOM.Customer + '-' + WOM."Ship To Code" + '.doc';
            WOS."File Exists" := Exists(CustFile);

            if WOS."File Exists" = true then
                CustInfoVisible := true
            else
                CustInfoVisible := false;
            */
        end;
    end;

    var
        WOM: Record WorkOrderMaster;
        WOS: Record Status;
        MasterNo: Code[7];
        OK: Boolean;
        CustFile: Text[250];
        WOD: Record WorkOrderDetail;
        SerialNo: Code[10];
        NotChecked: Code[10];
        QuotedQty: Code[10];
        EmptyQuotePrice: Code[10];
        Parts: Record Parts;
        Mechanics: Record QuoteMechanicsParts;
        Customer: Record Customer;
        EmailForm: Page "Email Dialog 2";
        UserSetup: Record "User Setup";
        [InDataSet]
        CustInfoVisible: Boolean;

    procedure QuoteToPDFEmail(WOD: Record WorkOrderDetail; Customer: Record Customer)
    var
        UserSetup: Record "User Setup";
        PDFPrinter: Codeunit ExportInvoicesToPDF;
        InternalEmail: Codeunit Mail;
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
        if not PDFPrinter.PrintQ2ToPDF(WOD, AttachmentName) then
            Error('');

        // Build strings
        MailTo := 'kaye@advaco.com';
        SubjectLine := StrSubstNo('Quote Phase 2 %1', WOD."Work Order No.");
        BodyText := 'Attached please find the Quote Phase 2 for Order #' + WOD."Work Order No." + '.';

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
            //InternalEmail.NewMessage(MailTo, MailCC, SubjectLine, BodyText, AttachmentName, '', false);
        end;
    end;
}

#pragma implicitwith restore

