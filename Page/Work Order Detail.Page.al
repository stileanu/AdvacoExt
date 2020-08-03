page 50002 "Work Order Detail"
{
    // 05/22/12 ADV
    //   Made "Labor Hours Quoted", Variance and "Order Adj." focusable, to allow Copy and Paste actions on values
    // 
    // 12/07/12 ADV
    //   Modify the caption of RD field to read PID, per Trisha request.
    // 
    // 2016_02_27 ADV
    //   Added new control - <Initial Order Type> to show the original Order Type field.
    // 
    // 2018_03_31
    //   Corrected sequence of controls on Other tab to jump from Shipping Charge to Container Saved checkbox.
    // 
    // 2018_04_01
    //   Corrected sequence of controls for all controls of the pages, on all tabs.
    // 
    // 04/16/18
    //   Transformed Saved Container control from check box to option (blank,yes,no).

    InsertAllowed = false;
    PageType = Card;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1220060124)
            {
                ShowCaption = false;
                grid(Control1220060123)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060122)
                    {
                        ShowCaption = false;
                        field("Work Order No."; "Work Order No.")
                        {
                            Editable = false;
                        }
                        field("Customer ID"; "Customer ID")
                        {
                            Caption = 'Customer';
                            Editable = false;
                        }
                        field("WOM.""Date Ordered"""; WOM."Date Ordered")
                        {
                            Caption = 'Order Date';
                            Editable = false;
                        }
                    }
                }
            }
            group(General)
            {
                group(Control1220060119)
                {
                    ShowCaption = false;
                    field("Order Type"; "Order Type")
                    {

                        trigger OnValidate()
                        begin
                            if xRec."Order Type" <> "Order Type" then begin
                                WOS.SetCurrentKey(WOS."Order No.", WOS.Step);
                                WOS.SetRange(WOS.Step, WOS.Step::QOT);
                                WOS.SetRange(WOS."Order No.", "Work Order No.");
                                if WOS.Find('-') then
                                    Error('The Work Order is Past Disassembly, and the Order Type can''t be modified by the Sales Department');
                            end;
                        end;
                    }
                    field("Initial Order Type"; "Initial Order Type")
                    {
                        Editable = InitialWorkOrderTypeEditable;
                    }
                    field("Non Copper"; "Non Copper")
                    {
                        Caption = 'INTEL Non Copper';
                        Editable = NonCopperEditable;
                    }
                    field("System Shipment"; "System Shipment")
                    {
                    }
                    field("Detail No."; "Detail No.")
                    {
                        Editable = false;
                    }
                    field("Model No."; "Model No.")
                    {
                    }
                    field(Description; Description)
                    {
                        Editable = false;
                    }
                    field("Model Type"; "Model Type")
                    {
                    }
                    field("Serial No."; "Serial No.")
                    {
                    }
                    field("Tool ID"; "Tool ID")
                    {
                    }
                    field("Customer Part No."; "Customer Part No.")
                    {
                    }
                    field("Customer PO No."; "Customer PO No.")
                    {
                    }
                    field(Notes; Notes)
                    {
                    }
                    field("Build Ahead"; "Build Ahead")
                    {
                    }
                }
                group(Control1220060125)
                {
                    ShowCaption = false;
                    field("Oil Type"; "Oil Type")
                    {
                    }
                    field("Income Code"; "Income Code")
                    {
                    }
                    field("Safety Form"; "Safety Form")
                    {
                    }
                    field("Tax Liable"; "Tax Liable")
                    {
                    }
                    field(TD; TD)
                    {
                    }
                    field(RD; RD)
                    {
                        Caption = 'PID';
                    }
                    field(Diagnosis; Diagnosis)
                    {
                        MultiLine = true;
                    }
                    field("Date Required"; "Date Required")
                    {
                    }
                    field("Quote Sent Date"; "Quote Sent Date")
                    {
                        Caption = 'Quote Sent';
                        Editable = false;
                    }
                    field(Control1220060025; "Install Date")
                    {
                        ShowCaption = false;
                    }
                    field("Sales Order No."; "Sales Order No.")
                    {
                        Editable = SalesOrderNoEditable;
                    }
                    field(Boxed; Boxed)
                    {
                    }
                    field(Expedite; Expedite)
                    {
                    }
                    field("Inventory Cost Adjusted"; "Inventory Cost Adjusted")
                    {
                        Editable = InvCostAdjustedEditable;
                    }
                    field("Customer Viewable Notes"; "Customer Viewable Notes")
                    {
                        MultiLine = true;
                    }
                    field("Ultimate Test"; "Ultimate Test")
                    {
                        Editable = false;
                    }
                }
            }
            group(Control1220060132)
            {
                ShowCaption = false;
                grid(Control1220060127)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060126)
                    {
                        ShowCaption = false;
                        field(Quote; Quote)
                        {
                            Editable = false;
                        }
                        field("Unrepairable Reason"; "Unrepairable Reason")
                        {
                            Editable = false;
                        }
                        field("Unrepairable Handling"; "Unrepairable Handling")
                        {
                            Editable = false;
                        }
                    }
                }
            }
            group(Instructions)
            {
                group("Step Work Instructions:")
                {
                    Caption = 'Step Work Instructions:';
                    field(REC; RCV)
                    {
                    }
                    field(DIS; DIS)
                    {
                    }
                    field(QOT; QOT)
                    {
                    }
                    field(CLN; CLN)
                    {
                    }
                    field(ASM; ASM)
                    {
                    }
                    field(TST; TST)
                    {
                    }
                    field(PNT; PNT)
                    {
                    }
                    field(QC; QC)
                    {
                    }
                    field(SHP; SHP)
                    {
                    }
                }
            }
            group(Other)
            {
                group(Control1220060135)
                {
                    ShowCaption = false;
                    field("Ship To Name"; "Ship To Name")
                    {
                    }
                    field("Ship To Address 1"; "Ship To Address 1")
                    {
                    }
                    field("Ship To Address 2"; "Ship To Address 2")
                    {
                    }
                    field("Ship To City"; "Ship To City")
                    {
                    }
                    field("Ship To State"; "Ship To State")
                    {
                    }
                    field("Ship To Zip Code"; "Ship To Zip Code")
                    {
                    }
                    field("Phone No."; "Phone No.")
                    {
                    }
                    field(Attention; Attention)
                    {
                    }
                    field("Payment Method"; "Payment Method")
                    {
                    }
                    field("Payment Terms"; "Payment Terms")
                    {
                    }
                    field("Card Type"; "Card Type")
                    {
                    }
                    field("Credit Card No."; "Credit Card No.")
                    {
                    }
                    field("Credit Card Exp."; "Credit Card Exp.")
                    {
                    }
                }
                group(Control1220060136)
                {
                    ShowCaption = false;
                    field(Carrier; Carrier)
                    {
                    }
                    field("Shipping Method"; "Shipping Method")
                    {
                    }
                    field("Shipping Account"; "Shipping Account")
                    {
                    }
                    field("Shipping Charge"; "Shipping Charge")
                    {
                    }
                    field("Container Type"; "Container Type")
                    {
                        Editable = false;
                    }
                    field("Container Quantity"; "Container Quantity")
                    {
                        Editable = false;
                    }
                    field(oContainerSaved; oContainerSaved)
                    {
                        Caption = 'Container Saved';
                        Editable = false;
                    }
                    field("Ship Weight"; "Ship Weight")
                    {
                        Editable = false;
                    }
                    field("Bill of Lading"; "Bill of Lading")
                    {
                        Editable = false;
                    }
                    field("Package Tracking No."; "Package Tracking No.")
                    {
                        Editable = false;
                    }
                    field(Accessories; Accessories)
                    {
                        Editable = false;
                    }
                    field("Receiving Notes"; "Receiving Notes")
                    {
                        Editable = false;
                    }
                    field("Pump Module"; "Pump Module")
                    {
                    }
                    field("Pump Module No."; "Pump Module No.")
                    {
                        Editable = PumpModuleNoEditable;
                    }
                    field("Customer Order No."; "Customer Order No.")
                    {
                        Editable = false;
                    }
                }
            }
            group(Figures)
            {
                group("Total Work Order Time")
                {
                    Caption = 'Total Work Order Time';
                    field("Current Reg Hours Used"; "Current Reg Hours Used")
                    {
                        Editable = false;
                    }
                    field("Current OT Hours Used"; "Current OT Hours Used")
                    {
                        Editable = false;
                    }
                    field("Current Extra Time Used"; "Current Extra Time Used")
                    {
                        Editable = false;
                    }
                    field("Labor Hours Quoted"; "Labor Hours Quoted")
                    {
                        Caption = 'Total Quoted Hours';
                        Editable = false;
                    }
                    field("( ""Current Reg Hours Used"" + ""Current OT Hours Used"" + ""Current Extra Time Used"") - ""Labor Hours Quoted"""; ("Current Reg Hours Used" + "Current OT Hours Used" + "Current Extra Time Used") - "Labor Hours Quoted")
                    {
                        Caption = 'Variance';
                        Editable = false;
                    }
                    field("Original Parts Cost"; "Original Parts Cost")
                    {
                        Editable = false;
                    }
                    field("Parts Cost"; "Parts Cost")
                    {
                        Editable = false;
                    }
                    field("Parts Variance"; "Parts Cost" - "Original Parts Cost")
                    {
                        Caption = 'Parts Variance';
                        Editable = false;
                    }
                }
                group(Control1220060138)
                {
                    ShowCaption = false;
                    field("Original Parts Price"; "Original Parts Price")
                    {
                        Caption = 'Parts Price';
                        Editable = false;
                    }
                    field("Original Labor Price"; "Original Labor Price")
                    {
                        Caption = 'Labor Price';
                        Editable = false;
                    }
                    field("Order Adj."; "Order Adj.")
                    {
                        Caption = 'Order Adjustment';
                        Editable = false;
                    }
                    field("Unrepairable Charge"; "Unrepairable Charge")
                    {
                        Editable = false;
                    }
                    field(QuotePrice; QuotePrice)
                    {
                        Caption = 'Quote Price';
                        Editable = false;
                    }
                    field(Freightin; Freightin)
                    {
                    }
                    field(Freightout; Freightout)
                    {
                    }
                }
            }
            group("Return To Vendor")
            {
                field("Vendor Repair"; "Vendor Repair")
                {
                }
                field("Reverse Build Ahead"; "Reverse Build Ahead")
                {
                }
                field("RMA No."; "RMA No.")
                {
                }
                field("RMA Date"; "RMA Date")
                {
                }
                field("RMA Description"; "RMA Description")
                {
                }
                field("Vendor Carrier"; "Vendor Carrier")
                {
                    Caption = 'Carrier';
                }
                field("Vendor Shipping Method"; "Vendor Shipping Method")
                {
                    Caption = 'Shipping Method';
                }
                field("Vendor Shipping Account"; "Vendor Shipping Account")
                {
                    Caption = 'Shipping Account';
                }
                field("Vendor Shipping Charge"; "Vendor Shipping Charge")
                {
                    Caption = 'Shipping Charge';
                }
                field("Vendor Container"; "Vendor Container")
                {
                    Caption = 'Container';
                    Editable = false;
                }
                field("Vendor Container Quantity"; "Vendor Container Quantity")
                {
                    Caption = 'Container Quantity';
                    Editable = false;
                }
                field("Vendor Ship Weight"; "Vendor Ship Weight")
                {
                    Caption = 'Ship Weight';
                    Editable = false;
                }
                field("Vendor Package Tracking No."; "Vendor Package Tracking No.")
                {
                    Caption = 'Package Tracking No.';
                    Editable = false;
                }
                field("Vendor Bill of Lading"; "Vendor Bill of Lading")
                {
                    Caption = 'Bill of Lading';
                    Editable = false;
                }
                field("RMA Ship Date"; "RMA Ship Date")
                {
                    Caption = 'Ship Date';
                    Editable = false;
                }
                field("Exchange Pump"; "Exchange Pump")
                {
                }
                field("Vendor Return"; "Vendor Return")
                {
                }
                field("RMA PO No."; "RMA PO No.")
                {
                }
                field("Vendor Code"; "Vendor Code")
                {
                }
                field("Vendor Name"; "Vendor Name")
                {
                }
                field("Vendor Address"; "Vendor Address")
                {
                }
                field("Vendor Address2"; "Vendor Address2")
                {
                }
                field("Vendor City"; "Vendor City")
                {
                }
                field("Vendor State"; "Vendor State")
                {
                }
                field("Vendor Zip"; "Vendor Zip")
                {
                }
                field("Vendor Contact"; "Vendor Contact")
                {
                }
                field("Vendor Phone No."; "Vendor Phone No.")
                {
                }
                field("Vendor Fax No."; "Vendor Fax No.")
                {
                }
            }
            group("Third Party")
            {
                group("Third Party Billing Information:")
                {
                    Caption = 'Third Party Billing Information:';
                    field("Third Party Name"; "Third Party Name")
                    {
                    }
                    field("Third Party Address"; "Third Party Address")
                    {
                    }
                    field("Third Party City"; "Third Party City")
                    {
                    }
                    field("Third Party State"; "Third Party State")
                    {
                    }
                    field("Third Party Zip"; "Third Party Zip")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(FAR)
            {
                Caption = 'FAR';
                Promoted = true;

                trigger OnAction()
                begin
                    /*IsActive := VARIABLEACTIVE(MSAccess);
                    IF IsActive THEN
                      CLEAR(MSAccess);
                    
                    //AVF.MAC - removed; Detector automation control not used
                    //IsActive := VARIABLEACTIVE(Detector);
                    //IF IsActive THEN
                    //  CLEAR(Detector);
                    
                    sAppName := 'MSACCESS.EXE';
                    //strdb := "Work Order No.";
                    strdb := ('[Enter The Work Order Number] = " &') + (' ') + ("Work Order No.") + (' ')+('& "');
                    Pathlocator;*/
                    // AVF.MAC - removed Detector code below since no longer used
                    /*
                    IF strform <> '' THEN BEGIN
                      CREATE(Detector);
                      IF Detector.MsAccessRunning(sAppName) THEN BEGIN
                        CREATE(MSAccess);
                        MSAccess.CloseCurrentDatabase;
                        MSAccess.OpenCurrentDatabase(strpath);
                        MSAccess.DoCmd.OpenReport(strform,2,'',strdb);
                       //DoCmd.OpenReport "MyReportName",2, , "[SomeDate] = #" &
                      //  MSAccess.DoCmd.FindRecord(strdb);
                      END ELSE BEGIN
                        CREATE(MSAccess);
                        MSAccess.OpenCurrentDatabase(strpath);
                       // MSAccess.DoCmd.OpenReport(strform);
                        MSAccess.DoCmd.OpenReport(strform,2,'','[Enter The Work Order Number] = " & strdb & "');
                       // MSAccess.DoCmd.FindRecord(strdb);
                      END;
                    */
                    /*
                    IF strform <> '' THEN BEGIN
                        CREATE(MSAccess);
                        MSAccess.OpenCurrentDatabase(strpath);
                       // MSAccess.DoCmd.OpenReport(strform);
                        MSAccess.DoCmd.OpenReport(strform,2,'','[Enter The Work Order Number] = " & strdb & "');
                       // MSAccess.DoCmd.FindRecord(strdb);
                      END
                    ELSE MESSAGE('The Model Type is Empty, so this feature is Disabled');
                    */

                end;
            }
            action(Freight)
            {
                Caption = 'Freight';
                Promoted = true;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", "Work Order No.");
                    PAGE.RunModal(50046, WOD);
                end;
            }
            action("Install Date")
            {
                Caption = 'Install Date';
                Enabled = InstallEnabled;
                Promoted = true;

                trigger OnAction()
                var
                    RetInstallDate: Code[20];

                begin
                    InstallText := '';
                    InstallDate := 0D;

                    ///--!
                    //Window.Open('The Install Date Was #1#########', InstallText);
                    //Window.Input();
                    //Window.Close;
                    GetWODNo.SetDialogValueType(SetType::InstallText, false);
                    if GetWODNo.RunModal() = Action::OK then
                        GetWODNo.GetWorkOrderNo_(RetInstallDate);
                    InstallText := CopyStr(RetInstallDate, 1, 10);

                    if not Evaluate(InstallDate, InstallText) then
                        InstallDate := 0D;

                    WOD.Get("Work Order No.");
                    WOD."Install Date" := InstallDate;
                    WOD.Modify;
                end;
            }
            action("WO Traveler")
            {
                Caption = 'WO Traveler';
                Enabled = TravelerEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    REPORT.RunModal(50002);
                end;
            }
            action("Current &Status")
            {
                Caption = 'Current &Status';
                Promoted = true;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", "Work Order No.");
                    PAGE.RunModal(50007, WOD);
                end;
            }
            group("&Detail")
            {
                Caption = '&Detail';
                action("Parts List")
                {
                    Caption = 'Parts List';
                    Promoted = true;
                    RunObject = Page "Parts List";
                    RunPageLink = "Work Order No." = FIELD("Work Order No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Complete = true then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
        if WOM.Get("Work Order Master No.") then
            OK := true;

        // Only Customers that are Checked Ship on Sales Order can be Assigned a Sales Order No.
        if Cust.Get("Customer ID") then begin
            //  IF Cust."Ship on Sales Order" THEN BEGIN
            //Prevents Unrepairable Pumps from being Shipped to a Sales Order.
            if (Quote = Quote::"Not Repairable") and (Released) then
                SalesOrderNoEditable := false
            else
                SalesOrderNoEditable := true;
        end else
            SalesOrderNoEditable := false;
        //END ELSE
        //  SalesOrderNoEditable := FALSE;

        //INTEL Non Copper only Editable for INTEL PUMPS
        if (Cust."No." = 'INT-01') or (Cust."No." = 'INT-02') or (Cust."No." = 'INT-03') then
            NonCopperEditable := true
        else
            NonCopperEditable := false;

        //Pump Module No. Only editable by Purchasing Department through Quote modify
        PumpModuleNoEditable := false;


        //ADVACO Inventory Cost Adjustment
        if (Cust."No." = 'ADV-01') and (purmngr = false) then
            InvCostAdjustedEditable := true
        else
            InvCostAdjustedEditable := false;

        QuotePrice := 0;

        if Quote = Quote::Accepted then
            QuotePrice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";

        if Quote = Quote::"Not Repairable" then
            QuotePrice := "Unrepairable Charge";

        if GetCurrentStatus("Work Order No.") >= 0 then
            InitialWorkOrderTypeEditable := false;
    end;

    trigger OnInit()
    begin
        //SETRANGE("Work Order No.",'');
    end;

    trigger OnOpenPage()
    begin
        ok2 := true;
        purmngr := true;

        Member.CalcFields("User Name");
        Member.SetRange(Member."User Name", UserId);
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALES') or (Member."Role ID" = 'SUPER') then
                    ok2 := false;
                if (Member."Role ID" = 'ADV-PURMNGR') or (Member."Role ID" = 'SUPER') then
                    purmngr := false;
            until Member.Next = 0;
        end;


        if ok2 then begin
            InstallEnabled := false;
            TravelerEnabled := false;
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Cust.Get("Customer ID") then begin
            //  IF Cust."Ship on Sales Order" THEN BEGIN
            //    OK := TRUE;
            //  END ELSE BEGIN
            if not Complete then begin
                if (Carrier = '') or ("Shipping Method" = '') or ("Shipping Charge" = "Shipping Charge"::" ") then
                    Message('All the Shipping Information hasn''t been entered for this detail');
            end;
        end;
        //END ELSE BEGIN
        if not Complete then begin
            if (Carrier = '') or ("Shipping Method" = '') or ("Shipping Charge" = "Shipping Charge"::" ") then
                Message('All the Shipping Information hasn''t been entered for this detail');
        end;
        //END;
    end;

    var
        WorkOrderDetail2: Record WorkOrderDetail;
        WOM: Record WorkOrderMaster;
        OK: Boolean;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        SearchRecord: Code[7];
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        VOT: Text[30];
        VMN: Text[30];
        VOL: Text[30];
        VIC: Text[30];
        VDS: Text[30];
        InstallText: Text[10];
        InstallDate: Date;
        QuotePrice: Decimal;
        Member: Record "Access Control";
        ok2: Boolean;
        Cust: Record Customer;
        //ADOConn: Automation ;
        //ADOrs: Automation ;
        strpath: Text[200];
        strform: Text[200];
        strdb: Text[50];
        stLinkCriteria: Text[50];
        IsActive: Boolean;
        sAppName: Text[50];
        MSDate: Date;
        WODModelType: Record WorkOrderDetail;
        purmngr: Boolean;
        [InDataSet]
        InstallEnabled: Boolean;
        [InDataSet]
        TravelerEnabled: Boolean;
        [InDataSet]
        SalesOrderNoEditable: Boolean;
        [InDataSet]
        NonCopperEditable: Boolean;
        [InDataSet]
        PumpModuleNoEditable: Boolean;
        [InDataSet]
        InvCostAdjustedEditable: Boolean;
        [InDataSet]
        InitialWorkOrderTypeEditable: Boolean;

    procedure Pathlocator()
    begin
        case "Model Type" of

            "Model Type"::" ":
                begin
                    strpath := '';
                    strform := '';
                end;

            "Model Type"::Blower:
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Blower Pump.mdb';
                    WODModelType.SetRange("Work Order No.", "Work Order No.");
                    WODModelType.SetFilter("Model No.", '%1', '*615*');
                    if WODModelType.Find('-') then
                        strform := 'Blower pump FAR Stokes 615-1/Roots RGS-615'
                    else
                        strform := 'Blower pump FAR Roots-Type';
                end;

            "Model Type"::"Cryo Compressor":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Cryo Compressor.mdb';
                    strform := 'Cryo Compressor FAR'
                end;

            "Model Type"::"Cryo Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Cryopump.mdb';
                    strform := 'Cryopump FAR'
                end;

            "Model Type"::"Diffusion Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Diffusion Pump.mdb';
                    strform := 'Diffusion Pump FAR'
                end;

            "Model Type"::"Dry Pump - Ebara":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Ebara Dry Pump.mdb';
                    strform := 'Dry Pump Ebara FAR'
                end;

            "Model Type"::"Dry Pump - Edwards":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Edwards Dry Pump.mdb';
                    strform := 'Dry pump Edwards FAR'
                end;

            "Model Type"::"Dry Pump - Leybold":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Leybold Dry Pump.mdb';
                    strform := 'Dry pump Leybold FAR'
                end;

            "Model Type"::"Filter System":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Filter System.mdb';
                    strform := 'Filter System FAR'
                end;

            "Model Type"::"Leak Detector":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Leak Detector.mdb';
                    strform := 'Leak Detector FAR'
                end;

            "Model Type"::"Mechanical Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Vacuum-Mechanical Pump.mdb';
                    WODModelType.SetRange("Work Order No.", "Work Order No.");
                    WODModelType.SetFilter("Model No.", '%1|%2', '*212*', '*412*');
                    if WODModelType.Find('-') then
                        strform := 'Stokes 412 FAR'
                    else
                        strform := 'Mechanical Pump FAR';
                end;

            "Model Type"::"Scroll Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Scroll Pump.mdb';
                    strform := 'Scroll Pump FAR'
                end;

            "Model Type"::"Turbo Controller":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Turbo Controller.mdb';
                    strform := 'Turbo Pump Controller FAR'
                end;

            "Model Type"::"Turbo Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Turbo Pump.mdb';
                    strform := 'Turbo Pump FAR'
                end;
        end;
    end;
}

