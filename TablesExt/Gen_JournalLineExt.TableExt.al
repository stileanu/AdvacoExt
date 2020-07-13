TableExtension 50106 Gen_JournalLineExt Extends "Gen. Journal Line"
{
    fields
    {
        field(50000; Rep; Code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";

        }
        field(50001; "Ship-To Code"; Code[10])
        {
            Caption = 'Ship-To Code';
            TableRelation = if ("Account Type" = const(Customer)) "Ship-to Address".Code where("Customer No." = field("Account No."));
        }
        modify(Amount)
        {
            trigger OnBeforeValidate()
            begin
                //>> HEF INSERT  - CODE CHANGES SIGN OF PAYMENTS ENTERED FOR CUSTOMERS AND INVOICES FOR VENDORS TO NEGATIVE
                IF "Document Type".AsInteger() = 1 THEN BEGIN
                    IF "Account Type".AsInteger() = 1 THEN BEGIN
                        IF Amount > 0 THEN
                            Amount := Amount * -1;
                    END;
                END ELSE
                    IF "Document Type".AsInteger() = 2 THEN BEGIN
                        IF "Account Type".AsInteger() = 2 THEN BEGIN
                            IF Amount > 0 THEN
                                Amount := Amount * -1;
                        END;
                    END;
                //<< HEF END       
            end;
        }
    }

}