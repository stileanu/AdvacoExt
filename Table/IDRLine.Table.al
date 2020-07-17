table 50018 IDRLine
{
    // version US2.60.05,LDUS2.60.05.22,HEF

    PasteIsValid = false;

    fields
    {
        field(10; "Document Type"; Enum IDRDocType)
        {
            //OptionMembers = " ",Receiving,Production;
        }
        field(20; "Document No."; Code[20])
        {
            TableRelation = IDRHeader."No.";
        }
        field(30; "Part Type"; Enum PartType)
        {
            //OptionMembers = Item,Resource;
        }
        field(40; "Item No."; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate();
            begin
                IF Item.GET("Item No.") THEN
                    OK := TRUE;

                CASE "Part Type" OF
                    "Part Type"::Item:
                        BEGIN
                            Description := Item.Description;
                            "Vendor Item No." := Item."Vendor Item No.";
                        END;
                END;
            end;
        }
        field(50; "Vendor Item No."; Text[20])
        {
        }
        field(60; Description; Text[50])
        {
        }
        field(70; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(90; "Serial No."; Code[20])
        {
        }
        field(100; "Defect code"; Code[5])
        {
        }
        field(110; Department; Enum IDRDept)
        {
            //OptionMembers = " ","Production Assembly",Test,"Quality Control";

            trigger OnValidate();
            begin
                //Convert to Codes
                "fDepartment Conversion";
                "fFailure Item Conversion";
                "fCodes Conversion";

                IF (FunctionalDepartment <> '') AND (ItemCode <> '') AND (KindCode <> '') THEN BEGIN
                    "Defect code" := FunctionalDepartment + ItemCode + KindCode;

                END ELSE BEGIN
                    "Defect code" := '';
                END;
            end;
        }
        field(120; "Failure Item"; Enum FailureItem)
        {
            //OptionMembers = " ",Pump,Motor,Assembly,Component,Finish,Hardware,Label,Cover,Base,"Belt Guard",Feet,Tubing,"Heat Exchanger",Pulley,Ballast,"Oil Prep.","Line Cord",Documentation;

            trigger OnValidate();
            begin
                //Convert to Codes
                "fDepartment Conversion";
                "fFailure Item Conversion";
                "fCodes Conversion";

                IF (FunctionalDepartment <> '') AND (ItemCode <> '') AND (KindCode <> '') THEN BEGIN
                    "Defect code" := FunctionalDepartment + ItemCode + KindCode;
                END ELSE BEGIN
                    "Defect code" := '';
                END;
            end;
        }
        field(130; "Code"; Enum FailureCode)
        {
            //OptionMembers = " ",Missing,Wrong,Loose,"Broken/Cracked","Not Clean","Defective/Damaged",Contaiminated,"Out of Dim","Mis-Alignment",
            //Peeling,"Surface Damage","Vacuum Leak","Poor Vacuum","Poor Pumping Speed","Leaks Oil","Seal Leak","Case Gasket Leaks","Window Leaks",
            //"Tubing Leaks",Seized,Noise,"Defective Bearings","High Vibration",Configuration;

            trigger OnValidate();
            begin
                //Convert to Codes
                "fDepartment Conversion";
                "fFailure Item Conversion";
                "fCodes Conversion";

                IF (FunctionalDepartment <> '') AND (ItemCode <> '') AND (KindCode <> '') THEN BEGIN
                    "Defect code" := FunctionalDepartment + ItemCode + KindCode;
                END ELSE BEGIN
                    "Defect code" := '';
                END;
            end;
        }
        field(150; "NonConformance Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        GLAcc: Record "G/L Account";
        Item: Record Item;
        UserSetup: Record "User Setup";
        FunctionalDepartment: Code[1];
        ItemCode: Code[1];
        KindCode: Code[2];
        OK: Boolean;

    procedure "fDepartment Conversion"();
    begin
        CLEAR(FunctionalDepartment);
        CASE Department.AsInteger() OF
            1:
                BEGIN
                    FunctionalDepartment := 'P';
                END;

            2:
                BEGIN
                    FunctionalDepartment := 'T';
                END;

            3:
                BEGIN
                    FunctionalDepartment := 'Q';
                END;
        END;
    end;

    procedure "fFailure Item Conversion"();
    begin
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

    procedure "fCodes Conversion"();
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

