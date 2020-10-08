codeunit 50052 PurchPost_Yes_No_Act
{
    // version US2.00,LDUS2.00,ADV

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
        PurchPost: Codeunit "Purch.-Post";
        Selection: Integer;

    local procedure "Code"();
    begin
        //WITH PurchHeader DO BEGIN ///--! Eliminate WITH Statement
        //
        IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order THEN BEGIN
            Selection := STRMENU('&Receive,&Invoice,Receive &and Invoice', 2);
            IF Selection = 0 THEN
                EXIT;
            PurchHeader.Receive := Selection IN [1, 3];
            PurchHeader.Invoice := Selection IN [2, 3];
        END ELSE
            IF NOT
               CONFIRM(
                 'Do you want to post the %1?', FALSE,
                 PurchHeader."Document Type")
            THEN
                EXIT;
        //>> HEF INSERTED TO CHECK FOR INVOICE NO. ON INVOICE POSTING
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
        //END;
    end;

    procedure APPaymentTerms();
    var
        APVendorHeader: Record Vendor;
        VendCode: Text[5];
        LenCode: Integer;
    begin
        // 04/30/12 New function
        LenCode := STRLEN(PurchHeader."Buy-from Vendor No.");
        VendCode := COPYSTR(PurchHeader."Buy-from Vendor No.", LenCode - 1, 2);
        IF VendCode <> 'AP' THEN
            IF APVendorHeader.GET(PurchHeader."Pay-to Vendor No.") THEN BEGIN
                PurchHeader."Payment Terms Code" := APVendorHeader."Payment Terms Code";
                PurchHeader.MODIFY(FALSE);
            END;
    end;
}

