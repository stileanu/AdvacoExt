tableextension 50114 CustomerExt extends Customer
{
    /*
        12/27/00
        Code added to OnValidate of Tax Exemption ID and Exemtion Organization
        01/11/01
        Code remarked out temporarily
        07/25/01
        Tax Liability Validate Code Added
        08/06/01
        LOCATION CODE, POSTING GROUP AUTO FILLED IN
        07/25/02
        Payment Terms set to NET30 When Credit Limit Added
        10/21/02
        USER ID save on Modify
        05/02/13 ADV
        Added new field <Email Invoice> to set Email for Invoices.
        01/21/16 ADV
        Added field 50010 Path to PDF where the PDF printed Invoices can be found.
        02/07/16 ADV
        Added field 50011 Invoicing Email for Invoices only.
        06/09/19
        Added field 50012 CC Fee Waived to indicate Credit Card fee is waived. Will print message on Envelopes.    
    */

    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                //HEF INSERTED 08/06/01
                "Customer Posting Group" := 'CPG';
                "Location Code" := 'MAIN';
                "Invoice Copies" := 2;
                "Customer Since" := WORKDATE;
            end;
        }
        modify("Credit Limit (LCY)")
        {
            trigger OnAfterValidate()
            begin
                //HEF INSERT
                "Payment Terms Code" := 'NET30';
                IF xRec."Payment Terms Code" <> '' THEN
                    MESSAGE('Payment Terms changed from %1 to NET30', xRec."Payment Terms Code")
                ELSE
                    MESSAGE('Payment Terms set to NET 30');
                //HEF END
            end;
        }

        field(50000; Rep; Code[10])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";
        }
        field(50001; "Shipping Account"; Code[20])
        {
        }
        field(50002; "Exempt Organization"; Text[50])
        {
            trigger OnValidate()
            begin

                /*
                //>>Insert by HTCS RJK 12/27/00
                TestString := COPYSTR("Tax Exemption No.",1,1);
                IF (TestString <> '0') AND (TestString <> '') THEN BEGIN
                  ERROR('Not a Valid Tax ID Number');
                END;
                //<<End Insert
                */

                IF "Tax Liable" = TRUE THEN BEGIN
                    "Tax Exemption No." := '';
                    MODIFY;
                    MESSAGE('%1 Can''t be Tax Liable and Have Tax Exempt Numbers at the same time,"No."');
                END;
            end;
        }
        field(50003; "Customer Since"; Date)
        {
        }
        field(50004; "Ship on Sales Order"; Boolean)
        {
            trigger OnValidate()
            begin
                // UPDATE Work Orders for Ship to Sales Orders Capabilities for Customers
                WOD.SETRANGE(WOD."Customer ID", "No.");
                WOD.SETRANGE(WOD.Complete, FALSE);
                IF WOD.FIND('-') THEN BEGIN
                    REPEAT
                        IF "Ship on Sales Order" THEN BEGIN
                            WOD."Ship on Sales Order" := TRUE;
                        END ELSE BEGIN
                            IF WOD."Sales Order No." = '' THEN BEGIN
                                WOD."Ship on Sales Order" := FALSE;
                            END;
                        END;
                        WOD.MODIFY;
                    UNTIL WOD.NEXT = 0;
                END;
            end;
        }
        field(50005; "User ID"; Code[20])
        {
        }
        field(50006; "Internet Invoicing"; Boolean)
        {
        }
        field(50007; "Credit Issues"; Boolean)
        {
        }
        field(50008; "No Internet/Paper Invoice"; Boolean)
        {
        }
        field(50009; "Email Invoice"; Boolean)
        {
            trigger OnValidate()
            begin
                // 02/07/16 Start
                IF "Email Invoice" THEN BEGIN
                    IF "Invoicing Email" = '' THEN BEGIN
                        IF "E-Mail" = '' THEN
                            ERROR(NO_EMAIL_ADDRESS)
                        ELSE BEGIN
                            "Invoicing Email" := "E-Mail";
                            MODIFY;
                        END;
                    END;
                    IF NOT ValidateEmail("Invoicing Email") THEN BEGIN
                        ERROR(NO_VALID_EMAIL, "Invoicing Email");
                    END;
                END;
                // 02/07/16 End
            end;
        }
        field(50010; "Path to PDF"; Text[127])
        {
        }
        field(50011; "Invoicing Email"; Text[80])
        {
            trigger OnValidate()
            begin
                IF "Invoicing Email" <> '' THEN BEGIN
                    IF NOT ValidateEmail("Invoicing Email") THEN BEGIN
                        ERROR(NO_VALID_EMAIL, "Invoicing Email");
                    END;
                END ELSE BEGIN
                    IF "Email Invoice" THEN
                        "Email Invoice" := FALSE;
                END;
            end;
        }
        field(50012; "CC Fee Waived"; Boolean)
        {
        }
    }

    trigger OnAfterModify()
    begin
        //>> HEF Add User Who Modified File
        "User ID" := USERID;
        //>> End Insert
    end;

    procedure ValidateEmail(Email: Text[80]): Boolean
    begin
        if StrPos(Email, '@') = 0 then
            exit(false);
        if StrPos(CopyStr(Email, StrPos(Email, '@') + 1), '.') = 0 then
            exit(false);
        if StrPos(CopyStr(Email, StrPos(Email, '@') + 1), '.') = StrLen(Email) then
            exit(false);

        exit(true);
    end;

    var
        WOD: Record WorkOrderDetail;
        NO_EMAIL_ADDRESS: Label 'No Invoicing Email address set for current customer.';
        NO_VALID_EMAIL: Label 'Email address %1 is not valid.';
}