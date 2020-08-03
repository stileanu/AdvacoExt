page 50019 "Quote Modify"
{
    SourceTable = Status;
    SourceTableView = SORTING("Order No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Step = CONST(QOT),
                            Type = CONST(WorkOrder));

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
                        field("Order No."; "Order No.")
                        {
                            Editable = false;
                        }
                        field("WOM.Customer"; WOM.Customer)
                        {
                            Caption = 'Customer';
                            Editable = false;
                        }
                        field(Employee; Employee)
                        {
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
                        field("WOD.""Model No."""; WOD."Model No.")
                        {
                            Caption = 'Model No.';
                            Editable = false;
                        }
                        field("Date In"; "Date In")
                        {
                            Editable = false;
                        }
                        field("Regular Hours"; "Regular Hours")
                        {
                            Editable = false;
                        }
                    }
                }
            }
            group(Control1220060020)
            {
                ShowCaption = false;
                grid(Control1220060015)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060004)
                    {
                        ShowCaption = false;
                        field("WOD.""Serial No."""; WOD."Serial No.")
                        {
                            Caption = 'Serial No.';
                        }
                        field("Date Out"; "Date Out")
                        {
                        }
                        field("Overtime Hours"; "Overtime Hours")
                        {
                        }
                    }
                }
            }
            group(Control1220060026)
            {
                ShowCaption = false;
                field("WOD.""Order Type"""; WOD."Order Type")
                {
                    Caption = 'Order Type';
                }
                field("WOD.""Pump Module No."""; WOD."Pump Module No.")
                {
                    Caption = 'Pump Module No.';
                    Editable = PumpModifyEditable;
                    TableRelation = WorkOrderDetail."Work Order No." WHERE("Customer ID" = FILTER('ADV-01'),
                                                                                Complete = FILTER(false),
                                                                                "Detail Step" = CONST(SHP),
                                                                                "Customer Order No." = FILTER(''));
                }
            }
            part(Control1220060029; "Quote Modify Parts List")
            {
                SubPageLink = "Work Order No." = FIELD("Order No.");
            }
            part(Control1220060030; "Mechanics Parts Phase 2")
            {
                SubPageLink = "Work Order No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Instructions)
            {
                Caption = 'Instructions';
                action("&Print")
                {
                    Caption = '&Print';

                    trigger OnAction()
                    begin
                        SerialNo := '';
                        NotChecked := '';
                        QuotedQty := '';
                        EmptyQuotePrice := '';

                        if WOD."Customer ID" = 'ADV-01' then begin
                            Parts.SetRange(Parts."Work Order No.", "Order No.");
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
                                WOD.Get("Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50040, false, false, WOD);
                                WOD.Reset;
                                WOD.Get("Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Order No.");
                                WOD.SetRecFilter;
                                if WOD."Build Ahead" then
                                    REPORT.RunModal(50042, false, false, WOD)
                                else
                                    REPORT.RunModal(50041, false, false, WOD);
                                WOD.Reset;
                            end;

                        end else begin
                            Parts.SetRange(Parts."Work Order No.", "Order No.");
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
                                WOD.Reset;
                                WOD.Get("Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Order No.");
                                WOD.SetRecFilter;
                                REPORT.RunModal(50040, false, false, WOD);
                                WOD.Reset;
                                WOD.Get("Order No.");
                                WOD.SetFilter(WOD."Work Order No.", "Order No.");
                                WOD.SetRecFilter;
                                if WOD."Build Ahead" then
                                    REPORT.RunModal(50042, false, false, WOD)
                                else
                                    REPORT.RunModal(50041, false, false, WOD);
                                WOD.Reset;
                            end;
                        end;
                    end;
                }
                action("&Email...")
                {
                    Caption = '&Email...';

                    trigger OnAction()
                    begin
                        UserSetup.Get(UserId);
                        if UserSetup."PDF Path to Documents" = '' then
                            Error('Call Administrator. Path to storage for PDF files not set for User %1.', UserSetup."User ID");
                        WOD.Get("Order No.");
                        Customer.Get(WOD."Customer ID");

                        SerialNo := '';
                        NotChecked := '';
                        QuotedQty := '';
                        EmptyQuotePrice := '';

                        if WOD."Customer ID" = 'ADV-01' then begin
                            Parts.SetRange(Parts."Work Order No.", "Order No.");
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
                                    WOD.Reset;
                                    WOD.Get("Order No.");
                                    WOD.SetFilter(WOD."Work Order No.", "Order No.");
                                    WOD.SetRecFilter;
                                    if WOD."Build Ahead" then
                                        REPORT.RunModal(50042, false, true, WOD)
                                    else
                                        REPORT.RunModal(50041, false, true, WOD);
                                    WOD.Reset;
                                end;
                            end;

                        end else begin
                            Parts.SetRange(Parts."Work Order No.", "Order No.");
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
                                    WOD.Reset;
                                    WOD.Get("Order No.");
                                    WOD.SetFilter(WOD."Work Order No.", "Order No.");
                                    WOD.SetRecFilter;
                                    if WOD."Build Ahead" then
                                        REPORT.RunModal(50042, false, true, WOD)
                                    else
                                        REPORT.RunModal(50041, false, true, WOD);
                                    WOD.Reset;
                                end;
                            end;
                        end;
                    end;
                }
            }
            action("Customer Info")
            {
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
        MasterNo := CopyStr("Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        WOD.Get("Order No.");
        OLDWOD := WOD;

        "File Exists" := false;

        CustFile := 'F:\SHARED\Customer Records\' + WOM.Customer + '-' + WOM."Ship To Code" + '.doc';
        "File Exists" := Exists(CustFile);

        if "File Exists" = true then
            CustInfoVisible := true
        else
            CustInfoVisible := false;

        //Prevents adding Pump Module No. before the Order is Processed by the Parts Department
        if WOD."Pump Module Processed" then
            PumpModifyEditable := true
        else
            PumpModifyEditable := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        MissingReason := false;
        Parts.Reset;
        Parts.SetCurrentKey("Work Order No.", "Part Type");
        Parts.SetRange(Parts."Work Order No.", "Order No.");
        if Parts.Find('-') then begin
            repeat
                if (Parts."After Quote Quantity" <> 0) and (Parts.Reason = 0) then
                    MissingReason := true;
            until Parts.Next = 0;
        end;

        if MissingReason then begin
            Error('Reason Codes Must be Added Before Exiting Parts Adjustment');
        end;
    end;

    var
        Window: Dialog;
        OrderReason: Text[100];
        WOD: Record WorkOrderDetail;
        WOD2: Record WorkOrderDetail;
        OLDWOD: Record WorkOrderDetail;
        WOM: Record WorkOrderMaster;
        Instructions: Text[250];
        MasterNo: Code[7];
        OK: Boolean;
        CustFile: Text[250];
        BAReport: Boolean;
        Parts: Record Parts;
        MissingReason: Boolean;
        SerialNo: Code[10];
        NotChecked: Code[10];
        QuotedQty: Code[10];
        EmptyQuotePrice: Code[10];
        Mechanics: Record QuoteMechanicsParts;
        ModuleParts: Record Parts;
        ModuleDetail: Record WorkOrderDetail;
        Customer: Record Customer;
        EmailForm: Page "Email Dialog 2";
        UserSetup: Record "User Setup";
        [InDataSet]
        CustInfoVisible: Boolean;
        [InDataSet]
        PumpModifyEditable: Boolean;

    procedure QuoteToPDFEmail(WOD: Record WorkOrderDetail; Customer: Record Customer)
    var
        UserSetup: Record "User Setup";
        PDFPrinter: Codeunit "Export Invoices to PDF";
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
        RepNo: Integer;
    begin
        LFChar := 10;
        CRChar := 13;
        CRLF[1] := LFChar;
        CRLF[2] := CRChar;

        // Print to PDF
        if WOD."Build Ahead" then
            RepNo := 50094
        else
            RepNo := 50093;
        if not PDFPrinter.PrintQMToPDF(WOD, AttachmentName, RepNo) then
            Error('');

        // Build strings
        MailTo := 'kaye@advaco.com';
        SubjectLine := StrSubstNo('Quote Modify Order %1', WOD."Work Order No.");
        BodyText := 'Attached please find the Quote Modify Document for Order #' + WOD."Work Order No." + '.';

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
            InternalEmail.NewMessage(MailTo, MailCC, SubjectLine, BodyText, AttachmentName, '', false);
        end;
    end;
}

