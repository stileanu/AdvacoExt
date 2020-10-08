codeunit 50053 PurchPost_Print_Act
{
    // version US2.00,ADV

    // 04/30/2012 - replace Payment Terms from original Purchase Order with Payment Terms from AP Vendor record

    TableNo = "Purchase Header";

    trigger OnRun();
    begin
        PurchHeader.COPY(Rec);
        Code;
        Rec := PurchHeader;
    end;

    var
        PurchHeader: Record "Purchase Header";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReportSelection: Record "Report Selections";
        PurchPost: Codeunit "Purch.-Post";
        Selection: Integer;

    local procedure "Code"();
    begin
        //WITH PurchHeader DO BEGIN -- removed per BC17 warning ///--! Syntax update
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order THEN BEGIN
            Selection := STRMENU('&Receive,&Invoice,Receive &and Invoice', 2);
            IF Selection = 0 THEN
                EXIT;
            PurchHeader.Receive := Selection IN [1, 3];
            PurchHeader.Invoice := Selection IN [2, 3];
        END ELSE
            IF NOT
               CONFIRM(
                 'Do you want to post and print the %1?', FALSE,
                 PurchHeader."Document Type")
            THEN
                EXIT;
        //>>  HEF INSERTED TO CHECK FOR INVOICE NO. ON INVOICE POSTING
        IF (Selection = 2) OR (Selection = 3) THEN BEGIN
            IF PurchHeader."Vendor Invoice No." = '' THEN
                ERROR('Vendor Invoice No. must be Entered')
            ELSE
              // 04/30/12 Start
              BEGIN
                APPaymentTerms;
                // 04/30/12 End
                PurchPost.RUN(PurchHeader);
                // 04/30/12 Start
            END
            // 04/30/12 End
        END ELSE BEGIN
            // 04/30/12 Start
            APPaymentTerms;
            // 04/30/12 End
            PurchPost.RUN(PurchHeader);
        END;
        //<< END INSERT
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::Order:
                BEGIN
                    IF PurchHeader.Receive THEN BEGIN
                        PurchReceiptHeader."No." := PurchHeader."Last Receiving No.";
                        PurchReceiptHeader.SETRECFILTER;
                        PrintReport(ReportSelection.Usage::"P.Receipt");
                    END;
                    IF PurchHeader.Invoice THEN BEGIN
                        PurchInvHeader."No." := PurchHeader."Last Posting No.";
                        PurchInvHeader.SETRECFILTER;
                        PrintReport(ReportSelection.Usage::"P.Invoice");
                    END;
                END;
            PurchHeader."Document Type"::Invoice:
                BEGIN
                    IF PurchHeader."Last Posting No." = '' THEN
                        PurchInvHeader."No." := PurchHeader."No."
                    ELSE
                        PurchInvHeader."No." := PurchHeader."Last Posting No.";
                    PurchInvHeader.SETRECFILTER;
                    PrintReport(ReportSelection.Usage::"P.Invoice");
                END;
            PurchHeader."Document Type"::"Credit Memo":
                BEGIN
                    IF PurchHeader."Last Posting No." = '' THEN
                        PurchCrMemoHeader."No." := PurchHeader."No."
                    ELSE
                        PurchCrMemoHeader."No." := PurchHeader."Last Posting No.";
                    PurchCrMemoHeader.SETRECFILTER;
                    PrintReport(ReportSelection.Usage::"P.Cr.Memo");
                END;
        END;
        //END;
    end;

    local procedure PrintReport(ReportUsage: Enum "Report Selection Usage");
    begin
        ReportSelection.RESET;
        ReportSelection.SETRANGE(Usage, ReportUsage);
        ReportSelection.FIND('-');
        REPEAT
            ReportSelection.TESTFIELD("Report ID");
            CASE ReportUsage OF
                ReportSelection.Usage::"P.Invoice":
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, PurchInvHeader);
                ReportSelection.Usage::"P.Cr.Memo":
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, PurchCrMemoHeader);
                ReportSelection.Usage::"P.Receipt":
                    REPORT.RUN(ReportSelection."Report ID", FALSE, FALSE, PurchReceiptHeader);
            END;
        UNTIL ReportSelection.NEXT = 0;
    end;

    procedure APPaymentTerms();
    var
        APVendorHeader: Record Vendor;
        VendCode: Text[5];
        LenCode: Integer;
    begin
        // 04/30/12 New function
        LenCode := STRLEN(PurchHeader."Buy-from Vendor No.");
        VendCode := STRSUBSTNO(PurchHeader."Buy-from Vendor No.", LenCode - 1, LenCode);
        IF VendCode <> 'AP' THEN
            IF APVendorHeader.GET(PurchHeader."Pay-to Vendor No.") THEN BEGIN
                PurchHeader."Payment Terms Code" := APVendorHeader."Payment Terms Code";
                PurchHeader.MODIFY(FALSE);
            END;
    end;
}

