page 50013 "Quote Phase 1"
{
    // 01/05/2011 ADV
    //   Added code to retrieve Customer Part No. specific instructions.
    //   Create a new function and remove the code not necessary.
    //   Ex:
    //   {
    //   WI.SETRANGE(WI."Customer Code",'');
    //   WI.SETRANGE(WI."Ship To Code",'');
    //   WI.SETRANGE(WI.Step, Step);
    //   WI.SETRANGE(WI.Model,WOD."Model No.");
    //   IF WI.FIND('-') THEN BEGIN
    //     Instructions := TRUE;
    //     IF WI."Date Last Modified" > WOM."Date Ordered" THEN
    //       NewInstruction := TRUE;
    //   END;
    //   WI.RESET;

    SourceTable = Status;
    SourceTableView = SORTING("Order No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Step = CONST(QOT),
                            Type = CONST(WorkOrder));

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
                        field("Order No."; "Order No.")
                        {
                            Editable = false;
                        }
                        field("WOM.Customer"; WOM.Customer)
                        {
                            Caption = 'Customer';
                            Editable = false;
                        }
                        field(Employee; Employee)
                        {
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
                        field("WOD.""Model No."""; WOD."Model No.")
                        {
                            Caption = 'Model No.';

                            trigger OnValidate()
                            begin
                                WOD.Validate(WOD."Model No.");
                                WOD.Modify;
                                Message('The Quoted Parts have been Reset, But You Must Click on one of the Parts to Update all the Quantities');
                            end;
                        }
                        field("Date In"; "Date In")
                        {
                        }
                        field("Regular Hours"; "Regular Hours")
                        {
                        }
                    }
                }
            }
            group(Control1220060017)
            {
                ShowCaption = false;
                grid(Control1220060016)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060015)
                    {
                        ShowCaption = false;
                        field("WOD.""Serial No."""; WOD."Serial No.")
                        {
                            Caption = 'Serial No.';

                            trigger OnValidate()
                            begin
                                if WOD."Serial No." <> OLDWOD."Serial No." then
                                    WOD.Modify;
                            end;
                        }
                        field("Date Out"; "Date Out")
                        {
                        }
                        field("Overtime Hours"; "Overtime Hours")
                        {
                        }
                    }
                }
            }
            group(Control1220060004)
            {
                ShowCaption = false;
                field("WOD.""Order Type"""; WOD."Order Type")
                {
                    Caption = 'Order Type';

                    trigger OnValidate()
                    begin
                        if WOD."Order Type" <> OLDWOD."Order Type" then begin
                            if not Confirm('Are you sure you wish to change the Order Type?') then begin
                                Error('Order Type has not been changed');
                            end else begin
                                Window.Open('Enter Order Change Reason #1#######################', OrderReason);
                                Window.Input();
                                Window.Close;
                                if OrderReason = '' then begin
                                    Error('You must enter a reason in order to change the Order Type');
                                end else begin
                                    WOD."Order Type Reason" := OrderReason;
                                    WOD.Validate("Model No.");
                                    if WOD."Order Type" <> WOD."Order Type"::Warranty then begin
                                        WOD."Warranty Type" := WOD."Warranty Type"::" ";
                                        WOD."Warranty Reason" := '';
                                    end;
                                    WOD.Modify;
                                    Commit;
                                    Message('The Quoted Parts have been Reset, But You Must Click on one of the Parts to Update all the Quantities');
                                end;
                            end;
                        end;
                    end;
                }
                field("WOD.""Warranty Type"""; WOD."Warranty Type")
                {
                    Caption = 'Warranty Type';

                    trigger OnValidate()
                    begin
                        if WOD."Warranty Type" <> OLDWOD."Warranty Type" then begin
                            if WOD."Order Type" <> WOD."Order Type"::Warranty then begin
                                Message('Order Type must be Warranty to Enter Warranty Type');
                                WOD."Warranty Type" := WOD."Warranty Type"::" ";
                            end else begin
                                WOD.Modify;
                            end;
                        end;
                    end;
                }
                field("WOD.""Build Ahead Report"""; WOD."Build Ahead Report")
                {
                    Caption = 'Build Ahead';

                    trigger OnValidate()
                    begin
                        if WOD."Build Ahead Report" <> OLDWOD."Build Ahead Report" then
                            WOD.Modify;
                    end;
                }
                field("WOD.""Warranty Reason"""; WOD."Warranty Reason")
                {
                    Caption = 'Reason';

                    trigger OnValidate()
                    begin
                        if WOD."Warranty Reason" <> OLDWOD."Warranty Reason" then begin
                            if WOD."Order Type" <> WOD."Order Type"::Warranty then begin
                                Message('Order Type must be Warranty to Enter Warranty Reason');
                                WOD."Warranty Reason" := '';
                            end else begin
                                WOD.Modify;
                            end;
                        end;
                    end;
                }
            }
            part(QuotePartsList; "Quote Phase 1 Parts List")
            {
                SubPageLink = "Work Order No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Instructions)
            {
                Caption = 'Instructions';
                Promoted = true;
                Visible = WorkInstructionsVisible;

                trigger OnAction()
                begin
                    InstructionRead := true;
                    PAGE.RunModal(50042, Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Instructions := false;
        NewInstruction := false;

        MasterNo := CopyStr("Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        WOD.Get("Order No.");
        OLDWOD := WOD;

        if WOD.QOT <> '' then begin
            Instructions := true;
            if WOD."QOT Date" > WOM."Date Ordered" then
                NewInstruction := true;
        end;

        // 01/05/2011 Start
        // Step,Model
        GetIfInstructionsExistsPerStep(Step, '', '', WOD."Model No.", '');

        // Step,Customer
        GetIfInstructionsExistsPerStep(Step, WOD."Customer ID", '', '', '');

        // Step,Customer,Part No.
        if (WOD."Customer Part No." <> '') then
            GetIfInstructionsExistsPerStep(Step, WOD."Customer ID", '', '', WOD."Customer Part No.");

        // Step,Customer,Model
        GetIfInstructionsExistsPerStep(Step, WOD."Customer ID", '', WOD."Model No.", '');

        // Step,Customer,ShipTo
        GetIfInstructionsExistsPerStep(Step, WOD."Customer ID", WOM."Ship To Code", '', '');

        // Step,Customer,ShiptTo,Model
        GetIfInstructionsExistsPerStep(Step, WOD."Customer ID", WOM."Ship To Code", WOD."Model No.", '');
        // 01/05/2011 End
        if Instructions then begin
            WorkInstructionsVisible := true;
            if NewInstruction then begin
                if xRec."Order No." <> "Order No." then begin
                    Message('Work Instructions have been updated, Please Read');
                end;
            end;
        end else begin
            WorkInstructionsVisible := false;
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if NewInstruction then begin
            if InstructionRead = false then
                Error('Work Instructions have been Updated, and Must be Read');
        end;
    end;

    var
        Window: Dialog;
        OrderReason: Text[100];
        WOD: Record WorkOrderDetail;
        WOD2: Record WorkOrderDetail;
        OLDWOD: Record WorkOrderDetail;
        WOI: Record WorkInstructions;
        WOM: Record WorkOrderMaster;
        MasterNo: Code[7];
        OK: Boolean;
        BAReport: Boolean;
        WI: Record WorkInstructions;
        NewInstruction: Boolean;
        Instructions: Boolean;
        Instruction: Text[250];
        InstructionDate: Date;
        InstructionRead: Boolean;
        [InDataSet]
        WorkInstructionsVisible: Boolean;

    procedure GetIfInstructionsExistsPerStep(StepCode: Enum DetailStep; CustCode: Code[20]; ShpToCode: Code[10]; ModelNo: Code[20]; CustPartNo: Code[20])
    //REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSH,PNT,QC,SHP
    begin
        // 01/05/2011 New function
        // set filters
        WI.SetRange(WI."Customer Code", CustCode);
        WI.SetRange(WI."Ship To Code", ShpToCode);
        WI.SetRange(WI.Step, StepCode);
        WI.SetRange(WI.Model, ModelNo);
        WI.SetRange(WI."Customer Part No.", CustPartNo);

        if WI.Find('-') then begin
            Instructions := true;
            if WI."Date Last Modified" > WOM."Date Ordered" then
                NewInstruction := true;
        end;
        WI.Reset;
    end;
}

