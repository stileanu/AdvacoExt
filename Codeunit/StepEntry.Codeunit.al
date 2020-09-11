codeunit 50001 "Step Entry"
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########', WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN)
        else
            exit;
        IF WODN <> '' THEN BEGIN
            WOD.SETCURRENTKEY(WOD."Work Order No.");
            IF WOD.GET(WODN) THEN BEGIN
                WOM.GET(WOD."Work Order Master No.");
                ReverseBuildAhead;
                IF WOD.Complete THEN BEGIN
                    IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::" " THEN BEGIN
                        MESSAGE('The Work Order was shipped');
                        OpenNextRecord;
                    END;
                    IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Un-Assembled" THEN BEGIN
                        MESSAGE('The Work Order was shipped Un-Assembled');
                        OpenNextRecord;
                    END;
                    IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Assembled" THEN BEGIN
                        MESSAGE('The Work Order was shipped Assembled');
                        OpenNextRecord;
                    END;
                    IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Save Parts & Scrap" THEN BEGIN
                        MESSAGE('The Pump was Scrapped & Parts Saved');
                        OpenNextRecord;
                    END;
                    IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::Scrap THEN BEGIN
                        MESSAGE('The Pump was Scrapped');
                        OpenNextRecord;
                    END;
                    IF WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return to Vendor" THEN BEGIN
                        MESSAGE('The Pump was Returned to the Vendor');
                        OpenNextRecord;
                    END;

                END ELSE BEGIN
                    WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
                    WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
                    IF WOS.FIND('+') THEN BEGIN
                        BlockCheck;
                        IF Continue THEN BEGIN
                            Found;
                        END ELSE BEGIN
                            OpenNextRecord;
                        END;
                    END ELSE
                        NotFound;
                END;
            END ELSE BEGIN
                MESSAGE('Work Order Detail %1 not found', WODN);
                NextRecord.RUN;
            END;
        END ELSE BEGIN
            MESSAGE('You must enter a number.');
            NextRecord.RUN;
        END;
    end;

    var
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        WOS3: Record Status;
        Mechanic: Record Status;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;

        WODN: Code[50];
        ///--! ParentWindow: Page "Model Card";
        ///--! CurrentWindow: Page "Model Card";
        NextRecord: Codeunit "Step Entry";
        UTI: Text[20];
        Ok: Boolean;
        Parts: Record Parts;
        CurrentStep: Enum DetailStep;
        // : Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        NewStep: Enum DetailStep;
        //NewStep : Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        Customer: Record Customer;
        Continue: Boolean;
        Failure: Record "Order Defects";
        Failure2: Record "Order Defects";
        Failure3: Record "Order Defects";
        NewNumber: Integer;
        Complete: Boolean;
        WONo: Code[10];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLineNo: Integer;
        ShipTo: Record "Ship-to Address";
        GPS: Record "General Posting Setup";
        SO: Code[10];
        PartsComplete: Record Parts;
        Tech: Code[10];
        //ADOconn : Automation "{00000205-0000-0010-8000-00AA006D2EA4} 2.5:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.5 Library'.Connection";
        //ADOrs : Automation "{00000205-0000-0010-8000-00AA006D2EA4} 2.5:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.5 Library'.Recordset";
        ConnStr: Text[200];
        AnzCount: Text[30];
        OpenMethod: Integer;
        LockMethod: Integer;
        Name: Text[200];
        Str: Text[200];
        strpath: Text[200];
        strOpen: Text[200];
        strtable: Text[200];
        WODModelType: Record WorkOrderDetail;

    procedure NotFound();
    begin
        WOS2.INIT;
        WOS2."Order No." := WOD."Work Order No.";
        WOS2."Line No." := WOS."Line No." + 10000;
        WOS2.Step := WOS2.Step::RCV;
        WOS2."Date In" := WORKDATE;
        WOS2.Status := WOS2.Status::Waiting;
        WOS2.INSERT;
        COMMIT;
        WOS2.SETRANGE(WOS2.Step, WOS2.Step);
        PAGE.RUNMODAL(50009, WOS2);
        WOS2.SETCURRENTKEY(WOS2."Order No.", WOS2."Line No.");
        WOS2.SETRANGE(WOS2."Order No.", WOD."Work Order No.");
        IF WOS2.FIND('+') THEN BEGIN
            IF WOS2.Status = WOS2.Status::Complete THEN BEGIN
                WOS3.INIT;
                WOS3."Order No." := WOD."Work Order No.";
                WOS3."Line No." := WOS2."Line No." + 10000;
                WOS3.Step := WOS3.Step::DIS;
                WOS3."Date In" := WOS2."Date Out";
                WOS3.Status := WOS3.Status::Waiting;
                WOS3.INSERT;
                /*
                //Find path to Model Database
                Pathlocator;

                IF strpath <> '' THEN BEGIN
                  //Create Failure Analysis Record in Access Database
                  // Test ODBC-Connector
                  OpenMethod := 2; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
                  LockMethod := 3; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic
                  CREATE(ADOconn);
                  ConnStr := 'PROVIDER=Microsoft.Jet.OLEDB.4.0; Data Source=' + strpath;
                  ADOconn.Open(ConnStr);
                  CREATE(ADOrs);
                  strOpen := 'select * from ' + strtable;
                  ADOrs.Open(strOpen,ADOconn,OpenMethod,LockMethod);

                  // Insert new Data
                  ADOrs.AddNew('WorkOrder', WOD."Work Order No.");
                  ADOrs.Update('Model',WOD."Model No.");
                  ADOrs.Update('Serial',WOD."Serial No.");
                  ADOrs.Update('Description',WOD.Description);

                  ADOrs.Close;
                  ADOconn.Close;
                  CLEAR(ADOrs);
                  CLEAR(ADOconn);
              END;
              */
            END ELSE BEGIN
                IF (WOS2.Employee = '') AND (WOS2."Regular Hours" = 0) THEN BEGIN
                    WOS2.DELETE;
                END;
            END;
            COMMIT;

            OpenNextRecord;
        END;

    end;

    procedure Found();
    begin
        IF (WOS.Step = WOS.Step::DIS) AND (WOD."Vendor Repair") THEN
            "Vendor Return"
        ELSE
            IF WOS.Step = WOS.Step::QOT THEN
                Quote
            ELSE
                IF WOS.Step = WOS.Step::"B-O" THEN
                    BackOrder
                ELSE
                    IF (WOS.Step = WOS.Step::QC) AND (WOD.BackorderText <> '') AND (WOD."Unrepairable BuildAhead" = FALSE) THEN
                        QCBACKORDER
                    ELSE
                        IF (WOS.Step = WOS.Step::QC) AND (WOD.BackorderText = '') AND (WOD."Unrepairable BuildAhead" = FALSE) THEN
                            QC
                        ELSE
                            IF WOS.Step <> WOS.Step::SHP THEN BEGIN
                                IF WOD."Unrepairable BuildAhead" = TRUE THEN
                                    UNREPAIRABLE
                                ELSE
                                    PreShipping;
                            END ELSE BEGIN
                                Shipping;
                            END;
    end;

    procedure "Vendor Return"();
    begin
        WOD.RESET;
        WOD.SETCURRENTKEY(WOD."Work Order Master No.");
        WOD.SETRANGE(WOD."Work Order No.", WOS."Order No.");
        PAGE.RUNMODAL(50032, WOD);
        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
        WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
        IF WOS.FIND('+') THEN BEGIN
            IF WOS.Status = WOS.Status::Complete THEN BEGIN
                WOS3.INIT;
                WOS3."Order No." := WOS."Order No.";
                WOS3."Line No." := WOS."Line No." + 10000;
                WOS3.Step := DetailStep.FromInteger(WOS.Step.AsInteger() + 1);
                WOS3."Date In" := WOS."Date Out";
                WOS3.Employee := 'UNK';
                WOS3."Regular Hours" := 1 / 100;
                WOS3.Status := WOS2.Status::Waiting;
                WOS3.INSERT;
            END;
        END;

        OpenNextRecord;
    end;

    procedure PreShipping();
    begin
        PAGE.RUNMODAL(50009, WOS);
        WOS.SETCURRENTKEY(WOS."Order No.", WOS."Line No.");
        WOS.SETRANGE(WOS."Order No.", WOD."Work Order No.");
        IF WOS.FIND('+') THEN BEGIN
            IF WOS."Skip Step" = FALSE THEN BEGIN
                IF WOS.Status = WOS.Status::Complete THEN BEGIN

                    //Enter Pass Fail Information from Test System
                    IF (WOS.Step = WOS.Step::TST) OR (WOS.Step = WOS.Step::RET) THEN BEGIN
                        IF NOT CONFIRM('Did the Pump pass the Test?', FALSE) THEN BEGIN
                            PumpFailed;
                        END ELSE BEGIN
                            PumpPassed;
                        END;
                    END;

                    //QC Defects
                    IF (WOS.Step = WOS.Step::QC) THEN BEGIN
                        IF CONFIRM('Any Defects discovered during Final Inspection?', FALSE) THEN BEGIN
                            QCDefects;
                        END ELSE BEGIN
                            InsertNextStep;
                        END;
                    END ELSE BEGIN
                        IF (WOS.Step <> WOS.Step::TST) OR (WOS.Step <> WOS.Step::RET) THEN
                            InsertNextStep;
                    END;
                END ELSE BEGIN
                    OpenNextRecord;
                END;
            END ELSE BEGIN
                SkipStepRoutine;
            END;
        END;
    end;

    procedure Shipping();
    begin
        MESSAGE('This Work Order Detail is in Shipping');
        COMMIT;
        OpenNextRecord;
    end;

    procedure Quote();
    begin
        MESSAGE('This Work Order Detail is in Quote Status');
        COMMIT;
        NextRecord.RUN;
    end;

    procedure BackOrder();
    begin

        MESSAGE('This Work Order Detail is in Back Order Status');
        COMMIT;
        NextRecord.RUN;
    end;

    procedure PumpPassed();
    begin
        IF WOD.GET(WOS."Order No.") THEN BEGIN
            PAGE.RUNMODAL(50043, WOD);
        END;

        WOS.Passed := TRUE;

        IF WOS."Date Out" < 99990101D THEN BEGIN
            WOS."Date Out" := WORKDATE;
            WOS.MODIFY;
        END;

        COMMIT;
        WOS3.INIT;
        WOS3."Order No." := WOS."Order No.";
        WOS3."Line No." := WOS."Line No." + 10000;
        WOS3.Step := WOS.Step::MSP;
        WOS3."Date In" := WOS."Date Out";
        WOS3.Status := WOS3.Status::Waiting;
        WOS3.INSERT;
        OpenNextRecord;
    end;

    procedure PumpFailed();
    begin
        COMMIT;
        NewNumber := 10;
        //Determine The Occurence No. for the Next Record Saved
        Failure.SETRANGE(Failure."Order No.", WOS."Order No.");
        Failure.SETRANGE(Failure.Department, Failure.Department::"Production Assembly");
        IF Failure.FIND('-') THEN BEGIN
            REPEAT
                IF Failure.Occurrence > NewNumber THEN
                    NewNumber := ROUND(Failure.Occurrence, 10, '<');
            UNTIL Failure.NEXT = 0;

            NewNumber := NewNumber + 10;
            Mechanic.SETRANGE(Mechanic."Order No.", WOS."Order No.");
            Mechanic.SETFILTER(Mechanic.Step, 'REP');
            IF Mechanic.FIND('+') THEN BEGIN
                Tech := Mechanic.Employee;
            END;
        END ELSE BEGIN
            Mechanic.SETRANGE(Mechanic."Order No.", WOS."Order No.");
            Mechanic.SETFILTER(Mechanic.Step, 'ASM');
            IF Mechanic.FIND('+') THEN BEGIN
                Tech := Mechanic.Employee;
            END;
        END;

        Failure2.INIT;
        Failure2.Occurrence := NewNumber;
        Failure2."Order No." := WOS."Order No.";
        Failure2.Department := Failure2.Department::"Production Assembly";
        Failure2."Model No." := WOD."Model No.";
        Failure2.Date := WOS."Date Out";
        Failure2.Technician := Tech;
        Failure2.INSERT;
        COMMIT;
        PAGE.RUNMODAL(50028, Failure2);
        COMMIT;

        //Validate the Test Code entered for the WorkOrder
        DefectCodeComplete;

        WOS3.INIT;
        WOS3."Order No." := WOS."Order No.";
        WOS3."Line No." := WOS."Line No." + 10000;
        WOS3.Step := WOS3.Step::REP;
        WOS3."Date In" := WOS."Date Out";
        WOS3.Status := WOS3.Status::Waiting;
        WOS3.INSERT;
        IF WOS."Date Out" < 99990101D THEN BEGIN
            WOS."Date Out" := WORKDATE;
            WOS.MODIFY;
        END;
        OpenNextRecord;
    end;

    procedure DefectCodeComplete();
    begin
        Failure3.GET(Failure2.Occurrence, Failure2."Order No.");
        IF Failure3."Defect Code" = '' THEN BEGIN
            MESSAGE('You must complete the Failure Item & Code before Completing the Step');
            IF Failure3.Department = Failure3.Department::"Production Assembly" THEN
                PAGE.RUNMODAL(50028, Failure3);
            IF Failure3.Department = Failure3.Department::"Quality Control" THEN
                PAGE.RUNMODAL(50029, Failure3);
            COMMIT;
            DefectCodeComplete;
        END;

        Failure3.GET(Failure2.Occurrence, Failure2."Order No.");
        IF Failure3.Category = Failure3.Category::" " THEN BEGIN
            MESSAGE('You must enter the Category before Completing the Step');
            IF Failure3.Department = Failure3.Department::"Production Assembly" THEN
                PAGE.RUNMODAL(50028, Failure3);
            IF Failure3.Department = Failure3.Department::"Quality Control" THEN
                PAGE.RUNMODAL(50029, Failure3);
            COMMIT;
            DefectCodeComplete;
        END;
    end;

    procedure InsertNextStep();
    begin
        IF WOS.Step = WOS.Step::ASM THEN BEGIN
            WOD.GET(WOS."Order No.");
            IF WOD.Quote = WOD.Quote::"Not Repairable" THEN BEGIN
                IF (WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Un-Assembled") OR
                   (WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Assembled") OR
                   (WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return to Vendor")
                   THEN BEGIN
                    WOS3.INIT;
                    WOS3."Order No." := WOS."Order No.";
                    WOS3."Line No." := WOS."Line No." + 10000;
                    WOS3.Step := WOS.Step::SHP;
                    WOS3."Date In" := WOS."Date Out";
                    WOS3.Status := WOS2.Status::Waiting;
                    WOS3.INSERT;
                END ELSE BEGIN
                    WOD.Complete := TRUE;
                    WOD."Ship Date" := WOS."Date Out";
                    WOD.MODIFY;
                    UpdateParts;
                    IF (WOD."Unrepairable Charge" > 0) OR (WOD."Freightin Bill Customer" = TRUE) THEN BEGIN
                        SalesLineNo := 10000;
                        CreateOrder;
                        URCreatelines;
                    END;
                END;
            END ELSE BEGIN
                WOS3.INIT;
                WOS3."Order No." := WOS."Order No.";
                WOS3."Line No." := WOS."Line No." + 10000;
                WOS3.Step := DetailStep.FromInteger(WOS.Step.AsInteger() + 1);
                WOS3."Date In" := WOS."Date Out";
                WOS3.Status := WOS2.Status::Waiting;
                WOS3.INSERT;
            END;
        END ELSE BEGIN
            WOS3.INIT;
            WOS3."Order No." := WOS."Order No.";
            WOS3."Line No." := WOS."Line No." + 10000;
            WOS3.Step := DetailStep.FromInteger(WOS.Step.AsInteger() + 1);
            WOS3."Date In" := WOS."Date Out";
            WOS3.Status := WOS2.Status::Waiting;
            WOS3.INSERT;
        END;

        OpenNextRecord;
    end;

    procedure SkipStepRoutine();
    begin

        CurrentStep := WOS.Step;
        NewStep := DetailStep.FromInteger(WOS.Step.AsInteger() + 1);
        IF (WOS.Step <> WOS.Step::TST) AND (WOS.Step <> WOS.Step::REP) AND (WOS.Step <> WOS.Step::RET) AND
           (WOS.Step <> WOS.Step::QC) AND (WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::" ")
          THEN BEGIN
            IF NOT CONFIRM('Are you sure you want to skip from %1 to %2 Step', FALSE, CurrentStep, NewStep) THEN BEGIN
                WOS."Skip Step" := FALSE;
                WOS.MODIFY;
                OpenNextRecord;
            END ELSE BEGIN
                WOS.Step := NewStep;
                WOS."Regular Hours" := 0.00;
                WOS."Overtime Hours" := 0.00;
                WOS.Employee := '';
                WOS.Status := WOS.Status::Waiting;
                WOS."Skip Step" := FALSE;
                WOS.MODIFY;
                OpenNextRecord;
            END;
        END ELSE BEGIN
            WOS."Skip Step" := FALSE;
            WOS.MODIFY;
            MESSAGE('You cannot skip %1', CurrentStep);
            OpenNextRecord;
        END;
    end;

    procedure OpenNextRecord();
    begin
        IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
            COMMIT;
            EXIT;
        END ELSE BEGIN
            COMMIT;
            NextRecord.RUN
        END;
    end;

    procedure BlockCheck();
    begin
        Continue := TRUE;
        IF Customer.GET(WOM.Customer) THEN BEGIN
            IF Customer.Blocked <> Customer.Blocked::" " THEN BEGIN
                IF WOD.Unblocked = FALSE THEN BEGIN
                    MESSAGE('This Work Order Detail is currently Blocked.  Please see Accounting');
                    Continue := FALSE;
                END;
            END;
        END;
    end;

    procedure ReverseBuildAhead();
    begin
        IF WOD."Reverse Build Ahead" THEN BEGIN
            MESSAGE('Work Order %1 is now a Vendor Repair, Please Notify the Parts Department to Return Parts.', WODN);
            Continue := FALSE;
        END;
    end;

    procedure QCBACKORDER();
    begin
        MESSAGE('Some Parts are Backordered or not Pulled, Please Contact the Parts Department to Update System');
        OpenNextRecord;
    end;

    procedure QC();
    begin
        WOS2.SETCURRENTKEY(WOS2."Order No.", WOS2."Line No.");
        WOS2.SETRANGE(WOS2."Order No.", WOD."Work Order No.");
        IF WOS2.FIND('-') THEN BEGIN
            REPEAT
                IF WOS2.Step = WOS2.Step::QOT THEN BEGIN
                    IF WOS2.Status = WOS2.Status::Waiting THEN
                        Complete := FALSE
                    ELSE
                        Complete := TRUE;
                END;
            UNTIL WOS2.NEXT = 0;
        END;

        IF Complete = TRUE THEN BEGIN
            Complete := FALSE;
            PreShipping;
        END ELSE BEGIN
            MESSAGE('The Work Order hasn''t been Released from Quote, Please Contact Sales to Update System');
            OpenNextRecord;
        END;
    end;

    procedure QCDefects();
    begin
        COMMIT;
        NewNumber := 110;
        //Determine The Occurence No. for the Next Record Saved
        Failure.SETRANGE(Failure."Order No.", WOS."Order No.");
        Failure.SETRANGE(Failure.Department, Failure.Department::"Quality Control");
        IF Failure.FIND('-') THEN BEGIN
            REPEAT
                IF Failure.Occurrence > NewNumber THEN
                    NewNumber := ROUND(Failure.Occurrence, 10, '<');
            UNTIL Failure.NEXT = 0;
            NewNumber := NewNumber + 10;
        END;

        Failure2.INIT;
        Failure2.Occurrence := NewNumber;
        Failure2."Order No." := WOS."Order No.";
        Failure2.Department := Failure2.Department::"Quality Control";
        Failure2."Model No." := WOD."Model No.";
        Failure2.Date := WOS."Date Out";
        Failure2.INSERT;
        COMMIT;
        PAGE.RUNMODAL(50029, Failure2);
        COMMIT;

        //Validate the Test Code entered for the WorkOrder
        DefectCodeComplete;

        WOS3.INIT;
        WOS3."Order No." := WOS."Order No.";
        WOS3."Line No." := WOS."Line No." + 10000;
        WOS3.Step := WOS3.Step::SHP;
        WOS3."Date In" := WOS."Date Out";
        WOS3.Status := WOS3.Status::Waiting;
        WOS3.INSERT;
        IF WOS."Date Out" < 99990101D THEN BEGIN
            WOS."Date Out" := WORKDATE;
            WOS.MODIFY;
        END;
        OpenNextRecord;
    end;

    procedure UNREPAIRABLE();
    begin
        MESSAGE('The Work Order is a Build Ahead Unrepairable & the Re-Usable Parts Need to be Returned, Contact the Parts Department');
        OpenNextRecord;
    end;

    procedure InitSalesHeaderRecord();
    begin
        IF (SalesHeader."No. Series" <> '') AND
           (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
        THEN
            SalesHeader."Posting No. Series" := SalesHeader."No. Series"
        ELSE
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
        IF SalesSetup."Shipment on Invoice" THEN
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
    end;

    procedure CreateOrder();
    begin

        CLEAR(SalesHeader);

        SalesHeader.INIT;
        SalesSetup.GET;

        IF SalesHeader."No." = '' THEN BEGIN
            // INSERTED 3/21/01 HEF
            IF SO <> '' THEN
                SalesHeader."No." := SO
            ELSE
                SalesHeader."No." := WOD."Work Order No.";
        END;

        // BOL FIX
        // HEF  NoSeriesMgt.InitSeries
        // HEF  (SalesSetup."Order Nos.",SalesHeader."No. Series",TODAY,SalesHeader."No.",SalesHeader."No. Series");

        InitSalesHeaderRecord;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.VALIDATE("Sell-to Customer No.", WOM.Customer);
        ShipTo.GET(SalesHeader."Sell-to Customer No.", WOM."Ship To Code");
        SalesHeader.VALIDATE("Posting Date", TODAY);
        SalesHeader."Order Date" := WOD."Work Order Date";
        SalesHeader."Ship-to Code" := WOM."Ship To Code";
        SalesHeader."Ship-to Name" := WOD."Ship To Name";
        SalesHeader."Ship-to Address" := WOD."Ship To Address 1";
        SalesHeader."Ship-to Address 2" := WOD."Ship To Address 2";
        SalesHeader."Ship-to City" := WOD."Ship To City";
        SalesHeader."Ship-to County" := WOD."Ship To State";
        SalesHeader."Ship-to Post Code" := WOD."Ship To Zip Code";
        SalesHeader."Ship-to Contact" := WOD.Attention;
        SalesHeader."Document Date" := TODAY;
        SalesHeader."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
        SalesHeader."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
        SalesHeader.Rep := ShipTo.Rep;
        SalesHeader."Salesperson Code" := ShipTo."Inside Sales";
        SalesHeader."Payment Terms Code" := WOD."Payment Terms";
        SalesHeader."Card Type" := WOD."Card Type";
        SalesHeader."Credit Card No." := WOD."Credit Card No.";
        SalesHeader."Credit Card Exp." := WOD."Credit Card Exp.";
        SalesHeader."Approval Code" := WOD."Approval Code";
        SalesHeader."Shipment Date" := TODAY;
        SalesHeader."Shipment Method Code" := '';
        SalesHeader."Shipping Agent Code" := '';
        SalesHeader."Shipping Charge" := SalesHeader."Shipping Charge"::" ";
        SalesHeader."Shipping Account" := '';
        SalesHeader."Package Tracking No." := '';
        SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Complete;
        SalesHeader."Your Reference" := WOD."Customer PO No.";

        IF WOD."Tax Liable" = TRUE THEN BEGIN
            SalesHeader."Tax Liable" := TRUE;
            SalesHeader."Tax Area Code" := 'MD';
        END ELSE BEGIN
            SalesHeader."Tax Liable" := FALSE;
            SalesHeader."Tax Area Code" := '';
        END;

        IF Customer.GET(SalesHeader."Sell-to Customer No.") THEN BEGIN
            IF WOD."Tax Liable" = FALSE THEN BEGIN
                SalesHeader."Tax Exemption No." := Customer."Tax Exemption No.";
                SalesHeader."Exempt Organization" := Customer."Exempt Organization";
            END;
        END ELSE BEGIN
            SalesHeader."Tax Exemption No." := '';
            SalesHeader."Exempt Organization" := '';
        END;

        SalesHeader."Shortcut Dimension 1 Code" := 'WO';
        SalesHeader.INSERT;
    end;

    procedure URCreatelines();
    begin
        IF (WOD."Unrepairable Charge" > 0) OR (WOD."Freightin Bill Customer" = TRUE) THEN BEGIN

            //>> Work Order No. & Order Type
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.VALIDATE("No.", '');
            SalesLine.Description := WOD."Work Order No." + ' ' + FORMAT(WOD."Order Type");
            // + 'Total Price: ' + FORMAT(ROUND(WOD."Quote Price")); //REMOVED PER BLF 6/12/01
            SalesLine."Commission Calculated" := FALSE;
            ///--! SalesLine."Cross Reference Item" := WOD."Model No.";
            SalesLine.INSERT;

            //>> Description
            IF WOD.Description <> '' THEN BEGIN
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.VALIDATE("No.", '');
                SalesLine.Description := WOD.Description;
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.INSERT;
            END;

            //>> Serial No. Info
            IF WOD."Serial No." <> '' THEN BEGIN
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.VALIDATE("No.", '');
                SalesLine.Description := 'S/N' + ' ' + WOD."Serial No.";
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.INSERT;
            END;

            //>>Customer Part Number
            IF WOD."Customer Part No." <> '' THEN BEGIN
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.VALIDATE("No.", '');
                SalesLine.Description := 'Customer P/N' + ' ' + WOD."Customer Part No.";
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.INSERT;
            END;


            //UnRepairable Charge
            IF WOD."Unrepairable Charge" > 0 THEN BEGIN
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                GPSLoop;
                SalesLine.VALIDATE(Quantity, 1);
                SalesLine.Description := 'UnRepairable Charge';
                SalesLine."Unit Price" := WOD."Unrepairable Charge";
                SalesLine.VALIDATE("Unit Price");
                SalesLine."Commission Calculated" := TRUE;
                SalesLine.INSERT;
            END;

            //InBound Freight Charge
            IF WOD."Freightin Bill Customer" = TRUE THEN BEGIN
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine.VALIDATE("No.", '312');   //Sales Account
                SalesLine.VALIDATE(Quantity, 1);
                SalesLine.Description := 'Inbound Freight Charge';
                SalesLine.VALIDATE("Unit Price", WOD.Freightin);
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.INSERT;
            END;
        END;
    end;

    procedure LineLoop();
    begin
        CLEAR(SalesLine);
        SalesLineNo := SalesLineNo + 10000;
        SalesLine.INIT;
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Line No." := SalesLineNo;
        SalesLine.VALIDATE(SalesLine."Document No.", SalesHeader."No.");
    end;

    procedure GPSLoop();
    begin
        IF (WOD."Income Code" = WOD."Income Code"::Cryo) THEN BEGIN
            GPS.GET('', 'REPAIR');
            SalesLine.VALIDATE("No.", GPS."Sales Account");   //Sales Account
        END;
        IF (WOD."Income Code" = WOD."Income Code"::Dry) THEN BEGIN
            GPS.GET('', 'PP SALES');
            SalesLine.VALIDATE("No.", GPS."Sales Account");   //Sales Account
        END;
        IF (WOD."Income Code" = WOD."Income Code"::Electronic) THEN BEGIN
            GPS.GET('', 'TURBO');
            SalesLine.VALIDATE("No.", GPS."Sales Account");   //Sales Account
        END;
        IF (WOD."Income Code" = WOD."Income Code"::Sales) THEN BEGIN
            GPS.GET('', 'ELECTRONIC');
            SalesLine.VALIDATE("No.", GPS."Sales Account");   //Sales Account
        END;
        IF (WOD."Income Code" = WOD."Income Code"::Service) THEN BEGIN
            GPS.GET('', 'DRY PUMP');
            SalesLine.VALIDATE("No.", GPS."Sales Account");   //Sales Account
        END;
        IF (WOD."Income Code" = WOD."Income Code"::Turbo) THEN BEGIN
            GPS.GET('', 'CRYO');
            SalesLine.VALIDATE("No.", GPS."Sales Account");   //Sales Account
        END;
    end;

    procedure UpdateParts();
    begin
        PartsComplete.SETCURRENTKEY("Work Order No.", "Part No.");
        PartsComplete.SETRANGE(PartsComplete."Work Order No.", WOD."Work Order No.");
        IF PartsComplete.FIND('-') THEN BEGIN
            REPEAT
                PartsComplete.Complete := TRUE;
                PartsComplete.MODIFY;
            UNTIL PartsComplete.NEXT = 0;
        END;
    end;

    procedure Pathlocator();
    begin

        CASE WOD."Model Type" OF

            WOD."Model Type"::" ":
                BEGIN
                    strpath := '';
                    strtable := '';
                END;

            WOD."Model Type"::Blower:
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Blower Pump.mdb';
                    strtable := '[Blower pump]';
                END;

            WOD."Model Type"::"Cryo Compressor":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Cryo Compressor.mdb';
                    strtable := '[Cryo Compressor]';
                END;

            WOD."Model Type"::"Cryo Pump":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Cryopump.mdb';
                    strtable := 'Cryopump';
                END;

            WOD."Model Type"::"Diffusion Pump":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Diffusion Pump.mdb';
                    strtable := '[Diffusion pump]';
                END;

            WOD."Model Type"::"Dry Pump - Ebara":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Ebara Dry Pump.mdb';
                    strtable := '[Ebara DP]';
                END;

            WOD."Model Type"::"Dry Pump - Edwards":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Edwards Dry Pump.mdb';
                    strtable := '[Edwards DP]';
                END;

            WOD."Model Type"::"Dry Pump - Leybold":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Leybold Dry Pump.mdb';
                    strtable := '[Leybold DP]';
                END;

            WOD."Model Type"::"Filter System":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Filter System.mdb';
                    strtable := '[Alcatel DE1]';
                END;

            WOD."Model Type"::"Leak Detector":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Leak Detector.mdb';
                    strtable := '[Leak Detector]';
                END;

            WOD."Model Type"::"Mechanical Pump":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Vacuum-Mechanical Pump.mdb';
                    WODModelType.SETRANGE("Work Order No.", WOD."Work Order No.");
                    WODModelType.SETFILTER("Model No.", '%1|%2', '*212*', '*412*');
                    IF WODModelType.FIND('-') THEN BEGIN
                        strtable := '[Stokes 412 FAR]';
                    END ELSE BEGIN
                        strtable := '[Mechanical Pump]';
                    END;
                END;

            WOD."Model Type"::"Scroll Pump":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Scroll Pump.mdb';
                    strtable := '[Turbo pump]';
                END;

            WOD."Model Type"::"Turbo Controller":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Turbo Controller.mdb';
                    strtable := '[Turbo pump controller]';
                END;

            WOD."Model Type"::"Turbo Pump":
                BEGIN
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Turbo Pump.mdb';
                    strtable := '[Turbo pump]';
                END;
        END;
    end;
}

