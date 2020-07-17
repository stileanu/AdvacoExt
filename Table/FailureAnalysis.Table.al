table 50014 "Failure Analysis"
{

    fields
    {
        field(10;"Order No.";Code[7])
        {
        }
        field(20;"Order Type";Option)
        {
            OptionMembers = Rebuild,Repair,Warranty;
        }
        field(30;"Model No.";Code[10])
        {
        }
        field(40;"Model Type";Option)
        {
            OptionMembers = " ",Blower,"Cryo Compressor","Cryo Pump","Diffusion Pump","Dry Pump - Ebara","Dry Pump - Edwards","Dry Pump - Leybold","Filter System","Leak Detector","Mechanical Pump","Scroll Pump","Turbo Controller","Turbo Pump";
        }
        field(1000;Motor;Boolean)
        {
            Description = 'Exterior Motor Inspection';
        }
        field(1010;Voltage;Code[10])
        {
        }
        field(1020;HP;Code[10])
        {
        }
        field(1025;kW;Decimal)
        {
        }
        field(1030;Phase;Code[10])
        {
        }
        field(1040;"Motor Condition";Option)
        {
            OptionMembers = " ","Bad Alignment",Noisy,Seized;
        }
        field(1045;"Motor Bearings";Option)
        {
            OptionMembers = OK,Replace;
        }
        field(1050;"Reverse Lock";Boolean)
        {
        }
        field(1051;"Reverse Lock Damaged";Boolean)
        {
        }
        field(1060;"Line Cord";Boolean)
        {
        }
        field(1061;"Line Cord Damaged";Boolean)
        {
        }
        field(1070;Switch;Boolean)
        {
        }
        field(1071;"Switch Damaged";Boolean)
        {
        }
        field(1080;Pulley;Boolean)
        {
        }
        field(1081;"Pulley Damaged";Boolean)
        {
        }
        field(1090;Plug;Boolean)
        {
        }
        field(1091;"Plug Damaged";Boolean)
        {
        }
        field(1100;"V-belts";Boolean)
        {
        }
        field(1101;"V-belts Size";Code[10])
        {
        }
        field(1102;"V-belts Condition";Option)
        {
            OptionMembers = " ",Good,Loose,Poor;
        }
        field(1110;Windings;Option)
        {
            OptionMembers = OK,Rewind;
        }
        field(1120;"Starting Amps";Code[10])
        {
        }
        field(1130;"Running Amps";Code[10])
        {
        }
        field(1140;"Motor Comments";Code[250])
        {
        }
        field(1200;"Exterior Dirt";Boolean)
        {
            Description = 'Exterior Inspection';
        }
        field(1210;"Oil Leak";Boolean)
        {
        }
        field(1211;"Oil Leak Description";Option)
        {
            OptionMembers = " ","Case",Seal,"Exhaust Port";
        }
        field(1220;"Water Leak";Boolean)
        {
        }
        field(1230;"Vacuum Leak";Boolean)
        {
        }
        field(1260;"Cooling Line";Option)
        {
            OptionMembers = " ",OK,"Replace Clogged","Replace Corroded","Replace Damaged";
        }
        field(1270;Thermostats;Option)
        {
            OptionMembers = " ",OK,"Replace Damaged";
        }
        field(1280;Heaters;Option)
        {
            OptionMembers = " ",OK,Replace;
        }
        field(1290;"Turbo Controller Cable";Boolean)
        {
        }
        field(1300;"Case Condition";Option)
        {
            Description = 'Blower Specific';
            OptionMembers = " ",OK,Repairable,Replace;
        }
        field(1310;"Lobes Condition";Option)
        {
            OptionMembers = " ",OK,Repairable,Replace;
        }
        field(1400;"Cover Condition";Option)
        {
            OptionMembers = " ",OK,Damaged,Missing,Bent;
        }
        field(1410;"Casters Condition";Option)
        {
            OptionMembers = " ",OK," Damaged";
        }
        field(1420;"Pressure Gauge Reading";Code[10])
        {
        }
        field(2000;Covers;Option)
        {
            Description = 'Pump Accessories - Dry';
            OptionMembers = " ",OK,Damaged;
        }
        field(2005;"Purge Fittings";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2010;"Purge Fittings Quantity";Option)
        {
            OptionMembers = " ",Complete,Partial;
        }
        field(2015;Electronics;Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2020;"Inlet Fittings";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2025;"Exhuast Fittings";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2030;"External Valves";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2035;"Inlet Filters";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2040;"Exhaust Filters";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2045;Base;Option)
        {
            Description = 'Pump Accessories - General Vacuum';
            OptionMembers = " ",OK,Damaged;
        }
        field(2046;Beltguard;Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2047;"Beltguard Quantity";Option)
        {
            OptionMembers = " ",Complete,Partial;
        }
        field(2048;Pully;Option)
        {
            OptionMembers = " ",OK,"Bad Alignment",Damaged;
        }
        field(2049;"External Oil Filters";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2050;"Oil Filter System";Option)
        {
            OptionMembers = " ",OK,Damaged;
        }
        field(2100;"Gas Module";Code[10])
        {
            Description = 'Pump Accessories - Edwards';
        }
        field(2101;"Gas Module SN";Code[30])
        {
        }
        field(2110;"Exhaust Pressure Module";Code[10])
        {
        }
        field(2111;"Exhaust Pressure Module SN";Code[30])
        {
        }
        field(2120;"iQ Gas System Module";Code[10])
        {
        }
        field(2121;"iQ Gas System Module SN";Code[30])
        {
        }
        field(2130;"iQ Electronics Module";Code[10])
        {
        }
        field(2131;"iQ Electronics Module SN";Code[30])
        {
        }
    }

    keys
    {
        key(Key1;"Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

