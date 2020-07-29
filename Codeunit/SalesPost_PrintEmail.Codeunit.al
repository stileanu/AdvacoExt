codeunit 50025 SalesPost_PrintEmail
{
    // version ADV

    // New Codeunit to print to PDF and email the Sales Invoice.

    TableNo = "Sales Header";

    trigger OnRun();
    begin
        SalesHeader.COPY(Rec);
        Code;
        Rec := SalesHeader;
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReportSelection: Record "Report Selections";
        Cust: Record Customer;
        EmailForm: Page "Email Dialog";
        SalesPost: Codeunit "Sales-Post";
        Selection: Integer;
        CRLF: Text[30];

    local procedure "Code"();
    begin
        Cust.GET(SalesHeader."Bill-to Customer No.");
        IF NOT Cust."Email Invoice" THEN
            ERROR('Customer %1 is not set to email Invoices', SalesHeader."Bill-to Customer No.");
        IF Cust."Invoicing Email" = '' THEN
            ERROR('Address to Email Invoices for Customer %1 is empty', SalesHeader."Bill-to Customer No.");

        WITH SalesHeader DO BEGIN
            IF "Document Type" = "Document Type"::Order THEN BEGIN
                Selection := STRMENU('&Ship,&Invoice,Ship &and Invoice', 3);
                IF Selection = 0 THEN
                    EXIT;
                Ship := Selection IN [1, 3];
                Invoice := Selection IN [2, 3];
            END ELSE
                IF NOT
                   CONFIRM(
                     'Do you want to post and email the %1?', FALSE,
                     "Document Type")
                THEN
                    EXIT;

            SalesPost.RUN(SalesHeader);

            CASE "Document Type" OF
                "Document Type"::Order:
                    BEGIN
                        IF Ship THEN BEGIN
                            SalesShipmentHeader."No." := "Last Shipping No.";
                            SalesShipmentHeader.SETRECFILTER;
                            PrintReport(ReportSelection.Usage::"S.Shipment");
                        END;
                        IF Invoice THEN BEGIN
                            SalesInvHeader."No." := "Last Posting No.";
                            SalesInvHeader.SETRECFILTER;
                            PrintReport(ReportSelection.Usage::"S.Invoice");
                        END;
                    END;
                "Document Type"::Invoice:
                    BEGIN
                        IF "Last Posting No." = '' THEN
                            SalesInvHeader."No." := "No."
                        ELSE
                            SalesInvHeader."No." := "Last Posting No.";
                        SalesInvHeader.SETRECFILTER;
                        PrintReport(ReportSelection.Usage::"S.Invoice");
                    END;
                "Document Type"::"Credit Memo":
                    BEGIN
                        IF "Last Posting No." = '' THEN
                            SalesCrMemoHeader."No." := "No."
                        ELSE
                            SalesCrMemoHeader."No." := "Last Posting No.";
                        SalesCrMemoHeader.SETRECFILTER;
                        PrintReport(ReportSelection.Usage::"S.Cr.Memo");
                    END;
            END;
        END;
    end;

    local procedure PrintReport(ReportUsage: Enum "Report Selection Usage");
    begin
        ReportSelection.RESET;
        ReportSelection.SETRANGE(Usage, ReportUsage);
        ReportSelection.FIND('-');
        REPEAT
            ReportSelection.TESTFIELD("Report ID");
            CASE ReportUsage OF
                ReportSelection.Usage::"S.Invoice":
                    // print to pdf: Start
                    // Get Bill-to Customer and test email-to field
                    BEGIN
                        IF CONFIRM('Do you want to print to PDF and email this invoice?', TRUE) THEN BEGIN
                            PrintPDFEmail(SalesInvHeader, Cust);
                            REPORT.RUN(50127, FALSE, TRUE, SalesInvHeader);
                        END ELSE
                            REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesInvHeader);
                    END;
                // print to pdf: End
                ReportSelection.Usage::"S.Cr.Memo":
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesCrMemoHeader);
                ReportSelection.Usage::"S.Shipment":
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, SalesShipmentHeader);
            END;
        UNTIL ReportSelection.NEXT = 0;
    end;

    procedure PrintPDFEmail(PostedSalesInvoice: Record "Sales Invoice Header"; BillToCustomer: Record Customer): Boolean;
    var
        UserSetup: Record "User Setup";
        ///--! PDFPrinter: Codeunit "Export Invoices to PDF";
        EmailToCustomer: Codeunit Mail;
        UserSignature: array[8] of Text[120];
        AttachmentName: Text[250];
        SubjectLine: Text[250];
        BodyText: Text[500];
        MailTo: Text[100];
        MailCC: Text[100];
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

        ///--! IF NOT PDFPrinter.PrintToPDF(PostedSalesInvoice."No.", BillToCustomer."No.", AttachmentName) THEN
        ///--!     ERROR('');

        // Build strings
        MailTo := BillToCustomer."Invoicing Email";
        SubjectLine := STRSUBSTNO('Invoice %1', PostedSalesInvoice."No.");
        BodyText := 'Attached please find the Invoice #' + PostedSalesInvoice."No." + '.';

        // Launch email form and email it
        ///--! EmailForm.SetEmailValues(MailTo, MailCC, SubjectLine, AttachmentName, BodyText);
        ///--! EmailForm.RUNMODAL;
        ///--! EmailForm.GetEmailValues(bCancel, MailTo, MailCC, SubjectLine, AttachmentName, BodyText, UserSignature);

        IF NOT bCancel THEN BEGIN
            // Add Signature to body
            BodyText += CRLF + CRLF;
            i := 1;
            REPEAT
                IF UserSignature[i] <> '' THEN
                    BodyText += UserSignature[i] + CRLF;
                i += 1;
            UNTIL i > 8;
            ///--! EmailToCustomer.NewMessage(MailTo, MailCC, SubjectLine, BodyText, AttachmentName, FALSE);
        END;
    end;
}

