page 50029 "QC Failure"
{
    SourceTable = "Order Defects";

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
                            ApplicationArea = All;
                            Caption = 'Work Order No.';
                            Editable = false;
                        }
                        field("Model No."; "Model No.")
                        {
                            ApplicationArea = All;
                            Caption = 'Model No.';
                            Editable = false;
                        }
                        field(Date; Date)
                        {
                            ApplicationArea = All;
                            Caption = 'Date';
                            Editable = false;
                        }
                    }
                }
            }
            group(Control1220060010)
            {
                ShowCaption = false;
                grid(Control1220060009)
                {
                    ShowCaption = false;
                    group("Code")
                    {
                        Caption = 'Code';
                        field("Defect Code"; "Defect Code")
                        {
                            ApplicationArea = All;
                            Caption = '''';
                            ShowCaption = false;
                            Editable = false;
                        }
                        field("fDefectCode[1]"; fDefectCode[1])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("fDefectCode[2]"; fDefectCode[2])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("fDefectCode[3]"; fDefectCode[3])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("fDefectCode[4]"; fDefectCode[4])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group(Department)
                    {
                        Caption = 'Department';
                        field(Control1220060020; Department)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }
                        field("fFunctionalDepartment[1]"; fFunctionalDepartment[1])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("fFunctionalDepartment[2]"; fFunctionalDepartment[2])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("fFunctionalDepartment[3]"; fFunctionalDepartment[3])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("fFunctionalDepartment[4]"; fFunctionalDepartment[4])
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                    group("Failure Item")
                    {
                        Caption = 'Failure Item';
                        field(Control1220060026; "Failure Item")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("fItemCode[1]"; fItemCode[1])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 1;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                        field("fItemCode[2]"; fItemCode[2])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 2;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                        field("fItemCode[3]"; fItemCode[3])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 3;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                        field("fItemCode[4]"; fItemCode[4])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 4;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                    }
                    group(Control1220060012)
                    {
                        Caption = 'Code';
                        field(Control1220060031; Code)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("fKindCode[1]"; fKindCode[1])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 1;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                        field("fKindCode[2]"; fKindCode[2])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 2;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                        field("fKindCode[3]"; fKindCode[3])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 3;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                        field("fKindCode[4]"; fKindCode[4])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 4;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := fFunctionalDepartment[ArrayCount] ::" ";
                                end;

                                //Convert to Codes
                                "fDepartment Conversion";
                                "fFailure Item Conversion";
                                "fCodes Conversion";

                                if (FunctionalDepartment <> '') and (ItemCode <> '') and (KindCode <> '') then begin
                                    fDefectCode[ArrayCount] := FunctionalDepartment + ItemCode + KindCode;
                                end else begin
                                    fDefectCode[ArrayCount] := '';
                                end;
                            end;
                        }
                    }
                    group(Category)
                    {
                        Caption = 'Category';
                        field(Control1220060033; Category)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("fCategoryCode[1]"; fCategoryCode[1])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("fCategoryCode[2]"; fCategoryCode[2])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("fCategoryCode[3]"; fCategoryCode[3])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("fCategoryCode[4]"; fCategoryCode[4])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                    group(Technician)
                    {
                        Caption = 'Technician';
                        field(Control1220060042; Technician)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            TableRelation = Resource."No." WHERE(Type = CONST(Person));
                        }
                        field("fTech[1]"; fTech[1])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            TableRelation = Resource."No." WHERE(Type = CONST(Person));
                        }
                        field("fTech[2]"; fTech[2])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            TableRelation = Resource."No." WHERE(Type = CONST(Person));
                        }
                        field("fTech[3]"; fTech[3])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            TableRelation = Resource."No." WHERE(Type = CONST(Person));
                        }
                        field("fTech[4]"; fTech[4])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            TableRelation = Resource."No." WHERE(Type = CONST(Person));
                        }
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        RecordCount := 1;

        OccurenceCount := 110;

        //Determine The Occurence No. for the Next Record Saved
        FailureCodeOccurence.SetRange(FailureCodeOccurence."Order No.", "Order No.");
        if FailureCodeOccurence.Find('-') then begin
            repeat
                if FailureCodeOccurence.Occurrence > OccurenceCount then
                    OccurenceCount := FailureCodeOccurence.Occurrence;
            until FailureCodeOccurence.Next = 0;
        end;

        //Loop Through Additional Failures
        for RecordCount := 1 to 4 do begin
            DuplicateRecord := false;
            //If a Record Exist check for Duplicates
            if fDefectCode[RecordCount] <> '' then begin
                FailureCodesEntered.SetRange(FailureCodesEntered."Order No.", "Order No.");
                if FailureCodesEntered.Find('-') then begin
                    repeat
                        if FailureCodesEntered."Defect Code" = fDefectCode[RecordCount] then begin
                            RecordCycle := Round(FailureCodesEntered.Occurrence, 10, '<');
                            CurrentCycle := Round(OccurenceCount, 10, '<');
                            if CurrentCycle = RecordCycle then
                                DuplicateRecord := true;
                        end;
                    until FailureCodesEntered.Next = 0;
                end;

                //If no Duplicates exist then save the record
                if DuplicateRecord = false then begin
                    FailureCodesInsert.Init;
                    FailureCodesInsert.Occurrence := OccurenceCount + 1;
                    FailureCodesInsert."Order No." := "Order No.";
                    FailureCodesInsert.Department := FailureCodesInsert.Department::Test;
                    FailureCodesInsert."Model No." := "Model No.";
                    FailureCodesInsert.Date := Date;
                    FailureCodesInsert.Technician := fTech[RecordCount];
                    FailureCodesInsert."Defect Code" := fDefectCode[RecordCount];
                    FailureCodesInsert.Department := fFunctionalDepartment[RecordCount];
                    FailureCodesInsert."Failure Item" := fItemCode[RecordCount];
                    FailureCodesInsert.Code := fKindCode[RecordCount];
                    FailureCodesInsert.Category := fCategoryCode[RecordCount];
                    FailureCodesInsert.Insert;
                    Commit;
                    OccurenceCount := OccurenceCount + 1;
                end;
            end;
        end;
    end;

    var
        fDefectCode: array[10] of Code[5];
        fFunctionalDepartment: array[10] of Enum PumpFailureDept;
        fItemCode: array[10] of Enum FailureItem;
        fKindCode: array[10] of Enum FailureCode;
        fCategoryCode: array[10] of Enum FailWorkReq;
        fTech: array[10] of Code[10];
        FailureCodes: Record "Order Defects";
        FailureCodesInsert: Record "Order Defects";
        FailureCodesEntered: Record "Order Defects";
        FailureCodeOccurence: Record "Order Defects";
        DuplicateRecord: Boolean;
        RecordCycle: Integer;
        CurrentCycle: Integer;
        OccurenceCount: Integer;
        ArrayCount: Integer;
        RecordCount: Integer;
        DefectCode: Code[5];
        FunctionalDepartment: Code[1];
        ItemCode: Code[1];
        KindCode: Code[2];

    procedure "fDepartment Conversion"()
    begin
        Clear(FunctionalDepartment);
        case fFunctionalDepartment[ArrayCount].AsInteger() of
            1:
                begin
                    FunctionalDepartment := 'F';
                end;

            2:
                begin
                    FunctionalDepartment := 'P';
                end;

            3:
                begin
                    FunctionalDepartment := 'T';
                end;

            4:
                begin
                    FunctionalDepartment := 'Q';
                end;

        end;
    end;

    procedure "fFailure Item Conversion"()
    begin
        Clear(ItemCode);
        case fItemCode[ArrayCount].AsInteger() of
            1:
                begin
                    ItemCode := 'A';
                end;

            2:
                begin
                    ItemCode := 'B';
                end;

            3:
                begin
                    ItemCode := 'C';
                end;

            4:
                begin
                    ItemCode := 'D';
                end;

            5:
                begin
                    ItemCode := 'E';
                end;

            6:
                begin
                    ItemCode := 'F';
                end;

            7:
                begin
                    ItemCode := 'G';
                end;

            8:
                begin
                    ItemCode := 'H';
                end;

            9:
                begin
                    ItemCode := 'I';
                end;

            10:
                begin
                    ItemCode := 'J';
                end;

            11:
                begin
                    ItemCode := 'K';
                end;

            12:
                begin
                    ItemCode := 'L';
                end;

            13:
                begin
                    ItemCode := 'M';
                end;

            14:
                begin
                    ItemCode := 'N';
                end;

            15:
                begin
                    ItemCode := 'O';
                end;

            16:
                begin
                    ItemCode := 'P';
                end;

            17:
                begin
                    ItemCode := 'Q';
                end;

            18:
                begin
                    ItemCode := 'R';
                end;
        end;
    end;

    procedure "fCodes Conversion"()
    begin
        Clear(KindCode);
        case fKindCode[ArrayCount].AsInteger() of
            1:
                begin
                    KindCode := '1';
                end;

            2:
                begin
                    KindCode := '2';
                end;

            3:
                begin
                    KindCode := '3';
                end;

            4:
                begin
                    KindCode := '4';
                end;

            5:
                begin
                    KindCode := '5';
                end;

            6:
                begin
                    KindCode := '6';
                end;

            7:
                begin
                    KindCode := '7';
                end;

            8:
                begin
                    KindCode := '8';
                end;

            9:
                begin
                    KindCode := '9';
                end;

            10:
                begin
                    KindCode := '10';
                end;

            11:
                begin
                    KindCode := '11';
                end;

            12:
                begin
                    KindCode := '12';
                end;

            13:
                begin
                    KindCode := '13';
                end;

            14:
                begin
                    KindCode := '14';
                end;

            15:
                begin
                    KindCode := '15';
                end;

            16:
                begin
                    KindCode := '16';
                end;

            17:
                begin
                    KindCode := '17';
                end;

            18:
                begin
                    KindCode := '18';
                end;

            19:
                begin
                    KindCode := '19';
                end;

            20:
                begin
                    KindCode := '20';
                end;

            21:
                begin
                    KindCode := '21';
                end;

            22:
                begin
                    KindCode := '22';
                end;

            23:
                begin
                    KindCode := '23';
                end;

            24:
                begin
                    KindCode := '24';
                end;
        end;
    end;
}

