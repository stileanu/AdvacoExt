Tableextension 50118 SalesHeaderExt extends "Sales Header"
{
    /*
      RJK HTCS 12/15/00
    Added code to OnInsert trigger to populate Project Code

    HEF
      Added Tax Code and Fields
      Added User Field

    HEF 02/19/01
      Exchange Rate not Needed so Code removed

    HEF 07/25/01  Exempt Oraganization Added to Bill to code Validate

    HEF 07/25/01 REMOVED TAX AREA CODE UPDATE ON SHIP TO CODE VALIDATE

    HEF 07/31/01 ADDED CODE TO CREDIT CARD INFORMATION TO VALIDATE  PAYMENT TERMS

    HEF 08/17/01 ADDED WORK ORDER NO. AND VARIABLES FOR LINKING SALES ORDERS TO WORK ORDERS.

    HEF 08/28/01 ADDED Code to Shipping Agent Validate

    HEF 05/07/02 ADDED CODE TO PAYMENT TERMS TO PREVENT CHANGE OF PAYMENT TERMS WHEN CC INFO ENTERED

    04/28/2011 ADV
      Added fields for Credit Card Payments (Name, Bill Address and Comments)

    ADV 10/07/11
      Eliminate reference to CrossRef tables - not accesible with our license(?)

    ADV 04/17/16
      Modify to check Cust Credit Limit only from Invoice(no Quote or Order)
    */

    fields
    {
        modify("Tax Liable")
        {
            trigger OnAfterValidate()
            begin
                //>> HEF INSERT
                IF "Tax Liable" THEN
                    "Tax Area Code" := 'MD';
                //<< HEF END INSERT;
            end;
        }
        field(50000; Rep; code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";

        }
        field(50001; "Shipping Account"; Code[20])
        {
            Caption = 'Shipping Account';

            trigger OnValidate()
            begin

                IF ("Shipping Account" = '') AND (xRec."Shipping Account" <> '') THEN BEGIN
                    IF "Shipping Charge".AsInteger() = 1 THEN BEGIN // Collect
                        MESSAGE('Shipping Charge Must be Changed from Collect Before Deleting the Shipping Account No.');
                        "Shipping Account" := xRec."Shipping Account";
                        MODIFY;
                    END;
                END;
            end;
        }
        field(50002; "Shipping Charge"; Enum ShippingCharge)
        {
            Caption = 'Shipping Charge';
            //OptionMembers = " ",Collect,"Pre-paid","Pre-Paid & Add","3rd Party",Consignee;
            //OptionCaption = ' ,Collect,Pre-Paid,Pre-Paid & Add,3rd Party,Consignee';

            trigger OnValidate()
            begin

                IF "Shipping Charge".AsInteger() = 1 THEN BEGIN  // Collect
                    IF Agent.GET("Shipping Agent Code") THEN BEGIN
                        IF Agent."Account No. Required" THEN BEGIN
                            IF "Shipping Account" = '' THEN BEGIN
                                MESSAGE('Shipping Account Must be Entered First');
                                "Shipping Charge" := "Shipping Charge"::" ";
                                MODIFY;
                            END;
                        END;
                    END ELSE BEGIN
                        MESSAGE('Shipping Agent Must be Entered First');
                        "Shipping Charge" := "Shipping Charge"::" ";
                        MODIFY;
                    END;
                END;

                IF "Shipping Charge" = "Shipping Charge"::"3rd Party" THEN BEGIN
                    MESSAGE('Please Enter Third Party Billing Information');
                END;

                IF (xRec."Shipping Charge" = "Shipping Charge"::"3rd Party") AND ("Shipping Charge" <> "Shipping Charge"::"3rd Party")
                THEN BEGIN
                    MESSAGE('No Longer 3rd Party Billing, so the 3rd Party Billing Information has been removed from the Detail');
                    "Third Party Name" := '';
                    "Third Party Address" := '';
                    "Third Party City" := '';
                    "Third Party State" := '';
                    "Third Party Zip" := '';
                END;

            end;
        }
        field(50003; "Exempt Organization"; Text[30])
        {
            Caption = 'Exempt Organization';
        }
        field(50004; User; Code[15])
        {
            Caption = 'User';

        }
        field(50005; "Card Type"; Enum CreditCardType)
        {
            Caption = 'Card Type';
            //OptionMembers = " ",AM,DI,MC,VI;
            //OptionCaption = ' ,AM,DI,MC,VI';
        }
        field(5006; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
            AutoFormatExpression = "Credit Card No.";
        }
        field(50007; "Credit Card Exp."; Code[6])
        {
            Caption = 'Credit Card Exp.';
            AutoFormatExpression = "Credit Card Exp.";

        }
        field(50008; "Bill of Lading"; Integer)
        {
            Caption = 'Bill of Lading';
        }
        field(50009; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
        }
        field(50010; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            AutoFormatExpression = "Phone No.";
        }
        field(50011; "Work Order No."; Code[7])
        {
            Caption = 'Work Order No.';
        }
        field(50012; "Customer Order No."; Code[30])
        {
            Caption = 'Customer Order No.';
        }
        field(50013; "Freight Include in Price"; Boolean)
        {
            Caption = 'Freight Include in Price';
        }
        field(50020; "Third Party Name"; Code[30])
        {
            Caption = 'Third Party Name';
        }
        field(50021; "Third Party Address"; Code[30])
        {
            Caption = 'Third Party Address';
        }
        field(50022; "Third Party City"; Code[30])
        {
            Caption = 'Third Party City';
        }
        field(50023; "Third Party State"; Code[15])
        {
            Caption = 'Third Party State';
        }
        field(50024; "Third Party Zip"; Code[15])
        {
            Caption = 'Third Party Zip';
        }
        field(50025; "Credit Card SC"; Text[4])
        {
            Caption = 'Credit Card SC';
        }
        field(50030; "Name on Card"; Text[50])
        {
            Caption = 'Work Order No.';
        }
        field(50031; "Bill-to Address_1"; Text[100])
        {
            Caption = 'Bill-to Address 1';
        }
        field(50032; "Bill-to Address_2"; Text[100])
        {
            Caption = 'Bill-to Address 2';
        }
        field(50033; "Bill-to Address_3"; Text[100])
        {
            Caption = 'Bill-to Address 3';
        }
        field(50034; "Bill-to Address_4"; Text[100])
        {
            Caption = 'Bill-to Address 4';
        }
        field(50035; "CC Comments 1"; Text[250])
        {
            Caption = 'CC Comments 1';
        }
        field(50036; "CC Comments 2"; Text[250])
        {
            Caption = 'CC Comments 2';
        }
        field(50037; "CC Comments 3"; Text[250])
        {
            Caption = 'CC Comments 3';
        }

    }
    trigger OnAfterInsert()
    begin

        //>> Insert by HTCS Project Code
        "Shortcut Dimension 2 Code" := 'SO';
        //>> End insert

        //>> HEF Add User Who Created File
        User := USERID;
        //>> End Insert
    end;

    var
        Agent: Record "Shipping Agent";
}