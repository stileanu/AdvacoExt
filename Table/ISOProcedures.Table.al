table 50010 "ISO Procedures"
{

    fields
    {
        field(10; Step; Enum DetailStep)
        {
            //OptionMembers = REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        }
        field(20; "Model Type"; Enum ModelType)
        {
            //OptionMembers = " ",Blower,"Cryo Compressor","Cryo Pump","Diffusion Pump","Dry Pump - Ebara","Dry Pump - Edwards","Dry Pump - Leybold",
            //                "Filter System","Leak Detector","Mechanical Pump","Scroll Pump","Turbo Controller","Turbo Pump";
        }
        field(30; "ISO Procedure"; Code[30])
        {
        }
        field(40; Release; Code[1])
        {
        }
        field(50; "ISO Filename"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; Step, "Model Type")
        {
        }
    }

    fieldgroups
    {
    }
}

