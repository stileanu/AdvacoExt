page 50028 "Test Failure"
{
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Order Defects";
    Editable = true;
    PageType = Card;

    layout
    {
        area(content)
        {
            group(Control1220060007)
            {
                //ShowCaption = false;
                Caption = 'General';
                grid(Control1220060008)
                {
                    GridLayout = Columns;
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
                //ShowCaption = false;
                Caption = 'Failures';
                fixed(Control1220060009)
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
                            Editable = true;
                        }
                        field("fItemCode[1]"; fItemCode[1])
                        {
                            ApplicationArea = All;
                            ShowCaption = false;

                            trigger OnValidate()
                            begin
                                ArrayCount := 1;

                                if fItemCode[ArrayCount].AsInteger() > 0 then begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::Test;
                                end else begin
                                    fFunctionalDepartment[ArrayCount] := PumpFailureDept::" ";
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

        OccurenceCount := 10;

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
                    FailureCodesInsert.Department := FailureCodesInsert.Department::"Production Assembly";
                    FailureCodesInsert."Model No." := "Model No.";
                    FailureCodesInsert.Date := Date;
                    FailureCodesInsert.Technician := Technician;
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
        //fFunctionalDepartment: array[10] of Option " ","Failure Analysis","Production Assembly",Test,"Quality Control";
        fFunctionalDepartment: array[10] of Enum PumpFailureDept;
        //fItemCode: array[10] of Option " ",Pump,Motor,Assembly,Component,Finish,Hardware,Label,Cover,Base,"Belt Guard",Feet,Tubing,"Heat Exchanger",Pulley,Ballast,"Oil Prep.","Line Cord",Documentation;
        fItemCode: array[10] of Enum FailureItem;
        //fKindCode: array[10] of Option " ",Missing,Wrong,Loose,"Broken/Cracked","Not Clean","Defective/Damaged",Contaiminated,"Out of Dim","Mis-Alignment",Peeling,"Surface Damage","Vacuum Leak","Poor Vacuum","Poor Pumping Speed","Leaks Oil","Seal Leak","Case Gasket Leaks","Window Leaks","Tubing Leaks",Seized,Noise,"Defective Bearings","High Vibration",Configuration;
        fKindCode: array[10] of Enum FailureCode;
        fCategoryCode: array[10] of Option " ",Repaired,"Rework Required";
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
        case fFunctionalDepartment[ArrayCount] of
            PumpFailureDept::"Failure Analysis":
                begin
                    FunctionalDepartment := 'F';
                end;

            PumpFailureDept::"Production Assembly":
                begin
                    FunctionalDepartment := 'P';
                end;

            PumpFailureDept::Test:
                begin
                    FunctionalDepartment := 'T';
                end;

            PumpFailureDept::"Quality Control":
                begin
                    FunctionalDepartment := 'Q';
                end;
        end;
    end;

    procedure "fFailure Item Conversion"()
    begin
        Clear(ItemCode);
        case fItemCode[ArrayCount] of
            FailureItem::Pump:
                begin
                    ItemCode := 'A';
                end;

            FailureItem::Motor:
                begin
                    ItemCode := 'B';
                end;

            FailureItem::Assembly:
                begin
                    ItemCode := 'C';
                end;

            FailureItem::Component:
                begin
                    ItemCode := 'D';
                end;

            FailureItem::Finish:
                begin
                    ItemCode := 'E';
                end;

            FailureItem::Hardware:
                begin
                    ItemCode := 'F';
                end;

            FailureItem::Label:
                begin
                    ItemCode := 'G';
                end;

            FailureItem::Cover:
                begin
                    ItemCode := 'H';
                end;

            FailureItem::Base:
                begin
                    ItemCode := 'I';
                end;

            FailureItem::"Belt Guard":
                begin
                    ItemCode := 'J';
                end;

            FailureItem::Feet:
                begin
                    ItemCode := 'K';
                end;

            FailureItem::Tubing:
                begin
                    ItemCode := 'L';
                end;

            FailureItem::"Heat Exchanger":
                begin
                    ItemCode := 'M';
                end;

            FailureItem::Pulley:
                begin
                    ItemCode := 'N';
                end;

            FailureItem::Ballast:
                begin
                    ItemCode := 'O';
                end;

            FailureItem::"Oil Prep.":
                begin
                    ItemCode := 'P';
                end;

            FailureItem::"Line Cord":
                begin
                    ItemCode := 'Q';
                end;

            FailureItem::Documentation:
                begin
                    ItemCode := 'R';
                end;
        end;
    end;

    procedure "fCodes Conversion"()
    begin
        Clear(KindCode);
        case fKindCode[ArrayCount] of
            FailureCode::Missing:
                begin
                    KindCode := '1';
                end;

            FailureCode::Wrong:
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
            //OptionMembers = " ",Missing,Wrong,Loose,"Broken/Cracked","Not Clean","Defective/Damaged",Contaiminated,"Out of Dim","Mis-Alignment",
            //                Peeling,"Surface Damage","Vacuum Leak","Poor Vacuum","Poor Pumping Speed","Leaks Oil","Seal Leak","Case Gasket Leaks",
            //                "Window Leaks","Tubing Leaks",Seized,Noise,"Defective Bearings","High Vibration",Configuration;

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

