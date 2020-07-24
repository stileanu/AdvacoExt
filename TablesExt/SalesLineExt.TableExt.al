tableextension 50119 SalesLineExt extends "Sales Line"
{
    /*
    10/24/00 HTCS RJK
    Added field 50000 Commission Calculated (Boolean)

    01/05/01 HEF
    Auto Check Commission Boolean when line is an item at Quantity Validate

    1/9/01 HTCS RCA
    added code to: No. - OnValidate()

    //>> insert by HEF
       Inserted fix for Tax Liability

    Insert by HTCS RJK 01/23/01
      Added code to OnMOdify Triger that if Type <> xRec Type they must confirm.

    //>> 2.60E Update

    05/02/13 ADV
      Added new field <Credit Card Fee> to indicate the line is Credit Card Fee for CC payments.
    */

    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                SalesHeader: Record "Sales Header";
                Item: Record Item;

            begin
                if not SalesHeader.Get("Document Type", "Document No.") then;
                //>> HEF INSERT FOR SALES ORDER REPORT
                "Vendor No." := Item."Vendor No.";
                "Vendor Item No." := Item."Vendor Item No.";
                //<< HEF END INSERT
                //>> insert by HEF
                IF (SalesHeader."Ship-to County" = 'MD') THEN BEGIN
                    IF (SalesHeader."Tax Liable" = FALSE) THEN BEGIN
                        IF (SalesHeader."Tax Exemption No." = '') AND (SalesHeader."Exempt Organization" = '') THEN
                            ERROR('Please complete the tax liability information on\' +
                                'the Sales Header before entering the Sales Lines.');
                    END;

                    IF (SalesHeader."Tax Liable" = TRUE) THEN BEGIN
                        IF (SalesHeader."Tax Area Code" = '') THEN
                            ERROR('Tax Area Must be filled in');
                    END;
                END;
                //<< end HEF insert
            end;
        }
        field(50000; "Commission Calculated"; Boolean)
        {
            Caption = 'Commission Calculated';
        }
        field(50004; User; code[15])
        {
            Caption = 'User';
        }
        field(50100; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
        }
        field(50110; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
        }
        field(50120; Leadtime; Code[20])
        {
            Caption = 'Leadtime';
        }
        field(50130; "Shipped Qty."; Decimal)
        {
            Caption = 'Shipped Qty.';
        }
        field(50140; "Credit Card Fee"; Boolean)
        {
            Caption = 'Credit Card Fee';
        }

    }

    trigger OnAfterInsert()
    begin
        //>> HEF Add User Who Created File
        User := USERID;
        //>> End Insert  
    end;

    trigger OnAfterModify()
    begin
        //>> Insert by HTCS RJK 01/23/01
        IF Type <> xRec.Type THEN BEGIN
            IF NOT CONFIRM('Are you sure you want to change the Sales Line Type?') THEN BEGIN
                ERROR('Sales Line reverted to original Type.');
            END;
        END;
        //>> End Insert
    end;

    var
        myInt: Integer;
}