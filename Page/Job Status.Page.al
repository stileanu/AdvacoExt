page 50009 "Job Status"
{
    // //>> This Code worked on OnNextRecord to prevent someone from using error buttons
    // //>> But found that SetRecFilter worked just as well
    // WOS := Rec;
    // CurrentSteps := WOSRec.NEXT(Steps);
    // IF CurrentSteps <> 0 THEN
    //   Rec := WOS;
    // EXIT(CurrentSteps);
    // 
    // //Instr12 Contains Message Box Code for New Instructions because it is the Last Instruction the System Looks At
    // AVF.SMS.032510 - changed check of editable SerialNo to add ADV-SHIPPING
    // 
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
    //     Length := STRLEN(WI.Instruction);
    //     IF Length > 144 THEN BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,1,72);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,73,72);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,145,72);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //     END;
    // 
    //     IF (Length > 72) AND (Length <= 144) THEN BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,1,72);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,73,72);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //     END;
    // 
    //     IF Length <= 72 THEN BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := WI.Instruction;
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //     END;
    // 
    //     //Insert Blank Line
    //     LineCount := LineCount + 1;
    // 
    //   END;
    //   WI.RESET;
    // 
    // 12/28/11 ADV
    //   Allow Shop Mgr and Shipping to edit Serian No. in REC step
    // 
    // 02/19/18
    //   Added filter for WI on Blocked field to do not show Blocked WI
    // 
    // 04/16/18
    //   Transformed Saved Container control from check box to option (blank,yes,no).

    InsertAllowed = false;
    SourceTable = Status;

    layout
    {
        area(content)
        {
            group(Control1220060008)
            {
                ShowCaption = false;
                grid(Control1220060007)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060006)
                    {
                        ShowCaption = false;
                        field("Order No."; "Order No.")
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
            group(Control1220060009)
            {
                ShowCaption = false;
                group(Control1220060027)
                {
                    ShowCaption = false;
                    field("FORMAT(WOD.""Order Type"",0)"; Format(WOD."Order Type", 0))
                    {
                        ApplicationArea = All;
                        Caption = 'Order Type';
                        Editable = false;
                    }
                    field(Step; Step)
                    {
                        ApplicationArea = All;
                        Caption = 'Current Job Step';
                        Editable = false;
                    }
                    field(ModelNo; ModelNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Model No.';
                        Editable = ModelNoEditable;
                    }
                    field("WOD.""Model Verified"""; WOD."Model Verified")
                    {
                        ApplicationArea = All;
                        Caption = 'Model Verified';

                        trigger OnValidate()
                        begin
                            WOD.VALIDATE("Model Verified");
                        end;
                    }
                    field(SerialNo; SerialNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Serial No.';
                        Editable = SerialNoEditable;
                    }
                    field(Employee; Employee)
                    {
                        ApplicationArea = All;
                    }
                    field("Date In"; "Date In")
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field("Date Out"; "Date Out")
                    {
                        ApplicationArea = All;
                        Caption = 'Finish Date';
                    }
                    field("Regular Hours"; "Regular Hours")
                    {
                        ApplicationArea = All;
                        Caption = 'Reg Time On Step';
                    }
                    field("Overtime Hours"; "Overtime Hours")
                    {
                        ApplicationArea = All;
                        Caption = 'OverTime on Step';
                    }
                    field("WOD.oContainerSaved"; WOD.oContainerSaved)
                    {
                        ApplicationArea = All;
                        Caption = 'Saved Container';
                        Editable = ContainerEditable;
                    }
                    field("WOD.""Container Type"""; WOD."Container Type")
                    {
                        ApplicationArea = All;
                        Caption = 'Container Type';
                        Editable = ContainerTypeEditable;
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = All;
                        Caption = 'Status Code';
                    }
                    field("WOD.""Safety Form"""; WOD."Safety Form")
                    {
                        ApplicationArea = All;
                        Caption = 'Safety Form';
                    }
                    field("WOD.""Receiving Notes"""; WOD."Receiving Notes")
                    {
                        ApplicationArea = All;
                        Caption = 'Receiving Notes';
                        MultiLine = true;
                    }
                }
                group("*  *  *  *  * *INTEL Non-Copper Segregation Required* *  *  *  *  *")
                {
                    Caption = '*  *  *  *  * *INTEL Non-Copper Segregation Required* *  *  *  *  *';
                    Visible = NonCopperVisible;
                    field("WOD.Description"; WOD.Description)
                    {
                        ApplicationArea = All;
                        Caption = 'Description';
                        Editable = false;
                    }
                    group("Current Work Instructions")
                    {
                        Caption = 'Current Work Instructions';
                        field("Instr[1]"; Instr[1])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[2]"; Instr[2])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[3]"; Instr[3])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[4]"; Instr[4])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[5]"; Instr[5])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[6]"; Instr[6])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[7]"; Instr[7])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[8]"; Instr[8])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[9]"; Instr[9])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[10]"; Instr[10])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[11]"; Instr[11])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Instr[12]"; Instr[12])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("ISO Procedure")
            {
                ApplicationArea = All;
                Caption = 'ISO Procedure';
                Visible = cmdProcedureVisible;

                trigger OnAction()
                begin
                    //ISOFile := 'F:\SHARED\ISO Documents\' + Customer + '-' + "Ship To Code" + '.doc';
                    ISOFile := 'F:\SHARED\ISO Documents\' + ISOFile;
                    HyperLink(ISOFile);
                end;
            }
            action("&Skip Step")
            {
                ApplicationArea = All;
                Caption = '&Skip Step';
                Promoted = true;
                PromotedCategory = Process;
                Image = StepOver;

                trigger OnAction()
                begin
                    if Step <> Step::RCV then begin
                        if WOD."Unrepairable BuildAhead" = true then begin
                            Message('You Can''t skip this step because it is an Unrepairable Build Ahead');
                        end else begin
                            "Skip Step" := true;
                            Modify;
                            CurrPage.Close;
                        end;
                    end else begin
                        Message('You can''t skip the Receiving Step');
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MessageNotDisplayed := true;
        NewInstructions := false;
        MasterNo := CopyStr("Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        if WOD.Get(Rec."Order No.") then
            OLDWOD := WOD;

        Clear(LineCount);
        Clear(Length);
        Clear(Instr);
        Clear(InstrDate);
        Clear(ISOFile);

        case Step.AsInteger() of
            0:
                begin
                    Instruction := WOD.RCV;
                    InstructionDate := WOD."REC Date";
                end;
            1:
                begin
                    Instruction := WOD.DIS;
                    InstructionDate := WOD."DIS Date";
                end;

            2:
                begin
                    Instruction := WOD.QOT;
                    InstructionDate := WOD."QOT Date";
                end;

            3:
                begin
                    Instruction := WOD."B-O";
                    InstructionDate := WOD."B-O Date";
                end;

            4:
                begin
                    Instruction := WOD.CLN;
                    InstructionDate := WOD."CLN Date";
                end;

            5:
                begin
                    Instruction := WOD.ASM;
                    InstructionDate := WOD."ASM Date";
                end;

            6:
                begin
                    Instruction := WOD.TST;
                    InstructionDate := WOD."TST Date";
                end;

            7:
                begin
                    Instruction := WOD.ASM;
                    InstructionDate := WOD."ASM Date";
                end;

            8:
                begin
                    Instruction := WOD.TST;
                    InstructionDate := WOD."TST Date";
                end;

            10:
                begin
                    Instruction := WOD.PNT;
                    InstructionDate := WOD."PNT Date";
                end;

            11:
                begin
                    Instruction := WOD.QC;
                    InstructionDate := WOD."QC Date";
                end;

            12:
                begin
                    Instruction := WOD.SHP;
                    InstructionDate := WOD."SHP Date";
                end;

            else
                Instruction := '';
        end;


        if Instruction <> '' then begin
            Length := StrLen(Instruction);
            if Length > 70 then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(Instruction, 1, 70);
                InstrDate[LineCount] := InstructionDate;
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(Instruction, 71, 70);
                InstrDate[LineCount] := InstructionDate;
            end else begin
                LineCount := LineCount + 1;
                Instr[LineCount] := Instruction;
                InstrDate[LineCount] := InstructionDate;
            end;

            //Insert Blank Line
            LineCount := LineCount + 1;

        end;

        // 01/05/2011 Start
        // Step,Model
        GetInstructionPerStep(Step, '', '', WOD."Model No.", '');

        // Step,Customer
        GetInstructionPerStep(Step, WOD."Customer ID", '', '', '');

        // Step,Customer,Part No.
        if (WOD."Customer Part No." <> '') then
            GetInstructionPerStep(Step, WOD."Customer ID", '', '', WOD."Customer Part No.");

        // Step,Customer,Model
        GetInstructionPerStep(Step, WOD."Customer ID", '', WOD."Model No.", '');

        // Step,Customer,ShipTo
        GetInstructionPerStep(Step, WOD."Customer ID", WOM."Ship To Code", '', '');

        // Step,Customer,ShiptTo,Model
        GetInstructionPerStep(Step, WOD."Customer ID", WOM."Ship To Code", WOD."Model No.", '');

        //CurrForm.QCFile.VISIBLE(QCFileName <> '');
        // 01/05/2011 End

        SerialNo := WOD."Serial No.";
        ModelNo := WOD."Model No.";

        // Allow Shop Mgr and Shipping to edit Serial No. in REC step
        OK2 := false;
        Member.CalcFields(Member."User Name");
        if (Step = Step::RCV) then begin         //---!
            Member.SetRange(Member."User Name", UserId);
            if Member.Find('-') then begin
                repeat
                    if (Member."Role ID" = 'ADV-SHOPMNGR') or
                       (Member."Role ID" = 'ADV-SHIPPING') then  //AVF.SMS.032510
                        OK2 := true;
                until Member.Next = 0;
            end;
            if OK2 then
                SerialNoEditable := true
            else
                SerialNoEditable := false;
            ModelNoEditable := true;
        end else begin
            SerialNoEditable := false;
            ModelNoEditable := false;
        end;

        // 04/16/18 Start
        //IF (Step = Step :: REC) THEN
        //   CurrForm.Container.EDITABLE(TRUE)
        //ELSE
        //   CurrForm.Container.EDITABLE(FALSE);
        if (Step = Step::RCV) then begin
            ContainerEditable := true;
            if WOD.oContainerSaved = WOD.oContainerSaved::No then
                ContainerTypeEditable := false
            else
                ContainerTypeEditable := true;
        end else begin
            ContainerEditable := false;
            ContainerTypeEditable := false;
        end;
        // 04/16/18 End

        if Status = Status::Complete then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);

        if WOD."Non Copper" then
            NonCopperVisible := true
        else
            NonCopperVisible := false;

        //ISO Procedure Button
        ISOProcedure.SetRange(ISOProcedure.Step, Step);
        ISOProcedure.SetRange(ISOProcedure."Model Type", WOD."Model Type");
        if ISOProcedure.Find('-') then begin
            ISOFile := ISOProcedure."ISO Filename";
            cmdProcedureVisible := true;
        end else begin
            ISOProcedure2.SetRange(ISOProcedure2.Step, Step);
            ISOProcedure2.SetRange(ISOProcedure2."Model Type", ISOProcedure2."Model Type"::" ");
            if ISOProcedure2.Find('-') then begin
                ISOFile := ISOProcedure2."ISO Filename";
                cmdProcedureVisible := true;
            end else begin
                ISOFile := '';
                cmdProcedureVisible := false;
            end;
        end;
    end;

    var
        WOM: Record WorkOrderMaster;
        OK: Boolean;
        OK2: Boolean;
        WOD: Record WorkOrderDetail;
        OLDWOD: Record WorkOrderDetail;
        MasterNo: Code[7];
        Instruction: Text[250];
        InstructionDate: Date;
        SerialNo: Code[20];
        ModelNo: Code[15];
        VerifyModel: Boolean;
        WI: Record WorkInstructions;
        LineCount: Integer;
        Length: Integer;
        Instr: array[50] of Code[250];
        InstrDate: array[50] of Date;
        NewInstructions: Boolean;
        MessageNotDisplayed: Boolean;
        Member: Record "Access Control";
        ISOFile: Text[50];
        ISOPath: Text[50];
        ISOProcedure: Record "ISO Procedures";
        ISOProcedure2: Record "ISO Procedures";
        QCFileName: Text[120];
        SavedContainer: Option " ",Yes,No;
        [InDataSet]
        SerialNoEditable: Boolean;
        [InDataSet]
        ModelNoEditable: Boolean;
        [InDataSet]
        ContainerEditable: Boolean;
        [InDataSet]
        ContainerTypeEditable: Boolean;
        [InDataSet]
        NonCopperVisible: Boolean;
        [InDataSet]
        cmdProcedureVisible: Boolean;

    procedure GetInstructionPerStep(StepCode: Enum DetailStep; CustCode: Code[20]; ShpToCode: Code[10]; ModelNo: Code[20]; CustPartNo: Code[20])
    begin
        // 01/05/2011 New function
        // set filters
        WI.SetRange(WI."Customer Code", CustCode);
        WI.SetRange(WI."Ship To Code", ShpToCode);
        WI.SetRange(WI.Step, StepCode);
        WI.SetRange(WI.Model, ModelNo);
        WI.SetRange(WI."Customer Part No.", CustPartNo);

        // 02/19/18 Start
        // Add filter per Blocked WI
        WI.SetRange(Blocked, false);
        // 02/19/18 End

        if WI.Find('-') then begin
            Length := StrLen(WI.Instruction);
            if Length > 144 then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 1, 72);
                InstrDate[LineCount] := WI."Date Last Modified";
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 73, 72);
                InstrDate[LineCount] := WI."Date Last Modified";
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 145, 72);
                InstrDate[LineCount] := WI."Date Last Modified";
            end;

            if (Length > 72) and (Length <= 144) then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 1, 72);
                InstrDate[LineCount] := WI."Date Last Modified";
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 73, 72);
                InstrDate[LineCount] := WI."Date Last Modified";
            end;

            if Length <= 72 then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := WI.Instruction;
                InstrDate[LineCount] := WI."Date Last Modified";
            end;

            //Insert Blank Line
            LineCount := LineCount + 1;

            if WI."Part Quality Ctrl Instructions" <> '' then
                QCFileName := GetQCFileName(WI."Part Quality Ctrl Instructions");

        end;
        WI.Reset;
    end;

    procedure GetQCFileName(QCFull: Text[250]): Text[120]
    var
        TextBuffer: Text[250];
    begin
        // 01/05/2011 New function
        repeat
            QCFull := CopyStr(QCFull, StrPos(QCFull, '\') + 1);
        until StrPos(QCFull, '\') = 0;
        exit(QCFull);
    end;
}

