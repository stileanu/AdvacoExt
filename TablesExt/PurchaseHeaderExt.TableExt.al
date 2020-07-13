tableextension 50120 PurchaseheaderExt extends "Purchase Header"
{
    /*  
        10/04/00
        Added code to insert special numbering series

        12/15/00
        Added field 50000 - Blanket Order No.
        IF Order Type = Blanket Order than Blanket Order No. = No.

        1/19/01
        htcs, rca - Added IF/THEN BEGIN to special numbering insert

        04/15/03
        HEF Added Code to Sell-to Customer No. - OnValidate() to insert Vendor Address in the Ship To

        04/26/11 ADV
        Linked Shipping Agent field with the Shipping Agent table

        08/27/12 ADV
        Added code and functions to update "Quality Clause" from Purchase Line table

        07/20/19
        Added field <Order Acknowledgement> to be set when Vendor confirm order.
        Modify tagged code to update lines.

    */
    fields
    {
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                //HEF INSERT
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    "Return to Vendor" := TRUE;
                //HEF END INSERT

                //>> HEF Insert
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    "Location Code" := 'defective';
                    VALIDATE("Location Code");
                END;

                IF "Location Code" = '' THEN BEGIN
                    "Location Code" := 'MAIN';
                    VALIDATE("Location Code");
                END;
                //<< END Insert
            end;
        }
        modify("Posting Date")
        {
            trigger OnAfterValidate()
            begin
                //HEF INSERT TO UPDATE DUE DATE TO INVOICE POSTING DATE
                "Document Date" := "Posting Date";
                VALIDATE("Document Date");
                //HEF END INSERT
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                //HEF INSERT
                //Code Added to allow Vendor Shipping Information to be Entered
                Vend.Get("Buy-from Vendor No.");
                IF "Return to Vendor" THEN BEGIN
                    "Ship-to Code" := '';
                    "Ship-to Name" := Vend.Name;
                    "Ship-to Name 2" := Vend."Name 2";
                    "Ship-to Address" := Vend.Address;
                    "Ship-to Address 2" := Vend."Address 2";
                    "Ship-to City" := Vend.City;
                    "Ship-to Post Code" := Vend."Post Code";
                    "Ship-to County" := Vend.County;
                    "Ship-to Country/Region Code" := Vend."Country/Region Code";
                    "Ship-to Contact" := Vend.Contact;
                    // HEF END INSERT
                end;
            end;
        }
        field(50000; "Blanket Order No."; Code[10])
        {
            Caption = 'Blanket Order No.';
        }
        field(50001; "Quality Clause"; Code[10])
        {
            Caption = 'Quality Clause';

            trigger OnValidate()
            var
                cCod: Text[1];
                nLength: Integer;

            begin
                // 08/27/12 Start
                nLength := STRLEN("Quality Clause");
                cCod := COPYSTR("Quality Clause", nLength);
                REPEAT
                    IF STRPOS('CFHIJKSXZ5', cCod) = 0 THEN BEGIN
                        MESSAGE(ADVMsg001, cCod);
                    END;
                    IF cCod = ',' THEN EXIT;
                    nLength -= 2;
                    IF nLength > 0 THEN
                        cCod := COPYSTR("Quality Clause", nLength, 1)
                UNTIL nLength <= 0;
                // 08/27/12 End
            end;
        }
        field(50002; "Shipping Agent"; Code[20])
        {
            Caption = 'Shipping Agent';
        }
        field(50003; Notes; Code[75])
        {
            Caption = 'Notes';
        }
        field(50004; "Placed by"; Enum OrderPlacedBy)
        {
            Caption = 'Placed by';
        }
        field(50005; "Order Acknowledgement"; Boolean)
        {
            Caption = 'Order Acknowledgement';
        }
        field(50006; Requested; Code[3])
        {
            Caption = 'Requested';
        }
        field(50007; "Vendor Fax"; Text[30])
        {
            Caption = 'Vendor Fax';
        }
        field(50008; "Vendor E-mail"; Text[80])
        {
            Caption = 'Vendor E-mail';
        }
        field(50009; "Vendor Repair"; Boolean)
        {
            Caption = 'Vendor Repair';
        }
        field(50010; "Credit Memo Posted"; Boolean)
        {
            Caption = 'Credit Memo Posted';
        }
        field(50011; "Credit Memo Action"; Enum CreditMemoAction)
        {
            Caption = 'Credit Memo Action';
        }
        field(50012; "Authorized By"; Code[30])
        {
            Caption = 'Authorized By';
        }
        field(50013; "Bill of Lading"; Integer)
        {
            Caption = 'Bill of Lading';
        }
        field(50014; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(50015; "Shipping Charge"; Enum ShippingCharge)
        {
            Caption = 'Shipping Charge';
        }
        field(50016; "Return Reason"; Code[200])
        {
            Caption = 'Return Reason';
        }
        field(50017; "Shipping Account"; Code[20])
        {
            Caption = 'Shipping Account';
        }
        field(50018; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
        }
        field(50019; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(50020; "Return to Vendor"; Boolean)
        {
            Caption = 'Return to Vendor';
        }
        field(50021; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
        }
        field(50022; "Completion USERID"; Code[20])
        {
            Caption = 'Completion USERID';
        }
        field(50023; "RMA No."; Code[30])
        {
            Caption = 'RMA No.';
        }

    }

    trigger OnBeforeInsert()
    begin
        //>> Inserted by RJK HTCS
        IF "No." = '' THEN BEGIN    // <---- line insert by rca 1/19/01
            PurchaseHeader.SETCURRENTKEY("Document Type", "Order Date");
            PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", "Document Type");
            //  PurchaseHeader.SETRANGE(PurchaseHeader."Document Date",WORKDATE);
            PurchaseHeader.SETRANGE(PurchaseHeader."Order Date", WORKDATE);

            IF PurchaseHeader.FIND('+') THEN BEGIN
                "No." := INCSTR(PurchaseHeader."No.");
                IF "Document Type" = "Document Type"::"Credit Memo" THEN BEGIN
                    "Blanket Order No." := "No.";
                END;
            END ELSE BEGIN
                IF "Document Type" = "Document Type"::Quote THEN
                    "No." := 'PQ' + FORMAT(WORKDATE, 0, '<Year><Month,2><Day,2>') + '01'
                ELSE
                    IF "Document Type" = "Document Type"::Order THEN
                        "No." := FORMAT(WORKDATE, 0, '<Year><Month,2><Day,2>') + '001'
                    ELSE
                        IF "Document Type" = "Document Type"::"Credit Memo" THEN
                            "No." := 'CM' + FORMAT(WORKDATE, 0, '<Year><Month,2><Day,2>') + '01'
                        ELSE
                            IF "Document Type" = "Document Type"::"Blanket Order" THEN BEGIN
                                "No." := 'BO' + FORMAT(WORKDATE, 0, '<Year><Month,2><Day,2>') + '01';
                                "Blanket Order No." := "No.";
                            END;
            END;
        END;

        "Order Date" := TODAY;

        IF "Document Type" = "Document Type"::"Credit Memo" THEN
            "Purchaser Code" := 'PMS';

        //<< End Insert
    end;

    var
        PurchaseHeader: Record "Purchase Header";
        Vend: Record Vendor;
        ADVMsg001: Label 'Code %1 not valid. Refer to SD0006 for acceptable codes.';

    procedure TestInQualityClause(CodeToTest: Text[1]; PurchHeader: Record "Purchase Header"): Boolean
    begin
        // 08/27/12 New Function
        Rec := PurchHeader;
        IF STRPOS("Quality Clause", CodeToTest) <> 0 THEN
            EXIT(TRUE);
        EXIT(FALSE);
    end;

    procedure AddCodeToQualityClause(CodeToAdd: Text[1]; var PurchHeader: Record "Purchase Header"): Boolean
    var
        TextCode: text[2];

    begin
        // 08/27/12 New Function
        Rec := PurchHeader;
        // Test for code already in clause
        IF STRPOS("Quality Clause", CodeToAdd) <> 0 THEN
            EXIT(FALSE);
        // Build string
        IF STRLEN("Quality Clause") = 0 THEN
            TextCode := 'I'
        ELSE
            TextCode := 'I,';
        // Add string and save modifications
        "Quality Clause" := TextCode + "Quality Clause";
        MODIFY(FALSE);

        PurchHeader := Rec;
        EXIT(TRUE);

    end;

    procedure DelCodeFromQualityClause(CodeToDel: Text[1]; var PurchHeader: Record "Purchase Header"): Boolean
    var
        nPos: Integer;

    begin
        // 08/27/12 New Function
        // Test for code in clause
        Rec := PurchHeader;
        nPos := STRPOS("Quality Clause", CodeToDel);
        IF nPos = 0 THEN
            EXIT(FALSE);
        CASE nPos OF
            9:
                "Quality Clause" := DELSTR("Quality Clause", nPos, 1);
            ELSE
                "Quality Clause" := DELSTR("Quality Clause", nPos, 2);
        END;
        MODIFY(FALSE);

        PurchHeader := Rec;
        EXIT(TRUE);
    end;

    procedure ExistInspectionReqItem(OrderNo: Code[20]; ItemToSkip: Code[20]): Boolean
    var
        PurchLineLocal: Record "Purchase Line";
        lFound: Boolean;
        ItemLocal: Record Item;

    begin

        // 08/27/12 New Function
        PurchLineLocal.RESET;
        //PurchLineLocal.SETRANGE("Document Type",PurchLineLocal."Document Type"::Order);
        PurchLineLocal.SETFILTER("Document Type", '1|4');
        PurchLineLocal.SETRANGE("Document No.", OrderNo);
        PurchLineLocal.SETRANGE(Type, PurchLineLocal.Type::Item);
        IF NOT PurchLineLocal.FINDFIRST THEN
            EXIT(TRUE);

        lFound := FALSE;
        REPEAT
            IF PurchLineLocal."No." <> ItemToSkip THEN BEGIN
                IF ItemLocal.GET(PurchLineLocal."No.") THEN
                    IF ItemLocal."Receiving Inspection" THEN
                        lFound := TRUE;
            END;
        UNTIL PurchLineLocal.NEXT = 0;

        EXIT(lFound);
    end;
}