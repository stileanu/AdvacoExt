codeunit 50050 PurchPost_Yes_No_
{
    // version US2.00,LDUS2.00

    TableNo = "Purchase Header";

    trigger OnRun();
    begin
        PurchHeader.COPY(Rec);
        Code;
        Rec := PurchHeader;
    end;

    var
        PurchHeader : Record "Purchase Header";
        PurchPost : Codeunit "Purch.-Post";
        Selection : Integer;

    local procedure "Code"();
    begin
        WITH PurchHeader DO BEGIN
          IF "Document Type" = "Document Type"::Order THEN BEGIN
            Selection := STRMENU('&Receive',1);
            IF Selection = 0 THEN
              EXIT;
            Receive := Selection IN [1];
            PurchHeader.Invoice := FALSE;
          END ELSE
            IF NOT
               CONFIRM(
                 'Do you want to post the %1?',FALSE,
                 "Document Type")
            THEN
              EXIT;

            PurchPost.RUN(PurchHeader);
        END;
    end;
}

