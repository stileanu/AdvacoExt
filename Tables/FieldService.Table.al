table 50020 FieldService
{
    fields
    {
        field(10; "Field Service No."; Code[7])
        {
        }
        field(20; Customer; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate();
            begin
                IF (Customer <> xRec.Customer) AND (xRec.Customer <> '') THEN BEGIN
                    IF NOT CONFIRM('Are you sure you want to change Customers?') THEN BEGIN
                        ERROR('Please Press the Escape Key to return the Customer Value to its previous entry');
                    END ELSE BEGIN
                        IF Cust.GET(Customer) THEN BEGIN
                            "Customer Name" := Cust.Name;
                            "Customer Address 1" := Cust.Address;
                            "Customer Address 2" := Cust."Address 2";
                            "Customer City" := Cust.City;
                            "Customer State" := Cust.County;
                            "Customer Zip Code" := Cust."Post Code";
                            "Customer Payment Terms" := Cust."Payment Terms Code";
                            "Card Type" := "Card Type"::" ";
                            "Credit Card No." := '';
                            "Credit Card Exp." := '';
                            "Tax Liable" := Cust."Tax Liable";
                            "Tax Exemption No." := Cust."Tax Exemption No.";
                            "Exempt Organization" := Cust."Exempt Organization";
                            "Ship To Code" := '';
                            VALIDATE("Ship To Code");
                        END ELSE BEGIN
                            ERROR('Customer Code Doesn''t Exist');
                        END;
                    END;
                END ELSE BEGIN
                    IF Cust.GET(Customer) THEN BEGIN
                        "Customer Name" := Cust.Name;
                        "Customer Address 1" := Cust.Address;
                        "Customer Address 2" := Cust."Address 2";
                        "Customer City" := Cust.City;
                        "Customer State" := Cust.County;
                        "Customer Zip Code" := Cust."Post Code";
                        "Customer Payment Terms" := Cust."Payment Terms Code";
                        "Tax Liable" := Cust."Tax Liable";
                        "Tax Exemption No." := Cust."Tax Exemption No.";
                        "Exempt Organization" := Cust."Exempt Organization";
                    END;
                END;
            end;
        }
        field(30; "Date Ordered"; Date)
        {
        }
        field(40; "Customer Name"; Text[30])
        {
        }
        field(50; "Customer Address 1"; Text[30])
        {
        }
        field(60; "Customer Address 2"; Text[30])
        {
        }
        field(70; "Customer City"; Text[30])
        {
        }
        field(80; "Customer State"; Code[15])
        {
        }
        field(90; "Customer Zip Code"; Code[15])
        {
        }
        field(100; "Ship To Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD(Customer));

            trigger OnValidate();
            begin
                IF ("Ship To Code" = '') AND (xRec."Ship To Code" <> '') THEN BEGIN
                    "Ship To Name" := '';
                    "Ship To Address 1" := '';
                    "Ship To Address 2" := '';
                    "Ship To City" := '';
                    "Ship To State" := '';
                    "Ship To Zip Code" := '';
                    "Phone No." := '';
                    Attention := '';
                    "E-Mail" := '';
                    "Fax No." := '';
                    "Inside Sales" := '';
                    Rep := '';
                    MODIFY;
                    COMMIT;
                END ELSE BEGIN
                    IF ("Ship To Code" <> xRec."Ship To Code") AND (xRec."Ship To Code" <> '') THEN BEGIN
                        IF NOT CONFIRM('Are you sure you want to change Ship To Code?') THEN BEGIN
                            ERROR('Please Press the Escape Key to return the Ship To Code Value to its previous entry');
                        END ELSE BEGIN
                            IF ShipTo.GET(Customer, "Ship To Code") THEN BEGIN
                                "Ship To Name" := ShipTo.Name;
                                "Ship To Address 1" := ShipTo.Address;
                                "Ship To Address 2" := ShipTo."Address 2";
                                "Ship To City" := ShipTo.City;
                                "Ship To State" := ShipTo.County;
                                "Ship To Zip Code" := ShipTo."Post Code";
                                "Phone No." := ShipTo."Phone No.";
                                Attention := ShipTo.Contact;
                                "E-Mail" := ShipTo."E-Mail";
                                "Fax No." := ShipTo."Fax No.";
                                "Inside Sales" := ShipTo."Inside Sales";
                                Rep := ShipTo.Rep;
                                MODIFY;
                                COMMIT;
                            END ELSE BEGIN
                                ERROR('Ship To Code Not Found');
                            END;
                        END;
                    END ELSE BEGIN
                        IF ShipTo.GET(Customer, "Ship To Code") THEN BEGIN
                            "Ship To Name" := ShipTo.Name;
                            "Ship To Address 1" := ShipTo.Address;
                            "Ship To Address 2" := ShipTo."Address 2";
                            "Ship To City" := ShipTo.City;
                            "Ship To State" := ShipTo.County;
                            "Ship To Zip Code" := ShipTo."Post Code";
                            "Phone No." := ShipTo."Phone No.";
                            Attention := ShipTo.Contact;
                            "E-Mail" := ShipTo."E-Mail";
                            "Fax No." := ShipTo."Fax No.";
                            "Inside Sales" := ShipTo."Inside Sales";
                            Rep := ShipTo.Rep;
                            MODIFY;
                        END;
                    END;
                END;
            end;
        }
        field(110; "Ship To Name"; Text[30])
        {
        }
        field(120; "Ship To Address 1"; Text[30])
        {
        }
        field(130; "Ship To Address 2"; Text[30])
        {
        }
        field(140; "Ship To City"; Text[30])
        {
        }
        field(150; "Ship To State"; Code[15])
        {
        }
        field(160; "Ship To Zip Code"; Code[15])
        {
        }
        field(170; Attention; Text[30])
        {
        }
        field(180; "E-Mail"; Text[80])
        {
        }
        field(190; "Phone No."; Text[30])
        {
        }
        field(193; Released; Boolean)
        {
        }
        field(200; "Fax No."; Text[30])
        {
        }
        field(210; "Inside Sales"; Code[3])
        {
        }
        field(220; Rep; Code[3])
        {
        }
        field(230; "Tax Liable"; Boolean)
        {

            trigger OnValidate();
            begin
                IF "Customer State" <> 'MD' THEN BEGIN
                    ERROR('%1 is not Located in Maryland, and can''t be Tax Liable', Customer);
                END ELSE BEGIN
                    IF ("Tax Exemption No." <> '') OR ("Exempt Organization" <> '') THEN BEGIN
                        IF "Tax Liable" = TRUE THEN BEGIN
                            IF NOT CONFIRM('This Customer has a Tax Exempt No., Are you sure this Order is Tax Liable', FALSE) THEN
                                ERROR('The Order is NOT Tax Liable');
                        END;
                    END;
                END;
            end;
        }
        field(240; "Tax Exemption No."; Text[30])
        {
        }
        field(250; "Exempt Organization"; Text[30])
        {
        }
        field(300; "Service Type"; Option)
        {
            OptionMembers = Paid,Unpaid;
        }
        field(310; Description; Text[250])
        {
        }
        field(320; "Income Code"; Option)
        {
            OptionMembers = " ",SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO,"EXPENSE FS","FREIGHT FS","LABOR FS","TRAVEL FS";
        }
        field(330; "Customer PO No."; Code[20])
        {
        }
        field(340; "Customer Payment Terms"; Code[10])
        {
            TableRelation = "Payment Terms".Code;

            trigger OnValidate();
            begin
                IF ("Credit Card No." <> '') OR ("Credit Card Exp." <> '') THEN BEGIN
                    IF "Customer Payment Terms" = 'CC' THEN BEGIN
                        OK := TRUE;
                    END ELSE BEGIN
                        MESSAGE('Credit Card Information must be removed in order to Change Payment Terms');
                        "Customer Payment Terms" := 'CC';
                        MODIFY;
                    END;
                END;
            end;
        }
        field(350; "Card Type"; Enum CreditCardType)
        {
            //OptionMembers = " ",AM,DI,MC,VI;

            trigger OnValidate();
            begin
                IF "Customer Payment Terms" = 'CC' THEN BEGIN
                    OK := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Type');
                    "Card Type" := "Card Type"::" ";
                    MODIFY;
                END;
            end;
        }
        field(360; "Credit Card No."; Code[20])
        {

            trigger OnValidate();
            begin
                IF "Customer Payment Terms" = 'CC' THEN BEGIN
                    OK := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Number');
                    "Credit Card No." := '';
                    MODIFY;
                END;
            end;
        }
        field(370; "Credit Card Exp."; Code[6])
        {

            trigger OnValidate();
            begin
                IF "Customer Payment Terms" = 'CC' THEN BEGIN
                    OK := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Expiration');
                    "Credit Card Exp." := '';
                    MODIFY;
                END;
            end;
        }
        field(400; "Parts Quoted"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum (Parts."Total Price" WHERE("Work Order No." = FIELD("Field Service No."), "Part Type" = CONST(Item)));
        }
        field(420; "Order Adj."; Decimal)
        {
            Description = 'Adj Added to Original Prices';
        }
        field(430; "Parts Cost"; Decimal)
        {
        }
        field(440; "Labor Hours Quoted"; Decimal)
        {
        }
        field(445; "Travel Hours"; Decimal)
        {
        }
        field(450; "Work Hours"; Decimal)
        {
        }
        field(452; "Labor Rate"; Decimal)
        {
        }
        field(453; Technician; Code[10])
        {
            TableRelation = Resource."No." WHERE(Type = FILTER(Person));
        }
        field(455; Lodging; Decimal)
        {
        }
        field(460; "Air Travel"; Decimal)
        {
        }
        field(465; "Rental Car"; Decimal)
        {
        }
        field(470; "Company Van Miles"; Decimal)
        {
        }
        field(475; "Personal Vehicle Miles"; Decimal)
        {
        }
        field(477; "Mileage Rate"; Decimal)
        {
        }
        field(480; Meals; Decimal)
        {
        }
        field(482; Freight; Decimal)
        {
        }
        field(485; "Misc Expenses"; Decimal)
        {
        }
        field(493; "Parts Required"; Boolean)
        {

            trigger OnValidate();
            begin
                IF "Parts Required" <> xRec."Parts Required" THEN BEGIN
                    IF "Parts Required" THEN BEGIN
                        //Insert QOT Step and leave open until The invoice is generated.
                        WOS.INIT;
                        WOS."Order No." := "Field Service No.";
                        WOS.Type := WOS.Type::FieldService;
                        WOS."Line No." := 10000;
                        WOS.Step := WOS.Step::QOT;
                        WOS."Date In" := WORKDATE;
                        WOS.Status := WOS.Status::Waiting;
                        WOS.INSERT;
                        COMMIT;

                        //Insert B-O Step to distribute parts
                        WOS2.INIT;
                        WOS2."Order No." := "Field Service No.";
                        WOS2.Type := WOS2.Type::FieldService;
                        WOS2."Line No." := 20000;
                        WOS2.Step := WOS2.Step::"B-O";
                        WOS2."Date In" := WORKDATE;
                        WOS2.Status := WOS.Status::Waiting;
                        WOS2.INSERT;
                    END ELSE BEGIN
                        Parts.SETRANGE(Parts."Work Order No.", "Field Service No.");
                        IF Parts.FIND('-') THEN BEGIN
                            ERROR('Parts have already been Quoted, so Parts Required must be Check.');
                        END ELSE BEGIN
                            IF NOT CONFIRM('Are you sure you want remove the Parts Required?', FALSE) THEN BEGIN
                                ERROR('Parts are still Required.');
                            END ELSE BEGIN
                                WOS.SETRANGE(WOS."Order No.", "Field Service No.");
                                IF WOS.FIND('-') THEN BEGIN
                                    REPEAT
                                        WOS.DELETE;
                                    UNTIL WOS.NEXT = 0;
                                END;
                            END;
                        END;
                    END;
                END;
            end;
        }
        field(500; Carrier; Code[20])
        {
            TableRelation = "Shipping Agent".Code;

            trigger OnValidate();
            begin
                IF Agent.GET(Carrier) THEN BEGIN
                    IF "Shipping Charge" = "Shipping Charge"::Collect THEN BEGIN
                        "Shipping Account" := '';
                        "Shipping Charge" := 0;
                        MODIFY;
                        MESSAGE('Shipping Charge & Account No. were Deleted because Shipping Agent was Changed');
                    END ELSE BEGIN
                        IF "Shipping Account" <> '' THEN BEGIN
                            "Shipping Account" := '';
                            MODIFY;
                            MESSAGE('Shipping Account No. was Deleted because Shipping Agent was Changed');
                        END;
                    END;
                END;
            end;
        }
        field(510; "Shipping Method"; Code[10])
        {
            TableRelation = "Shipment Method".Code;
        }
        field(520; "Shipping Account"; Code[30])
        {

            trigger OnValidate();
            begin
                IF ("Shipping Account" = '') AND (xRec."Shipping Account" <> '') THEN BEGIN
                    IF "Shipping Charge" = "Shipping Charge"::Collect THEN BEGIN
                        MESSAGE('Shipping Charge Must be Changed from Collect Before Deleting the Shipping Account No.');
                        "Shipping Account" := xRec."Shipping Account";
                        MODIFY;
                    END;
                END;
            end;
        }
        field(530; "Shipping Charge"; Option)
        {
            OptionMembers = " ",Collect,"Pre-Paid","Pre-Paid & Add","3rd Party",Consignee;

            trigger OnValidate();
            begin
                IF "Shipping Charge" = "Shipping Charge"::Collect THEN BEGIN
                    IF Agent.GET(Carrier) THEN BEGIN
                        IF Agent."Account No. Required" THEN BEGIN
                            IF "Shipping Account" = '' THEN BEGIN
                                MESSAGE('Carrier Must be Entered First');
                                "Shipping Charge" := 0;
                                MODIFY;
                            END;
                        END;
                    END ELSE BEGIN
                        MESSAGE('Carrier Must be Entered First');
                        "Shipping Charge" := 0;
                        MODIFY;
                    END;
                END;
            end;
        }
        field(1000; "No. Series"; Code[10])
        {
        }
        field(1900; "Incomplete Parts"; Boolean)
        {
        }
        field(2000; Complete; Boolean)
        {

            trigger OnValidate();
            begin
                IF Complete THEN BEGIN
                    CompleteParts.SETRANGE(CompleteParts."Work Order No.", "Field Service No.");
                    IF CompleteParts.FIND('-') THEN BEGIN
                        REPEAT
                            CompleteParts.Complete := TRUE;
                            CompleteParts.MODIFY;
                        UNTIL CompleteParts.NEXT = 0;
                    END;
                END ELSE BEGIN
                    CompleteParts.SETRANGE(CompleteParts."Work Order No.", "Field Service No.");
                    IF CompleteParts.FIND('-') THEN BEGIN
                        REPEAT
                            CompleteParts.Complete := FALSE;
                            CompleteParts.MODIFY;
                        UNTIL CompleteParts.NEXT = 0;
                    END;
                END;
            end;
        }
        field(2010; "Completed USERID"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Field Service No.")
        {
        }
        key(Key2; "Service Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin

        IF NOT CONFIRM('Are you sure you want to DELETE %1?', FALSE, "Field Service No.") THEN BEGIN
            ERROR('Field Service %1 not deleted', "Field Service No.");
        END ELSE BEGIN
            WOS.RESET;
            WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
            WOS.SETRANGE(WOS."Order No.", "Field Service No.");
            WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
            IF WOS.FIND('-') THEN
                ERROR('Can''t Delete the Field Service Order because Parts have been Quoted');
        END;
    end;

    trigger OnInsert();
    begin
        IF "Field Service No." = '' THEN BEGIN
            InvtSetup.GET;
            InvtSetup.TESTFIELD("Work Order Nos.");
            NoseriesMgt.InitSeries(InvtSetup."Work Order Nos.", xRec."No. Series", 0D, "Field Service No.", "No. Series");
            "Field Service No." := COPYSTR("Field Service No.", 1, 5) + '01';
            "Date Ordered" := TODAY;

            SalesSetup.GET;
            "Mileage Rate" := SalesSetup."Mileage Rate";
            "Labor Rate" := SalesSetup."Field Service Rate";
        END;
    end;

    var
        Cust: Record Customer;
        ShipTo: Record "Ship-to Address";
        InvtSetup: Record "Inventory Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        WOS: Record Status;
        WOS2: Record Status;
        Parts: Record Parts;
        SalesSetup: Record "Sales & Receivables Setup";
        OK: Boolean;
        Agent: Record "Shipping Agent";
        CompleteParts: Record Parts;
        Expenses: Decimal;
}

