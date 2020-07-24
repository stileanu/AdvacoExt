codeunit 50014 CreditCardFeeFunctions
{
    // version ADV

    TableNo = "Sales Header";

    trigger OnRun();
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        SalesHeader: Record "Sales Header";

    procedure InsertCreditCardFeeLine(Rec: Record "Sales Header");
    begin
        // 04/30/13 - new function
        SalesHeader.COPY(Rec);
        SalesHeader.CALCFIELDS(Amount, "Amount Including VAT");
        GLSetup.GET;
        // test for setup
        IF GLSetup."Credit Card Fee Account" = '' then
            ERROR('Credit Card payment Account is not set in G/L Setup');

        // Test for existing line
        IF not IsCCFee(SalesHeader) then begin
            // Line No.
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            IF SalesLine.FIND('+') then
                LineNo += SalesLine."Line No." + 10000
            ELSE
                LineNo := 10000;

            SalesLine.RESET;
            SalesLine.INIT;
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Line No." := LineNo;
            SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            SalesLine.Type := SalesLine.Type::"G/L Account";
            SalesLine."No." := GLSetup."Credit Card Fee Account";
            SalesLine."Location Code" := 'MAIN';
            SalesLine.Description := 'Credit Card Processing Fee ' + FORMAT(GLSetup."Credit Card Fee %") + ' %';
            SalesLine."Credit Card Fee" := TRUE;
            SalesLine."Allow Invoice Disc." := FALSE;
            SalesLine."VAT Calculation Type" := SalesLine."VAT Calculation Type"::"Sales Tax";
            SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
            SalesLine.VALIDATE(Quantity, 1);
            SalesLine.VALIDATE("Unit Price", SalesHeader."Amount Including VAT" * GLSetup."Credit Card Fee %" / 100);
            SalesLine."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";

            SalesLine.INSERT(FALSE);
        end;
        Rec := SalesHeader;
    end;

    procedure IsCCFee(SalesHeader: Record "Sales Header"): Boolean;
    var
        IsCCFeeInserted: Boolean;
    begin
        // 04/30/13 - new function
        IsCCFeeInserted := FALSE;
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FIND('-') then
            repeat
                IF SalesLine."Credit Card Fee" then
                    IsCCFeeInserted := TRUE;
            until SalesLine.NEXT = 0;

        exit(IsCCFeeInserted);
    end;
}

