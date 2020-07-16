table 50000 WorkOrderMaster
{
    // To find commented code, use pattern <//--!>

    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Work Order Master No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Customer; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
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
                            "Payment Method" := Cust."Payment Method Code";
                            "Customer Payment Terms" := Cust."Payment Terms Code";
                            "Card Type" := "Card Type";

                            "Credit Card No." := '';
                            "Credit Card Exp." := '';
                            "Tax Liable" := Cust."Tax Liable";
                            "Tax Exemption No." := Cust."Tax Exemption No.";
                            "Exempt Organization" := Cust."Exempt Organization";

                            "Ship To Code" := '';
                            VALIDATE("Ship To Code");
                            WorkOrderDetail2.RESET;
                            WorkOrderDetail2.SETCURRENTKEY(WorkOrderDetail2."Work Order No.");
                            WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order Master No.", "Work Order Master No.");
                            IF WorkOrderDetail2.FIND('-') THEN BEGIN
                                REPEAT
                                    WorkOrderDetail2."Ship To Name" := "Ship To Name";
                                    WorkOrderDetail2."Ship To Address 1" := "Ship To Address 1";
                                    WorkOrderDetail2."Ship To Address 2" := "Ship To Address 2";
                                    WorkOrderDetail2."Ship To City" := "Ship To City";
                                    WorkOrderDetail2."Ship To State" := "Ship To State";
                                    WorkOrderDetail2."Ship To Zip Code" := "Ship To Zip Code";
                                    WorkOrderDetail2."Phone No." := "Phone No.";
                                    WorkOrderDetail2.Attention := Attention;
                                    WorkOrderDetail2."Customer ID" := Customer;
                                    WorkOrderDetail2."Payment Method" := "Payment Method";
                                    WorkOrderDetail2."Payment Terms" := "Customer Payment Terms";
                                    WorkOrderDetail2."Card Type" := WorkOrderDetail2."Card Type"::" ";
                                    WorkOrderDetail2."Credit Card No." := '';
                                    WorkOrderDetail2."Credit Card Exp." := '';
                                    WorkOrderDetail2."Tax Liable" := "Tax Liable";
                                    WorkOrderDetail2.MODIFY;
                                UNTIL WorkOrderDetail2.NEXT = 0;
                                COMMIT;
                            END;
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
                        "Payment Method" := Cust."Payment Method Code";
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
            DataClassification = ToBeClassified;
        }
        field(39; "Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Customer Address 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Customer Address 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Customer City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Customer State"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Customer Zip Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Attention"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Ship To Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
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

                    WorkOrderDetail2.RESET;
                    WorkOrderDetail2.SETCURRENTKEY(WorkOrderDetail2."Work Order No.");
                    WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order Master No.", "Work Order Master No.");
                    IF WorkOrderDetail2.FIND('-') THEN BEGIN
                        REPEAT
                            WorkOrderDetail2."Ship To Name" := '';
                            WorkOrderDetail2."Ship To Address 1" := '';
                            WorkOrderDetail2."Ship To Address 2" := '';
                            WorkOrderDetail2."Ship To City" := '';
                            WorkOrderDetail2."Ship To State" := '';
                            WorkOrderDetail2."Ship To Zip Code" := '';
                            WorkOrderDetail2."Phone No." := '';
                            WorkOrderDetail2.Attention := '';
                            WorkOrderDetail2.MODIFY;
                        UNTIL WorkOrderDetail2.NEXT = 0;
                        MESSAGE('Work Order Details have been Updated with Work Order Master Information');
                        COMMIT;
                    END;

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

                                WorkOrderDetail2.RESET;
                                WorkOrderDetail2.SETCURRENTKEY(WorkOrderDetail2."Work Order No.");
                                WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order Master No.", "Work Order Master No.");
                                IF WorkOrderDetail2.FIND('-') THEN BEGIN
                                    REPEAT
                                        WorkOrderDetail2."Ship To Name" := "Ship To Name";
                                        WorkOrderDetail2."Ship To Address 1" := "Ship To Address 1";
                                        WorkOrderDetail2."Ship To Address 2" := "Ship To Address 2";
                                        WorkOrderDetail2."Ship To City" := "Ship To City";
                                        WorkOrderDetail2."Ship To State" := "Ship To State";
                                        WorkOrderDetail2."Ship To Zip Code" := "Ship To Zip Code";
                                        WorkOrderDetail2."Phone No." := "Phone No.";
                                        WorkOrderDetail2.Attention := Attention;
                                        WorkOrderDetail2.MODIFY;
                                    UNTIL WorkOrderDetail2.NEXT = 0;
                                    MESSAGE('Work Order Details have been Updated with Work Order Master Information');
                                    COMMIT;
                                END;
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

                            WorkOrderDetail2.RESET;
                            WorkOrderDetail2.SETCURRENTKEY(WorkOrderDetail2."Work Order No.");
                            WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order Master No.", "Work Order Master No.");
                            IF WorkOrderDetail2.FIND('-') THEN BEGIN
                                REPEAT
                                    WorkOrderDetail2."Ship To Name" := "Ship To Name";
                                    WorkOrderDetail2."Ship To Address 1" := "Ship To Address 1";
                                    WorkOrderDetail2."Ship To Address 2" := "Ship To Address 2";
                                    WorkOrderDetail2."Ship To City" := "Ship To City";
                                    WorkOrderDetail2."Ship To State" := "Ship To State";
                                    WorkOrderDetail2."Ship To Zip Code" := "Ship To Zip Code";
                                    WorkOrderDetail2."Phone No." := "Phone No.";
                                    WorkOrderDetail2.Attention := Attention;
                                    WorkOrderDetail2.MODIFY;
                                UNTIL WorkOrderDetail2.NEXT = 0;
                                MESSAGE('Work Order Details have been Updated with Work Order Master Information');
                                COMMIT;
                            END;
                        END;
                    END;
                END;
            end;
        }
        field(100; "Ship To Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Ship To Address 1"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Ship To Address 1" <> xRec."Ship To Address 1") THEN BEGIN
                    WorkOrderDetail2.RESET;
                    WorkOrderDetail2.SETCURRENTKEY(WorkOrderDetail2."Work Order No.");
                    WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order Master No.", "Work Order Master No.");
                    IF WorkOrderDetail2.FIND('-') THEN BEGIN
                        REPEAT
                            WorkOrderDetail2."Ship To Address 1" := "Ship To Address 1";
                            WorkOrderDetail2.MODIFY;
                        UNTIL WorkOrderDetail2.NEXT = 0;
                        MESSAGE('Work Order Details have been Updated with Work Order Master Information');
                        COMMIT;
                    END;
                END;
            end;
        }
        field(120; "Ship To Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Ship To Address 2" <> xRec."Ship To Address 2") THEN BEGIN
                    WorkOrderDetail2.RESET;
                    WorkOrderDetail2.SETCURRENTKEY(WorkOrderDetail2."Work Order No.");
                    WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order Master No.", "Work Order Master No.");
                    IF WorkOrderDetail2.FIND('-') THEN BEGIN
                        REPEAT
                            WorkOrderDetail2."Ship To Address 2" := "Ship To Address 2";
                            WorkOrderDetail2.MODIFY;
                        UNTIL WorkOrderDetail2.NEXT = 0;
                        MESSAGE('Work Order Details have been Updated with Work Order Master Information');
                        COMMIT;
                    END;
                END;
            end;
        }
        field(130; "Ship To City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Ship To State"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(150; "Ship To Zip Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(151; "Pickup Sheet"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(152; "Tax Liable"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // 05/07/13 Start
                //  IF "Customer State" <> 'MD' THEN BEGIN
                //    ERROR('%1 is not Located in Maryland, and can''t be Tax Liable',Customer);
                //  END ELSE BEGIN
                // 05/07/13 End
                IF ("Tax Exemption No." <> '') OR ("Exempt Organization" <> '') THEN BEGIN
                    IF "Tax Liable" = TRUE THEN BEGIN
                        IF NOT CONFIRM('This Customer has a Tax Exempt No., Are you sure this Order is Tax Liable', FALSE) THEN
                            ERROR('The Order is NOT Tax Liable');
                    END;
                END;
                //  END;
            end;
        }
        field(154; "Tax Exemption No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(156; "Exempt Organization"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(160; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(170; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(175; "Fax No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(180; "Date Required"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(185; "Inside Sales"; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Rep"; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Customer Payment Terms"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
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
        field(240; "Parts Quoted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(250; "Labor Quoted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(260; "Labor Hours Quoted"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(270; "Freight Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(280; Details; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(290; Notes; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(300; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(310; "Payment Method"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(330; "Card Type"; Enum CreditCardType)
        {
            DataClassification = ToBeClassified;
            //OptionCaption = ' ,AM,DI,MC,VI';
            //OptionMembers = "",AM,DI,MC,VI;

            trigger OnValidate()
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
        field(340; "Credit Card No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
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
        field(350; "Credit Card Exp."; Code[6])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
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
        field(351; "Credit Card SC"; Text[4])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Name on Card "; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; "Bill-to Address 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Bill-to Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Bill-to Address 3"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50034; "Bill-to Address 4"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "CC Comments 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "CC Comments 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "CC Comments 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(100000; PDF; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(100001; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(100002; "File Exists"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(100003; Comment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key("Work Order Master"; "Work Order Master No.")
        {
            Clustered = true;
        }
    }

    var
        Cust: Record Customer;
        ShipTo: Record "Ship-to Address";
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WOD: Record WorkOrderDetail;
        WorkOrderDetail2: Record WorkOrderDetail;
        WODH: Record DeletedWorkOrders;
        WOS: Record Status;
        OK: Boolean;
        Agent: Record "Shipping Agent";

    trigger OnInsert()
    begin
        if "Work Order Master No." = '' then begin
            InvtSetup.GET;
            InvtSetup.TESTFIELD("Work Order Nos.");
            NoSeriesMgt.InitSeries(InvtSetup."Work Order Nos.", xRec."No. Series", 0D, "Work Order Master No.", "No. Series");
            "Date Ordered" := TODAY;
        end;
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
        IF NOT CONFIRM('Are you sure you want to DELETE %1?', FALSE, "Work Order Master No.") THEN
            ERROR('Work Order %1 not deleted', "Work Order Master No.");

        WOD.SETCURRENTKEY("Work Order No.");
        WOD.SETRANGE(WOD."Work Order Master No.", "Work Order Master No.");
        IF WOD.FIND('-') THEN BEGIN
            REPEAT
                WOS.RESET;
                WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                WOS.SETRANGE(WOS.Step, WOS.Step::RCV);
                IF WOS.FIND('-') THEN
                    ERROR('Can''t Delete the Work Order Master because Atleast One Detail has been Received');
            UNTIL WOD.NEXT = 0;
        END;

        WOD.RESET;
        WOD.SETCURRENTKEY("Work Order No.");
        WOD.SETRANGE(WOD."Work Order Master No.", "Work Order Master No.");
        IF WOD.FIND('-') THEN BEGIN
            IF NOT CONFIRM('Do you want to delete Work Order Detail Records?', FALSE) THEN BEGIN
                ERROR('Work Order Master & Details weren''t Deleted')
            END ELSE BEGIN
                REPEAT
                    WODH.RESET;
                    WODH.INIT;
                    WODH.TRANSFERFIELDS(WOD);
                    WODH."Deletion Date" := WORKDATE;
                    // WODH."Reason Deleted" := ;     //Harlen will insert code for Deletion Reason
                    WODH.INSERT;
                    WOD.DELETE;
                UNTIL WOD.NEXT = 0;
            END;
        END;
    end;

    trigger OnRename()
    begin

    end;

}