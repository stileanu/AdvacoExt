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

            trigger OnValidate()
            begin
                //>>Insert by HTCS RJK 12/27/00
                TestString := COPYSTR("Exempt Organization", 1, 2);
                IF (TestString <> '29') AND (TestString <> '30')
                  AND (TestString <> '31') AND (TestString <> '32')
                  AND (TestString <> '33') AND (TestString <> '') THEN BEGIN
                    ERROR('Not a Valid Tax Exempt Organization Number');
                END;
                //<<End Insert
            end;
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

            trigger OnValidate()
            begin

                IF "Payment Terms Code" = 'CC' THEN BEGIN
                    OK := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Type');
                    "Card Type" := "Card Type"::" ";
                    MODIFY;
                END;
            end;
        }
        field(50006; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
            AutoFormatExpression = "Credit Card No.";

            trigger OnValidate()
            begin
                IF "Payment Terms Code" = 'CC' THEN BEGIN
                    OK := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Number');
                    "Credit Card No." := '';
                    MODIFY;
                END;
            end;
        }
        field(50007; "Credit Card Exp."; Code[6])
        {
            Caption = 'Credit Card Exp.';

            trigger OnValidate()
            begin
                IF "Payment Terms Code" = 'CC' THEN BEGIN
                    OK := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Number');
                    "Credit Card No." := '';
                    MODIFY;
                END;
            end;
        }
        field(50008; "Bill of Lading"; Integer)
        {
            Caption = 'Bill of Lading';
            TableRelation = BillOfLading."Bill of Lading";
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
        field(50011; "Work Order No."; Code[20])
        {
            Caption = 'Work Order No.';
            TableRelation = WorkOrderDetail."Work Order No." WHERE("Ship on Sales Order" = FILTER(true), Complete = FILTER(false), Quote = FILTER(' ' | Accepted));
        }
        field(50012; "Customer Order No."; Code[30])
        {
            Caption = 'Customer Order No.';

            trigger OnValidate()
            begin

                Duplicate := FALSE;
                SalesOrder := '';
                WorkOrder := '';
                PumpModuleWO := FALSE;

                //Search Sales Orders to see if the Work Order is already assigned to another Sales order
                IF "Work Order No." <> '' THEN BEGIN
                    SalesHeaderDupCheck.SETRANGE(SalesHeaderDupCheck."Document Type", SalesHeaderDupCheck."Document Type"::Order);
                    IF SalesHeaderDupCheck.FIND('-') THEN BEGIN
                        REPEAT
                            IF SalesHeaderDupCheck."Work Order No." = "Work Order No." THEN BEGIN
                                Duplicate := TRUE;
                                SalesOrder := SalesHeaderDupCheck."No.";
                            END;
                        UNTIL SalesHeaderDupCheck.NEXT = 0;
                    END;
                END;

                // Search Work Orders to see if the Sales Order is already assigned to another Work Order
                IF WODDupCheck.FIND('-') THEN BEGIN
                    REPEAT
                        IF WODDupCheck."Sales Order No." = "No." THEN BEGIN
                            IF xRec."Work Order No." <> WODDupCheck."Work Order No." THEN BEGIN
                                Duplicate := TRUE;
                                WorkOrder := WODDupCheck."Work Order No.";
                            END;
                        END;

                        IF WODDupCheck."Pump Module No." = "Work Order No." THEN BEGIN
                            Duplicate := TRUE;
                            PumpModuleWO := TRUE;
                            WorkOrder := WODDupCheck."Work Order No.";
                        END;
                    UNTIL WODDupCheck.NEXT = 0;
                END;

                IF Duplicate THEN BEGIN
                    IF WorkOrder <> '' THEN BEGIN
                        IF PumpModuleWO THEN BEGIN
                            "Work Order No." := xRec."Work Order No.";
                            MODIFY;
                            MESSAGE('This Work Order is already Linked to Work Order %1 as a Pump Module', WorkOrder);
                        END ELSE BEGIN
                            "Work Order No." := xRec."Work Order No.";
                            MODIFY;
                            MESSAGE('This Sales Order is already Linked to Work Order %1', WorkOrder);
                        END;
                    END;

                    IF SalesOrder <> '' THEN BEGIN
                        IF "Work Order No." <> xRec."Work Order No." THEN BEGIN
                            "Work Order No." := xRec."Work Order No.";
                            MODIFY;
                            MESSAGE('This Work Order is already Linked to Sales Order %1', SalesOrder);
                        END;
                    END;
                END ELSE BEGIN
                    IF "Work Order No." <> '' THEN BEGIN
                        IF (xRec."Work Order No." <> '') THEN BEGIN
                            xWO := xRec."Work Order No.";
                            IF NOT CONFIRM('Are you sure you want to remove the link between this Work Order and Sales Order %1', FALSE, xWO) THEN BEGIN
                                ;
                                "Work Order No." := xRec."Work Order No.";
                                MODIFY;
                            END ELSE BEGIN
                                IF WOD.GET(xRec."Work Order No.") THEN BEGIN
                                    WOD."Sales Order No." := '';
                                    WOD."Ship To Name" := '';
                                    WOD."Ship To Address 1" := '';
                                    WOD."Ship To Address 2" := '';
                                    WOD."Ship To City" := '';
                                    WOD."Ship To State" := '';
                                    WOD."Ship To Zip Code" := '';
                                    WOD.Attention := '';
                                    WOD."Phone No." := '';
                                    WOD.MODIFY;
                                END;
                                SalesLine.SETRANGE("Document Type", "Document Type");
                                SalesLine.SETRANGE("Document No.", "No.");
                                IF SalesLine.FIND('-') THEN BEGIN
                                    IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN BEGIN
                                        SalesLine."Serial No." := '';
                                        SalesLine.MODIFY;
                                    END;
                                END;
                                COMMIT;
                            END;
                        END;
                        SalesLine.SETRANGE("Document Type", "Document Type");
                        SalesLine.SETRANGE("Document No.", "No.");
                        IF SalesLine.FIND('-') THEN BEGIN
                            IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN BEGIN
                                IF WOD.GET("Work Order No.") THEN BEGIN
                                    WOD."Sales Order No." := "No.";
                                    WOD."Ship To Name" := "Ship-to Name";
                                    WOD."Ship To Address 1" := "Ship-to Address";
                                    WOD."Ship To Address 2" := "Ship-to Address 2";
                                    WOD."Ship To City" := "Ship-to City";
                                    WOD."Ship To State" := "Ship-to County";
                                    WOD."Ship To Zip Code" := "Ship-to Post Code";
                                    WOD.Attention := "Ship-to Contact";
                                    WOD."Phone No." := "Phone No.";
                                    WOD.MODIFY;
                                    SalesLine."Serial No." := WOD."Serial No.";
                                    SalesLine."Commission Calculated" := TRUE;
                                    SalesLine.MODIFY;
                                    MODIFY;
                                    COMMIT;
                                END ELSE BEGIN
                                    ERROR('Work Order No. can only be linked to Sales Orders that have One Account G/L Line');
                                END;
                            END ELSE BEGIN
                                ERROR('Work Order No. can only be linked to Sales Orders that have One Account G/L Line');
                            END;
                        END;
                    END;
                    IF ("Work Order No." = '') AND (xRec."Work Order No." <> '') THEN BEGIN
                        IF NOT CONFIRM('Are you sure you want to remove the link between the Work Order and Sales Order', FALSE) THEN BEGIN
                            ;
                            "Work Order No." := xRec."Work Order No.";
                        END ELSE BEGIN
                            IF WOD.GET(xRec."Work Order No.") THEN BEGIN
                                WOD."Sales Order No." := '';
                                WOD."Ship To Name" := '';
                                WOD."Ship To Address 1" := '';
                                WOD."Ship To Address 2" := '';
                                WOD."Ship To City" := '';
                                WOD."Ship To State" := '';
                                WOD."Ship To Zip Code" := '';
                                WOD.Attention := '';
                                WOD."Phone No." := '';
                                WOD.MODIFY;
                            END;
                            SalesLine.SETRANGE("Document Type", "Document Type");
                            SalesLine.SETRANGE("Document No.", "No.");
                            IF SalesLine.FIND('-') THEN BEGIN
                                IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN BEGIN
                                    SalesLine."Serial No." := '';
                                    SalesLine.MODIFY;
                                END;
                            END;
                            MODIFY;
                            COMMIT;
                        END;
                    END;
                END;
            end;
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
        TestString: Text[2];
        OK: Boolean;
        Duplicate: Boolean;
        SalesOrder: Code[20];
        WorkOrder: Code[20];
        WOD: Record WorkOrderDetail;
        WO: Code[20];
        PumpModuleWO: Boolean;
        SalesHeaderDupCheck: Record "Sales Header";
        WODDupCheck: Record WorkOrderDetail;
        xWO: Code[20];
        SalesLine: Record "Sales Line";
}