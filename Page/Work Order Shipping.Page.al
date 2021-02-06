page 50033 "Work Order Shipping"
{
    // 2/1/01, HTCS, RCA - added code to "Ship" command button OnPush() 
    // 2/20/01 HEF FIX BOL PROBLEM
    // 
    // 2/28/12 ADV Reverse the debug settings in Repairable() function to partially post the shippment
    // 
    // 04/17/18
    //   Mesage to Use saved Customer Container if Saved Container = Yes. Moved before open form.
    // 05/2/18
    //   Container Type control set to field options in table 50001. Make it editable.

    ///--! SN: Serial No. issue - must find serial No. 
    ///--! Report (BOL and Address Labels)
    // 
    // 2021_01_11 Intelice  
    //    Added logic to test for processed shipped orders to stop reprocess and allow printing BOL and Address labels
    //

    DeleteAllowed = false;
    InsertAllowed = false;
    //PageType = List;
    SourceTable = WorkOrderDetail;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Control1220060011)
            {
                ShowCaption = false;

                /*field("Shipping Processed";"Shipping Processed")
                {
                    ShowCaption = false;
                    Visible = false;
                }*/
                field(ShipmentWeight; ShipmentWeight)
                {
                    ApplicationArea = All;
                    Caption = 'Total Shipment Weight';
                }
                field(LabelsToPrint; LabelsToPrint)
                {
                    ApplicationArea = All;
                    Caption = 'Label Quantity';
                }
                field(ContainerType; ContainerType)
                {
                    ApplicationArea = All;
                    Caption = 'Container Type';
                }
                field(TotalContainerQuantity; TotalContainerQuantity)
                {
                    ApplicationArea = All;
                    Caption = 'Total Container Qty';
                }
                field(Shipper; Shipper)
                {
                    ApplicationArea = All;
                    Caption = 'Shippers Initals';
                    TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''));
                }
                field(ShippingTime; ShippingTime)
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Time';
                }
            }
            repeater(Group)
            {
                field(Ship; Ship)
                {
                    ApplicationArea = All;
                }
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'WOD';
                    Editable = false;
                }
                field("Model No."; "Model No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Part No."; "Customer Part No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Carrier; Carrier)
                {
                    ApplicationArea = All;
                }
                field("Shipping Charge"; "Shipping Charge")
                {
                    ApplicationArea = All;
                }
                field("Shipping Method"; "Shipping Method")
                {
                    ApplicationArea = All;
                }
                field("Shipping Account"; "Shipping Account")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1220060018)
            {
                ShowCaption = false;
                field("Customer ID"; "Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Ship To Name"; "Ship To Name")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address 1"; "Ship To Address 1")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address 2"; "Ship To Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship To City"; "Ship To City")
                {
                    ApplicationArea = All;
                }
                field("Ship To State"; "Ship To State")
                {
                    ApplicationArea = All;
                }
                field("Ship To Zip Code"; "Ship To Zip Code")
                {
                    ApplicationArea = All;
                }
                field(Attention; Attention)
                {
                    ApplicationArea = All;
                }
                field("Ship Weight"; "Ship Weight")
                {
                    ApplicationArea = All;
                }
                field("Container Quantity"; "Container Quantity")
                {
                    ApplicationArea = All;
                }
                field("Packaging Location"; "Packaging Location")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field(Packaging; Packaging)
                {
                    ApplicationArea = All;
                }
                field(Accessories; Accessories)
                {
                    ApplicationArea = All;
                }
                field("Receiving Notes"; "Receiving Notes")
                {
                    ApplicationArea = All;
                }
                field(SHP; SHP)
                {
                    ApplicationArea = All;
                }
            }
            group("*  *  *  *  * *INTEL Non-Copper Segregation Required* *  *  *  *  *")
            {
                Caption = '*  *  *  *  * *INTEL Non-Copper Segregation Required* *  *  *  *  *';
                Visible = NonCopperVisible;
                field(NonCopperMessage; NonCopperMessage)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    Visible = NonCopperVisible;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print All BOL's")
            {
                ApplicationArea = All;
                Caption = 'Print All BOL''s';
                Enabled = false;
                Visible = false;

                trigger OnAction()
                var
                    WODCorrect: Record WorkOrderDetail;

                begin
                    //HEF REMOVED BECAUSE SHOULDN'T NEED

                    /*
                    
                    IF NOT CONFIRM('Do you want to print labels now?',FALSE) THEN BEGIN
                      EXIT;
                    END ELSE BEGIN
                      BOL3.SETRANGE(BOL3."BOL Printed",FALSE);
                      IF BOL3.FIND('-') THEN BEGIN
                        REPEAT
                          BOL3."BOL Printed" := TRUE;
                          BOL3."Label Printed" := TRUE;
                          BOL3.SETRANGE(BOL3."Bill of Lading",BOL3."Bill of Lading");
                          REPORT.RUNMODAL(50016,FALSE,FALSE,BOL3);               // BOL Document
                    
                          LabelCount := BOL3."Label Quantity";
                            REPEAT
                              BEGIN
                                LabelCount := LabelCount -1;
                                REPORT.RUNMODAL(50015,FALSE,FALSE,BOL3);               // Shipping Label
                              END;
                            UNTIL LabelCount = 0;
                    
                          ConfirmBatchLabels;
                       UNTIL BOL3.NEXT = 0;
                      END;
                    END;
                    
                    WODCorrect.Get('6817001');
                    WODCorrect.Complete := false;
                    WODCorrect."Shipping Processed" := false;
                    WODCorrect.Modify(false);

                    WODCorrect.Get('6819101');
                    WODCorrect.Complete := false;
                    WODCorrect."Shipping Processed" := false;
                    WODCorrect.Modify(false);

                    CurrPage.Close();
                    */

                end;
            }
            action(Instructions)
            {
                ApplicationArea = All;
                Caption = 'Instructions';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Documents;
                Visible = WorkInstructionsVisible;

                trigger OnAction()
                begin
                    InstructionRead := true;

                    WSI.SetRange(WSI."Order No.", "Work Order No.");
                    WSI.SetRange(WSI.Step, "Detail Step");
                    PAGE.RunModal(50042, WSI);
                end;
            }
            group("Print")
            {
                Caption = 'Print';
                Image = PrintForm;

                action(BillOfLading)
                {
                    Caption = 'Bill of Lading';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        // 2021_01_11 Intelice Start
                        if not Rec."Shipping Processed" then begin
                            Message('You nedd to <Ship> this order to be able to print BOL.');
                            exit;
                        end;
                        // 2021_01_11 Intelice End
                        PrintBOL;
                    end;
                }

                action(AddrLabels)
                {
                    Caption = 'Address Labels';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Report;

                    trigger OnAction()
                    begin
                        // 2021_01_11 Intelice Start
                        if not Rec."Shipping Processed" then begin
                            Message('You nedd to <Ship> this order to be able to print Address Labels.');
                            exit;
                        end;
                        // 2021_01_11 Intelice End
                        PrintLabels;
                    end;

                }

            }
            action("&Ship")
            {
                ApplicationArea = All;
                Caption = '&Ship';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Shipment;
                Visible = True; //ICE RSK 12/28/20 

                trigger OnAction()
                begin
                    SystemShipment := false;
                    IncompleteSystem := false;
                    SystemWO := '';

                    // 2021_01_11 Intelice Start
                    // Test for processed order
                    if Rec."Shipping Processed" then begin
                        Message('Current Order %1 is already processed. You cannot process it.', Rec."Work Order No.");
                        exit;
                    end;
                    // 2021_01_11 Intelice End

                    // 04/17/18 start
                    IF oContainerSaved = oContainerSaved::Yes THEN
                        MESSAGE(STRSUBSTNO('Be sure to ship with Saved Customer Container [%1]', FORMAT("Container Type")));
                    // 04/17/18 end

                    if (MessageShowed > 0) and (InstructionRead = false) then
                        Error('Work Instructions must be read before Shipping the Work Order');

                    if ShipmentWeight = 0 then
                        Error('Shipment Weight must be entered.');

                    if Shipper = '' then
                        Error('Shipper must be entered.');

                    if ShippingTime = 0 then
                        Error('Shipping Time must be entered.');

                    SalesLineNo := 0;

                    // Update current record in the DB
                    CurrPage.Update(true);

                    WOD.SetCurrentKey(WOD."Work Order No.");
                    WOD.SetRange(WOD."Work Order Master No.", WOM."Work Order Master No.");
                    WOD.SetRange(WOD.Ship, true);
                    WOD.SetRange(WOD.Complete, false);
                    if WOD.Find('-') then begin
                        repeat
                            if WOD."System Shipment" then
                                SystemShipment := true;
                        until WOD.Next = 0;
                    end;

                    if SystemShipment then begin
                        WODSystem.SetRange(WODSystem."Work Order Master No.", WOM."Work Order Master No.");
                        WODSystem.SetRange(WODSystem.Complete, false);
                        if WODSystem.Find('-') then begin
                            repeat
                                if WODSystem."System Shipment" then begin
                                    SystemWO := SystemWO + WODSystem."Work Order No." + ' ';
                                    if WODSystem.Ship then
                                        Ok := true
                                    else
                                        IncompleteSystem := true;
                                end;
                            until WODSystem.Next = 0;
                        end;
                    end;

                    if IncompleteSystem then
                        Error('The Following Work Orders %1 need to be shipped together', SystemWO);

                    URCheck;

                    // get the current record
                    //Commit();
                    Rec.Get(Rec."Work Order No.");

                    // 2021_01_11 Intelice Start
                    // Reset WOS Status to Waiting
                    /*
                    WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
                    WOS.Reset();
                    WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
                    if WOS.Find('+') then begin
                        if WOS.Status = WOS.Status::Complete then begin
                            WOS.Status := WOS.Status::Waiting;
                            WOS.Modify(false);
                        end;
                    end;
                    */
                    // Clean Complete Status on WOD to allow page to stay on, if something was processed
                    if not NothingToShip then begin
                        Rec.Complete := false;
                        // Mark current WOD as processed
                        Rec."Shipping Processed" := true;
                        Rec.Modify();
                    end;
                    // 2021_01_11 Intelice End

                    //CurrPage.Close;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CalcFields("Detail Step");
        Instructions := false;
        NewInstruction := false;
        NothingToShip := true;

        WOM.SetCurrentKey(WOM."Work Order Master No.");
        WOM.Get("Work Order Master No.");

        if SHP <> '' then begin
            Instructions := true;
            if "SHP Date" > WOM."Date Ordered" then
                NewInstruction := true;
        end;

        // Step,Model
        WI.SetRange(WI."Customer Code", '');
        WI.SetRange(WI."Ship To Code", '');
        WI.SetRange(WI.Step, "Detail Step");
        WI.SetRange(WI.Model, "Model No.");
        if WI.Find('-') then begin
            Instructions := true;
            if WI."Date Last Modified" > WOM."Date Ordered" then
                NewInstruction := true;
        end;
        WI.Reset;


        // Step,Customer
        WI.SetRange(WI."Customer Code", "Customer ID");
        WI.SetRange(WI."Ship To Code", '');
        WI.SetRange(WI.Step, "Detail Step");
        WI.SetRange(WI.Model, '');
        if WI.Find('-') then begin
            Instructions := true;
            if WI."Date Last Modified" > WOM."Date Ordered" then
                NewInstruction := true;
        end;
        WI.Reset;

        //Step,Customer,Model
        WI.SetRange(WI."Customer Code", "Customer ID");
        WI.SetRange(WI."Ship To Code", '');
        WI.SetRange(WI.Step, "Detail Step");
        WI.SetRange(WI.Model, "Model No.");
        if WI.Find('-') then begin
            Instructions := true;
            if WI."Date Last Modified" > WOM."Date Ordered" then
                NewInstruction := true;
        end;
        WI.Reset;

        //Step,Customer,ShipTo
        WI.SetRange(WI."Customer Code", "Customer ID");
        WI.SetRange(WI."Ship To Code", WOM."Ship To Code");
        WI.SetRange(WI.Step, "Detail Step");
        WI.SetRange(WI.Model, '');
        if WI.Find('-') then begin
            Instructions := true;
            if WI."Date Last Modified" > WOM."Date Ordered" then
                NewInstruction := true;
        end;
        WI.Reset;


        //Step,Customer,ShiptTo,Model
        WI.SetRange(WI."Customer Code", "Customer ID");
        WI.SetRange(WI."Ship To Code", WOM."Ship To Code");
        WI.SetRange(WI.Step, "Detail Step");
        WI.SetRange(WI.Model, "Model No.");
        if WI.Find('-') then begin
            Instructions := true;
            if WI."Date Last Modified" > WOM."Date Ordered" then
                NewInstruction := true;
        end;
        WI.Reset;

        if Instructions then begin
            WorkInstructionsVisible := true;
            if NewInstruction then begin
                MessageShowed := MessageShowed + 1;
                if MessageShowed = 1 then
                    Message('Work Instructions have been updated, Please Read');
            end;
        end else begin
            WorkInstructionsVisible := false;
        end;

        if "Non Copper" then
            NonCopperVisible := true
        else
            NonCopperVisible := false;
    end;

    trigger OnOpenPage()
    begin
        LabelsToPrint := 1;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        if not Dialog.Confirm('Is this order completed?', false) then
            if Dialog.Confirm('Do you want to close this page without completing the order?', false) then begin
                WorkOrderDetail.Reset;
                WorkOrderDetail.SetCurrentKey("Work Order Master No.");
                WorkOrderDetail.SetRange(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
                if WorkOrderDetail.Find('-') then begin
                    repeat
                        WorkOrderDetail.Ship := false;
                        WorkOrderDetail.Modify;
                    //Commit;
                    until WorkOrderDetail.Next = 0;
                end;
                exit(true);

            end else
                exit(false);

        Rec.Complete := true;
        Rec.Modify();
        exit(true);
    end;

    var
        Window: Dialog;
        WorkOrderDetail: Record WorkOrderDetail;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOD2: Record WorkOrderDetail;
        PlaceOnLine: Boolean;
        WOS: Record Status;
        Ok: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        WOP: Record Parts;
        SalesLineNo: Integer;
        ShipTo: Record "Ship-to Address";
        ShipmentWeight: Integer;
        Tracking: Text[30];
        Shipper: Code[3];
        ShippingTime: Decimal;
        TempCarrier: Code[20];
        TempMethod: Code[10];
        TempAccount: Code[30];
        TempCharge: Enum ShippingCharge;
        //TempCharge: Option;
        TotalContainerQuantity: Integer;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        POTest: Code[30];
        BOL: Record BillOfLading;
        BOL2: Record BillOfLading;
        BOL3: Record BillOfLading;
        BOLNo: Integer;
        LabelsToPrint: Integer;
        LabelCount: Integer;
        PrintNow: Boolean;
        ContainerType: Option " ",Skid,Box,Crate,Drum,"Skid Box",Loose;
        GPS: Record "General Posting Setup";
        Item: Record Item;
        SerialNo: Code[20];
        ResourceCost: Decimal;
        PartsCost: Decimal;
        AdjRemainder: Decimal;
        ShopLabor: Decimal;
        PartsPrice: Decimal;
        BL: Code[10];
        SO: Code[10];
        ReturnInventoryQty: Decimal;
        UR: Boolean;
        R: Boolean;
        NoCharge: Boolean;
        Charge: Boolean;
        BLInteger: Integer;
        Warranty: Boolean;
        NonWarranty: Boolean;
        RemoveInventoryQty: Decimal;
        ZeroDollars: Decimal;
        SystemShipment: Boolean;
        WODSystem: Record WorkOrderDetail;
        IncompleteSystem: Boolean;
        SystemWO: Text[50];
        PartsComplete: Record Parts;
        Instructions: Boolean;
        NewInstruction: Boolean;
        WI: Record WorkInstructions;
        WSI: Record Status;
        MessageShowed: Integer;
        WODPM: Record WorkOrderDetail;
        WOSPM: Record Status;
        InstructionRead: Boolean;
        [InDataSet]
        WorkInstructionsVisible: Boolean;
        [InDataSet]
        NonCopperVisible: Boolean;
        NonCopperMessage: Label 'Blank';
        ItemLedgEntryType: Enum "Item Ledger Entry Type";
        ExitBool: Boolean;
        NothingToShip: Boolean;

    procedure URCheck()
    begin
        UR := false;
        R := false;
        NoCharge := false;
        Charge := false;
        Warranty := false;
        NonWarranty := false;
        NothingToShip := true;

        if WOD.Find('-') then begin
            repeat
                if WOD."Unrepairable Handling" <> WOD."Unrepairable Handling"::" " then
                    UR := true
                else
                    R := true;
            until WOD.Next = 0;
            NothingToShip := false;
        end;

        if UR and R then
            Error('Can''t Ship an Unrepairable Pump with a Repairable Pump on same Bill of Lading');

        if R then begin
            if WOD.Find('-') then begin
                repeat
                    if WOD."Order Type" = WOD."Order Type"::Warranty then
                        Warranty := true
                    else
                        NonWarranty := true;
                until WOD.Next = 0;
            end;

            if Warranty and NonWarranty then
                Error('Can''t Ship Warranty Pump with a Non Warranty Pump on same Bill of Lading');

            if NonWarranty then
                Repairable;

            if Warranty then
                WarrantyShip;

            //Check for Pump Module
            if WOD."Pump Module No." <> '' then
                PumpModule;
        end;


        if UR then begin
            if WOD.Find('-') then begin
                repeat
                    if WOD."Unrepairable Charge" > 0 then
                        Charge := true
                    else
                        NoCharge := true;
                until WOD.Next = 0;
            end;

            if Charge and NoCharge then
                URCharge;
            if Charge and (NoCharge = false) then
                URCharge;
            if NoCharge then
                URNoCharge;
        end;
    end;

    procedure Repairable()
    begin
        if WOD.Find('-') then begin
            if Confirm('Carrier is %1, Method is %2, \' +
                     'Charge is %3, Account is %4, \' +
                     'are these correct?', false, WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge", WOD."Shipping Account")
            then begin

                if BOL.Find('+') then
                    BLInteger := BOL."Bill of Lading" + 1
                else
                    BLInteger := 100000;

                TempCarrier := WOD.Carrier;
                TempMethod := WOD."Shipping Method";
                TempCharge := WOD."Shipping Charge";
                TempAccount := WOD."Shipping Account";
                SalesLineNo := SalesLineNo + 10000;

                // Checks for Invoice Amount > 0
                WOD.CalcFields(WOD."Original Parts Price", WOD."Original Labor Price");
                if (Round(WOD."Original Labor Price" + WOD."Original Parts Price" + WOD."Order Adj.") > 0)
                or (WOD."System Shipment") then begin
                    POCheck;
                    CreateOrder;

                    repeat
                        ResourceCost := 0;
                        PartsCost := 0;
                        WOD.CalcFields(WOD."Original Parts Price", WOD."Original Labor Price");
                        CreateLines;
                        UpdateWOD;
                        UpdateParts;
                        UpdateWOS;

                    until WOD.Next = 0;
                    CreateShippingLine;
                    Reservation; // COMMIT included!
                    CreateBOLRecords;
                    //PrintBOL; // another COMMIT
                    //PrintLabels;
                end else begin
                    ZeroChargeRepairable;
                end;

            end;
        end;
    end;

    procedure ZeroChargeRepairable()
    begin
        repeat
            WOP.Reset;
            WOP.SetCurrentKey("Work Order No.", "Part No.");
            WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
            WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
            WOP.SetFilter(WOP."Pulled Quantity", '>0');
            if WOP.Find('-') then begin
                repeat
                    if Item.Get(WOP."Part No.") then begin
                        WOP.CalcFields(WOP."In-Process Quantity");
                        if Item."Costing Method" = Item."Costing Method"::Specific then
                            SerialNo := WOP."Serial No."
                        else
                            SerialNo := '';
                        ReturnInventory;
                        RemoveInventory;
                        WOP."In-Process Quantity" := 0;
                        WOP.Modify;
                    end;
                until WOP.Next = 0;
            end;
            UpdateWOD;
            UpdateParts;
            UpdateWOS;
        until WOD.Next = 0;
        CreateBOLRecords;
        //PrintBOL;
        //PrintLabels;
    end;

    procedure WarrantyShip()
    begin
        if WOD.Find('-') then begin
            if Confirm('Carrier is %1, Method is %2, \' +
                     'Charge is %3, Account is %4, \' +
                     'are these correct?', false, WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge", WOD."Shipping Account")
            then begin

                if BOL.Find('+') then
                    BLInteger := BOL."Bill of Lading" + 1
                else
                    BLInteger := 100000;

                TempCarrier := WOD.Carrier;
                TempMethod := WOD."Shipping Method";
                TempCharge := WOD."Shipping Charge";
                TempAccount := WOD."Shipping Account";

                repeat
                    WOP.Reset;
                    WOP.SetCurrentKey("Work Order No.", "Part No.");
                    WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
                    WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
                    WOP.SetFilter(WOP."Pulled Quantity", '>0');
                    if WOP.Find('-') then begin
                        repeat
                            if Item.Get(WOP."Part No.") then begin
                                WOP.CalcFields(WOP."In-Process Quantity");
                                if Item."Costing Method" = Item."Costing Method"::Specific then
                                    SerialNo := WOP."Serial No."
                                else
                                    SerialNo := '';
                                ReturnInventory;
                                RemoveInventory;
                                WOP."In-Process Quantity" := 0;
                                WOP.Modify;
                            end;
                        until WOP.Next = 0;
                    end;
                    UpdateWOD;
                    UpdateParts;
                    UpdateWOS;
                until WOD.Next = 0;
                CreateBOLRecords;
                //PrintBOL;
                //PrintLabels;
            end;
        end;
    end;

    procedure URCharge()
    begin
        if WOD.Find('-') then begin
            if Confirm('Carrier is %1, Method is %2, \' +
                     'Charge is %3, Account is %4, \' +
                     'are these correct?', false, WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge", WOD."Shipping Account")
            then begin
                if BOL.Find('+') then
                    BLInteger := BOL."Bill of Lading" + 1
                else
                    BLInteger := 100000;

                TempCarrier := WOD.Carrier;
                TempMethod := WOD."Shipping Method";
                TempCharge := WOD."Shipping Charge";
                TempAccount := WOD."Shipping Account";
                SalesLineNo := SalesLineNo + 10000;
                POCheck;
                CreateOrder;

                repeat
                    URCreatelines;
                    UpdateWOD;
                    UpdateParts;
                    UpdateWOS;
                until WOD.Next = 0;

                CreateShippingLine;
                CreateBOLRecords;
                //PrintBOL;
                //PrintLabels;
            end;
        end;
    end;

    procedure URNoCharge()
    begin
        if WOD.Find('-') then begin
            if Confirm('Carrier is %1, Method is %2, \' +
                     'Charge is %3, Account is %4, \' +
                     'are these correct?', false, WOD.Carrier, WOD."Shipping Method", WOD."Shipping Charge", WOD."Shipping Account")
            then begin
                if BOL.Find('+') then
                    BLInteger := BOL."Bill of Lading" + 1
                else
                    BLInteger := 100000;

                TempCarrier := WOD.Carrier;
                TempMethod := WOD."Shipping Method";
                TempCharge := WOD."Shipping Charge";
                TempAccount := WOD."Shipping Account";
                repeat
                    UpdateWOD;
                    UpdateParts;
                    UpdateWOS;
                until WOD.Next = 0;

                CreateBOLRecords;
                //PrintBOL;
                //PrintLabels;
            end;
        end;
    end;

    procedure InitSalesHeaderRecord()
    begin
        if (SalesHeader."No. Series" <> '') and
           (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
        then
            SalesHeader."Posting No. Series" := SalesHeader."No. Series"
        else
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
        if SalesSetup."Shipment on Invoice" then
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
    end;

    procedure CreateOrder()
    begin

        Clear(SalesHeader);

        SalesHeader.Init;
        SalesSetup.Get;

        if SalesHeader."No." = '' then begin
            // INSERTED 3/21/01 HEF
            if SO <> '' then
                SalesHeader."No." := SO
            else
                SalesHeader."No." := WOD."Work Order No.";
        end;

        // BOL FIX
        // HEF  NoSeriesMgt.InitSeries
        // HEF  (SalesSetup."Order Nos.",SalesHeader."No. Series",TODAY,SalesHeader."No.",SalesHeader."No. Series");

        InitSalesHeaderRecord;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Validate("Sell-to Customer No.", WOM.Customer);
        ShipTo.Get(SalesHeader."Sell-to Customer No.", WOM."Ship To Code");
        SalesHeader.Validate("Posting Date", Today);
        SalesHeader."Order Date" := WOD."Work Order Date";
        SalesHeader."Ship-to Code" := WOM."Ship To Code";
        SalesHeader."Ship-to Name" := WOD."Ship To Name";
        SalesHeader."Ship-to Address" := WOD."Ship To Address 1";
        SalesHeader."Ship-to Address 2" := WOD."Ship To Address 2";
        SalesHeader."Ship-to City" := WOD."Ship To City";
        SalesHeader."Ship-to County" := WOD."Ship To State";
        SalesHeader."Ship-to Post Code" := WOD."Ship To Zip Code";
        SalesHeader."Ship-to Contact" := WOD.Attention;
        SalesHeader."Document Date" := Today;
        SalesHeader."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
        SalesHeader."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
        SalesHeader.Rep := ShipTo.Rep;
        SalesHeader."Salesperson Code" := ShipTo."Inside Sales";
        SalesHeader."Payment Terms Code" := WOD."Payment Terms";
        SalesHeader."Card Type" := WOD."Card Type";
        SalesHeader."Credit Card No." := WOD."Credit Card No.";
        SalesHeader."Credit Card Exp." := WOD."Credit Card Exp.";
        SalesHeader."Approval Code" := WOD."Approval Code";
        SalesHeader."Shipment Date" := Today;
        SalesHeader."Shipment Method Code" := WOD."Shipping Method";
        SalesHeader."Shipping Agent Code" := WOD.Carrier;
        SalesHeader."Shipping Charge" := WOD."Shipping Charge";
        SalesHeader."Shipping Account" := WOD."Shipping Account";
        SalesHeader."Package Tracking No." := Tracking;
        SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Partial;
        SalesHeader."Bill of Lading" := BLInteger;

        if WOD."Tax Liable" = true then begin
            SalesHeader."Tax Liable" := true;
            SalesHeader."Tax Area Code" := 'MD';
        end else begin
            SalesHeader."Tax Liable" := false;
            SalesHeader."Tax Area Code" := '';
        end;

        if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
            if SalesHeader."Tax Liable" = false then begin
                SalesHeader."Tax Exemption No." := Customer."Tax Exemption No.";
                SalesHeader."Exempt Organization" := Customer."Exempt Organization";
            end;
        end else begin
            SalesHeader."Tax Exemption No." := '';
            SalesHeader."Exempt Organization" := '';
        end;

        if PlaceOnLine = false then
            SalesHeader."Your Reference" := POTest
        else
            SalesHeader."Your Reference" := 'See Line Items';

        SalesHeader."Shortcut Dimension 2 Code" := 'WO';
        SalesHeader.Insert;
    end;

    procedure CreateLines()
    var
        PurchLine: Record "Purchase Line";

    begin
        //>> Work Order No. & Order Type
        LineLoop;
        SalesLine.Type := SalesLine.Type::" ";
        SalesLine.Validate("No.", '');
        SalesLine.Description := WOD."Work Order No." + ' ' + Format(WOD."Order Type");
        // + 'Total Price: ' + FORMAT(ROUND(WOD."Quote Price")); //REMOVED PER BLF 6/12/01
        SalesLine."Commission Calculated" := FALSE;
        SalesLine."Cross Reference Item" := WOD."Model No.";
        SalesLine.Insert;

        //>> Description
        if WOD.Description <> '' then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.Validate("No.", '');
            SalesLine.Description := WOD.Description;
            SalesLine."Commission Calculated" := FALSE;
            SalesLine.Insert;
        end;

        //>> Serial No. Info
        if WOD."Serial No." <> '' then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.Validate("No.", '');
            SalesLine.Description := 'S/N' + ' ' + WOD."Serial No.";
            SalesLine."Commission Calculated" := FALSE;
            SalesLine.Insert;
        end;

        //>>Customer Part Number
        if WOD."Customer Part No." <> '' then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.Validate("No.", '');
            SalesLine.Description := 'Customer P/N' + ' ' + WOD."Customer Part No.";
            SalesLine."Commission Calculated" := FALSE;
            SalesLine.Insert;
        end;

        //>> Customer P.O. Info
        if PlaceOnLine = true then begin
            if WOD."Customer PO No." <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := 'PO No.' + ' ' + WOD."Customer PO No.";
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;
        end;

        //>> Credit Card Approval Code
        if WOD."Approval Code" <> '' then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.Validate("No.", '');
            SalesLine.Description := 'Approval Code No.' + ' ' + WOD."Approval Code";
            SalesLine."Commission Calculated" := FALSE;
            SalesLine.Insert;
        end;

        //Determine If PUMP MODULE for order creation handling
        if WOD."Pump Module No." <> '' then begin
            //Parts Total
            //Determine The Shop Labor Total
            WOP.Reset;
            WOP.SetCurrentKey("Work Order No.", "Part No.");
            WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
            WOP.SetRange(WOP."Part Type", WOP."Part Type"::Resource);
            WOP.SetRange(WOP."Part No.", '1'); //Shop Labor
            if WOP.Find('-') then begin
                ShopLabor := WOP."Total Quote Price";
                PartsPrice := (WOD."Original Parts Price" + WOD."Original Labor Price" - WOP."Total Quote Price");
            end else begin
                ShopLabor := 0;
                PartsPrice := (WOD."Original Parts Price" + WOD."Original Labor Price");
            end;

            AdjRemainder := 0;
            if WOD."Order Adj." < 0 then begin
                //ABS added to return a positive number
                if Abs(WOD."Order Adj.") > PartsPrice then begin
                    AdjRemainder := PartsPrice + WOD."Order Adj.";
                end else begin
                    if Round(PartsPrice + WOD."Order Adj.") > 0 then begin
                        LineLoop;
                        SalesLine.Type := SalesLine.Type::"G/L Account";
                        GPSLoop;
                        SalesLine.Validate(Quantity, 1);
                        SalesLine.Description := 'Parts ';
                        SalesLine."Unit Price" := Round(PartsPrice + WOD."Order Adj.");
                        SalesLine.Validate("Unit Price");

                        if SalesHeader."Tax Liable" then begin
                            SalesLine."Tax Group Code" := 'DEFAULT';
                            SalesLine."Tax Area Code" := 'MD';
                            SalesLine."Tax Liable" := true;
                            SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
                            SalesLine.Validate(Quantity);
                        end;

                        IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                            SalesLine."Commission Calculated" := FALSE
                        ELSE
                            SalesLine."Commission Calculated" := TRUE;
                        SalesLine.Insert;
                    end;
                end;
            end else begin
                if Round(PartsPrice + WOD."Order Adj.") > 0 then begin
                    LineLoop;
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                    GPSLoop;
                    SalesLine.Validate(Quantity, 1);
                    SalesLine.Description := 'Parts ';
                    SalesLine."Unit Price" := Round(PartsPrice + WOD."Order Adj.");
                    SalesLine.Validate("Unit Price");

                    if SalesHeader."Tax Liable" then begin
                        SalesLine."Tax Group Code" := 'DEFAULT';
                        SalesLine."Tax Area Code" := 'MD';
                        SalesLine."Tax Liable" := true;
                        SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
                        SalesLine.Validate(Quantity);
                    end;

                    IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                        SalesLine."Commission Calculated" := FALSE
                    ELSE
                        SalesLine."Commission Calculated" := TRUE;
                    SalesLine.Insert;
                end;
            end;

            //Labor Total
            if Round(ShopLabor + AdjRemainder) > 0 then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                if GPS."Sales Account" = '' then
                    GPSLoop;
                SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Labor ';
                SalesLine."Unit Price" := Round(ShopLabor + AdjRemainder);
                SalesLine.Validate("Unit Price");

                /// 1/18/2021 ICE Start 
                SalesLine."Tax Area Code" := '';
                SalesLine."Tax Liable" := false;
                /// 1/18/2021 ICE End

                IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                    SalesLine."Commission Calculated" := FALSE
                ELSE
                    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
            end;

            //Standard Customer Quote
        end else begin
            //Parts Total
            // Inserted 2/6/01  move adjustment from Labor to Parts, but if parts go below zero move rest back to labor
            AdjRemainder := 0;
            if WOD."Order Adj." < 0 then begin
                //>>03/15/01 ABS added to return a positive number
                if Abs(WOD."Order Adj.") > WOD."Original Parts Price" then begin
                    AdjRemainder := WOD."Original Parts Price" + WOD."Order Adj.";
                end else begin
                    if Round(WOD."Original Parts Price" + WOD."Order Adj.") > 0 then begin
                        LineLoop;
                        SalesLine.Type := SalesLine.Type::"G/L Account";
                        GPSLoop;
                        SalesLine.Validate(Quantity, 1);
                        SalesLine.Description := 'Parts ';
                        SalesLine."Unit Price" := Round(WOD."Original Parts Price" + WOD."Order Adj.");
                        SalesLine.Validate("Unit Price");

                        if SalesHeader."Tax Liable" then begin
                            SalesLine."Tax Group Code" := 'DEFAULT';
                            SalesLine."Tax Area Code" := 'MD';
                            SalesLine."Tax Liable" := true;
                            SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
                            SalesLine.Validate(Quantity);
                        end;

                        IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                            SalesLine."Commission Calculated" := FALSE
                        ELSE
                            SalesLine."Commission Calculated" := TRUE;
                        SalesLine.Insert;
                    end;
                end;
            end else begin
                if Round(WOD."Original Parts Price" + WOD."Order Adj.") > 0 then begin
                    LineLoop;
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                    GPSLoop;
                    SalesLine.Validate(Quantity, 1);
                    SalesLine.Description := 'Parts ';
                    SalesLine."Unit Price" := Round(WOD."Original Parts Price" + WOD."Order Adj.");
                    SalesLine.Validate("Unit Price");

                    if SalesHeader."Tax Liable" then begin
                        SalesLine."Tax Group Code" := 'DEFAULT';
                        SalesLine."Tax Area Code" := 'MD';
                        SalesLine."Tax Liable" := true;
                        SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
                        SalesLine.Validate(Quantity);
                    end;

                    IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                        SalesLine."Commission Calculated" := FALSE
                    ELSE
                        SalesLine."Commission Calculated" := TRUE;
                    SalesLine.Insert;
                end;
            end;
            //End 2/6/01 mod.

            //Labor Total
            if Round(WOD."Original Labor Price" + AdjRemainder) > 0 then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                if GPS."Sales Account" = '' then
                    GPSLoop;
                SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Labor ';
                SalesLine."Unit Price" := Round(WOD."Original Labor Price" + AdjRemainder);
                SalesLine.Validate("Unit Price");

                /// 1/18/2021 ICE Start 
                SalesLine."Tax Area Code" := '';
                SalesLine."Tax Liable" := false;
                /// 1/18/2021 ICE End

                IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                    SalesLine."Commission Calculated" := FALSE
                ELSE
                    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
            end;
        end;

        //UPS HANDLING
        if WOD.Carrier = 'UPS' then begin
            if (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid") or
               (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine.Validate("No.", '311');   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Handling Charge';
                SalesLine.Validate("Unit Price", SalesSetup."UPS Handling Charge");
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;
        end;

        //UPS SHIPPING
        if WOD.Carrier = 'UPS' then begin
            if (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid") or
               (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine.Validate("No.", '312');   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'UPS Shipping Charge';
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;
        end;

        //InBound Freight Charge
        if WOD."Freightin Bill Customer" = true then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::"G/L Account";
            SalesLine.Validate("No.", '312');   //Sales Account
            SalesLine.Validate(Quantity, 1);
            SalesLine.Description := 'Inbound Freight Charge';
            SalesLine.Validate("Unit Price", WOD.Freightin);
            SalesLine."Commission Calculated" := FALSE;
            SalesLine.Insert;
        end;


        //>>Create Resources Line
        WOP.Reset;
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Resource);
        WOP.SetFilter(WOP."Quoted Quantity", '>0');
        if WOP.Find('-') then begin
            repeat
                LineLoop;
                SalesLine.Type := SalesLine.Type::Resource;
                SalesLine.Validate("No.", WOP."Part No.");   //Shop Labor
                SalesLine.Validate(Quantity, WOP."Quoted Quantity");
                SalesLine.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");

                IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                    SalesLine."Commission Calculated" := FALSE
                ELSE
                    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
                ResourceCost := ResourceCost + WOP."Total Quote Cost";
            until WOP.Next = 0;
        end;

        //>>Create Parts Lines
        WOP.Reset;
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
        WOP.SetFilter(WOP."Pulled Quantity", '>0');
        if WOP.Find('-') then begin
            repeat
                if Item.Get(WOP."Part No.") then begin
                    WOP.CalcFields(WOP."In-Process Quantity");
                    if Item."Costing Method" = Item."Costing Method"::Specific then begin
                        SerialNo := WOP."Serial No."
                    end else begin
                        SerialNo := ''
                    end
                end;

                ReturnInventory;
                LineLoop;
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", WOP."Part No.");

                ///--! SN
                //IF Item."Costing Method" = Item."Costing Method" :: Specific THEN BEGIN
                //  SalesLine."Serial No." := SerialNo
                //END;

                ///
                SalesLine.Validate(Reserve, SalesLine.Reserve::Always);
                SalesLine.Validate(Quantity, WOP."Pulled Quantity");
                SalesLine.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                if SalesLine."VAT Prod. Posting Group" = '' then
                    SalesLine."VAT Prod. Posting Group" := 'DEFAULT';

                IF WOD."Order Type" = WOD."Order Type"::Warranty THEN
                    SalesLine."Commission Calculated" := FALSE
                ELSE
                    SalesLine."Commission Calculated" := TRUE;

                SalesLine.Insert;

                /// Set Serial No
                /// 
                /// Create Reservation Entry for Parts
                if SerialNo <> '' then
                    if not WOD.SetSerialNo_(37, SalesLine, PurchLine, SerialNo) then
                        Error('Serial No. %1 not saved for the line %2.', SerialNo, SalesLine."Line No.");
                ////Commit;                
                PartsCost := PartsCost + WOP."Total Quote Cost";
                WOP."In-Process Quantity" := 0;
                WOP.Modify;
            until WOP.Next = 0;
        end;
    end;

    procedure CreateShipping()
    begin
    end;

    procedure URCreatelines()
    begin
        if (WOD."Unrepairable Charge" > 0) or (WOD."Freightin Bill Customer" = true) then begin
            //>> Work Order No. & Order Type
            LineLoop;
            SalesLine.Type := SalesLine.Type::" ";
            SalesLine.Validate("No.", '');
            SalesLine.Description := WOD."Work Order No." + ' ' + Format(WOD."Order Type");
            // + 'Total Price: ' + FORMAT(ROUND(WOD."Quote Price")); //REMOVED PER BLF 6/12/01
            SalesLine."Commission Calculated" := FALSE;
            SalesLine."Cross Reference Item" := WOD."Model No.";
            SalesLine.Insert;

            //>> Description
            if WOD.Description <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := WOD.Description;
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;

            //>> Serial No. Info
            if WOD."Serial No." <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := 'S/N' + ' ' + WOD."Serial No.";
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;

            //>>Customer Part Number
            if WOD."Customer Part No." <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := 'Customer P/N' + ' ' + WOD."Customer Part No.";
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;

            //>> Customer P.O. Info
            if PlaceOnLine = true then begin
                if WOD."Customer PO No." <> '' then begin
                    LineLoop;
                    SalesLine.Type := SalesLine.Type::" ";
                    SalesLine.Validate("No.", '');
                    SalesLine.Description := 'PO No.' + ' ' + WOD."Customer PO No.";
                    SalesLine."Commission Calculated" := FALSE;
                    SalesLine.Insert;
                end;
            end;

            //>> Credit Card Approval Code
            if WOD."Approval Code" <> '' then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::" ";
                SalesLine.Validate("No.", '');
                SalesLine.Description := 'Approval Code No.' + ' ' + WOD."Approval Code";
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;

        end;

        if WOD."Unrepairable Charge" > 0 then begin
            //UnRepairable Charge
            LineLoop;
            SalesLine.Type := SalesLine.Type::"G/L Account";
            GPSLoop;
            SalesLine.Validate(Quantity, 1);
            SalesLine.Description := 'UnRepairable Charge';
            SalesLine."Unit Price" := WOD."Unrepairable Charge";
            SalesLine.Validate("Unit Price");
            SalesLine."Commission Calculated" := TRUE;
            SalesLine.Insert;
        end;

        //UPS HANDLING
        if WOD.Carrier = 'UPS' then begin
            if (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid") or
                (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine.Validate("No.", '311');   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Handling Charge';
                SalesLine.Validate("Unit Price", SalesSetup."UPS Handling Charge");
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;
        end;

        //UPS SHIPPING
        if WOD.Carrier = 'UPS' then begin
            if (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid") or
                (WOD."Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                SalesLine.Validate("No.", '312');   //Sales Account
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'UPS Shipping Charge';
                SalesLine."Commission Calculated" := FALSE;
                SalesLine.Insert;
            end;
        end;

        //InBound Freight Charge
        if WOD."Freightin Bill Customer" = true then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::"G/L Account";
            SalesLine.Validate("No.", '312');   //Sales Account
            SalesLine.Validate(Quantity, 1);
            SalesLine.Description := 'Inbound Freight Charge';
            SalesLine.Validate("Unit Price", WOD.Freightin);
            SalesLine."Commission Calculated" := FALSE;
            SalesLine.Insert;
        end;
    end;

    procedure CreateShippingLine()
    begin
        //>> Shippment Information
        LineLoop;
        SalesLine.Type := SalesLine.Type::" ";
        SalesLine.Description := 'Total Shipment Weight is ' + Format(ShipmentWeight) + ' lbs';
        SalesLine.Insert;
    end;

    procedure UpdateWOD()
    begin
        WOD.Carrier := TempCarrier;
        WOD."Shipping Method" := TempMethod;
        WOD."Shipping Charge" := TempCharge;
        WOD."Shipping Account" := TempAccount;
        WOD."Ship Date" := WorkDate;
        WOD.Complete := true;
        WOD."Bill of Lading" := BLInteger;
        WOD."Package Tracking No." := Tracking;
        WOD.Modify;
    end;

    procedure UpdateWOS()
    begin
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", WOD."Work Order No.");
        if WOS.Find('+') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS."Regular Hours" := ShippingTime;
            WOS.Employee := Shipper;
            WOS.Modify;
        end;
    end;

    procedure UpdateParts()
    begin
        PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
        PartsComplete.SetRange(PartsComplete."Work Order No.", WOD."Work Order No.");
        if PartsComplete.Find('-') then begin
            repeat
                PartsComplete.Complete := true;
                PartsComplete.Modify;
            until PartsComplete.Next = 0;
        end;
    end;

    procedure POCheck()
    begin
        WOD2.SetCurrentKey(WOD2."Work Order No.");
        WOD2.SetRange(WOD2.Ship, true);
        WOD2.SetRange(WOD2.Complete, false);
        if WOD2.Find('-') then begin
            repeat
                if PlaceOnLine = false then begin
                    if POTest <> '' then begin
                        if POTest <> WOD2."Customer PO No." then begin
                            PlaceOnLine := true
                        end else begin
                            POTest := WOD2."Customer PO No.";
                            PlaceOnLine := false;
                        end;
                    end else begin
                        POTest := WOD2."Customer PO No.";
                        PlaceOnLine := false;
                    end;
                end;
            until WOD2.Next = 0;
        end
    end;

    procedure TaxCheck()
    begin
    end;

    procedure CreateBOLRecords()
    begin
        BOL2.Init;
        BOL2."Bill of Lading" := BLInteger;
        BOL2."Order No." := WOD."Work Order No.";
        BOL2.Customer := WOD."Customer ID";
        BOL2."PO No." := WOD."Customer PO No.";
        BOL2."Ship To Name" := WOD."Ship To Name";
        BOL2."Ship To Address" := WOD."Ship To Address 1";
        BOL2."Ship To Address2" := WOD."Ship To Address 2";
        BOL2."Ship To City" := WOD."Ship To City";
        BOL2."Ship To State" := WOD."Ship To State";
        BOL2."Ship To Zip Code" := WOD."Ship To Zip Code";
        BOL2.Attention := WOD.Attention;
        BOL2."Phone No." := WOD."Phone No.";
        BOL2."Shipping Weight" := ShipmentWeight;
        BOL2."Container Quantity" := TotalContainerQuantity;
        BOL2.Employee := Shipper;
        // 04/17/18 start
        //BOL2."Container Type" := ContainerType;
        BOL2."Container Type" := WOD."Container Type";
        // 04/17/18 end
        BOL2.Carrier := TempCarrier;
        BOL2."Shipping Method" := TempMethod;
        BOL2."Shipping Charge" := ConvertBOLShipCharge(TempCharge);
        BOL2."Shipping Account" := TempAccount;
        BOL2."Shipment Date" := WorkDate;
        BOL2."Label Quantity" := LabelsToPrint;
        BOL2."RMA No." := WOD."RMA No.";
        BOL2.Insert;

    end;

    procedure PrintBOL()
    begin
        ///--! Commit
        //Commit;
        if not Confirm('Is Bill of Lading loaded in Printer?', false) then
            if not Confirm('Last Chance, Is Bill of Lading loaded in Printer?', false) then
                //Ok := true;
                Exit;
        //end else begin
        BOL2.Reset;
        BOL2.SetRange("Bill of Lading", Rec."Bill of Lading");
        if not BOL2.FindFirst() then
            Error('Cannot find BOL %1', Rec."Bill of Lading");
        ///--! Report
        REPORT.RunModal(50016, false, false, BOL2);               // BOL Document Print 
        BOL2."BOL Printed" := true;
        BOL2.Modify;
        CurrPage.Update();

        //end;
        /*
        end else begin
            BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
            ///--! Report
            //REPORT.RunModal(50016, false, false, BOL2);               // BOL Document
            BOL2."BOL Printed" := true;
            BOL2.Modify;
            LabelCount := LabelsToPrint;
            if LabelCount > 0 then begin
                repeat
                begin
                    LabelCount := LabelCount - 1;
                    ///--! Report
                    //REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                end;
                until LabelCount = 0;
                BOL2."Label Printed" := true;
            end else begin
                BOL2."Label Printed" := false;
            end;
            BOL2.Modify;
            ConfirmLabels;
        end;
        */
    end;

    procedure PrintLabels()
    var
        LabelsPrinted: Boolean;
    begin
        LabelCount := LabelsToPrint;
        BOL2.Reset();
        BOL2.SetRange("Bill of Lading", Rec."Bill of Lading");
        if not BOL2.FindFirst() then
            Error('Cannot find BOL %1', Rec."Bill of Lading");

        if LabelCount > 0 then begin
            if not Confirm('Is Label Printer ready?', false) then
                if not Confirm('Last Chance, is Label Printer ready?', false) then
                    Exit;
            repeat begin
                LabelCount := LabelCount - 1;
                ///--! Report
                REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
            end until LabelCount = 0;
            LabelsPrinted := true;
        end else
            LabelsPrinted := false;
        BOL2.Get(Rec."Bill of Lading");
        BOL2."Label Printed" := LabelsPrinted;
        BOL2.Modify;

        //ConfirmLabels;
    end;

    procedure ConfirmLabels()
    begin
        if not Confirm('Did Bill of Lading & labels print correctly?', false) then begin
            BOL2."BOL Printed" := false;
            BOL2."Label Printed" := false;
            BOL2.Modify;
            if not Confirm('Do you want to reprint?', false) then begin
                Ok := true;
            end else begin
                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                REPORT.RunModal(50016, false, false, BOL2);               // BOL Document
                BOL2."BOL Printed" := true;
                BOL2.Modify;
                LabelCount := LabelsToPrint;
                if LabelCount > 0 then begin
                    repeat
                    begin
                        LabelCount := LabelCount - 1;
                        REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                    end;
                    until LabelCount = 0;
                    BOL2."Label Printed" := true;
                end else begin
                    BOL2."Label Printed" := false;
                end;
                BOL2.Modify;
                ConfirmLabels;
            end;
        end;
    end;

    procedure LineLoop()
    begin
        Clear(SalesLine);
        SalesLineNo := SalesLineNo + 10000;
        SalesLine.Init;
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Line No." := SalesLineNo;
        SalesLine.Validate(SalesLine."Document No.", SalesHeader."No.");
    end;

    procedure GPSLoop()
    begin
        // ,SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO
        if (WOD."Income Code" = WOD."Income Code"::Service) then begin
            GPS.Get('', 'REPAIR');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (WOD."Income Code" = WOD."Income Code"::Sales) then begin
            GPS.Get('', 'PP SALES');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (WOD."Income Code" = WOD."Income Code"::Turbo) then begin
            GPS.Get('', 'TURBO');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (WOD."Income Code" = WOD."Income Code"::Electronic) then begin
            GPS.Get('', 'ELECTRONIC');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (WOD."Income Code" = WOD."Income Code"::Dry) then begin
            GPS.Get('', 'DRY PUMP');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (WOD."Income Code" = WOD."Income Code"::Cryo) then begin
            GPS.Get('', 'CRYO');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
    end;
    // ,SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO

    procedure GPSLoopNoGLEntry()
    begin
        if (WOD."Income Code" = WOD."Income Code"::Cryo) then begin
            GPS.Get('', 'CRYO');
        end;
        if (WOD."Income Code" = WOD."Income Code"::Dry) then begin
            GPS.Get('', 'DRY');
        end;
        if (WOD."Income Code" = WOD."Income Code"::Electronic) then begin
            GPS.Get('', 'ELECTRONIC');
        end;
        if (WOD."Income Code" = WOD."Income Code"::Sales) then begin
            GPS.Get('', 'PP SALES');
        end;
        if (WOD."Income Code" = WOD."Income Code"::Service) then begin
            GPS.Get('', 'REPAIR');
        end;
        if (WOD."Income Code" = WOD."Income Code"::Turbo) then begin
            GPS.Get('', 'TURBO');
        end;
    end;

    procedure ReturnInventory()
    begin
        ReturnInventoryQty := WOP."Pulled Quantity";
        if ReturnInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'SHIP RETURN PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := ReturnInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'MAIN';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure ReturnInventoryPM()
    begin
        ReturnInventoryQty := WOP."Pulled Quantity";
        if ReturnInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
                ItemJournalLine."Document No." := WOP."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := WOP."Work Order No." + ' ' + 'SHIP RETURN PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := ReturnInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'MAIN';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure RemoveInventory()
    begin
        RemoveInventoryQty := WOP."Pulled Quantity";
        if RemoveInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'WARRANTY';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::"Negative Adjmt."; ///--! Negative Adjustment
                ItemJournalLine."Document No." := WOD."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := WOD."Work Order No." + ' ' + 'WARRANTY';
                ItemJournalLine."Location Code" := 'MAIN';
                ItemJournalLine.Quantity := RemoveInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure RemoveInventoryPM()
    begin
        RemoveInventoryQty := WOP."Pulled Quantity";
        if RemoveInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'WARRANTY';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::"Negative Adjmt."; ///--! Negative Adjustment
                ItemJournalLine."Document No." := WODPM."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := WODPM."Work Order No." + ' ' + 'Pump Module';
                ItemJournalLine."Location Code" := 'MAIN';
                ItemJournalLine.Quantity := RemoveInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine.Validate(ItemJournalLine."Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");

                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure Reservation()
    begin
        // Reservation Entry
        ///!!- Commit   
        //Commit;
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Find('-') then begin
            repeat
                if (SalesLine.Reserve = SalesLine.Reserve::Always) and (SalesLine."Outstanding Qty. (Base)" <> 0) then
                    SalesLine.AutoReserve();
            until
              SalesLine.Next = 0;
        end;
    end;

    procedure PumpModule()
    begin
        WODPM.SetCurrentKey(WODPM."Work Order No.");
        WODPM.SetRange(WODPM."Work Order No.", WOD."Pump Module No.");
        if WODPM.Find('-') then begin
            WOP.Reset;
            WOP.SetCurrentKey("Work Order No.", "Part No.");
            WOP.SetRange(WOP."Work Order No.", WODPM."Work Order No.");
            WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
            WOP.SetFilter(WOP."Pulled Quantity", '>0');
            if WOP.Find('-') then begin
                repeat
                    if Item.Get(WOP."Part No.") then begin
                        WOP.CalcFields(WOP."In-Process Quantity");
                        if Item."Costing Method" = Item."Costing Method"::Specific then
                            SerialNo := WOP."Serial No."
                        else
                            SerialNo := '';

                        GPSLoopNoGLEntry;
                        ReturnInventoryPM;
                        RemoveInventoryPM;
                        WOP."In-Process Quantity" := 0;
                        WOP.Modify;
                    end;
                until WOP.Next = 0;
            end;

            //Update the Work Order Detail
            WODPM.Carrier := TempCarrier;
            WODPM."Shipping Method" := TempMethod;
            WODPM."Shipping Charge" := TempCharge;
            WODPM."Shipping Account" := TempAccount;
            WODPM."Ship Date" := WorkDate;
            WODPM."Ship Weight" := ShipmentWeight;
            WODPM.Complete := true;
            WODPM."Bill of Lading" := BLInteger;
            WODPM."Package Tracking No." := Tracking;
            WODPM."Ship To Name" := WOD."Ship To Name";
            WODPM."Ship To Address 1" := WOD."Ship To Address 1";
            WODPM."Ship To Address 2" := WOD."Ship To Address 2";
            WODPM."Ship To City" := WOD."Ship To City";
            WODPM."Ship To State" := WOD."Ship To State";
            WODPM."Ship To Zip Code" := WOD."Ship To Zip Code";
            WODPM.Attention := WOD.Attention;
            WODPM.Modify;

            //Update the Work Order Status
            WOSPM.SetCurrentKey(WOSPM."Order No.", WOSPM."Line No.");
            WOSPM.SetRange(WOSPM."Order No.", WODPM."Work Order No.");
            if WOSPM.Find('+') then begin
                WOSPM.Status := WOSPM.Status::Complete;
                WOSPM."Date Out" := WorkDate;
                WOSPM."Regular Hours" := (1 / 100);
                WOSPM.Employee := Shipper;
                WOSPM.Modify;
            end;

            //Update Parts
            PartsComplete.Reset;
            PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
            PartsComplete.SetRange(PartsComplete."Work Order No.", WODPM."Work Order No.");
            if PartsComplete.Find('-') then begin
                repeat
                    PartsComplete.Complete := true;
                    PartsComplete.Modify;
                until PartsComplete.Next = 0;
            end;
        end;
    end;

    local procedure ConvertBOLShipCharge(ShipCharge: Enum ShippingCharge): Enum BOLShipCharge
    var
        ExitShCharge: Enum BOLShipCharge;
    begin
        ExitShCharge := BOLShipCharge.FromInteger(ShipCharge.AsInteger());
        exit(ExitShCharge);
    end;

}

