codeunit 50026 PurchPost_PrintEmail
{
    // version ADV

    // New Codeunit to print to PDF and email the Purchase Order.

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
        //WITH PurchHeader DO BEGIN ///--! WITH statement eliminated
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order THEN BEGIN
            Selection := STRMENU('&Receive,&Invoice,Receive &and Invoice', 3);
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

        PurchPost.RUN(PurchHeader);

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
}

