table 50001 WorkOrderDetail
{
    DataClassification = ToBeClassified;
    DrillDownPageID = "Work Order Detail List";
    LookupPageID = "Work Order Detail List";

    /*
        11/9/00 RJK TempStateCode can be removed but retained for possible later use.

        2/13/01, RCA - Added keys for reporting: "Customer ID,Boxed,Shipment Approved"

        2/20/01 HEF - removed Shipping Charge Check to allow for shipping several orders at once.

        2011/04/13 ADV
        Allow Warranty fields modifications for closed orders for Sales Manager (Kaye)

        2012/04/13 ADV
        No mods, just recompile.

        2013/05/07 ADV
        Modified "Tax liable" validation code to allow manual set.

        2015/07/26 ADV
        Added new key <Work Order Master No.,Ship Date,Customer ID,Model No.> for Warranty Analysis form

        2015/08/01 ADV
        Add code to OnInsert to do not allow record insertion with empty Work Order No.

        2016_02_27 ADV
        Added new field - <32 Initial Order Type> to store the original Order Type if the type changed after REC is completed.
        Added new key based on new field.
        Added code to synchonize it with Order Type before REC is completed.
        Added new function <GetCurrentStatus> to return last completed step.

        2016_04_02 ADV
        Reverse differntial factor for Parts Markup and Quoted Price calculation

        2018_02_26
        Clean Parts when changing Model No. Adding new Parts list.

        2018_03_12
        Added boolean Overwrite Cr. Limit to overwrite credit check for vendor without increasing Credit Limit.

        2018_04_16
        Added field (option) 177 Container Type (Crate,Box,Skid,Case).

        2018_05_02
        Synchronized option string with forms ( ,Crate,Box,Skid,Case,Drum,Skid Box,Loose)

        // To find commented code, use pattern <//--!>

        2021_01_11 Intelice
        Added field(200001; "Shipping Processed"; Boolean) to show if an WO Detail was shipped (create SO, return parts etc..) 

        2021_01_19 Intelice
        Added field(200002; "Vendor Shipping Processed"; Boolean) to show if an WO Detail was shipped to the Vendor (create BOL, return parts etc..) 

        2021_01_11 Intelice
        New function procedure SetItemSerialNo_(DocType: Integer; ItemJnlLine: Record "Item Journal Line"; SerialNo: Code[20]): Boolean
        to create Reservation Entry for Item Jnl Line.

    */

    fields
    {
        field(5; "Work Order Master No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = WorkOrderMaster."Work Order Master No.";
        }
        field(6; "Customer ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Work Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Work Order Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Sales Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));

            trigger OnValidate()
            var
                PurchLine: Record "Purchase Line";

            begin

                Duplicate := FALSE;
                PMWorkOrder := FALSE;
                SalesOrder := '';
                WorkOrder := '';

                //Search Sales Orders to seel if this Work Order is already assigned to anther Sales Order
                SalesHeaderDupCheck.SETRANGE(SalesHeaderDupCheck."Document Type", SalesHeaderDupCheck."Document Type"::Order);
                IF SalesHeaderDupCheck.FIND('-') THEN BEGIN
                    REPEAT
                        IF SalesHeaderDupCheck."Work Order No." = "Work Order No." THEN BEGIN
                            IF xRec."Sales Order No." <> SalesHeaderDupCheck."No." THEN BEGIN
                                Duplicate := TRUE;
                                SalesOrder := SalesHeaderDupCheck."No.";
                            END;
                        END;
                    UNTIL SalesHeaderDupCheck.NEXT = 0;
                END;

                //Search to verify Work Order aren't duplicated
                IF "Sales Order No." <> '' THEN BEGIN
                    IF WODDupCheck.FIND('-') THEN BEGIN
                        REPEAT
                            //Search Work Orders to see if the Sales Order is already linked to another Work Order
                            IF WODDupCheck."Sales Order No." = "Sales Order No." THEN BEGIN
                                Duplicate := TRUE;
                                WorkOrder := WODDupCheck."Work Order No.";
                            END;

                            //Search to verify the Work Order isn't already assigned to another Work Order as a Pump Module
                            IF WODDupCheck."Sales Order No." <> '' THEN BEGIN
                                IF "Work Order No." = WODDupCheck."Pump Module No." THEN BEGIN
                                    Duplicate := TRUE;
                                    PMWorkOrder := TRUE;
                                    WorkOrder := WODDupCheck."Work Order No.";
                                END;
                            END;
                        UNTIL WODDupCheck.NEXT = 0;
                    END;
                END;

                //Error Messages if Duplicates Exist
                IF Duplicate THEN BEGIN
                    IF WorkOrder <> '' THEN BEGIN
                        IF WorkOrder <> "Work Order No." THEN BEGIN
                            "Sales Order No." := xRec."Sales Order No.";
                            MODIFY;
                            MESSAGE('This Sales Order is already Linked to Work Order %1', WorkOrder);
                        END ELSE BEGIN
                            IF PMWorkOrder THEN BEGIN
                                "Sales Order No." := xRec."Sales Order No.";
                                MODIFY;
                                MESSAGE('This Work Order is already Linked to Work Order %1 as a Pump Module', WorkOrder);
                            END;
                        END;
                    END;

                    IF SalesOrder <> '' THEN BEGIN
                        "Sales Order No." := xRec."Sales Order No.";
                        MODIFY;
                        MESSAGE('This Work Order is already Linked to Sales Order %1', SalesOrder);
                    END;

                END ELSE BEGIN
                    IF "Sales Order No." <> '' THEN BEGIN
                        IF (xRec."Sales Order No." <> '') THEN BEGIN
                            xSO := xRec."Sales Order No.";
                            IF NOT CONFIRM('Are you sure you want to remove the link between this Work Order and Sales Order %1', FALSE, xSO) THEN BEGIN
                                ;
                                "Sales Order No." := xRec."Sales Order No.";
                                MODIFY;
                            END ELSE BEGIN
                                IF SalesHeader.GET(SalesHeader."Document Type"::Order, xRec."Sales Order No.") THEN BEGIN
                                    "Ship To Name" := '';
                                    "Ship To Address 1" := '';
                                    "Ship To Address 2" := '';
                                    "Ship To City" := '';
                                    "Ship To State" := '';
                                    "Ship To Zip Code" := '';
                                    Attention := '';
                                    "Phone No." := '';
                                    MODIFY;
                                    SalesHeader."Work Order No." := '';
                                    SalesHeader.MODIFY;
                                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                                    IF SalesLine.FIND('-') THEN BEGIN
                                        ///--! Clean Serial No.
                                        //IF SalesLine.Type.AsInteger() = 1 THEN BEGIN
                                        //    SalesLine."Serial No." := '';
                                        //    SalesLine.MODIFY;
                                        ClearSerialNo_(Database::"Sales Line", SalesLine."Line No.", SalesLine."No.");
                                    END;
                                END;
                                COMMIT;
                            END;
                        END;
                    END;
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, "Sales Order No.") THEN BEGIN
                        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                        IF SalesLine.FIND('-') THEN BEGIN
                            IF SalesLine.Type.AsInteger() = 1 THEN BEGIN
                                "Ship To Name" := SalesHeader."Ship-to Name";
                                "Ship To Address 1" := SalesHeader."Ship-to Address";
                                "Ship To Address 2" := SalesHeader."Ship-to Address 2";
                                "Ship To City" := SalesHeader."Ship-to City";
                                "Ship To State" := SalesHeader."Ship-to County";
                                "Ship To Zip Code" := SalesHeader."Ship-to Post Code";
                                Attention := SalesHeader."Ship-to Contact";
                                "Phone No." := SalesHeader."Phone No.";
                                MODIFY;
                                ///--! Set Serial No.
                                //SalesLine."Serial No." := "Serial No.";
                                SetSerialNo_(Database::"Sales Line", SalesLine, PurchLine, "Serial No.");
                                SalesLine."Commission Calculated" := TRUE;
                                SalesLine.MODIFY;
                                SalesHeader."Work Order No." := "Work Order No.";
                                SalesHeader.MODIFY;
                                COMMIT;
                            END ELSE BEGIN
                                ERROR('Work Order No. can only be linked to Sales Orders that have One Account G/L Line');
                            END;
                        END ELSE BEGIN
                            ERROR('Work Order No. can only be linked to Sales Orders that have One Account G/L Line');
                        END;
                    END;
                END;
                IF ("Sales Order No." = '') AND (xRec."Sales Order No." <> '') THEN BEGIN
                    IF NOT CONFIRM('Are you sure you want to remove the link between the Work Order and Sales Order', FALSE) THEN BEGIN
                        "Sales Order No." := xRec."Sales Order No.";
                        MODIFY;
                    END ELSE BEGIN
                        IF SalesHeader.GET(SalesHeader."Document Type"::Order, xRec."Sales Order No.") THEN BEGIN
                            "Ship To Name" := '';
                            "Ship To Address 1" := '';
                            "Ship To Address 2" := '';
                            "Ship To City" := '';
                            "Ship To State" := '';
                            "Ship To Zip Code" := '';
                            Attention := '';
                            "Phone No." := '';
                            MODIFY;
                            SalesHeader."Work Order No." := '';
                            SalesHeader.MODIFY;
                            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                            IF SalesLine.FIND('-') THEN BEGIN
                                IF SalesLine.Type.AsInteger() = 1 THEN BEGIN
                                    ///--! Clean Serial No.
                                    //IF SalesLine.Type.AsInteger() = 1 THEN BEGIN
                                    //    SalesLine."Serial No." := '';
                                    //    SalesLine.MODIFY;                                    
                                    ClearSerialNo_(Database::"Sales Line", SalesLine."Line No.", SalesLine."No.");
                                END;
                            END;
                        END;
                    END;
                END;

            end;

        }
        field(13; "Ship on Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Detail No."; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Model No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE(Class = CONST('MODEL'));

            trigger OnValidate()
            begin

                IF Item.GET("Model No.") THEN BEGIN
                    Description := item.Description;
                    "Model Type" := item."Model Type";
                    "Ship Weight" := item."Gross Weight";
                END;

                IF "Model Verified" THEN BEGIN
                    WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                    WOS.SETRANGE(WOS.Step, WOS.Step::"B-O");
                    WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                    IF WOS.FIND('-') THEN BEGIN
                        // 2/26/18 Start
                        User.Get(UserSecurityId);
                        IF (User."User Name" <> 'KAYE') AND (User."User Name" <> 'STELIAN.ILEANU_INTELICE.COM') THEN
                            // 2/26/18 End
                            ERROR('Work Order has already been Quoted.  You cannot change the Model');
                        // 2/26/18 Start
                        ExistingParts.SETCURRENTKEY("Work Order No.", "Part No.");
                        ExistingParts.SETRANGE(ExistingParts."Work Order No.", "Work Order No.");
                        IF ExistingParts.FIND('-') THEN BEGIN
                            REPEAT
                                DeleteParts;
                                DeletePartsInProcess;
                                ExistingParts.DELETE;
                            UNTIL ExistingParts.NEXT = 0;
                            ///--! Commit here?
                            ///Commit();
                            CreateParts;
                        END ELSE BEGIN
                            CreateParts;
                        END;
                        // 2/26/18 End
                    END ELSE BEGIN
                        IF ("Quote Phase" = "Quote Phase"::" ") OR ("Quote Phase" = "Quote Phase"::"Phase 1") THEN BEGIN
                            ExistingParts.SETCURRENTKEY("Work Order No.", "Part No.");
                            ExistingParts.SETRANGE(ExistingParts."Work Order No.", "Work Order No.");
                            IF ExistingParts.FIND('-') THEN BEGIN
                                REPEAT
                                    DeleteParts;
                                    ExistingParts.DELETE;
                                UNTIL ExistingParts.NEXT = 0;
                                CreateParts;
                            END ELSE BEGIN
                                CreateParts;
                            END;
                        END ELSE BEGIN
                            ERROR('Work Order has already been Quoted.  You cannot change the Model');
                        END;
                    END;
                END;
            end;
        }
        field(25; "Model Verified"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Model Verified" THEN BEGIN
                    CreateParts;
                    MODIFY;
                END ELSE
                    ERROR('This pump has already been verified.');
            end;
        }
        field(28; "Order Type USERID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Order Type"; Enum OrderType)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.SETRANGE(WOS.Status, WOS.Status::Complete);
                IF WOS.FIND('-') THEN BEGIN
                    ERROR('Work Order has already been Quoted.  You cannot change the Order Type');
                END ELSE BEGIN
                    IF "Order Type" = "Order Type"::Warranty THEN BEGIN
                        "Shipping Charge" := "Shipping Charge"::Collect;
                        MODIFY;
                    END;
                END;

                IF GetCurrentStatus("Work Order No.") < 0 THEN
                    VALIDATE("Initial Order Type", "Order Type");

                IF xRec."Order Type" <> "Order Type" THEN
                    "Order Type USERID" := USERID;
            end;
        }
        field(32; "Initial Order Type"; Enum OrderType)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // 2016_02_27 ADV
                IF xRec."Initial Order Type" <> "Initial Order Type" THEN
                    IF GetCurrentStatus("Work Order No.") >= 0 THEN BEGIN
                        MESSAGE('Work Order has already been Received.  You cannot change the Initial Order Type');
                        "Initial Order Type" := xRec."Initial Order Type";
                    END;
            end;
        }
        field(35; "Order Type Reason"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.SETRANGE(WOS.Status, 1);  // Complete
                IF WOS.FIND('-') THEN BEGIN
                    MESSAGE('Work Order has already been Quoted.  You cannot change the Order Type Reason');
                    "Order Type Reason" := '';
                    MODIFY;
                END;
            end;
        }
        field(38; "Model Type"; Enum ModelType)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Serial No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Build Ahead"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Vendor Repair" THEN
                    ERROR('Vendor Repairs Can''t be Built Ahead');
            end;
        }
        field(56; "Build Ahead Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Customer PO No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70; Notes; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Oil Type"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Non Copper"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(90; "Income Code"; Enum IncomeCode)
        {
            DataClassification = ToBeClassified;
        }
        field(100; "Customer Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(115; "Tax Liable"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // 05/05/13 Start
                //IF WorkOrderMaster.GET("Work Order Master No.") THEN BEGIN;
                //  IF WorkOrderMaster."Customer State" <> 'MD' THEN BEGIN
                //    ERROR('%1 is not Located in Maryland, and can''t be Tax Liable',"Customer ID");
                //  END ELSE BEGIN
                // 05/05/13 End
                IF (WorkOrderMaster."Tax Exemption No." <> '') OR (WorkOrderMaster."Exempt Organization" <> '') THEN BEGIN
                    IF "Tax Liable" = TRUE THEN BEGIN
                        IF NOT CONFIRM('This Customer has a Tax Exempt No., Are you sure this Order is Tax Liable', FALSE) THEN
                            ERROR('The Order is NOT Tax Liable');
                    END;
                END;
                //  END;
                //END;
            end;
        }
        field(125; Diagnosis; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(130; "Ultimate Test"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(150; "System Shipment"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                WorkOrderDetail.RESET;
                WorkOrderDetail.SETCURRENTKEY("Work Order Master No.");
                WorkOrderDetail.SETRANGE(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
                IF WorkOrderDetail.FIND('-') THEN BEGIN
                    REPEAT
                        RecordCount := RecordCount + 1;
                        IF RecordCount = 1 THEN BEGIN
                            WorkOrderMaster.RESET;
                            WorkOrderMaster.GET("Work Order Master No.");
                            PTTest := WorkOrderMaster."Customer Payment Terms";
                        END;
                        IF PTTest <> WorkOrderMaster."Customer Payment Terms" THEN
                            ERROR('Shipping Addresses must match to place multilple Work Order together');
                        IF ("Ship To Name" <> WorkOrderDetail."Ship To Name")
                          OR ("Ship To Address 1" <> WorkOrderDetail."Ship To Address 1")
                          OR ("Ship To Address 2" <> WorkOrderDetail."Ship To Address 2")
                          OR ("Ship To City" <> WorkOrderDetail."Ship To City")
                          OR ("Ship To State" <> WorkOrderDetail."Ship To State")
                          OR ("Ship To Zip Code" <> WorkOrderDetail."Ship To Zip Code") THEN BEGIN
                            WorkOrderDetail.RESET;
                            WorkOrderDetail.SETCURRENTKEY("Work Order Master No.");
                            WorkOrderDetail.SETRANGE(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
                            IF WorkOrderDetail.FIND('-') THEN BEGIN
                                REPEAT
                                    WorkOrderDetail.Ship := FALSE;
                                    WorkOrderDetail.MODIFY;
                                    COMMIT;
                                UNTIL WorkOrderDetail.NEXT = 0;
                            END;
                            ERROR('Shipping Addresses must match to place multilple Work Order together');
                        END;
                    UNTIL WorkOrderDetail.NEXT = 0;
                END;
            end;
        }
        field(160; Container; Enum Container)
        {
            DataClassification = ToBeClassified;
        }
        field(170; "Container Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(175; "Container Saved"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(176; oContainerSaved; Enum YesNo)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CASE oContainerSaved OF
                    oContainerSaved::Yes:
                        "Container Saved" := TRUE;
                    oContainerSaved::No:
                        "Container Saved" := FALSE;
                    ELSE
                        ERROR('You need to choose Yes on No for Saved Container.');
                END;
                IF oContainerSaved = oContainerSaved::No THEN
                    "Container Type" := "Container Type"::" ";
                MODIFY;
            end;
        }
        field(177; "Container Type"; Enum BOLContainer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF oContainerSaved = oContainerSaved::Yes THEN
                    IF "Container Type".AsInteger() = 0 THEN
                        ERROR('You need to pick a Container Type.');
            end;
        }

        field(180; "Ship Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(185; "Package Tracking No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Bill of Lading"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Labor Hours Quoted"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(Parts."Quoted Quantity" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Resource)));
        }
        field(202; "Labor Quoted"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(Parts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Resource)));
        }
        field(210; "Parts Cost"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(Parts."Total Cost" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Item)));
        }
        field(220; "Order Adj."; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Order Type" = "Order Type"::Warranty THEN BEGIN
                    IF "Order Adj." > 0 THEN
                        ERROR('Order Adjustment can''t be used to Charge Customers for Warranties, Please Use Return Charge');
                END;
            end;
        }
        field(222; "Original Parts Cost"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(OriginalQuotedParts."Total Quote Cost" WHERE("Work Order No." = FIELD("Work Order No.")));
        }
        field(223; "Original Parts Price"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(OriginalQuotedParts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Item)));
        }
        field(224; "Original Labor Price"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(OriginalQuotedParts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Resource)));
        }
        field(226; "Unrepairable Charge"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(229; Rep; Code[3])
        {
            DataClassification = ToBeClassified;
        }
        field(230; Freightin; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(231; "Freightin Deducted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(232; "Freightin Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(233; "Freightin Bill Customer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(235; "Freightout"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(236; "Freightout Deducted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(237; "Freightout Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(240; "Install Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(241; "Warranty Type"; Enum WarrantyType)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.SETRANGE(WOS.Status, 1);  // Complete
                IF WOS.FIND('-') THEN BEGIN

                    // 2011/04/13 Start
                    IF (USERID <> 'KAYE') AND (USERID <> 'ADMIN') THEN
                        // 2011/04/13 End
                        ERROR('Work Order has already been Quoted.  You cannot change the Order Type Reason');
                END;
            end;
        }
        field(242; "Warranty Reason"; Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.SETRANGE(WOS.Status, 1);  // Complete
                IF WOS.FIND('-') THEN BEGIN

                    // 2011/04/13 Start
                    IF (USERID <> 'KAYE') AND (USERID <> 'ADMIN') THEN BEGIN
                        // 2011/04/13 End

                        MESSAGE('Work Order has already been Quoted.  You cannot change the Order Type Reason');
                        "Warranty Reason" := '';
                        MODIFY;

                        // 2011/04/13 Start
                    END;
                    // 2011/04/13 End

                END;
            end;
        }
        field(243; ReQuoted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(244; "Quote Sent Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(245; Quote; Enum QuoteOptions)
        {
            DataClassification = ToBeClassified;
        }
        field(246; "Unrepairable Reason"; Enum UnrepairableReason)
        {
            DataClassification = ToBeClassified;
        }
        field(247; "Unrepairable Handling"; Enum UnrepairableHandling)
        {
            DataClassification = ToBeClassified;
        }
        field(248; "Unrepairable BuildAhead"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(249; "ReUsable Parts Returned"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(250; "Parts Quoted"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(Parts."Total Quote Price" WHERE("Work Order No." = FIELD("Work Order No."), "Part Type" = CONST(Item)));
        }
        field(260; Carrier; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent".Code;

            trigger OnValidate()
            begin
                IF Agent.GET(Carrier) THEN BEGIN
                    IF "Shipping Charge" = "Shipping Charge"::Collect THEN BEGIN
                        "Shipping Account" := '';
                        "Shipping Charge" := "Shipping Charge"::" ";
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
        field(265; "Shipping Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method".Code;
        }
        field(270; "Shipping Account"; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
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
        field(275; "Shipping Charge"; Enum ShippingCharge)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

                IF "Shipping Charge" = "Shipping Charge"::Collect THEN BEGIN
                    IF Agent.GET(Carrier) THEN BEGIN
                        IF Agent."Account No. Required" THEN BEGIN
                            IF "Shipping Account" = '' THEN BEGIN
                                MESSAGE('Carrier Must be Entered First');
                                "Shipping Charge" := "Shipping Charge"::" ";
                                MODIFY;
                            END;
                        END;
                    END ELSE BEGIN
                        MESSAGE('Carrier Must be Entered First');
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
        field(280; "Date Required"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(290; Warranty; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(300; Released; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(305; "Released USERID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(310; Invoiced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(330; Accessories; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(335; "Receiving Notes"; Text[90])
        {
            DataClassification = ToBeClassified;
        }
        field(340; "Safety Form"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(345; Packaging; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(350; "Packaging Location"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(360; "Pump Location"; Code[2])
        {
            DataClassification = ToBeClassified;
        }
        field(370; Boxed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(380; "Inventory Cost Adjusted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(400; "Detail Step"; Enum DetailStep)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Max(Status.Step WHERE("Order No." = FIELD("Work Order No.")));
        }
        field(405; BackorderText; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(410; "Quote Phase"; Enum QuotePhase)
        {
            DataClassification = ToBeClassified;
        }
        field(500; "Current Reg Hours Used"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(Status."Regular Hours" WHERE("Order No." = FIELD("Work Order No.")));
        }
        field(505; "Current OT Hours Used"; Decimal)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = Sum(Status."Overtime Hours" WHERE("Order No." = FIELD("Work Order No.")));
        }
        field(510; "Current Extra Time Used"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(600; Stage; Enum StageOption)
        {
            DataClassification = ToBeClassified;
        }
        field(700; RCV; Text[130])
        {
            DataClassification = ToBeClassified;
            Caption = 'REC';

            trigger OnValidate()
            begin
                IF RCV <> xRec.RCV THEN BEGIN
                    "REC Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(705; "REC Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(710; DIS; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF DIS <> xRec.DIS THEN BEGIN
                    "DIS Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(715; "DIS Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(720; QOT; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF QOT <> xRec.QOT THEN BEGIN
                    "QOT Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(725; "QOT Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(730; "B-O"; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "B-O" <> xRec."B-O" THEN BEGIN
                    "B-O Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(735; "B-O Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(740; CLN; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF CLN <> xRec.CLN THEN BEGIN
                    "CLN Date" := WORKDATE;
                    MODIFY;
                END;
            end;

        }
        field(745; "CLN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(750; ASM; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ASM <> xRec.ASM THEN BEGIN
                    "ASM Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(755; "ASM Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(760; TST; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF TST <> xRec.TST THEN BEGIN
                    "TST Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(765; "TST Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(770; PNT; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF PNT <> xRec.PNT THEN BEGIN
                    "PNT Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(775; "PNT Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(780; QC; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF QC <> xRec.QC THEN BEGIN
                    "QC Date" := WORKDATE;
                    MODIFY;
                END;
            end;

        }
        field(785; "QC Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(790; SHP; Text[130])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF SHP <> xRec.SHP THEN BEGIN
                    "SHP Date" := WORKDATE;
                    MODIFY;
                END;
            end;
        }
        field(791; "SHP Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(795; Ship; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Ship = TRUE THEN BEGIN
                    WorkOrderDetail.RESET;
                    WorkOrderDetail.SETCURRENTKEY("Work Order Master No.");
                    WorkOrderDetail.SETRANGE(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
                    WorkOrderDetail.SETRANGE(WorkOrderDetail.Ship, TRUE);
                    IF WorkOrderDetail.FIND('-') THEN BEGIN
                        REPEAT
                            RecordCount := RecordCount + 1;
                            IF RecordCount = 1 THEN BEGIN
                                WorkOrderMaster.RESET;
                                WorkOrderMaster.GET("Work Order Master No.");
                                PTTest := WorkOrderMaster."Customer Payment Terms";
                            END;
                            IF PTTest <> WorkOrderMaster."Customer Payment Terms" THEN
                                ERROR('Shipping Addresses must match to place multilple Work Order together');
                            IF ("Ship To Name" <> WorkOrderDetail."Ship To Name")
                              OR ("Ship To Address 1" <> WorkOrderDetail."Ship To Address 1")
                              OR ("Ship To Address 2" <> WorkOrderDetail."Ship To Address 2")
                              OR ("Ship To City" <> WorkOrderDetail."Ship To City")
                              OR ("Ship To State" <> WorkOrderDetail."Ship To State")
                              OR ("Ship To Zip Code" <> WorkOrderDetail."Ship To Zip Code") THEN BEGIN
                                WorkOrderDetail.RESET;
                                WorkOrderDetail.SETCURRENTKEY("Work Order Master No.");
                                WorkOrderDetail.SETRANGE(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
                                IF WorkOrderDetail.FIND('-') THEN BEGIN
                                    REPEAT
                                        WorkOrderDetail.Ship := FALSE;
                                        WorkOrderDetail.MODIFY;
                                        COMMIT;
                                    UNTIL WorkOrderDetail.NEXT = 0;
                                END;
                                ERROR('Shipping Addresses must match to place multilple Work Order together');
                            END;
                        UNTIL WorkOrderDetail.NEXT = 0;
                    END;
                END;
            end;
        }
        field(796; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(800; "Ship To Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(810; "Ship To Address 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(820; "Ship To Address 2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(830; "Ship To City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(840; "Ship To State"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(850; "Ship To Zip Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(860; Attention; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(865; "Phone No."; Text[30])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(870; Expedite; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(875; "Expedite Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(880; "Billing List"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(890; "Billing Notes"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(900; Unblocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(910; "Unblocked SHP"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(1000; Complete; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Complete THEN BEGIN
                    CompleteParts.SETRANGE(CompleteParts."Work Order No.", "Work Order No.");
                    IF CompleteParts.FIND('-') THEN BEGIN
                        REPEAT
                            CompleteParts.Complete := TRUE;
                            CompleteParts.MODIFY;
                        UNTIL CompleteParts.NEXT = 0;
                    END;
                END ELSE BEGIN
                    CompleteParts.SETRANGE(CompleteParts."Work Order No.", "Work Order No.");
                    IF CompleteParts.FIND('-') THEN BEGIN
                        REPEAT
                            CompleteParts.Complete := FALSE;
                            CompleteParts.MODIFY;
                        UNTIL CompleteParts.NEXT = 0;
                    END;
                END;
            end;
        }
        field(1001; "Last User Modified"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(1005; "Payment Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method".Code;
        }
        field(1010; "Card Type"; Enum CreditCardType)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Payment Terms" = 'CC' THEN BEGIN
                    Ok := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Type');
                    "Card Type" := "Card Type"::" ";
                    MODIFY;
                END;
            end;
        }
        field(1020; "Credit Card No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Payment Terms" = 'CC' THEN BEGIN
                    Ok := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Number');
                    "Credit Card No." := '';
                    MODIFY;
                END;
            end;
        }
        field(1030; "Credit Card Exp."; Code[6])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Payment Terms" = 'CC' THEN BEGIN
                    Ok := TRUE;
                END ELSE BEGIN
                    MESSAGE('Payment Terms must be CC in order to enter a Credit Card Expiration');
                    "Credit Card Exp." := '';
                    MODIFY;
                END;
            end;
        }
        field(1035; "Approval Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(1050; "Payment Terms"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms".Code;

            trigger OnValidate()
            begin
                Terms := COPYSTR("Payment Terms", 1, 3);
                IF Terms = 'NET' THEN BEGIN
                    IF Cust.GET("Customer ID") THEN BEGIN
                        ;
                        CustTerms := COPYSTR(Cust."Payment Terms Code", 1, 3);
                        IF CustTerms <> 'NET' THEN BEGIN
                            MESSAGE('Payment Terms can''t be set to %1 because Customer is setup as %2, Please See Accounting', "Payment Terms",
                                     Cust."Payment Terms Code");
                            "Payment Terms" := '';
                            VALIDATE("Payment Terms");
                        END;
                    END;
                END;

                IF ("Credit Card No." <> '') OR ("Credit Card Exp." <> '') THEN BEGIN
                    IF "Payment Terms" = 'CC' THEN BEGIN
                        Ok := TRUE;
                    END ELSE BEGIN
                        MESSAGE('Credit Card Information must be removed in order to Change Payment Terms');
                        "Payment Terms" := 'CC';
                        MODIFY;
                    END;
                END;
            end;
        }
        field(2000; "Repaired Pump Part No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE(Class = FILTER('PUMP'));
        }
        field(4960; "Customer Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = WorkOrderDetail."Work Order No." WHERE("Customer ID" = FILTER('<> ADV-01'));
        }
        field(4970; "Pump Module No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = WorkOrderDetail."Work Order No." WHERE("Customer ID" = FILTER('ADV-01'), Complete = FILTER(false),
                            "Pump Module No." = FILTER(''), "Sales Order No." = FILTER(''));

            trigger OnValidate()
            begin
                Duplicate := FALSE;
                SalesOrder := '';
                Ok := TRUE;
                PMOrder := '';

                //Search all Sales Order for Advaco Order already assigned to a Sales Order
                IF "Pump Module No." <> '' THEN BEGIN
                    SalesHeaderDupCheck.SETRANGE(SalesHeaderDupCheck."Document Type", SalesHeaderDupCheck."Document Type"::Order);
                    IF SalesHeaderDupCheck.FIND('-') THEN BEGIN
                        REPEAT
                            IF SalesHeaderDupCheck."Work Order No." = "Pump Module No." THEN BEGIN
                                Duplicate := TRUE;
                                SalesOrder := SalesHeaderDupCheck."No.";
                            END;
                        UNTIL SalesHeaderDupCheck.NEXT = 0;
                    END;
                END;

                IF Duplicate THEN BEGIN
                    //Error Message for already being linked to a Sales Order
                    IF SalesOrder <> '' THEN BEGIN
                        PMOrder := "Pump Module No.";
                        "Pump Module No." := xRec."Pump Module No.";
                        MODIFY;
                        MESSAGE('Work Order %1 is already Linked to Sales Order %2', PMOrder, SalesOrder);
                    END;
                END ELSE BEGIN
                    WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                    WOS.SETRANGE(WOS.Step, WOS.Step::QOT);
                    WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                    WOS.SETRANGE(WOS.Status, WOS.Status::Complete);
                    IF WOS.FIND('-') THEN BEGIN
                        // Error Message for finding a QOT Complete without being quoted for a Pump Module
                        IF xRec."Pump Module No." = '' THEN BEGIN
                            "Pump Module No." := xRec."Pump Module No.";
                            MODIFY;
                            MESSAGE('This Work Order has already been Quoted.  It must be Re-Quoted to add a Pump Module')
                            // Error Message for trying to change the Pump Module after it has been released from QOT
                        END ELSE BEGIN
                            "Pump Module No." := xRec."Pump Module No.";
                            MODIFY;
                            MESSAGE('The Work Order has already been Quoted for another Pump Module, and It must be Re-Quoted to change the Pump Module'
                      );
                        END;
                    END ELSE BEGIN
                        // QOT in Waiting
                        ModuleParts.SETRANGE(ModuleParts."Work Order No.", "Work Order No.");
                        ModuleParts.SETRANGE(ModuleParts."Part Type", ModuleParts."Part Type"::Resource);
                        IF ModuleParts.FIND('-') THEN BEGIN
                            // Search for Resource PUMP MODULE
                            REPEAT
                                IF ModuleParts."Part No." = 'PUMP MODULE' THEN
                                    Ok := FALSE;
                            UNTIL ModuleParts.NEXT = 0;

                            IF Ok THEN BEGIN
                                "Pump Module No." := xRec."Pump Module No.";
                                MODIFY;
                                MESSAGE('The Resource "PUMP MODULE" must be included in Parts List before adding a Pump Module Work Order No.');
                            END ELSE BEGIN
                                // If PUMP MODULE is Quoted then check for additional criteria
                                IF ModuleDetail.GET("Pump Module No.") THEN BEGIN
                                    ModuleDetail.CALCFIELDS("Detail Step");
                                    //Check to see if Work Order is Open
                                    IF ModuleDetail.Complete = FALSE THEN BEGIN
                                        // Check to see if it is in Shipping
                                        IF ModuleDetail."Detail Step" = "Detail Step"::SHP THEN BEGIN
                                            //Check to see if it has already been assigned to another Work Order
                                            IF ModuleDetail."Customer Order No." = '' THEN BEGIN
                                                // Update Pump Module Detail with Customers Order No.
                                                ModuleDetail."Customer Order No." := "Work Order No.";
                                                ModuleDetail.MODIFY;

                                                ModuleDetail.RESET;

                                                // Remove old Work Orde No. if one exist
                                                IF ModuleDetail.GET(xRec."Pump Module No.") THEN BEGIN
                                                    ModuleDetail."Customer Order No." := '';
                                                    ModuleDetail.MODIFY;
                                                END;
                                            END ELSE BEGIN
                                                MESSAGE('Work Order %1 has already been assigned to %2', "Pump Module No.", ModuleDetail."Customer Order No.");
                                                "Pump Module No." := xRec."Pump Module No.";
                                                MODIFY;
                                            END;
                                        END ELSE BEGIN
                                            "Pump Module No." := xRec."Pump Module No.";
                                            MODIFY;
                                            MESSAGE('The Work Order must be in the Shipping Step and Waiting to be a Pump Module');
                                        END;
                                    END ELSE BEGIN
                                        "Pump Module No." := xRec."Pump Module No.";
                                        MODIFY;
                                        MESSAGE('The Work Order must be Open to be a Pump Module');
                                    END;
                                END ELSE BEGIN
                                    IF "Pump Module No." = '' THEN BEGIN
                                        IF xRec."Pump Module No." <> '' THEN BEGIN
                                            IF ModuleDetail.GET(xRec."Pump Module No.") THEN BEGIN
                                                ModuleDetail."Customer Order No." := '';
                                                ModuleDetail.MODIFY;
                                            END;
                                        END;
                                    END ELSE BEGIN
                                        "Pump Module No." := xRec."Pump Module No.";
                                        MODIFY;
                                        MESSAGE('The Pump Module Work Order No. is not Valid');
                                    END;
                                END;
                            END;
                        END ELSE BEGIN
                            "Pump Module No." := xRec."Pump Module No.";
                            MODIFY;
                            MESSAGE('The Resource "Pump Module" must be included in Parts List before adding a Pump Module Work Order No.');
                        END;
                    END;
                END;
            end;

        }
        field(4975; "Pump Module"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4976; "Pump Module Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4980; "Exchange Pump"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Vendor Repair" THEN
                    IF CONFIRM('Do you want to convert Vendor Repair into an Exchange Pump', TRUE) THEN
                        "Vendor Repair" := FALSE
                    ELSE
                        "Exchange Pump" := FALSE;

                IF "Reverse Build Ahead" THEN
                    ERROR('This Work Order is Already an Reverse Build Ahead');

                IF "Vendor Return" THEN
                    ERROR('This Work Order is Already a Vendor Return');

                IF "Vendor Bill of Lading" = 0 THEN
                    MESSAGE('Vendor RMA Information needs to be completed before Shipping');
            end;
        }
        field(4985; "Vendor Return"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Vendor Repair" THEN
                    ERROR('This Work Order is Already a Vendor Repair');

                IF "Exchange Pump" THEN
                    ERROR('This Work Order is Already an Exchange Pump');

                IF "Reverse Build Ahead" THEN
                    ERROR('This Work Order is Already an Reverse Build Ahead');

                IF "Vendor Return" THEN BEGIN
                    IF "Sales Order No." <> '' THEN
                        ERROR('This Work Order is linked to %1 and must be removed before making it a Return to Vendor', "Sales Order No.");
                END;
            end;
        }
        field(4990; "Vendor Repair"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Build Ahead" THEN
                    ERROR('This Pump is a Build Ahead');
                IF ("Vendor Repair" = FALSE) AND (xRec."Vendor Repair" = TRUE) THEN BEGIN
                    IF ("RMA No." <> '') OR ("RMA PO No." <> '') OR ("Vendor Bill of Lading" <> 0) THEN
                        ERROR('ALL Vendor Return Information must be Deleted before changing Status');
                END;

                IF "Exchange Pump" THEN
                    IF CONFIRM('Do you want to convert the Exchange Pump into a Vendor Repair', TRUE) THEN
                        "Exchange Pump" := FALSE
                    ELSE
                        "Vendor Repair" := FALSE;

                IF "Vendor Return" THEN
                    ERROR('This Work Order is Already a Vendor Return');

                //Verify that step DIS isn't closed
                WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
                WOS.SETRANGE(WOS.Step, WOS.Step::DIS);
                WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                WOS.SETRANGE(WOS.Status, WOS.Status::Complete);
                IF WOS.FIND('-') THEN
                    IF "Vendor Bill of Lading" = 0 THEN
                        ERROR('The Work Order is Quoted, so It must first be converted to a "Build Ahead", and then Check the "Reverse Build Ahead"');
            end;
        }
        field(4991; "Reverse Build Ahead"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Vendor Repair" THEN
                    ERROR('This Work Order is Already a Vendor Repair');

                IF "Build Ahead" THEN
                    Ok := FALSE
                ELSE
                    ERROR('This Work Order is Not a Build Ahead, so it can''t be Reversed');

                IF "Exchange Pump" THEN
                    ERROR('This Work Order is Already an Exchange Pump');

                IF "Reverse Build Ahead" THEN
                    MESSAGE('Vendor RMA Information needs to be completed, and Notify the Parts Department to Return Parts.');

                IF "Vendor Return" THEN
                    ERROR('This Work Order is Already a Vendor Return');
            end;
        }
        field(5000; "RMA No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5010; "RMA Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5020; "RMA Description"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(5030; "RMA Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5031; "Vendor Carrier"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipping Agent".Code;
        }
        field(5032; "Vendor Shipping Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Shipment Method".Code;
        }
        field(5033; "Vendor Shipping Account"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5034; "Vendor Shipping Charge"; Enum ShippingCharge)
        {
            DataClassification = ToBeClassified;
        }
        field(5035; "Vendor Container"; Enum Container)
        {
            DataClassification = ToBeClassified;
        }
        field(5036; "Vendor Container Quantity"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5037; "Vendor Ship Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5038; "Vendor Package Tracking No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5039; "Vendor Bill of Lading"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5040; "RMA PO No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF ("Vendor Name" = '') AND ("Vendor Address" = '') THEN BEGIN
                    PurchaseHeader.SETRANGE(PurchaseHeader."Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", "RMA PO No.");
                    IF PurchaseHeader.FIND('-') THEN BEGIN
                        "Vendor Code" := PurchaseHeader."Buy-from Vendor No.";
                        "Vendor Name" := PurchaseHeader."Buy-from Vendor Name";
                        "Vendor Address" := PurchaseHeader."Buy-from Address";
                        "Vendor Address2" := PurchaseHeader."Buy-from Address 2";
                        "Vendor City" := PurchaseHeader."Buy-from City";
                        "Vendor State" := PurchaseHeader."Buy-from County";
                        "Vendor Zip" := PurchaseHeader."Buy-from Post Code";
                        "Vendor Contact" := PurchaseHeader."Buy-from Contact";
                        IF Vendor.GET(PurchaseHeader."Buy-from Vendor No.") THEN BEGIN
                            "Vendor Phone No." := Vendor."Phone No.";
                            "Vendor Fax No." := Vendor."Fax No.";
                        END;
                    END;
                END;
            end;
        }
        field(5050; "Vendor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5060; "Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5070; "Vendor Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5080; "Vendor Address2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5090; "Vendor City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5100; "Vendor State"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5110; "Vendor Zip"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5115; "Vendor Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5120; "Vendor Phone No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5130; "Vendor Fax No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5135; "Third Party Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5136; "Third Party Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5138; "Third Party City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5139; "Third Party State"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5140; "Third Party Zip"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5141; "Credit Card SC"; Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(5200; "Date Filter"; Date)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowFilter;
        }
        field(50000; "Overwrite Cr. Limit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(100003; Comment; Boolean)
        {
            //DataClassification = ToBeClassified;
            Caption = 'Comment';
            CalcFormula = Exist("ADVACO Comment Line" WHERE("Table Name" = CONST(WorkOrderDetail), "No." = FIELD("Work Order No.")));
            Editable = false; //ICE RSK 12/13/20

            FieldClass = FlowField;
        }
        field(100004; "Tool ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(100005; TD; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(100006; RD; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(100007; "Customer Viewable Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(200001; "Shipping Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(200002; "Vendor Shipping Processed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Work Order No.")
        {
            Clustered = true;
        }
        key(Key2; "Work Order Master No.")
        {
        }
        key(Key3; "Order Type")
        {
        }
        key(Key4; "Customer ID", Boxed)
        {
        }
        key(Key5; "Bill of Lading")
        {
        }
        key(Key6; "Model No.")
        {
        }
        key(Key7; "Quote Sent Date")
        {
        }
        key(Key8; "Customer Part No.")
        {
        }
        key(Key9; Expedite)
        {
        }
        key(Key10; "Customer ID")
        {
        }
        key(Key11; "Work Order Master No.", "Ship Date", "Customer ID", "Model No.")
        {
        }
        key(Key12; "Initial Order Type")
        {
        }
        key(Key14; Complete)
        {
        }
    }

    procedure CreateParts()
    begin
        PartsMarkup := 1.86;
        IF item.GET("Model No.") THEN BEGIN
            item.SETRANGE(item."Location Filter", 'MAIN');
            item.CALCFIELDS(item.Inventory);
            Parts.SETRANGE(Parts."Work Order No.", "Work Order No.");
            IF Parts.FIND('-') THEN BEGIN
                Ok := TRUE
            END ELSE BEGIN
                BOM.SETRANGE(BOM."Parent Item No.", item."No.");
                IF BOM.FIND('-') THEN BEGIN
                    REPEAT
                        LineNumber := LineNumber + 10000;
                        PartsList.INIT;
                        PartsList."Work Order No." := "Work Order No.";
                        PartsList."Part No." := BOM."No.";
                        PartsList.Description := BOM.Description;
                        PartsList.Stage := 0;
                        IF BOM.Type = BOM.Type::Item THEN BEGIN
                            Item2.GET(BOM."No.");
                            IF Item2.Blocked THEN BEGIN
                                Ok := TRUE;
                            END ELSE BEGIN
                                Item2.SETRANGE(Item2."Location Filter", 'MAIN');
                                Item2.CALCFIELDS(Item2.Inventory, Item2."Reserved Qty. on Inventory", Item2."Qty. on Purch. Order");
                                "Qty Available" := (Item2.Inventory - Item2."Reserved Qty. on Inventory");
                                PartsList."Part Type" := PartsList."Part Type"::Item;
                                PartsList."Part Cost" := Item2."Last Direct Cost";
                                IF "Order Type" = "Order Type"::Rebuild THEN BEGIN
                                    PartsList."BOM Quantity" := BOM."Quantity per";
                                    PartsList."Quoted Quantity" := BOM."Quantity per";
                                    PartsList."Total Quote Cost" := BOM."Quantity per" * Item2."Last Direct Cost";
                                    PartsList."Total Cost" := PartsList."Total Quote Cost";

                                    // 2016_04_02 ADV Parts Markup: Start
                                    /*IF Item2."Vendor No." = 'LEY-01' THEN BEGIN
                                                              PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.94;
                                                              PartsList."Total Quote Price" := (BOM."Quantity per" * (Item2."Last Direct Cost" * 1.94));
                                                          END;
                                                          IF Item2."Vendor No." = 'PPV-01' THEN BEGIN
                                                              PartCode := COPYSTR(item."No.", 1, 3);
                                                              IF PartCode = 'EBD' THEN BEGIN
                                                                  PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.86;
                                                                  PartsList."Total Quote Price" := (BOM."Quantity per" * (Item2."Last Direct Cost" * 1.86));
                                                              END ELSE BEGIN
                                                                  PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.98;
                                                                  PartsList."Total Quote Price" := (BOM."Quantity per" * (Item2."Last Direct Cost" * 1.98));
                                                              END;
                                                          END ELSE BEGIN
                                                              PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.86;
                                                              PartsList."Total Quote Price" := (BOM."Quantity per" * (Item2."Last Direct Cost" * 1.86));
                                                          END;*/
                                    PartsList."Quoted Price" := Item2."Last Direct Cost" * PartsMarkup;
                                    PartsList."Total Quote Price" := (BOM."Quantity per" * (Item2."Last Direct Cost" * PartsMarkup));
                                    // 2016_04_02 ADV Parts Markup: End

                                    PartsList."Total Price" := PartsList."Total Quote Price";
                                    IF "Qty Available" > 0 THEN BEGIN
                                        IF "Qty Available" < PartsList."BOM Quantity" THEN BEGIN
                                            PartsList."Quantity Backorder" := PartsList."BOM Quantity" - "Qty Available";
                                            BackOrderParts;
                                        END ELSE BEGIN
                                            FillOrder;
                                        END;
                                    END ELSE BEGIN
                                        PartsList."Quantity Backorder" := PartsList."BOM Quantity";
                                    END;
                                END ELSE BEGIN
                                    PartsList."BOM Quantity" := 0;
                                    IF Item2."Vendor No." = 'LEY-01' THEN
                                        PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.94;
                                    IF Item2."Vendor No." = 'PPV-01' THEN BEGIN
                                        PartCode := COPYSTR(item."No.", 1, 3);
                                        IF PartCode = 'EBD' THEN
                                            PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.86
                                        ELSE
                                            PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.98;
                                    END ELSE
                                        PartsList."Quoted Price" := Item2."Last Direct Cost" * 1.86;
                                END;
                            END;
                        END ELSE
                            IF BOM.Type = BOM.Type::Resource THEN BEGIN
                                Resource.GET(BOM."No.");
                                IF Resource.Blocked THEN BEGIN
                                    Ok := TRUE;
                                END ELSE BEGIN
                                    PartsList."Quoted Price" := Resource."Unit Price";
                                    PartsList."Part Type" := PartsList."Part Type"::Resource;
                                    IF "Order Type" = "Order Type"::Rebuild THEN BEGIN
                                        PartsList."BOM Quantity" := BOM."Quantity per";
                                        PartsList."Quoted Quantity" := BOM."Quantity per";
                                        PartsList."Total Quote Price" := BOM."Quantity per" * Resource."Unit Price";
                                        PartsList."Total Price" := PartsList."Total Quote Price";
                                    END ELSE BEGIN
                                        PartsList."BOM Quantity" := 0;
                                    END;
                                END;
                            END;
                        PartsList.INSERT;
                    UNTIL BOM.NEXT = 0;
                END;
            END;
        END;
    end;

    procedure BackOrderParts()
    begin
        BackOrderQty := (PartsList."BOM Quantity" - PartsList."Quantity Backorder");
        IF BackOrderQty > 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'MAIN';
            WriteItemJournalLine;
            ItemJournalLine.Description := "Work Order No." + ' ' + 'REC COMMIT PARTS';
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, BackOrderQty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'COMMITTED');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure FillOrder()
    begin
        FillOrderQty := PartsList."BOM Quantity";
        IF FillOrderQty > 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Location Code" := 'MAIN';
            ItemJournalLine.Description := "Work Order No." + ' ' + 'REC COMMIT PARTS';
            WriteItemJournalLine;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, FillOrderQty);
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code", 'COMMITTED');
            ItemJournalLine.INSERT;

            PostJournalLine;
        END;
    end;

    procedure DeleteParts()
    begin
        ExistingParts.CALCFIELDS(ExistingParts."Committed Quantity");

        IF ExistingParts."Committed Quantity" > 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'COMMITTED';
            ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Document No." := "Work Order No.";
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Item No." := ExistingParts."Part No.";
            ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WORKDATE;
            ItemJournalLine.Description := "Work Order No." + ' ' + 'WOD RETURN PARTS';
            ItemJournalLine."Location Code" := 'COMMITTED';
            ItemJournalLine.Quantity := ExistingParts."Committed Quantity";
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'MAIN';
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code");
            ItemJournalLine.INSERT;

            PostLine.RUN(ItemJournalLine);

            ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
            ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
            IF ItemJournalClear.FIND('-') THEN
                REPEAT
                    ItemJournalClear.DELETE;
                UNTIL ItemJournalClear.NEXT = 0;
        END;
    end;

    procedure WriteItemJournalLine()
    begin
        LineNumber := LineNumber + 10000;
        ItemJournalLine.VALIDATE("Journal Template Name", 'TRANSFER');
        ItemJournalLine.VALIDATE("Journal Batch Name", 'TRANSFER');
        ItemJournalLine."Line No." := LineNumber;
        ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
        ItemJournalLine."Document No." := "Work Order No.";
        ItemJournalLine.VALIDATE("Item No.", Item2."No.");
        ItemJournalLine."Posting Date" := WORKDATE;
    end;

    procedure PostJournalLine()
    begin
        PostLine.RUN(ItemJournalLine);

        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
        ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
        IF ItemJournalClear.FIND('-') THEN
            REPEAT
                ItemJournalClear.DELETE;
            UNTIL ItemJournalClear.NEXT = 0;
    end;

    procedure MoveInventory()
    begin
        MoveInventoryQty := Parts."Committed Quantity";
        IF MoveInventoryQty > 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
            ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Document No." := "Work Order No.";
            ItemJournalLine."Item No." := Parts."Part No.";
            ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WORKDATE;
            ItemJournalLine.Description := "Work Order No." + ' ' + 'PM Build Ahead';
            ItemJournalLine."Location Code" := 'COMMITTED';
            ItemJournalLine.Quantity := MoveInventoryQty;
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'IN PROCESS';
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code");

            IF SerialNo <> '' THEN BEGIN
                WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
                ItemJournalLine."Serial No." := SerialNo;
                ItemJournalLine."New Serial No." := SerialNo;
                SerialNo := '';
            END;


            PostLine.RUN(ItemJournalLine);

            ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
            ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
            IF ItemJournalClear.FIND('-') THEN
                REPEAT
                    ItemJournalClear.DELETE;
                UNTIL ItemJournalClear.NEXT = 0;
        END;
    end;

    procedure GetCurrentStatus(WONo: Code[20]): Integer
    begin
        // 2016_02_27 ADV - New function
        WOS.RESET;
        WOS.SETRANGE("Order No.", WONo);
        WOS.SETRANGE(Status, WOS.Status::Complete);
        IF WOS.FINDLAST THEN
            EXIT(WOS.Step.AsInteger())
        ELSE
            EXIT(-1);
    end;

    procedure DeletePartsInProcess()
    begin
        // 2/26/18 - New function
        ExistingParts.CALCFIELDS(ExistingParts."In-Process Quantity");

        IF ExistingParts."In-Process Quantity" > 0 THEN BEGIN
            ItemJournalLine.INIT;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
            ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Document No." := "Work Order No.";
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Item No." := ExistingParts."Part No.";
            ItemJournalLine.VALIDATE(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WORKDATE;
            ItemJournalLine.Description := "Work Order No." + ' ' + 'WOD RETURN PARTS';
            ItemJournalLine."Location Code" := 'IN PROCESS';
            ItemJournalLine.Quantity := ExistingParts."In-Process Quantity";
            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'MAIN';
            ItemJournalLine.VALIDATE(ItemJournalLine."New Location Code");
            ItemJournalLine.INSERT;

            PostLine.RUN(ItemJournalLine);

            ItemJournalClear.SETRANGE(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
            ItemJournalClear.SETRANGE(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
            IF ItemJournalClear.FIND('-') THEN
                REPEAT
                    ItemJournalClear.DELETE;
                UNTIL ItemJournalClear.NEXT = 0;
        END;
    end;

    procedure ClearSerialNo_(DocType: Integer; SourceRefNo: Integer; ItemNo: Code[20]): Boolean
    var
        ReservEntry: Record "Reservation Entry";

    begin
        ReservEntry.Reset();
        ReservEntry.SetRange("Source Type", DocType);
        ReservEntry.SetRange("Source Ref. No.", SourceRefNo);
        ReservEntry.SetRange("Item No.", ItemNo);

        if ReservEntry.FindSet() then begin
            // if entries found, delete them
            ReservEntry.DeleteAll();
            exit(true);
        end;

        // did not find entries
        exit(false);

    end;

    procedure SetSerialNo_(DocType: Integer; SalesDoc: Record "Sales Line"; PurchDoc: Record "Purchase Line"; SerialNo: Code[20]): Boolean
    var
        entryNo: Integer;
        ReservEntry: Record "Reservation Entry";
        PurchMessage: Label 'Purchase Reservation Entry not implemented. Contact Intelice.';

    begin
        Clear(ReservEntry);
        ReservEntry.Reset();
        if ReservEntry.FindLast() then
            entryNo := ReservEntry."Entry No." + 1
        else
            entryNo := 10000;
        ReservEntry.Init();
        ReservEntry."Entry No." := entryNo;

        case DocType of

            Database::"Sales Line":
                begin
                    ReservEntry.Positive := false;
                    ReservEntry."Item No." := SalesDoc."No.";
                    ReservEntry."Location Code" := SalesDoc."Location Code";
                    ReservEntry."Qty. per Unit of Measure" := SalesDoc."Qty. per Unit of Measure";
                    ReservEntry.Validate("Quantity (Base)", -1 * SalesDoc."Quantity (Base)");
                    //??? - should be simple Quantity??
                    ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                    ReservEntry."Creation Date" := WorkDate();
                    ReservEntry."Shipment Date" := SalesDoc."Shipment Date";
                    ReservEntry."Source Type" := DocType;
                    ReservEntry."Source Subtype" := 1;
                    ReservEntry."Source ID" := SalesDoc."Document No.";
                    ReservEntry."Source Ref. No." := SalesDoc."Line No.";
                    ReservEntry."Created By" := UserId;
                    ReservEntry.Quantity := -1 * SalesDoc.Quantity;
                    //ReservEntry.Validate("Quantity", SalesDoc.Signed(1) * ItemJnlLine."Quantity");

                    ReservEntry."Disallow Cancellation" := false;
                    ReservEntry.Correction := false;
                    ReservEntry."Item Tracking" := ReservEntry."Item Tracking"::"Serial No.";
                    ReservEntry."Serial No." := SerialNo;
                    ReservEntry."Untracked Surplus" := false;

                    ReservEntry.Insert();
                    exit(true);
                end;

            Database::"Purchase Line":
                begin
                    Error(PurchMessage);
                end;


        end;

        exit(false);
    end;

    procedure SetItemSerialNo_(DocType: Integer; ItemJnlLine: Record "Item Journal Line"; SerialNo: Code[20]): Boolean
    var
        entryNo: Integer;
        ReservEntry: Record "Reservation Entry";

    begin
        // 2021_01_11 Intelice
        Clear(ReservEntry);
        ReservEntry.Reset();
        if ReservEntry.FindLast() then
            entryNo := ReservEntry."Entry No." + 1
        else
            entryNo := 10000;
        ReservEntry.Init();
        ReservEntry."Entry No." := entryNo;

        case DocType of

            Database::"Item Journal Line":
                begin
                    //ReservEntry.Positive := false;
                    ReservEntry."Item No." := ItemJnlLine."Item No.";
                    ReservEntry."Location Code" := ItemJnlLine."Location Code";
                    ReservEntry.Validate("Quantity (Base)", ItemJnlLine.Signed(1) * ItemJnlLine."Quantity (Base)");
                    //ReservEntry."Quantity (Base)" := ItemJnlLine.Signed(1) * ReservEntry."Quantity (Base)";

                    // Should convert to Base first??
                    //??? - should be simple Quantity??

                    ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Prospect;
                    ReservEntry."Creation Date" := WorkDate();
                    //ReservEntry."Shipment Date" := ItemJnlLine."Shipment Date";
                    ReservEntry."Source Type" := DocType;
                    ReservEntry."Source Subtype" := ItemJnlLine."Entry Type".AsInteger();
                    ReservEntry."Source ID" := ItemJnlLine."Journal Template Name";
                    ReservEntry."Source Ref. No." := ItemJnlLine."Line No.";
                    ReservEntry."Created By" := UserId;
                    //ReservEntry.Quantity := ItemJnlLine.Quantity;
                    ReservEntry."Qty. per Unit of Measure" := ItemJnlLine."Qty. per Unit of Measure";
                    //ReservEntry.Quantity := ItemJnlLine.Signed(1) * ReservEntry.Quantity;
                    ReservEntry.Validate("Quantity", ItemJnlLine.Signed(1) * ItemJnlLine."Quantity");
                    if ReservEntry.Quantity > 0 then
                        ReservEntry.Positive := true
                    else
                        ReservEntry.Positive := false;
                    ReservEntry."Source Batch Name" := ItemJnlLine."Journal Batch Name";
                    ReservEntry."Disallow Cancellation" := false;
                    ReservEntry.Correction := false;
                    ReservEntry."Item Tracking" := ReservEntry."Item Tracking"::"Serial No.";
                    ReservEntry."Serial No." := SerialNo;
                    ReservEntry."New Serial No." := SerialNo;
                    ReservEntry."Untracked Surplus" := false;

                    ReservEntry.Insert();
                    exit(true);
                end;
        end;

        exit(false);
    end;

    procedure GetSerialNo_(DocType: Integer; SalesDoc: Record "Sales Line"; PurchDoc: Record "Purchase Line"; var SerialNo: Code[20]): Boolean
    var
        entryNo: Integer;
        ReservEntry: Record "Reservation Entry";
        PurchMessage: Label 'Purchase Reservation Entry not implemented. Contact Intelice.';

    begin

        ReservEntry.Reset();

        case DocType of

            Database::"Sales Line":
                begin
                    ReservEntry.SetRange("Source ID", SalesDoc."Document No.");
                    ReservEntry.SetRange("Source Ref. No.", SalesDoc."Line No.");
                    ReservEntry.SetRange("Item No.", SalesDoc."No.");
                    ReservEntry.SetRange("Item Tracking", ReservEntry."Item Tracking"::"Serial No.");
                    ReservEntry.SetRange("Source Type", DocType);

                    if ReservEntry.FindFirst() then begin
                        SerialNo := ReservEntry."Serial No.";
                        exit(true);
                    end;
                end;

            Database::"Item Ledger Entry":
                begin
                    ReservEntry.SetRange("Source ID", SalesDoc."Document No.");
                    ReservEntry.SetRange("Source Ref. No.", SalesDoc."Line No.");
                    ReservEntry.SetRange("Item No.", SalesDoc."No.");
                    ReservEntry.SetRange("Item Tracking", ReservEntry."Item Tracking"::"Serial No.");
                    ReservEntry.SetRange("Source Type", DocType);

                    if ReservEntry.FindFirst() then begin
                        SerialNo := ReservEntry."Serial No.";
                        exit(true);
                    end;
                end;

            Database::"Purchase Line":
                begin
                    //Error(PurchMessage);
                    ReservEntry.SetRange("Source ID", PurchDoc."Document No.");
                    ReservEntry.SetRange("Source Ref. No.", PurchDoc."Line No.");
                    ReservEntry.SetRange("Item No.", PurchDoc."No.");
                    ReservEntry.SetRange("Item Tracking", ReservEntry."Item Tracking"::"Serial No.");
                    ReservEntry.SetRange("Source Type", DocType);

                    if ReservEntry.FindFirst() then begin
                        SerialNo := ReservEntry."Serial No.";
                        exit(true);
                    end;
                end;


        end;

        exit(false);

    end;

    procedure SetOverrideConfirmation()
    var
        myInt: Integer;
    begin
        OverrideConfirmation := true;
    end;

    var
        User: Record User;
        WOD: Record WorkOrderDetail;
        Window: Dialog;
        WorkOrderDetail: Record WorkOrderDetail;
        WorkOrderMaster: Record WorkOrderMaster;
        Ok: Boolean;
        PartsList: Record 50003;
        item: Record Item;
        BOM: Record "BOM Component";
        Item2: Record Item;
        Resource: Record Resource;
        Parts: Record Parts;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        WOS: Record Status;
        WOS2: Record Status;
        ExistingParts: Record Parts;
        PTTest: Code[10];
        RecordCount: Integer;
        WODH: Record DeletedWorkOrders;
        OrderReason: Text[100];
        "Qty Available": Decimal;
        FillOrderQty: Decimal;
        BackOrderQty: Decimal;
        SalesHeader: Record "Sales Header";
        SalesHeaderDupCheck: Record "Sales Header";
        WODDupCheck: Record WorkOrderDetail;
        SalesLine: Record "Sales Line";
        Agent: Record "Shipping Agent";
        Duplicate: Boolean;
        SalesOrder: Code[20];
        WorkOrder: Code[20];
        xSO: Code[20];
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        CompleteParts: Record Parts;
        PartCode: Code[10];
        Terms: Code[10];
        CustTerms: Code[10];
        Cust: Record Customer;
        ModuleParts: Record Parts;
        ModuleDetail: Record WorkOrderDetail;
        PMWorkOrder: Boolean;
        PMOrder: Code[20];
        MoveInventoryQty: Decimal;
        SerialNo: Code[20];
        QuotedQty: Code[10];
        SerialNoFound: Code[10];
        Mechanics: Record QuoteMechanicsParts;
        DateIn: Date;
        DateOut: Date;
        Person: Code[10];
        Regular: Decimal;
        Overtime: Decimal;
        PartsMarkup: Decimal;
        OverrideConfirmation: Boolean;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    trigger OnInsert()
    begin
        // 2015/08/01 ADV Start
        IF "Work Order No." = '' THEN BEGIN
            ERROR('Cannot add a record with empty Order No.');
        END;
        // 2015/08/01 ADV End
        if NOT OverrideConfirmation THEN begin
            ;
            IF CONFIRM('Do you want to add another Detail?') THEN
                Ok := TRUE
            ELSE
                ERROR('');
        end;
    end;

    trigger OnModify()
    begin
        //IF xRec.Complete = TRUE THEN
        //  ERROR('This Work Order is complete.  No changes can be made to this record');

        //"Last User Modified" := USERID;    begin
    end;

    trigger OnDelete()
    begin
        WOS.SETCURRENTKEY(WOS."Order No.", WOS.Step);
        WOS.SETRANGE(WOS."Order No.", "Work Order No.");
        WOS.SETRANGE(WOS.Step, WOS.Step::RCV);
        IF WOS.FIND('-') THEN
            ERROR('Pump has already been received. You may not delete this record!');

        WorkOrderDetail.GET("Work Order No.");

        WODH.RESET;
        WODH.INIT;
        WODH.TRANSFERFIELDS(WorkOrderDetail);
        WODH."Deletion Date" := WORKDATE;
        // WODH."Reason Deleted" := ;     //Harlen will insert code for Deletion Reason
        WODH.INSERT;

        WorkOrderDetail."Work Order No." := ''
    end;

    trigger OnRename()
    begin

    end;

}