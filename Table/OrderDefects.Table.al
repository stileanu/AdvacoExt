table 50013 "Order Defects"
{
    // version ADV

    // Departments:
    // 1 F - Failure Analysis
    // 2 P - Production Assembly
    // 3 T - Test
    // 4 Q - Quality Control
    // 
    // Failure Item
    // 1 A - Pump
    // 2 B - Motor
    // 3 C - Assembly
    // 4 D - Component
    // 5 E - Finish
    // 6 F - Hardware
    // 7 G - Label
    // 8 H - Cover
    // 9 I -  Base
    // 10 J - Belt guard
    // 11 K - Feet
    // 12 L - Tubing
    // 13 M - Heat exchanger
    // 14 N - Pulley
    // 15 O - Ballast
    // 16 P - Oil prep.
    // 17 Q - Line cord
    // 18 R - Documentation
    // 
    // Codes
    // 1 - Missing
    // 2 - Wrong
    // 3 - Loose
    // 4 - Broken/cracked
    // 5 - Not Clean
    // 6 - Defective/damaged
    // 7 - Contaminated
    // 8 - Out of Dim
    // 9 - Mis-alignment
    // 10 - Peeling
    // 11 - Surface damage
    // 12 - Vacuum leak
    // 13 - Poor vacuum
    // 14 - Poor pumping speed
    // 15 - Leaks oil
    // 16 - Seal leak
    // 17 - Case gasket leaks
    // 18 - Window leaks
    // 19 - Tubing leaks
    // 20  - Seized
    // 21 - Noise
    // 22 - Defective bearings
    // 23 - High vibration
    // 24 - Configuration
    // 
    // 08/27/12 ADV
    //   Commented code to eliminate compiling errors on forms.
    //   Looks like it never worked.


    fields
    {
        field(10; Occurrence; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Order No."; Code[9])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Defect Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Department; Enum PumpFailureDept)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ","Failure Analysis","Production Assembly",Test,"Quality Control";

            trigger OnValidate();
            begin
                //Convert to Codes
                "Department Conversion";
                "Failure Item Conversion";
                "Codes Conversion";

                IF (FunctionalDepartment <> '') AND (ItemCode <> '') AND (KindCode <> '') THEN BEGIN
                    "Defect Code" := FunctionalDepartment + ItemCode + KindCode;
                END ELSE BEGIN
                    "Defect Code" := '';
                END;
            end;
        }
        field(50; "Failure Item"; Enum FailureItem)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ",Pump,Motor,Assembly,Component,Finish,Hardware,Label,Cover,Base,"Belt Guard",Feet,Tubing,"Heat Exchanger",Pulley,
            //                Ballast,"Oil Prep.","Line Cord",Documentation; 

            trigger OnValidate();
            begin
                //Convert to Codes
                "Department Conversion";
                "Failure Item Conversion";
                "Codes Conversion";

                IF (FunctionalDepartment <> '') AND (ItemCode <> '') AND (KindCode <> '') THEN BEGIN
                    "Defect Code" := FunctionalDepartment + ItemCode + KindCode;
                END ELSE BEGIN
                    "Defect Code" := '';
                END;
            end;
        }
        field(60; "Code"; Enum FailureCode)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ",Missing,Wrong,Loose,"Broken/Cracked","Not Clean","Defective/Damaged",Contaiminated,"Out of Dim","Mis-Alignment",
            //                Peeling,"Surface Damage","Vacuum Leak","Poor Vacuum","Poor Pumping Speed","Leaks Oil","Seal Leak","Case Gasket Leaks",
            //                "Window Leaks","Tubing Leaks",Seized,Noise,"Defective Bearings","High Vibration",Configuration;

            trigger OnValidate();
            begin
                //Convert to Codes
                "Department Conversion";
                "Failure Item Conversion";
                "Codes Conversion";

                IF (FunctionalDepartment <> '') AND (ItemCode <> '') AND (KindCode <> '') THEN BEGIN
                    "Defect Code" := FunctionalDepartment + ItemCode + KindCode;
                END ELSE BEGIN
                    "Defect Code" := '';
                END;
            end;
        }
        field(70; Category; Enum FailWorkReq)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ",Repaired,"Rework Required";
        }
        field(80; "Model No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Model Type"; Enum ModelType)
        {
            DataClassification = ToBeClassified;
            //OptionMembers = " ",Blower,"Cryo Compressor","Cryo Pump","Diffusion Pump","Dry Pump - Ebara","Dry Pump - Edwards","Dry Pump - Leybold",
            //                "Filter System","Leak Detector","Mechanical Pump","Scroll Pump","Turbo Controller","Turbo Pump";
        }
        field(90; Technician; Code[5])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(100; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(200; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; Occurrence, "Order No.")
        {
        }
        key(Key2; "Order No.", Occurrence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify();
    begin

        VALIDATE(Department);
        VALIDATE("Failure Item");
        VALIDATE(Code);
    end;

    var
        DefectCode: Code[5];
        FunctionalDepartment: Code[1];
        ItemCode: Code[1];
        KindCode: Code[2];

    procedure "Department Conversion"();
    begin
        CLEAR(FunctionalDepartment);
        CASE Department.AsInteger() OF
            1:
                BEGIN
                    FunctionalDepartment := 'F';
                END;

            2:
                BEGIN
                    FunctionalDepartment := 'P';
                END;

            3:
                BEGIN
                    FunctionalDepartment := 'T';
                END;

            4:
                BEGIN
                    FunctionalDepartment := 'Q';
                END;

        END;
    end;

    procedure "Failure Item Conversion"();
    begin
        CLEAR(ItemCode);
        CASE "Failure Item".AsInteger() OF
            1:
                BEGIN
                    ItemCode := 'A';
                END;

            2:
                BEGIN
                    ItemCode := 'B';
                END;

            3:
                BEGIN
                    ItemCode := 'C';
                END;

            4:
                BEGIN
                    ItemCode := 'D';
                END;

            5:
                BEGIN
                    ItemCode := 'E';
                END;

            6:
                BEGIN
                    ItemCode := 'F';
                END;

            7:
                BEGIN
                    ItemCode := 'G';
                END;

            8:
                BEGIN
                    ItemCode := 'H';
                END;

            9:
                BEGIN
                    ItemCode := 'I';
                END;

            10:
                BEGIN
                    ItemCode := 'J';
                END;

            11:
                BEGIN
                    ItemCode := 'K';
                END;

            12:
                BEGIN
                    ItemCode := 'L';
                END;

            13:
                BEGIN
                    ItemCode := 'M';
                END;

            14:
                BEGIN
                    ItemCode := 'N';
                END;

            15:
                BEGIN
                    ItemCode := 'O';
                END;

            16:
                BEGIN
                    ItemCode := 'P';
                END;

            17:
                BEGIN
                    ItemCode := 'Q';
                END;

            18:
                BEGIN
                    ItemCode := 'R';
                END;
        END;
    end;

    procedure "Codes Conversion"();
    begin
        CLEAR(KindCode);
        CASE Code.AsInteger() OF
            1:
                BEGIN
                    KindCode := '1';
                END;

            2:
                BEGIN
                    KindCode := '2';
                END;

            3:
                BEGIN
                    KindCode := '3';
                END;

            4:
                BEGIN
                    KindCode := '4';
                END;

            5:
                BEGIN
                    KindCode := '5';
                END;

            6:
                BEGIN
                    KindCode := '6';
                END;

            7:
                BEGIN
                    KindCode := '7';
                END;

            8:
                BEGIN
                    KindCode := '8';
                END;

            9:
                BEGIN
                    KindCode := '9';
                END;

            10:
                BEGIN
                    KindCode := '10';
                END;

            11:
                BEGIN
                    KindCode := '11';
                END;

            12:
                BEGIN
                    KindCode := '12';
                END;

            13:
                BEGIN
                    KindCode := '13';
                END;

            14:
                BEGIN
                    KindCode := '14';
                END;

            15:
                BEGIN
                    KindCode := '15';
                END;

            16:
                BEGIN
                    KindCode := '16';
                END;

            17:
                BEGIN
                    KindCode := '17';
                END;

            18:
                BEGIN
                    KindCode := '18';
                END;

            19:
                BEGIN
                    KindCode := '19';
                END;

            20:
                BEGIN
                    KindCode := '20';
                END;

            21:
                BEGIN
                    KindCode := '21';
                END;

            22:
                BEGIN
                    KindCode := '22';
                END;

            23:
                BEGIN
                    KindCode := '23';
                END;

            24:
                BEGIN
                    KindCode := '24';
                END;
        END;
    end;
}

