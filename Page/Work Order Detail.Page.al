#pragma implicitwith disable
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
    //ICE RSK 12/13/20 added comment field

    InsertAllowed = false;
    PageType = Card;
    SourceTable = WorkOrderDetail;
    //UsageCategory = Tasks;
    //ApplicationArea = All;
    PromotedActionCategories = 'New,Process,Report,Detail';

    layout
    {
        area(content)
        {

            group(General)
            {
                group(Control1220060122)
                {
                    ShowCaption = false;
                    field("Work Order No."; Rec."Work Order No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer ID"; Rec."Customer ID")
                    {
                        Caption = 'Customer';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("WOM.""Date Ordered"""; WOM."Date Ordered")
                    {
                        Caption = 'Order Date';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(Comment; Format(Rec.Comment))
                    {

                        ApplicationArea = all;
                    }
                }
                group(Control1220060119)
                {
                    Editable = (not Rec.Complete);
                    ShowCaption = false;
                    field("Order Type"; Rec."Order Type")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if xRec."Order Type" <> Rec."Order Type" then begin
                                WOS.SetCurrentKey(WOS."Order No.", WOS.Step);
                                WOS.SetRange(WOS.Step, WOS.Step::QOT);
                                WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
                                if WOS.Find('-') then
                                    Error('The Work Order is Past Disassembly, and the Order Type can''t be modified by the Sales Department');
                            end;
                        end;
                    }
                    field("Initial Order Type"; Rec."Initial Order Type")
                    {
                        ApplicationArea = All;
                        Editable = InitialWorkOrderTypeEditable;
                    }
                    field("Non Copper"; Rec."Non Copper")
                    {
                        ApplicationArea = All;
                        Caption = 'INTEL Non Copper';
                        Editable = NonCopperEditable;
                    }
                    field("System Shipment"; Rec."System Shipment")
                    {
                        ApplicationArea = All;
                    }
                    field("Detail No."; Rec."Detail No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Model No."; Rec."Model No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Model Type"; Rec."Model Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Serial No."; Rec."Serial No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Tool ID"; Rec."Tool ID")
                    {
                        ApplicationArea = All;
                    }
                    field("Customer Part No."; Rec."Customer Part No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Customer PO No."; Rec."Customer PO No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Notes; Rec.Notes)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field(Complete; Rec.Complete)
                    {
                        ApplicationArea = All;
                        Editable = true;
                    }
                    field("Build Ahead"; Rec."Build Ahead")
                    {
                        ApplicationArea = All;
                        Enabled = true;
                        Editable = false;
                    }
                }
                group(Control1220060125)
                {
                    Editable = (not Rec.Complete);
                    ShowCaption = false;
                    field("Oil Type"; Rec."Oil Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Income Code"; Rec."Income Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Safety Form"; Rec."Safety Form")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Liable"; Rec."Tax Liable")
                    {
                        ApplicationArea = All;
                    }
                    field(TD; Rec.TD)
                    {
                        ApplicationArea = All;
                    }
                    field(RD; Rec.RD)
                    {
                        ApplicationArea = All;
                        Caption = 'PID';
                    }
                    field(Diagnosis; Rec.Diagnosis)
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field("Date Required"; Rec."Date Required")
                    {
                        ApplicationArea = All;
                    }
                    field("Quote Sent Date"; Rec."Quote Sent Date")
                    {
                        ApplicationArea = All;
                        Caption = 'Quote Sent';
                        Editable = false;
                    }
                    field(Control1220060025; Rec."Install Date")
                    {
                        ApplicationArea = All;
                        //ShowCaption = false;
                    }
                    field("Sales Order No."; Rec."Sales Order No.")
                    {
                        ApplicationArea = All;
                        Editable = SalesOrderNoEditable;
                    }
                    field(Boxed; Rec.Boxed)
                    {
                        ApplicationArea = All;
                    }
                    field(Expedite; Rec.Expedite)
                    {
                        ApplicationArea = All;
                    }
                    field("Inventory Cost Adjusted"; Rec."Inventory Cost Adjusted")
                    {
                        ApplicationArea = All;
                        Editable = InvCostAdjustedEditable;
                    }
                    field("Customer Viewable Notes"; Rec."Customer Viewable Notes")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                    }
                    field("Ultimate Test"; Rec."Ultimate Test")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
            group(Control1220060132)
            {
                Editable = (not Rec.Complete);
                ShowCaption = false;
                grid(Control1220060127)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060126)
                    {
                        ShowCaption = false;
                        field(Quote; Rec.Quote)
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Unrepairable Reason"; Rec."Unrepairable Reason")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Unrepairable Handling"; Rec."Unrepairable Handling")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                    }
                }
            }
            group(Instructions)
            {
                group("Step Work Instructions:")
                {
                    Editable = (not Rec.Complete);
                    Caption = 'Step Work Instructions:';
                    field(REC; Rec.RCV)
                    {
                        ApplicationArea = All;
                        Caption = 'Receive';
                    }
                    field(DIS; Rec.DIS)
                    {
                        ApplicationArea = All;
                        Caption = 'Disassemble';
                    }
                    field(QOT; Rec.QOT)
                    {
                        ApplicationArea = All;
                        Caption = 'Quote';
                    }
                    field(CLN; Rec.CLN)
                    {
                        ApplicationArea = All;
                        Caption = 'Clean';
                    }
                    field(ASM; Rec.ASM)
                    {
                        ApplicationArea = All;
                        Caption = 'Assemble';
                    }
                    field(TST; Rec.TST)
                    {
                        ApplicationArea = All;
                        Caption = 'Test';
                    }
                    field(PNT; Rec.PNT)
                    {
                        ApplicationArea = All;
                        Caption = 'Paint';
                    }
                    field(QC; Rec.QC)
                    {
                        ApplicationArea = All;
                        Caption = 'Quality Control';
                    }
                    field(SHP; Rec.SHP)
                    {
                        ApplicationArea = All;
                        Caption = 'Ship';
                    }
                }
            }
            group(Other)
            {
                Editable = (not Rec.Complete);
                group(Control1220060135)
                {
                    ShowCaption = false;
                    field("Ship To Name"; Rec."Ship To Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Address 1"; Rec."Ship To Address 1")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Address 2"; Rec."Ship To Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To City"; Rec."Ship To City")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To State"; Rec."Ship To State")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Zip Code"; Rec."Ship To Zip Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Attention; Rec.Attention)
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Method"; Rec."Payment Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Terms"; Rec."Payment Terms")
                    {
                        ApplicationArea = All;
                    }
                    field("Card Type"; Rec."Card Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Credit Card No."; Rec."Credit Card No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Credit Card Exp."; Rec."Credit Card Exp.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060136)
                {
                    ShowCaption = false;

                    field(Carrier; Rec.Carrier)
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Method"; Rec."Shipping Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Account"; Rec."Shipping Account")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Charge"; Rec."Shipping Charge")
                    {
                        ApplicationArea = All;
                    }
                    field("Container Type"; Rec."Container Type")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Container Quantity"; Rec."Container Quantity")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(oContainerSaved; Rec.oContainerSaved)
                    {
                        ApplicationArea = All;
                        Caption = 'Container Saved';
                        Editable = false;
                    }
                    field("Ship Weight"; Rec."Ship Weight")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Bill of Lading"; Rec."Bill of Lading")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Package Tracking No."; Rec."Package Tracking No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Accessories; Rec.Accessories)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Receiving Notes"; Rec."Receiving Notes")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Pump Module"; Rec."Pump Module")
                    {
                        ApplicationArea = All;
                    }
                    field("Pump Module No."; Rec."Pump Module No.")
                    {
                        ApplicationArea = All;
                        Editable = PumpModuleNoEditable;
                    }
                    field("Customer Order No."; Rec."Customer Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
            group(Figures)
            {
                group("Total Work Order Time")
                {
                    Caption = 'Total Work Order Time';
                    field("Current Reg Hours Used"; Rec."Current Reg Hours Used")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Current OT Hours Used"; Rec."Current OT Hours Used")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Current Extra Time Used"; Rec."Current Extra Time Used")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Labor Hours Quoted"; Rec."Labor Hours Quoted")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Quoted Hours';
                        Editable = false;
                    }
                    field("( ""Current Reg Hours Used"" + ""Current OT Hours Used"" + ""Current Extra Time Used"") - ""Labor Hours Quoted"""; (Rec."Current Reg Hours Used" + Rec."Current OT Hours Used" + Rec."Current Extra Time Used") - Rec."Labor Hours Quoted")
                    {
                        ApplicationArea = All;
                        Caption = 'Variance';
                        Editable = false;
                    }
                    field("Original Parts Cost"; Rec."Original Parts Cost")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Parts Cost"; Rec."Parts Cost")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Parts Variance"; Rec."Parts Cost" - Rec."Original Parts Cost")
                    {
                        ApplicationArea = All;
                        Caption = 'Parts Variance';
                        Editable = false;
                    }
                }
                group(Control1220060138)
                {
                    ShowCaption = false;
                    field("Original Parts Price"; Rec."Original Parts Price")
                    {
                        ApplicationArea = All;
                        Caption = 'Parts Price';
                        Editable = false;
                    }
                    field("Original Labor Price"; Rec."Original Labor Price")
                    {
                        ApplicationArea = All;
                        Caption = 'Labor Price';
                        Editable = false;
                    }
                    field("Order Adj."; Rec."Order Adj.")
                    {
                        ApplicationArea = All;
                        Caption = 'Order Adjustment';
                        Editable = false;
                    }
                    field("Unrepairable Charge"; Rec."Unrepairable Charge")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(QuotePrice; QuotePrice)
                    {
                        ApplicationArea = All;
                        Caption = 'Quote Price';
                        Editable = false;
                    }
                    field(Freightin; Rec.Freightin)
                    {
                        ApplicationArea = All;
                    }
                    field(Freightout; Rec.Freightout)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group("Return To Vendor")
            {
                Editable = (not Rec.Complete);
                field("Vendor Repair"; Rec."Vendor Repair")
                {
                    ApplicationArea = All;
                }
                field("Reverse Build Ahead"; Rec."Reverse Build Ahead")
                {
                    ApplicationArea = All;
                }
                field("RMA No."; Rec."RMA No.")
                {
                    ApplicationArea = All;
                }
                field("RMA Date"; Rec."RMA Date")
                {
                    ApplicationArea = All;
                }
                field("RMA Description"; Rec."RMA Description")
                {
                    ApplicationArea = All;
                }
                field("Vendor Carrier"; Rec."Vendor Carrier")
                {
                    ApplicationArea = All;
                    Caption = 'Carrier';
                }
                field("Vendor Shipping Method"; Rec."Vendor Shipping Method")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Method';
                }
                field("Vendor Shipping Account"; Rec."Vendor Shipping Account")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Account';
                }
                field("Vendor Shipping Charge"; Rec."Vendor Shipping Charge")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Charge';
                }
                field("Vendor Container"; Rec."Vendor Container")
                {
                    ApplicationArea = All;
                    Caption = 'Container';
                    Editable = false;
                }
                field("Vendor Container Quantity"; Rec."Vendor Container Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Container Quantity';
                    Editable = false;
                }
                field("Vendor Ship Weight"; Rec."Vendor Ship Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Ship Weight';
                    Editable = false;
                }
                field("Vendor Package Tracking No."; Rec."Vendor Package Tracking No.")
                {
                    ApplicationArea = All;
                    Caption = 'Package Tracking No.';
                    Editable = false;
                }
                field("Vendor Bill of Lading"; Rec."Vendor Bill of Lading")
                {
                    ApplicationArea = All;
                    Caption = 'Bill of Lading';
                    Editable = false;
                }
                field("RMA Ship Date"; Rec."RMA Ship Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ship Date';
                    Editable = false;
                }
                field("Exchange Pump"; Rec."Exchange Pump")
                {
                    ApplicationArea = All;
                }
                field("Vendor Return"; Rec."Vendor Return")
                {
                    ApplicationArea = All;
                }
                field("RMA PO No."; Rec."RMA PO No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Code"; Rec."Vendor Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address"; Rec."Vendor Address")
                {
                    ApplicationArea = All;
                }
                field("Vendor Address2"; Rec."Vendor Address2")
                {
                    ApplicationArea = All;
                }
                field("Vendor City"; Rec."Vendor City")
                {
                    ApplicationArea = All;
                }
                field("Vendor State"; Rec."Vendor State")
                {
                    ApplicationArea = All;
                }
                field("Vendor Zip"; Rec."Vendor Zip")
                {
                    ApplicationArea = All;
                }
                field("Vendor Contact"; Rec."Vendor Contact")
                {
                    ApplicationArea = All;
                }
                field("Vendor Phone No."; Rec."Vendor Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Fax No."; Rec."Vendor Fax No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Third Party")
            {
                Editable = (not Rec.Complete);
                group("Third Party Billing Information:")
                {
                    Caption = 'Third Party Billing Information:';
                    field("Third Party Name"; Rec."Third Party Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Third Party Address"; Rec."Third Party Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Third Party City"; Rec."Third Party City")
                    {
                        ApplicationArea = All;
                    }
                    field("Third Party State"; Rec."Third Party State")
                    {
                        ApplicationArea = All;
                    }
                    field("Third Party Zip"; Rec."Third Party Zip")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(Correct)
            {
                ApplicationArea = All;
                Visible = lAccGroup;

                trigger OnAction()
                begin
                    if Rec."Shipping Processed" then begin
                        Rec."Shipping Processed" := false;
                        Rec."Vendor Shipping Processed" := true;
                        rec.Modify();
                    end;
                end;
            }
            action(FAR)
            {
                // Potential Obsolite. It deals with Access DBs, no longer in use.
                Visible = false;
                ApplicationArea = All;
                Caption = 'FAR';
                Promoted = true;
                PromotedCategory = Process;

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
                ApplicationArea = All;
                Caption = 'Freight';
                Promoted = true;
                PromotedCategory = Process;
                Image = CalculateShipment;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", Rec."Work Order No.");
                    Page.RunModal(Page::"Input Freight", WOD);
                end;
            }
            action("Install Date")
            {
                ApplicationArea = All;
                Caption = 'Install Date';
                Enabled = InstallEnabled;
                Promoted = true;
                PromotedCategory = Process;
                Image = DueDate;

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

                    WOD.Get(Rec."Work Order No.");
                    WOD."Install Date" := InstallDate;
                    WOD.Modify;
                end;
            }
        }
        area(Reporting)
        {
            action("WO Traveler")
            {
                ApplicationArea = All;
                Caption = 'WO Traveler';
                Enabled = TravelerEnabled;
                Promoted = true;
                PromotedCategory = Report;
                Image = StepInto;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", Rec."Work Order No.");
                    IF WOD.FindFirst() then;
                    REPORT.RunModal(50002, true, false, WOD);
                end;
            }
        }
        area(Navigation)
        {
            action("Current &Status")
            {
                ApplicationArea = All;
                Caption = 'Current &Status';
                Promoted = true;
                PromotedCategory = Category4;
                Image = Status;

                trigger OnAction()
                begin
                    WOD.SetRange(WOD."Work Order No.", Rec."Work Order No.");
                    PAGE.RunModal(50007, WOD);
                end;
            }
            group("&Detail")
            {
                Caption = '&Detail';
                action(List)
                {
                    Caption = 'List';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = OrderList;
                    RunObject = page "Work Order Detail List";
                    RunPageLink = "Work Order Master No." = field("Work Order Master No.");
                }
                action("Parts List")
                {
                    Caption = 'Parts List';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = ItemLines;
                    RunObject = page "Parts List";
                    RunPageLink = "Work Order No." = FIELD("Work Order No.");
                }
                //ICE RSK 12/13/20
                action(Comments)
                {
                    Caption = 'Comments';
                    ApplicationArea = all;
                    Promoted = True;
                    PromotedCategory = Category4;
                    Image = ViewComments;
                    RunObject = page "ADVACO Comment Sheet";
                    RunPageLink = "Table Name" = const(WorkOrderDetail), "No." = field("Work Order No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.Complete = true then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
        if WOM.Get(Rec."Work Order Master No.") then
            OK := true;

        // Only Customers that are Checked Ship on Sales Order can be Assigned a Sales Order No.
        if Cust.Get(Rec."Customer ID") then begin
            //  IF Cust."Ship on Sales Order" THEN BEGIN
            //Prevents Unrepairable Pumps from being Shipped to a Sales Order.
            if (Rec.Quote = Rec.Quote::"Not Repairable") and (Rec.Released) then
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

        Rec.CalcFields("Original Parts Price", "Original Labor Price");
        QuotePrice := 0;

        if Rec.Quote = Rec.Quote::Accepted then
            QuotePrice := Rec."Original Parts Price" + Rec."Original Labor Price" + Rec."Order Adj.";

        if Rec.Quote = Rec.Quote::"Not Repairable" then
            QuotePrice := Rec."Unrepairable Charge";

        if Rec.GetCurrentStatus(Rec."Work Order No.") >= 0 then
            InitialWorkOrderTypeEditable := false;
    end;

    trigger OnInit()
    begin
        //SETRANGE("Work Order No.",'');
    end;

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        User: Record User;
        AcctCode: Label 'ADVACO ACCOUNTING';
        SalesCode: Label 'ADVACO SALES';
        PurchCode: Label 'ADV-PURMNGR';
        Permiss: Label 'SUPER';
        txtAnswer: Text[120];


    begin
        //ok2 := true;
        purmngr := true;

        ///--!
        /*
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
        */
        // initialize group flag
        lAccGroup := false;
        //lSalesGroup := false;
        //lShipGroup := false;

        ///--! Permission level check code. 
        User.Get(UserSecurityId);
        Ok := true;
        //User.SetRange("User Security ID", User."User Security ID");
        //Member.SetRange("User Security ID", User."User Security ID");

        lAccGroup := (SysFunctions.getIfSingleGroupId(AcctCode, txtAnswer) or
                        SysFunctions.getIfSingleGroupId(SalesCode, txtAnswer));
        if not lAccGroup then
            lAccGroup := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);

        //if not lAccGroup then
        //    lAccGroup := SysFunctions.getIfSingleRoleId(PurchCode, txtAnswer);
        //if not lAccGroup then
        //    lAccGroup := SysFunctions.getIfSingleRoleId(SalesCode, txtAnswer);
        if purmngr then
            purmngr := not (SysFunctions.getIfSingleRoleId(PurchCode, txtAnswer));

        //if not (lAccGroup or lSalesGroup) then
        //   lShipGroup := SysFunctions.getIfSingleGroupId(ShipCode, txtAnswer);
        if lAccGroup then begin
            InstallEnabled := true;
            TravelerEnabled := true;
        end;

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Cust.Get(Rec."Customer ID") then begin
            //  IF Cust."Ship on Sales Order" THEN BEGIN
            //    OK := TRUE;
            //  END ELSE BEGIN
            if not Rec.Complete then begin
                if (Rec.Carrier = '') or (Rec."Shipping Method" = '') or (Rec."Shipping Charge" = Rec."Shipping Charge"::" ") then
                    Message('All the Shipping Information hasn''t been entered for this detail');
            end;
        end;
        //END ELSE BEGIN
        if not Rec.Complete then begin
            if (Rec.Carrier = '') or (Rec."Shipping Method" = '') or (Rec."Shipping Charge" = Rec."Shipping Charge"::" ") then
                Message('All the Shipping Information hasn''t been entered for this detail');
        end;
        //END;
    end;

    var
        lAccGroup: Boolean;
        SysFunctions: Codeunit systemFunctionalLibrary;
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
        case Rec."Model Type" of

            Rec."Model Type"::" ":
                begin
                    strpath := '';
                    strform := '';
                end;

            Rec."Model Type"::Blower:
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Blower Pump.mdb';
                    WODModelType.SetRange("Work Order No.", Rec."Work Order No.");
                    WODModelType.SetFilter("Model No.", '%1', '*615*');
                    if WODModelType.Find('-') then
                        strform := 'Blower pump FAR Stokes 615-1/Roots RGS-615'
                    else
                        strform := 'Blower pump FAR Roots-Type';
                end;

            Rec."Model Type"::"Cryo Compressor":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Cryo Compressor.mdb';
                    strform := 'Cryo Compressor FAR'
                end;

            Rec."Model Type"::"Cryo Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Cryopump.mdb';
                    strform := 'Cryopump FAR'
                end;

            Rec."Model Type"::"Diffusion Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Diffusion Pump.mdb';
                    strform := 'Diffusion Pump FAR'
                end;

            Rec."Model Type"::"Dry Pump - Ebara":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Ebara Dry Pump.mdb';
                    strform := 'Dry Pump Ebara FAR'
                end;

            Rec."Model Type"::"Dry Pump - Edwards":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Edwards Dry Pump.mdb';
                    strform := 'Dry pump Edwards FAR'
                end;

            Rec."Model Type"::"Dry Pump - Leybold":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Leybold Dry Pump.mdb';
                    strform := 'Dry pump Leybold FAR'
                end;

            Rec."Model Type"::"Filter System":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Filter System.mdb';
                    strform := 'Filter System FAR'
                end;

            Rec."Model Type"::"Leak Detector":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Leak Detector.mdb';
                    strform := 'Leak Detector FAR'
                end;

            Rec."Model Type"::"Mechanical Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Vacuum-Mechanical Pump.mdb';
                    WODModelType.SetRange("Work Order No.", Rec."Work Order No.");
                    WODModelType.SetFilter("Model No.", '%1|%2', '*212*', '*412*');
                    if WODModelType.Find('-') then
                        strform := 'Stokes 412 FAR'
                    else
                        strform := 'Mechanical Pump FAR';
                end;

            Rec."Model Type"::"Scroll Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Scroll Pump.mdb';
                    strform := 'Scroll Pump FAR'
                end;

            Rec."Model Type"::"Turbo Controller":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Turbo Controller.mdb';
                    strform := 'Turbo Pump Controller FAR'
                end;

            Rec."Model Type"::"Turbo Pump":
                begin
                    strpath := 'F:\SHARED\Service Department\Failure Analysis Reports\FAR Database\Turbo Pump.mdb';
                    strform := 'Turbo Pump FAR'
                end;
        end;
    end;
}

#pragma implicitwith restore

