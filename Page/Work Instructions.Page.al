page 50042 "Work Instructions"
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
    //     Length := STRLEN(WI.Instruction);
    //     IF Length > 230 THEN BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,1,115);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,116,115);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,231,50);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //     END;
    // 
    //     IF (Length > 115) AND (Length <= 230) THEN BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,1,115);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,116,115);
    //       InstrDate[LineCount] := WI."Date Last Modified";
    //     END;
    // 
    //     IF Length <= 115 THEN BEGIN
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

    InsertAllowed = false;
    SourceTable = Status;

    layout
    {
        area(content)
        {
            group(Control1000000018)
            {
                ShowCaption = false;
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field("STRSUBSTNO(QLTY_FILE_TO_PRINT,QCFileName)"; StrSubstNo(QLTY_FILE_TO_PRINT, QCFileName))
                {
                    ApplicationArea = All;
                    Caption = 'Current Work Instructions';
                    Visible = QCFileVisible;
                }
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
                field(Step; Step)
                {
                    ApplicationArea = All;
                    Caption = 'Current Job Step';
                    Editable = false;
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
                field("Instr[13]"; Instr[13])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
                field("Instr[14]"; Instr[14])
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        MasterNo := CopyStr("Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        if WOD.Get("Order No.") then
            OK := true;

        Clear(LineCount);
        Clear(Length);
        Clear(Instr);
        Clear(InstrDate);

        case Step.AsInteger() of
            0:
                begin
                    //Instruction := WOD.REC;
                    Instruction := WOD.RCV;  //ICE-MPC field name misspelled.
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
            if Length > 115 then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(Instruction, 1, 115);
                InstrDate[LineCount] := InstructionDate;
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(Instruction, 116, 115);
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

        QCFileVisible := QCFileName <> '';
        // 01/05/2011 End
    end;

    var
        WOM: Record WorkOrderMaster;
        OK: Boolean;
        WOD: Record WorkOrderDetail;
        MasterNo: Code[7];
        Instruction: Text[250];
        InstructionDate: Date;
        WI: Record WorkInstructions;
        LineCount: Integer;
        Length: Integer;
        Instr: array[50] of Code[250];
        InstrDate: array[50] of Date;
        NewInstructions: Boolean;
        QCFileName: Text[120];
        QLTY_FILE_TO_PRINT: Label 'Attach the QC file <%1> to this Work Order.';
        [InDataSet]
        QCFileVisible: Boolean;

    procedure GetInstructionPerStep(StepCode: Enum DetailStep; CustCode: Code[20]; ShpToCode: Code[10]; ModelNo: Code[20]; CustPartNo: Code[20])
    begin
        // 01/05/2011 New function
        // set filters
        WI.SetRange(WI."Customer Code", CustCode);
        WI.SetRange(WI."Ship To Code", ShpToCode);
        WI.SetRange(WI.Step, StepCode);
        WI.SetRange(WI.Model, ModelNo);
        WI.SetRange(WI."Customer Part No.", CustPartNo);

        if WI.Find('-') then begin
            Length := StrLen(WI.Instruction);
            if Length > 230 then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 1, 115);
                InstrDate[LineCount] := WI."Date Last Modified";
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 116, 115);
                InstrDate[LineCount] := WI."Date Last Modified";
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 231, 50);
                InstrDate[LineCount] := WI."Date Last Modified";
            end;

            if (Length > 115) and (Length <= 230) then begin
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 1, 115);
                InstrDate[LineCount] := WI."Date Last Modified";
                LineCount := LineCount + 1;
                Instr[LineCount] := CopyStr(WI.Instruction, 116, 115);
                InstrDate[LineCount] := WI."Date Last Modified";
            end;

            if Length <= 115 then begin
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

