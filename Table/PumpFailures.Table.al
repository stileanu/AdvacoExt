table 50008 "Pump Failures"
{
    // Departments:
    // 1 D - Disassembly
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


    fields
    {
        field(10; Number; Integer)
        {
        }
        field(20; "Failure Code"; Code[5])
        {
            TableRelation = "Failure Codes"."Failure Code";

            trigger OnValidate();
            begin
                FailureCodes.GET("Failure Code");
                Descripton := FailureCodes.Description;
            end;
        }
        field(22; Department; Enum PumpFailureDept)
        {
            //OptionMembers = " ","Failure Analysis","Production Assembly",Test,"Quality Control";
        }
        field(24; "Failure Item"; Enum FailureItem)
        {
            //OptionMembers = " ",Pump,Motor,Assembly,Component,Finish,Hardware,Label,Cover,Base,"Belt Guard",Feet,Tubing,"Heat Exchanger",
            //                Pulley,Ballast,"Oil Prep.","Line Cord",Documentation;
        }
        field(26; "Code"; Enum FailureItem)
        {
            //OptionMembers = " ",Missing,Wrong,Loose,"Broken/Cracked","Not Clean","Defective/Damaged",Contaiminated,"Out of Dim","Mis-Alignment",
            //                Peeling,"Surface Damage","Vacuum Leak","Poor Vacuum","Poor Pumping Speed","Leaks Oil","Seal Leak","Case Gasket Leaks",
            //                "Window Leaks","Tubing Leaks",Seized,Noise,"Defective Bearings","High Vibration",Configuration;
        }
        field(30; Descripton; Text[30])
        {
        }
        field(35; Category; Enum FailWorkReq)
        {
            //OptionMembers = " ","Repaired at Test","Rework Required";
        }
        field(40; "Model No."; Code[15])
        {
        }
        field(45; "Model Type"; Enum ModelType)
        {
            //OptionMembers = " ",Blower,"Cryo Compressor","Cryo Pump","Diffusion Pump","Dry Pump - Ebara","Dry Pump - Edwards","Dry Pump - Leybold",
            //                "Filter System","Leak Detector","Mechanical Pump","Scroll Pump","Turbo Controller","Turbo Pump";
        }
        field(50; Date; Date)
        {
            FieldClass = Normal;
        }
        field(60; Mechanic; Code[5])
        {
        }
        field(100; "Work Order No."; Code[7])
        {
        }
        field(200; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; Number, "Work Order No.")
        {
        }
        key(Key2; "Failure Code")
        {
        }
        key(Key3; "Model No.")
        {
        }
        key(Key4; "Work Order No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FailureCodes: Record "Failure Codes";
        Ok: Boolean;
}

