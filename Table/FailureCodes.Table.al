table 50009 "Failure Codes"
{
    // Departments:
    // 1 P - Production Assembly
    // 2 T - Test
    // 3 Q - Quality Control
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
        field(1; Deptarment; Enum FailureDept)
        {
            //OptionMembers = " ","Production Assembly",Test,"Quality Control";
        }
        field(2; "Failure Item"; Enum FailureItem)
        {
            //OptionMembers = " ",Pump,Motor,Assembly,Component,Finish,Hardware,Label,Cover,Base,"Belt Guard",Feet,Tubing,"Heat Exchanger",
            //                Pulley,Ballast,"Oil Prep.","Line Cord",Documentation;
        }
        field(3; "Code"; Enum FailureCode)
        {
            //OptionMembers = " ",Missing,Wrong,Loose,"Broken/Cracked","Not Clean","Defective/Damaged",Contaiminated,"Out of Dim","Mis-Alignment",
            //                Peeling,"Surface Damage","Vacuum Leak","Poor Vacuum","Poor Pumping Speed","Leaks Oil","Seal Leak","Case Gasket Leaks",
            //                "Window Leaks","Tubing Leaks",Seized,Noise,"Defective Bearings","High Vibration",Configuration;
        }
        field(10; "Failure Code"; Code[5])
        {
        }
        field(20; Description; Text[30])
        {
        }
        field(100; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Failure Code")
        {
        }
    }

    fieldgroups
    {
    }
}

