#pragma implicitwith disable
page 50017 "Quote Phase 3"
{
    // 11/13/16
    //   Added code to compare open orders value against the credit limit for customer
    // 
    // 3/12/18
    //   Test <Overwrite Cr. Limit> field to allow continuing without increasing Cr. Limit. This is set by Accounting
    //   in form 50044.
    // 3/25/18
    //   Reset <Overwrite Cr. Limit> field after release, user needs to ask permission from Accounting again.

    ///--! FileMgmt issue
    // 08/05/20 ICE SII
    //   Temporary commented File.Exist function not working in cloud

    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1220060007)
            {
                ShowCaption = false;
                grid(Control1220060008)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060005)
                    {
                        ShowCaption = false;
                        field("Work Order No."; Rec."Work Order No.")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("WOM.Customer"; WOM.Customer)
                        {
                            ApplicationArea = All;
                            Caption = 'Customer';
                            Editable = false;
                        }
                        field("WOM.""Date Ordered"""; WOM."Date Ordered")
                        {
                            ApplicationArea = All;
                            Caption = 'Order Date';
                            Editable = false;
                        }
                    }
                }
            }
            group(Control1220060011)
            {
                ShowCaption = false;
                grid(Control1220060010)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060009)
                    {
                        ShowCaption = false;
                        field("Model No."; Rec."Model No.")
                        {
                            ApplicationArea = All;
                            DrillDownPageID = "Model List";
                            Editable = false;
                            LookupPageID = "Model List";
                        }
                        field("Serial No."; Rec."Serial No.")
                        {
                            ApplicationArea = All;
                            Editable = false;
                        }
                        field("Labor Hours Quoted"; Rec."Labor Hours Quoted")
                        {
                            ApplicationArea = All;
                            DrillDownPageID = "Quote Phase 3 Parts List";
                            Editable = false;
                        }
                    }
                }
            }
            group(Control1220060013)
            {
                ShowCaption = false;
                group(Control1220060015)
                {
                    ShowCaption = false;
                    field("Labor Quoted"; Rec."Labor Quoted")
                    {
                        ApplicationArea = All;
                        DrillDownPageID = "Quote Phase 3 Parts List";
                        Editable = false;
                    }
                    field("Parts Quoted"; Rec."Parts Quoted")
                    {
                        ApplicationArea = All;
                        DrillDownPageID = "Quote Phase 3 Parts List";
                        Editable = false;
                    }
                    field("""Labor Quoted"" + ""Parts Quoted"""; Rec."Labor Quoted" + Rec."Parts Quoted")
                    {
                        ApplicationArea = All;
                        Caption = 'Sub-Total';
                        Editable = false;
                    }
                    field("Order Adj."; Rec."Order Adj.")
                    {
                        ApplicationArea = All;
                        Caption = 'Adjustment';
                        Editable = OrderAdjEditable;
                    }
                    field("""Labor Quoted"" + ""Parts Quoted"" + ""Order Adj."""; Rec."Labor Quoted" + Rec."Parts Quoted" + Rec."Order Adj.")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Quote';
                        Editable = false;
                    }
                    field("Order Type"; Rec."Order Type")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Unrepairable Charge"; Rec."Unrepairable Charge")
                    {
                        ApplicationArea = All;
                        Caption = 'Return Charge';
                    }
                    field("Customer PO No."; Rec."Customer PO No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Quote Sent Date"; Rec."Quote Sent Date")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Tax Liable"; Rec."Tax Liable")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(BypassCreditLimit; BypassCreditLimit)
                    {
                        ApplicationArea = All;
                        Caption = 'Bypass Credit Limit';
                        Visible = BypassCCheckVisible;
                    }
                }
                group(Control1220060030)
                {
                    ShowCaption = false;
                    field(Quote; Rec.Quote)
                    {
                        ApplicationArea = All;
                    }
                    field("Warranty Type"; Rec."Warranty Type")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Unrepairable Reason"; Rec."Unrepairable Reason")
                    {
                        ApplicationArea = All;
                        Caption = 'Reason';
                    }
                    field("Warranty Reason"; Rec."Warranty Reason")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Unrepairable Handling"; Rec."Unrepairable Handling")
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
            action(Requote)
            {
                ApplicationArea = All;
                Caption = 'Requote';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Quote;

                trigger OnAction()
                begin
                    if Rec."Build Ahead" = true then
                        Error('Can''t Requote a Build Ahead, but it can be Modified by the Purchasing Department');

                    if not Confirm('Are you Absolutely sure you want to Requote this Work Order?') then begin
                        Ok := true;
                    end else begin
                        Rec."Quote Phase" := Rec."Quote Phase"::" ";
                        Rec."Order Adj." := 0;
                        Rec.ReQuoted := true;
                        Rec.Modify;
                        Commit;
                        CurrPage.Close;
                    end;
                end;
            }
            action("Acceptance Form")
            {
                ApplicationArea = All;
                Caption = 'Acceptance Form';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Form;

                trigger OnAction()
                begin
                    WOD.SetCurrentKey("Work Order No.");
                    WOD.SetRange(WOD."Work Order No.", Rec."Work Order No.");
                    if Rec."Pump Module" then begin
                        PMParts.SetCurrentKey(PMParts."Work Order No.", PMParts."Part No.");
                        PMParts.SetRange(PMParts."Work Order No.", Rec."Work Order No.");
                        PMParts.SetRange(PMParts."Part Type", PMParts."Part Type"::Resource);
                        PMParts.SetRange(PMParts."Part No.", 'PUMP MODULE');
                        if PMParts.Find('-') then begin
                            if PMParts."Quoted Quantity" > 0 then begin
                                REPORT.RunModal(50014, true, false, WOD);
                            end else begin
                                Message('This Work Order has been Proccessed as a Pump Module, but still needs the Quoted Qty. Added to the Pump Module');
                            end;
                        end else begin
                            Message('This Work Order needs to be Proccessed by the Parts Department because it is a setup as a Pump Module');
                        end;
                    end else begin
                        REPORT.RunModal(50014, true, false, WOD);
                    end;
                end;
            }
            action("Complete Quote")
            {
                ApplicationArea = All;
                Caption = 'Complete Quote';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Completed;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to complete this Quote', false) then
                        Error('Completion of Quote has been stopped.')
                    else
                        case Rec.Quote.AsInteger() of
                            0:
                                Error('In order to complete the Quote you must select either Accepted or Not Repairable');
                            1:
                                if not Confirm('This Quote has been Mark Accepted, is this correct?', false) then
                                    Error('Completion of Quote has been stopped.')
                                else
                                    Accept;
                            2:
                                if not Confirm('This Quote has been Mark Not Repairable, is this correct?', false) then
                                    Error('Completion of Quote has been stopped.')
                                else
                                    NR;
                        end;
                end;
            }
            action("Customer Info")
            {
                ApplicationArea = All;
                Caption = 'Customer Info';
                Promoted = true;
                Visible = CustInfoVisible;

                trigger OnAction()
                begin
                    if WOM."Work Order Master No." <> '' then begin
                        CustFile := 'C:\Windows\Desktop\' + WOM.Customer + '-' + WOM."Ship To Code" + '.doc';
                        HyperLink(CustFile);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        WOM.Get(Rec."Work Order Master No.");

        if Rec."Order Type" = Rec."Order Type"::Warranty then begin
            Rec."Order Adj." := -(Rec."Labor Quoted" + Rec."Parts Quoted");
            OrderAdjEditable := false;
        end else begin
            OrderAdjEditable := true;
        end;

        WOS.Reset;
        WOS.SetCurrentKey("Order No.", Step);
        WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
        if WOS.Find('+') then begin
            WOS."File Exists" := false;
            ///--! FileMgmt issue
            // 08/05/20 ICE SII
            /*
            CustFile := 'C:\Windows\Desktop\' + WOM.Customer + '-' + WOM."Ship To Code" + '.doc';
            WOS."File Exists" := Exists(CustFile);

            if WOS."File Exists" = true then
                CustInfoVisible := true
            else
                CustInfoVisible := false;
            */
        end;

        Type := Rec."Order Type";
    end;

    trigger OnClosePage()
    begin
        Ok := false;
        Member.CalcFields(Member."User Name");
        Member.SetRange(Member."User Name", UserId);
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALES') then
                    Ok := true;
            until Member.Next = 0;
        end;

        if Ok then begin
            if Rec."Quote Sent Date" = 0D then begin
                if Confirm('Will the Quote be Sent to the Customer Today?') then begin
                    if WOD.Get(Rec."Work Order No.") then begin
                        WOD."Quote Sent Date" := WorkDate;
                        WOD.Modify;
                    end;
                end;
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        BypassCCheckVisible := false;
        lSuperUser := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);
        if lSuperUser then
            //IF USERID = 'ADMIN' THEN
            BypassCCheckVisible := true;

    end;

    var
        lSuperUser: Boolean;
        SysFunctions: Codeunit systemFunctionalLibrary;
        txtAnswer: Text[120];
        Permiss: Label 'SUPER';
        WOM: Record WorkOrderMaster;
        WOS: Record Status;
        WOS2: Record Status;
        WOS3: Record Status;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        Parts: Record Parts;
        OQP: Record OriginalQuotedParts;
        Ok: Boolean;
        CustFile: Text[250];
        Item: Record Item;
        WOD: Record WorkOrderDetail;
        SerialNo: Code[20];
        ReturnInventoryQty: Decimal;
        MoveInventoryQty: Decimal;
        ItemFound: Boolean;
        Window: Dialog;
        OrderReason: Text[100];
        Type: Enum OrderType;
        Member: Record "Access Control";
        PMParts: Record Parts;
        OpenOrdersAmounts: Decimal;
        BypassCreditLimit: Boolean;
        [InDataSet]
        CustInfoVisible: Boolean;
        [InDataSet]
        BypassCCheckVisible: Boolean;
        [InDataSet]
        OrderAdjEditable: Boolean;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    procedure Accept()
    var
        lCustomer: Record Customer;
    begin
        Rec.CalcFields("Labor Hours Quoted", "Labor Quoted", "Parts Cost", "Parts Quoted", "Current Reg Hours Used", "Current OT Hours Used");

        // 11/13/16 Start
        // Compare orders against Credit Limit
        OpenOrdersAmounts := GetOpenOrdersAmount(Rec."Customer ID", Rec."Work Order No.");
        if not lCustomer.Get(Rec."Customer ID") then
            Error('Customer %1 on Work Order %2 does not exist', Rec."Customer ID", Rec."Work Order No.");
        // Add current order value to Total Amount and check against the limit
        OpenOrdersAmounts := OpenOrdersAmounts + Rec."Order Adj." + Rec."Labor Quoted" + Rec."Parts Quoted";
        lCustomer.CalcFields("Balance (LCY)");
        if OpenOrdersAmounts + lCustomer."Balance (LCY)" > lCustomer."Credit Limit (LCY)" then
            // 3/12/18 start
            //IF NOT BypassCreditLimit THEN BEGIN
            if not (BypassCreditLimit or Rec."Overwrite Cr. Limit") then begin
                // 3/12/18 end
                //    ERROR('Customer %1 Open Balance of %2 exceeds Credit Limit %3. See Accounting',
                //          "Customer ID",ROUND(OpenOrdersAmounts + lCustomer."Balance ($)",0.01,'='),lCustomer."Credit Limit ($)");
                Message('Customer %1 Open Balance of %2 exceeds Credit Limit %3. See Accounting',
                      Rec."Customer ID", Round(OpenOrdersAmounts + lCustomer."Balance (LCY)", 0.01, '='), lCustomer."Credit Limit (LCY)");
                exit;
                // 3/12/18 start
                //END;
            end else
                if Rec."Overwrite Cr. Limit" then
       // 3/25/18 start
       begin
                    // 3/25/18 end
                    Message('Customer %1 Open Balance of %2 exceeds Credit Limit %3. Credit Limit overwritten by Accounting.',
                            Rec."Customer ID", Round(OpenOrdersAmounts + lCustomer."Balance (LCY)", 0.01, '='), lCustomer."Credit Limit (LCY)");
                    // 3/25/18 start
                    Rec."Overwrite Cr. Limit" := false;
                    Rec.Modify;
                end;
        // 3/25/18 end
        // 3/12/18 end
        // 11/13/16 End

        if (Rec."Order Type" = Rec."Order Type"::Rebuild) or (Rec."Order Type" = Rec."Order Type"::Repair) then begin
            if Rec."Customer PO No." = '' then
                Error('Customer PO must be filled in to complete this Quote');

            if ((Rec."Labor Quoted" + Rec."Parts Quoted" + Rec."Order Adj.") < (1 / 100)) then begin
                if Rec."System Shipment" then begin
                    if not Confirm('The Quote Price is Zero Dollars for this Workorder, is this correct?', false) then
                        Error('Completion of Quote has been stopped.');
                end else begin
                    Error('Total Quote Price is Zero, so it must be released as a Warranty');
                end;
            end;
        end;

        if Rec."Order Type" = Rec."Order Type"::Warranty then begin
            if Rec."Warranty Type" = Rec."Warranty Type"::" " then
                Error('Warranty Type must be Selected by the Shop before Releasing');
        end;

        if Rec."Unrepairable Charge" > 0 then
            Error('Return Charge can only be Used for Unrepairable Pumps');

        if (Rec."Unrepairable Reason".AsInteger() > 0) then begin
            Rec."Unrepairable Reason" := Rec."Unrepairable Reason"::" ";
        end;

        if (Rec."Unrepairable Handling".AsInteger() > 0) then begin
            Rec."Unrepairable Handling" := Rec."Unrepairable Handling"::" ";
        end;

        if WOM."Customer State" = 'MD' then begin
            if (WOM."Tax Exemption No." = '') and (WOM."Exempt Organization" = '') then begin
                if Rec."Tax Liable" = false then
                    Error('Tax Exempt information needs to be entered or Tax Liable needs to be Checked to Complete Quote');
            end;
        end;

        if (Rec.Carrier = 'UNKNOWN') or (Rec.Carrier = '') then
            Error('Carrier must be determined before completing the Quote');

        // Checks for Pump Module on Parts List & Verifies the Quoted Quantity
        if Rec."Pump Module" then begin
            if Rec."Pump Module Processed" then begin
                PMParts.SetCurrentKey(PMParts."Work Order No.", PMParts."Part No.");
                PMParts.SetRange(PMParts."Work Order No.", Rec."Work Order No.");
                PMParts.SetRange(PMParts."Part Type", PMParts."Part Type"::Resource);
                PMParts.SetRange(PMParts."Part No.", 'PUMP MODULE');
                if PMParts.Find('-') then begin
                    if PMParts."Quoted Quantity" > 0 then begin
                        if Rec."Pump Module No." = '' then
                            Error('This Work Order is Quoted for a Pump Module, and one must be assigned to release from Quote');
                    end else begin
                        Error('A Pump Module has been added to the Parts List, but the Quantity is Zero.  Please Delete or add Quote Quantity');
                    end;
                end;
            end else begin
                Error('The Work Order must go through Parts Adjustment before being released from QUOTE');
            end;
        end;

        Rec."Released USERID" := UserId;
        Rec.Modify;

        // Transfer Quoted Parts to Original Quoted Parts Table for Reference
        Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
        Parts.SetRange(Parts."Work Order No.", Rec."Work Order No.");
        if Parts.Find('-') then begin
            repeat
                if Parts."Quoted Quantity" > 0 then begin
                    OQP.Init;
                    OQP.TransferFields(Parts);
                    OQP.Insert;
                end;
            until Parts.Next = 0;
        end;
        Parts.Reset;

        if Rec."Build Ahead" = false then begin
            Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
            Parts.SetRange(Parts."Work Order No.", Rec."Work Order No.");
            Parts.SetRange(Parts."Part Type", Parts."Part Type"::Item);
            if Parts.Find('-') then begin
                repeat
                begin
                    Parts.CalcFields(Parts."Committed Quantity");

                    if SerialNo = '' then begin
                        if Parts."Serial No." <> '' then
                            SerialNo := Parts."Serial No.";
                    end;

                    MoveInventoryQuote;

                end;

                if Parts."Quoted Quantity" = 0 then
                    Parts.Delete;

                until Parts.Next = 0;
            end;

            WOS.Reset;
            WOS.SetCurrentKey(WOS."Order No.", WOS.Step);
            WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
            WOS.SetRange(WOS.Step, WOS.Step::QOT);
            if WOS.Find('+') then begin
                WOS.Status := WOS.Status::Complete;
                WOS."Date Out" := WorkDate;
                WOS3.Init;
                WOS3."Order No." := WOS."Order No.";
                WOS3."Line No." := WOS."Line No." + 10000;
                WOS3.Step := DetailStep.FromInteger(WOS.Step.AsInteger() + 1);
                WOS3."Date In" := WOS."Date Out";
                WOS3.Status := WOS3.Status::Waiting;
                WOS3.Insert;
                Commit;
                WOS.Modify;
            end;

        end else begin
            WOS.Reset;
            WOS.SetCurrentKey(WOS."Order No.", WOS.Step);
            WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
            WOS.SetRange(WOS.Step, WOS.Step::QOT);
            if WOS.Find('+') then begin
                WOS.Status := WOS.Status::Complete;
                WOS."Date Out" := WorkDate;
                WOS.Modify;
            end;

            if Rec."Pump Module" then begin
                WOS.Reset;
                WOS.SetCurrentKey(WOS."Order No.", WOS.Step);
                WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
                if WOS.Find('+') then begin
                    if WOS.Step <> WOS.Step::QC then begin
                        //IF THE PM WASN'T A BUILD AHEAD PRIOR TO BEING CONVERTED B-0 WILL BE LEFT IN WAITING
                        if WOS.Step = WOS.Step::"B-O" then begin
                            WOS3.Init;
                            WOS3."Order No." := WOS."Order No.";
                            WOS3."Line No." := WOS."Line No." + 10000;
                            WOS3.Step := WOS3.Step::QC;
                            WOS3."Date In" := WOS."Date Out";
                            WOS3.Status := WOS3.Status::Waiting;
                            WOS3.Insert;
                            Commit;
                            // COMPLETE BACK ORDER
                            WOS.Status := WOS.Status::Complete;
                            WOS.Modify;
                        end else begin
                            WOS3.Init;
                            WOS3."Order No." := WOS."Order No.";
                            WOS3."Line No." := WOS."Line No." + 10000;
                            WOS3.Step := WOS3.Step::QC;
                            WOS3."Date In" := WOS."Date Out";
                            WOS3.Status := WOS3.Status::Waiting;
                            WOS3.Insert;
                            Commit;
                            // Delete Last step in Waiting
                            WOS.Delete;
                        end;
                    end;
                end;
            end;
        end;

        CurrPage.Close;
    end;

    procedure NR()
    begin
        if (Rec."Unrepairable Reason" = Rec."Unrepairable Reason"::" ") then
            Error('Unrepairable Reason must be entered');


        if (Rec."Unrepairable Handling" = Rec."Unrepairable Handling"::" ") then
            Error('Unrepairable Handling must be entered');

        if Rec."Sales Order No." <> '' then
            Error('This Work Order is linked to Sales Order %1 and must be removed before releasing it Unrepairable', Rec."Sales Order No.");

        Rec.CalcFields("Labor Hours Quoted", "Labor Quoted", "Parts Cost", "Parts Quoted", "Current Reg Hours Used", "Current OT Hours Used");

        if Rec."Unrepairable Charge" > 0 then begin
            if Rec."Customer PO No." = '' then
                Error('Customer PO must be filled in to complete this Quote');
            if WOM."Customer State" = 'MD' then begin
                if (WOM."Tax Exemption No." = '') and (WOM."Exempt Organization" = '') then begin
                    if Rec."Tax Liable" = false then
                        Error('Tax Exempt information needs to be entered or Tax Liable needs to be Checked to Complete Quote');
                end;
            end;
        end;

        Rec."Order Adj." := -(Rec."Labor Quoted" + Rec."Parts Quoted");
        Rec."Released USERID" := UserId;
        Rec.Modify;

        WOS.Reset;
        WOS.SetCurrentKey(WOS."Order No.", WOS.Step);
        WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
        WOS.SetRange(WOS.Step, WOS.Step::QOT);
        if WOS.Find('+') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS.Modify;
        end;

        if Rec."Build Ahead" = false then begin
            WOS2.Init;
            WOS2."Order No." := WOS."Order No.";
            WOS2."Line No." := WOS."Line No." + 10000;
            WOS2.Step := WOS2.Step::ASM;
            WOS2."Date In" := WorkDate;
            WOS2.Insert;

            Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
            Parts.SetRange(Parts."Work Order No.", Rec."Work Order No.");
            Parts.SetRange(Parts."Part Type", Parts."Part Type"::Item);
            if Parts.Find('-') then begin
                repeat
                begin
                    Parts.CalcFields(Parts."Committed Quantity");

                    if SerialNo = '' then begin
                        if Parts."Serial No." <> '' then
                            SerialNo := Parts."Serial No.";
                    end;

                    ReturnInventoryQuote;

                end;

                if Parts."Quoted Quantity" = 0 then
                    Parts.Delete;

                if Parts."Quoted Quantity" > 0 then begin
                    Parts."Quantity Backorder" := 0;
                    Parts.Modify;
                end;

                until Parts.Next = 0;
            end;

        end else begin
            if Rec."Pump Module" then begin
                //Remove Pump Module Link
                if Rec."Pump Module No." <> '' then begin
                    Message('This Work Order was linked to Work Order %1 as a Pump Module', Rec."Pump Module No.");
                    Rec."Pump Module No." := '';
                    Rec.Validate("Pump Module No.");
                end;
            end;
            Rec."Unrepairable BuildAhead" := true;
            Rec.Modify;
            Message('Please Contact the Parts Department to Return Parts to Inventory');

        end;

        CurrPage.Close;
    end;

    procedure ReturnInventoryQuote()
    begin
        ReturnInventoryQty := Parts."Committed Quantity";
        if ReturnInventoryQty > 0 then begin
            ItemJournalLine.Init;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'COMMITTED';
            ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Document No." := Rec."Work Order No.";
            ItemJournalLine."Item No." := Parts."Part No.";
            ItemJournalLine.Validate(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WorkDate;
            ItemJournalLine.Description := Rec."Work Order No." + ' ' + 'RETURN PARTS';
            ItemJournalLine."Location Code" := 'COMMITTED';
            ItemJournalLine.Quantity := ReturnInventoryQty;
            ItemJournalLine.Validate(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'MAIN';
            ItemJournalLine.Validate(ItemJournalLine."New Location Code");

            if SerialNo <> '' then begin
                WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
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

    procedure MoveInventoryQuote()
    begin
        MoveInventoryQty := Parts."Committed Quantity";
        if MoveInventoryQty > 0 then begin
            ItemJournalLine.Init;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
            ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Document No." := Rec."Work Order No.";
            ItemJournalLine."Item No." := Parts."Part No.";
            ItemJournalLine.Validate(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WorkDate;
            ItemJournalLine.Description := Rec."Work Order No." + ' ' + 'IN PROCESS PARTS';
            ItemJournalLine."Location Code" := 'COMMITTED';
            ItemJournalLine.Quantity := MoveInventoryQty;
            ItemJournalLine.Validate(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'IN PROCESS';
            ItemJournalLine.Validate(ItemJournalLine."New Location Code");

            if SerialNo <> '' then begin
                WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
                ItemJournalLine."Serial No." := SerialNo;
                ItemJournalLine."New Serial No." := SerialNo;
                SerialNo := '';
            end;


            PostLine.Run(ItemJournalLine);

            ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
            ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
            if ItemJournalClear.Find('-') then
                repeat
                    ItemJournalClear.Delete;
                until ItemJournalClear.Next = 0;
        end;
    end;

    procedure GetOpenOrdersAmount(CustomerID: Code[20]; CurrentOrder: Code[7]): Decimal
    var
        lStatus: Record Status;
        lWorkOrder: Record WorkOrderDetail;
        NoRecs: Integer;
        TotalOpenOrders: Decimal;
    begin
        // 11/13/16 - new function
        lWorkOrder.Reset;
        lWorkOrder.SetCurrentKey("Customer ID");
        lWorkOrder.SetRange("Customer ID", CustomerID);
        lWorkOrder.SetRange(Complete, false);
        /// ??add filter for Accepted

        if lWorkOrder.FindFirst then
            repeat
                if lWorkOrder."Work Order No." <> CurrentOrder then begin
                    lWorkOrder.CalcFields("Detail Step", "Labor Quoted", "Parts Quoted");
                    if lWorkOrder."Detail Step".AsInteger() > DetailStep::QOT.AsInteger() then begin
                        lStatus.Reset;
                        lStatus.SetCurrentKey("Order No.", Step);
                        lStatus.SetRange("Order No.", lWorkOrder."Work Order No.");
                        lStatus.SetRange(Step, lStatus.Step::QOT);
                        if lStatus.FindFirst then
                            if lStatus.Status = lStatus.Status::Complete then begin
                                if lWorkOrder."Detail Step" <> lWorkOrder."Detail Step"::SHP then
                                    TotalOpenOrders := TotalOpenOrders + lWorkOrder."Labor Quoted" +
                                                       lWorkOrder."Parts Quoted" + lWorkOrder."Order Adj."
                                else begin
                                    lStatus.Reset;
                                    lStatus.SetCurrentKey("Order No.", Step);
                                    lStatus.SetRange("Order No.", lWorkOrder."Work Order No.");
                                    lStatus.SetRange(Step, lStatus.Step::SHP);
                                    if lStatus.FindLast then
                                        if lStatus.Status <> lStatus.Status::Complete then
                                            TotalOpenOrders := TotalOpenOrders + lWorkOrder."Labor Quoted" +
                                                               lWorkOrder."Parts Quoted" + lWorkOrder."Order Adj.";

                                end;
                            end;
                    end;
                end;
            until lWorkOrder.Next = 0;
        exit(TotalOpenOrders);
    end;
}

#pragma implicitwith restore

