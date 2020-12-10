report 50002 "Work Order Traveler"
{
    // 'MACHINE SHOP'
    // 'BALANCING'
    // 'ADVACO-GMP-2005..2006'
    // 
    // 11/02/2010 ADV
    //   Added code to retrieve Customer Part No. specific instructions.
    //   Create a new function and remove the code not necessary.
    //   Ex:
    //   {
    //   WI.SETRANGE(WI."Customer Code",'');
    //   WI.SETRANGE(WI."Ship To Code",'');
    //   WI.SETRANGE(WI.Step,WI.Step :: REC);
    //   WI.SETRANGE(WI.Model,"Work Order Detail"."Model No.");
    //   IF WI.FIND('-') THEN BEGIN
    //     Length := STRLEN(WI.Instruction);
    //     IF Length > 130 THEN BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,1,130);
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := COPYSTR(WI.Instruction,131,120);
    //     END ELSE BEGIN
    //       LineCount := LineCount + 1;
    //       Instr[LineCount] := WI.Instruction;
    //     END;
    //   END;
    //   WI.RESET;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50002_WorkOrderTraveler.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            DataItemTableView = SORTING("Work Order No.") ORDER(Ascending);
            RequestFilterFields = "Work Order Master No.", "Work Order No.";
            column(TIME; Time)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(ADWO; 'A D V A C O   W O R K  O R D E R')
            {
            }
            column(USERID; UserId)
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(Work_Order_Detail__Work_Order_Date_; "Work Order Date")
            {
            }
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Customer_Part_No__; "Customer Part No.")
            {
            }
            column(Work_Order_Detail__Date_Required_; "Date Required")
            {
            }
            column(Work_Order_Detail_Description; Description)
            {
            }
            column(Work_Order_Detail__Serial_No__; "Serial No.")
            {
            }
            column(Work_Order_Detail__Oil_Type_; "Oil Type")
            {
            }
            column(Work_Order_Detail_Carrier; Carrier)
            {
            }
            column(Work_Order_Detail_Notes; Notes)
            {
            }
            column(Work_Order_Detail_Non_Copper; "Non Copper")
            {
            }
            column(Work_Order_Detail_Diagnosis; Diagnosis)
            {
            }
            column(INTEL; '*  *  * INTEL Non-Copper Segregation Required *  *  * ')
            {
            }
            column(Work_Order_Detail__Order_Type__Control33; "Order Type")
            {
            }
            column(Work_Order_Detail__Work_Order_Date__Control34; "Work Order Date")
            {
            }
            column(Work_Order_Detail__Date_Required__Control35; "Date Required")
            {
            }
            column(Work_Order_Detail_Notes_Control37; Notes)
            {
            }
            column(Work_Order_Detail__Work_Order_No___Control38; "Work Order No.")
            {
            }
            column(WO; 'W O R K  O R D E R')
            {
            }
            column(AD; 'A D V A C O')
            {
            }
            column(Work_Order_Detail__Model_No___Control45; "Model No.")
            {
            }
            column(Work_Order_Detail_Description_Control46; Description)
            {
            }
            column(Work_Order_Detail__Serial_No___Control47; "Serial No.")
            {
            }
            column(Work_Order_Detail__Oil_Type__Control49; "Oil Type")
            {
            }
            column(FORMAT_TODAY_0_4__Control50; Format(Today, 0, 4))
            {
            }
            column(USERID_Control51; UserId)
            {
            }
            column(TIME_Control53; Time)
            {
            }
            column(Work_Order_Detail_Carrier_Control25; Carrier)
            {
            }
            column(ShipTo_Control59; ShipTo)
            {
            }
            column(Work_Order_Detail__Customer_Part_No___Control90; "Customer Part No.")
            {
            }
            column(Work_Order_Detail_Diagnosis_Control92; Diagnosis)
            {
            }
            column(RECEIVING_; 'RECEIVING')
            {
            }
            column(NOTES___; 'NOTES :')
            {
            }
            column(EmptyString; '______')
            {
            }
            column(DATE___IN___; 'DATE / IN :')
            {
            }
            column(EmptyString_Control233; '___|___|___')
            {
            }
            column(DATE___OUT___; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control235; '___|___|___')
            {
            }
            column(REG_HOURS_____________; 'REG HOURS:')
            {
            }
            column(Instr_1_RCV; Instr_RCV[1])
            {
            }
            column(Instr_3_RCV; Instr_RCV[3])
            {
            }
            column(Instr_2_RCV; Instr_RCV[2])
            {
            }
            column(Instr_1_DIS; Instr_DIS[1])
            {
            }
            column(Instr_3_DIS; Instr_DIS[3])
            {
            }
            column(Instr_2_DIS; Instr_DIS[2])
            {
            }
            column(Instr_1_QOT; Instr_QOT[1])
            {
            }
            column(Instr_3_QOT; Instr_QOT[3])
            {
            }
            column(Instr_2_QOT; Instr_QOT[2])
            {
            }
            column(Instr_1_CLN; Instr_CLN[1])
            {
            }
            column(Instr_3_CLN; Instr_CLN[3])
            {
            }
            column(Instr_2_CLN; Instr_CLN[2])
            {
            }
            column(Instr_1_ASM; Instr_ASM[1])
            {
            }
            column(Instr_3_ASM; Instr_ASM[3])
            {
            }
            column(Instr_2_ASM; Instr_ASM[2])
            {
            }
            column(Instr_1_TST; Instr_TST[1])
            {
            }
            column(Instr_3_TST; Instr_TST[3])
            {
            }
            column(Instr_2_TST; Instr_TST[2])
            {
            }
            column(Instr_1_PNT; Instr_PNT[1])
            {
            }
            column(Instr_3_PNT; Instr_PNT[3])
            {
            }
            column(Instr_2_PNT; Instr_PNT[2])
            {
            }
            column(Instr_1_QC; Instr_QC[1])
            {
            }
            column(Instr_3_QC; Instr_QC[3])
            {
            }
            column(Instr_2_QC; Instr_QC[2])
            {
            }
            column(Instr_1_SHP; Instr_SHP[1])
            {
            }
            column(Instr_3_SHP; Instr_SHP[3])
            {
            }
            column(Instr_2_SHP; Instr_SHP[2])
            {
            }
            column(AddNotes; AddNotes)
            {
            }
            column(DISASSEMBLY_; 'DISASSEMBLY')
            {
            }
            column(EmptyString_Control239; '______')
            {
            }
            column(DATE___IN____Control240; 'DATE / IN :')
            {
            }
            column(EmptyString_Control241; '___|___|___')
            {
            }
            column(DATE___OUT____Control242; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control243; '___|___|___')
            {
            }
            column(REG_HOURS______________Control244; 'REG HOURS:')
            {
            }
            column(NOTES____Control65; 'NOTES :')
            {
            }
            column(Instr_3__Control52; Instr[3])
            {
            }
            column(Instr_2__Control62; Instr[2])
            {
            }
            column(Instr_1__Control64; Instr[1])
            {
            }
            column(AddNotes_Control10; AddNotes)
            {
            }
            column(QUOTE_; 'QUOTE')
            {
            }
            column(EmptyString_Control248; '______')
            {
            }
            column(DATE___IN____Control249; 'DATE / IN :')
            {
            }
            column(EmptyString_Control250; '___|___|___')
            {
            }
            column(DATE___OUT____Control251; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control252; '___|___|___')
            {
            }
            column(REG_HOURS______________Control253; 'REG HOURS:')
            {
            }
            column(NOTES____Control66; 'NOTES :')
            {
            }
            column(Instr_1__Control75; Instr[1])
            {
            }
            column(Instr_3__Control77; Instr[3])
            {
            }
            column(Instr_2__Control79; Instr[2])
            {
            }
            column(AddNotes_Control26; AddNotes)
            {
            }
            column(B_O_HOLD_; 'B/O HOLD')
            {
            }
            column(EmptyString_Control269; '______')
            {
            }
            column(DATE___IN____Control271; 'DATE / IN :')
            {
            }
            column(EmptyString_Control273; '___|___|___')
            {
            }
            column(DATE___OUT____Control274; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control275; '___|___|___')
            {
            }
            column(REG_HOURS______________Control276; 'REG HOURS:')
            {
            }
            column(CLEANING_; 'CLEANING')
            {
            }
            column(EmptyString_Control282; '______')
            {
            }
            column(DATE___IN____Control283; 'DATE / IN :')
            {
            }
            column(EmptyString_Control284; '___|___|___')
            {
            }
            column(DATE___OUT____Control285; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control286; '___|___|___')
            {
            }
            column(REG_HOURS______________Control287; 'REG HOURS:')
            {
            }
            column(NOTES____Control69; 'NOTES :')
            {
            }
            column(Instr_1__Control84; Instr[1])
            {
            }
            column(Instr_3__Control86; Instr[3])
            {
            }
            column(Instr_2__Control87; Instr[2])
            {
            }
            column(AddNotes_Control63; AddNotes)
            {
            }
            column(ASSEMBLY_; 'ASSEMBLY')
            {
            }
            column(EmptyString_Control291; '______')
            {
            }
            column(DATE___IN____Control292; 'DATE / IN :')
            {
            }
            column(EmptyString_Control293; '___|___|___')
            {
            }
            column(DATE___OUT____Control294; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control295; '___|___|___')
            {
            }
            column(REG_HOURS______________Control296; 'REG HOURS:')
            {
            }
            column(NOTES____Control70; 'NOTES :')
            {
            }
            column(Instr_1__Control89; Instr[1])
            {
            }
            column(Instr_3__Control95; Instr[3])
            {
            }
            column(Instr_2__Control97; Instr[2])
            {
            }
            column(AddNotes_Control76; AddNotes)
            {
            }
            column(TESTING_; 'TESTING')
            {
            }
            column(EmptyString_Control300; '______')
            {
            }
            column(DATE___IN____Control301; 'DATE / IN :')
            {
            }
            column(EmptyString_Control302; '___|___|___')
            {
            }
            column(DATE___OUT____Control303; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control304; '___|___|___')
            {
            }
            column(REG_HOURS______________Control305; 'REG HOURS:')
            {
            }
            column(NOTES____Control71; 'NOTES :')
            {
            }
            column(Instr_1__Control100; Instr[1])
            {
            }
            column(Instr_3__Control113; Instr[3])
            {
            }
            column(Instr_2__Control118; Instr[2])
            {
            }
            column(AddNotes_Control81; AddNotes)
            {
            }
            column(REWORK_; 'REWORK')
            {
            }
            column(EmptyString_Control354; '______')
            {
            }
            column(DATE___IN____Control355; 'DATE / IN :')
            {
            }
            column(EmptyString_Control356; '___|___|___')
            {
            }
            column(DATE___OUT____Control357; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control358; '___|___|___')
            {
            }
            column(REG_HOURS______________Control359; 'REG HOURS:')
            {
            }
            column(RE_TEST_; 'RE-TEST')
            {
            }
            column(EmptyString_Control345; '______')
            {
            }
            column(DATE___IN____Control346; 'DATE / IN :')
            {
            }
            column(EmptyString_Control347; '___|___|___')
            {
            }
            column(DATE___OUT____Control348; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control349; '___|___|___')
            {
            }
            column(REG_HOURS______________Control350; 'REG HOURS:')
            {
            }
            column(MachineBalance; MachineBalance)
            {
            }
            column(EmptyString_Control336; '______')
            {
            }
            column(DATE___IN____Control337; 'DATE / IN :')
            {
            }
            column(EmptyString_Control338; '___|___|___')
            {
            }
            column(DATE___OUT____Control339; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control340; '___|___|___')
            {
            }
            column(REG_HOURS______________Control341; 'REG HOURS:')
            {
            }
            column(PAINT_SHOP_; 'PAINT SHOP')
            {
            }
            column(EmptyString_Control309; '______')
            {
            }
            column(DATE___IN____Control310; 'DATE / IN :')
            {
            }
            column(EmptyString_Control311; '___|___|___')
            {
            }
            column(DATE___OUT____Control312; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control313; '___|___|___')
            {
            }
            column(REG_HOURS______________Control314; 'REG HOURS:')
            {
            }
            column(NOTES____Control72; 'NOTES :')
            {
            }
            column(Instr_1__Control123; Instr[1])
            {
            }
            column(Instr_3__Control180; Instr[3])
            {
            }
            column(Instr_2__Control181; Instr[2])
            {
            }
            column(AddNotes_Control85; AddNotes)
            {
            }
            column(QUALITY_CHK_; 'QUALITY CHK')
            {
            }
            column(EmptyString_Control318; '______')
            {
            }
            column(DATE___IN____Control319; 'DATE / IN :')
            {
            }
            column(EmptyString_Control320; '___|___|___')
            {
            }
            column(DATE___OUT____Control321; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control322; '___|___|___')
            {
            }
            column(REG_HOURS______________Control323; 'REG HOURS:')
            {
            }
            column(NOTES____Control73; 'NOTES :')
            {
            }
            column(Instr_2__Control182; Instr[2])
            {
            }
            column(Instr_3__Control184; Instr[3])
            {
            }
            column(AddNotes_Control93; AddNotes)
            {
            }
            column(Instr_1__Control227; Instr[1])
            {
            }
            column(SHIPPING_; 'SHIPPING')
            {
            }
            column(EmptyString_Control327; '______')
            {
            }
            column(DATE___IN____Control328; 'DATE / IN :')
            {
            }
            column(EmptyString_Control329; '___|___|___')
            {
            }
            column(DATE___OUT____Control330; 'DATE / OUT :')
            {
            }
            column(EmptyString_Control331; '___|___|___')
            {
            }
            column(REG_HOURS______________Control332; 'REG HOURS:')
            {
            }
            column(NOTES____Control74; 'NOTES :')
            {
            }
            column(Instr_1__Control186; Instr[1])
            {
            }
            column(Instr_3__Control188; Instr[3])
            {
            }
            column(Instr_2__Control189; Instr[2])
            {
            }
            column(AddNotes_Control103; AddNotes)
            {
            }
            column(CreditCardWarning; CreditCardWarning)
            {
            }
            column(VendorRepair; VendorRepair)
            {
            }
            column(Work_Order_Detail__Shipping_Account_; "Shipping Account")
            {
            }
            column(Work_Order_Detail__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(Work_Order_Detail_Carrier_Control54; Carrier)
            {
            }
            column(Model_No__Caption; Model_No__CaptionLbl)
            {
            }
            column(Part_No__Caption; Part_No__CaptionLbl)
            {
            }
            column(W_O_Date_Caption; W_O_Date_CaptionLbl)
            {
            }
            column(Order_Type_Caption; Order_Type_CaptionLbl)
            {
            }
            column(W_O_No__Caption; W_O_No__CaptionLbl)
            {
            }
            column(Due_Date_Caption; Due_Date_CaptionLbl)
            {
            }
            column(Description_Caption; Description_CaptionLbl)
            {
            }
            column(Serial_No__Caption; Serial_No__CaptionLbl)
            {
            }
            column(Oil_Type_Caption; Oil_Type_CaptionLbl)
            {
            }
            column(Carrier_Caption; Carrier_CaptionLbl)
            {
            }
            column(Notes_Caption; Notes_CaptionLbl)
            {
            }
            column(Diagnosis_Caption; Diagnosis_CaptionLbl)
            {
            }
            column(Due_Date_Caption_Control28; Due_Date_Caption_Control28Lbl)
            {
            }
            column(Notes_Caption_Control30; Notes_Caption_Control30Lbl)
            {
            }
            column(W_O_Date_Caption_Control31; W_O_Date_Caption_Control31Lbl)
            {
            }
            column(Order_Type_Caption_Control32; Order_Type_Caption_Control32Lbl)
            {
            }
            column(W_O_No__Caption_Control39; W_O_No__Caption_Control39Lbl)
            {
            }
            column(Model_No__Caption_Control42; Model_No__Caption_Control42Lbl)
            {
            }
            column(Description_Caption_Control43; Description_Caption_Control43Lbl)
            {
            }
            column(Serial_No__Caption_Control44; Serial_No__Caption_Control44Lbl)
            {
            }
            column(Oil_Type_Caption_Control48; Oil_Type_Caption_Control48Lbl)
            {
            }
            column(Carrier_Caption_Control27; Carrier_Caption_Control27Lbl)
            {
            }
            column(Part_No__Caption_Control91; Part_No__Caption_Control91Lbl)
            {
            }
            column(Diagnosis_Caption_Control94; Diagnosis_Caption_Control94Lbl)
            {
            }
            column(INITIALS_Caption; INITIALS_CaptionLbl)
            {
            }
            column(INITIALS_Underscore; INITIALS_UnderscoreLbl)
            {
            }
            column(INITIALS_Caption_Control238; INITIALS_Caption_Control238Lbl)
            {
            }
            column(INITIALS_Caption_Control247; INITIALS_Caption_Control247Lbl)
            {
            }
            column(INITIALS_Caption_Control267; INITIALS_Caption_Control267Lbl)
            {
            }
            column(INITIALS_Caption_Control281; INITIALS_Caption_Control281Lbl)
            {
            }
            column(INITIALS_Caption_Control290; INITIALS_Caption_Control290Lbl)
            {
            }
            column(INITIALS_Caption_Control299; INITIALS_Caption_Control299Lbl)
            {
            }
            column(INITIALS_Caption_Control353; INITIALS_Caption_Control353Lbl)
            {
            }
            column(INITIALS_Caption_Control344; INITIALS_Caption_Control344Lbl)
            {
            }
            column(INITIALS_Caption_Control335; INITIALS_Caption_Control335Lbl)
            {
            }
            column(INITIALS_Caption_Control308; INITIALS_Caption_Control308Lbl)
            {
            }
            column(INITIALS_Caption_Control317; INITIALS_Caption_Control317Lbl)
            {
            }
            column(INITIALS_Caption_Control326; INITIALS_Caption_Control326Lbl)
            {
            }
            column(Shipping_Acct_Caption; Shipping_Acct_CaptionLbl)
            {
            }
            column(Carrier_Caption_Control56; Carrier_Caption_Control56Lbl)
            {
            }
            column(lMachineBalance; lMachineBalance)
            {
            }
            column(lVendRepair; lVendRepair)
            {
            }
            column(lPaintStep; lPaintStep)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(CreditCardWarning);

                WOM.Get(WorkOrderDetail."Work Order Master No.");

                if ("Payment Method" = 'CC') or ("Payment Terms" = 'CC') then
                    CreditCardWarning := 'CONTACT ACCOUNTING FOR CREDIT CARD APPROVAL BEFORE SHIPPING!';

                if ("Payment Terms" = 'COD') then
                    CreditCardWarning := 'CONTACT ACCOUNTING FOR COD APPROVAL BEFORE SHIPPING!';

                if "Vendor Repair" then
                    VendorRepair := '* * * * V E N D O R   R E P A I R * * * *'
                else
                    Clear(VendorRepair);

                ShipTo := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");

                // set visibility
                lVendRepair := WorkOrderDetail."Vendor Repair";

                IF (WorkOrderDetail."Income Code" = "Income Code"::Turbo) or
                   (WorkOrderDetail."Income Code" = "Income Code"::Cryo) or
                   (WorkOrderDetail."Income Code" = "Income Code"::Electronic) or
                   lVendRepair then
                    lPaintStep := true
                else
                    lPaintStep := false;
                lPaintStep := lPaintStep or lVendRepair;

                // Get Instructions 
                // GetInstructions(WI.Step::RCV, Instr);
                GetInstructions(WI.Step::RCV, Instr_RCV);
                GetInstructions(WI.Step::DIS, Instr_DIS);
                GetInstructions(WI.Step::QOT, Instr_QOT);
                GetInstructions(WI.Step::CLN, Instr_CLN);
                GetInstructions(WI.Step::ASM, Instr_ASM);
                GetInstructions(WI.Step::TST, Instr_TST);
                TestProcedureSet;
                MachineBalanceSet(lMachineBalance, MachineBalance);
                GetInstructions(WI.Step::PNT, Instr_PNT);
                GetInstructions(WI.Step::QC, Instr_QC);
                GetInstructions(WI.Step::SHP, Instr_SHP);
            end;

            trigger OnPreDataItem()
            begin
                //IF "Vendor Repair" THEN BEGIN
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        WOM: Record WorkOrderMaster;
        CreditCardWarning: Text[80];
        ShipTo: Text[50];
        lPaintStep: Boolean;
        lVendRepair: Boolean;
        VendorRepair: Text[80];
        WI: Record WorkInstructions;
        LineCount: Integer;
        Length: Integer;
        lMachineBalance: Boolean;
        Instr: array[50] of Code[250];
        Instr_RCV: array[50] of Code[250];
        Instr_DIS: array[50] of Code[250];
        Instr_QOT: array[50] of Code[250];
        Instr_CLN: array[50] of Code[250];
        Instr_ASM: array[50] of Code[250];
        Instr_TST: array[50] of Code[250];
        Instr_PNT: array[50] of Code[250];
        Instr_QC: array[50] of Code[250];
        Instr_SHP: array[50] of Code[250];
        AddNotes: Code[30];
        TestProcedure: Code[30];
        MachineBalance: Text[50];
        BalanceProcedure: Text[50];
        ShowOutput_Instruct: Boolean;
        QLTY_FILE_TO_PRINT: Label 'You need to print and attach the QC file <%1> to this Work Order.';
        QLTY_FILE_TO_OPEN: Label 'The linked QC file <%1> was open for you.';
        OpenFile: Record "Open File" temporary;
        FILE_DOES_NOT_EXIST: Label 'Cannot open linked file. File %1 doesn''t exist.';
        Model_No__CaptionLbl: Label 'Model No.:';
        Part_No__CaptionLbl: Label 'Part No.:';
        W_O_Date_CaptionLbl: Label 'W/O Date:';
        Order_Type_CaptionLbl: Label 'Order Type:';
        W_O_No__CaptionLbl: Label 'W/O No.:';
        Due_Date_CaptionLbl: Label 'Due Date:';
        Description_CaptionLbl: Label 'Description:';
        Serial_No__CaptionLbl: Label 'Serial No.:';
        Oil_Type_CaptionLbl: Label 'Oil Type:';
        Carrier_CaptionLbl: Label 'Carrier:';
        Notes_CaptionLbl: Label 'Notes:';
        Diagnosis_CaptionLbl: Label 'Diagnosis:';
        Due_Date_Caption_Control28Lbl: Label 'Due Date:';
        Notes_Caption_Control30Lbl: Label 'Notes:';
        W_O_Date_Caption_Control31Lbl: Label 'W/O Date:';
        Order_Type_Caption_Control32Lbl: Label 'Order Type:';
        W_O_No__Caption_Control39Lbl: Label 'W/O No.:';
        Model_No__Caption_Control42Lbl: Label 'Model No.:';
        Description_Caption_Control43Lbl: Label 'Description:';
        Serial_No__Caption_Control44Lbl: Label 'Serial No.:';
        Oil_Type_Caption_Control48Lbl: Label 'Oil Type:';
        Carrier_Caption_Control27Lbl: Label 'Carrier:';
        Part_No__Caption_Control91Lbl: Label 'Part No.:';
        Diagnosis_Caption_Control94Lbl: Label 'Diagnosis:';
        INITIALS_CaptionLbl: Label 'INITIALS:';
        INITIALS_UnderscoreLbl: Label '_________';
        INITIALS_Caption_Control238Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control247Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control267Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control281Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control290Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control299Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control353Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control344Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control335Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control308Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control317Lbl: Label 'INITIALS:';
        INITIALS_Caption_Control326Lbl: Label 'INITIALS:';
        Shipping_Acct_CaptionLbl: Label 'Shipping Acct:';
        Carrier_Caption_Control56Lbl: Label 'Carrier:';


    //procedure GetInstructionPerStep(StepCode: Option REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSH,PNT,QC,SHP; CustCode: Code[20]; ShpToCode: Code[10]; ModelNo: Code[20]; CustPartNo: Code[20])
    procedure GetInstructionPerStep(StepCode: Enum DetailStep; CustCode: Code[20]; ShpToCode: Code[10]; ModelNo: Code[20]; CustPartNo: Code[20]; var Instruc: array[50] of Code[250])
    var
        QCFileName: Text[120];
    begin
        // 11/02/2010 New function
        // set filters
        WI.SetRange(WI."Customer Code", CustCode);
        WI.SetRange(WI."Ship To Code", ShpToCode);
        WI.SetRange(WI.Step, StepCode);
        WI.SetRange(WI.Model, ModelNo);
        WI.SetRange(WI."Customer Part No.", CustPartNo);

        // 04/01/2013 Start
        //IF WI.FIND('-') THEN BEGIN
        if (WI.Find('-')) and (not WI.Blocked) then begin
            // 04/01/2013 End
            Length := StrLen(WI.Instruction);
            if Length > 130 then begin
                LineCount := LineCount + 1;
                Instruc[LineCount] := CopyStr(WI.Instruction, 1, 130);
                LineCount := LineCount + 1;
                Instruc[LineCount] := CopyStr(WI.Instruction, 131, 120);
            end else
                if Length <> 0 then begin
                    LineCount := LineCount + 1;
                    Instruc[LineCount] := WI.Instruction;
                end;
            if WI."Part Quality Ctrl Instructions" <> '' then begin
                QCFileName := GetQCFileName(WI."Part Quality Ctrl Instructions");
                // 07/02/2012 Start
                // MESSAGE(QLTY_FILE_TO_PRINT,QCFileName);
                if AddFileLocation(WI."Part Quality Ctrl Instructions") then
                    Message(QLTY_FILE_TO_OPEN, QCFileName);
                // 07/02/2012 End
            end;
        end;
        WI.Reset;
        // Compact Instruc vector
        CompressArray(Instruc);
        //MESSAGE('Moves %1',NoOfMoves)
    end;

    procedure GetQCFileName(QCFull: Text[250]): Text[120]
    var
        TextBuffer: Text[250];
    begin
        // 11/02/2010 New function
        repeat
            QCFull := CopyStr(QCFull, StrPos(QCFull, '\') + 1);
        until StrPos(QCFull, '\') = 0;
        exit(QCFull);
    end;

    procedure AddFileLocation(LocationString: Text[250]): Boolean
    var
        nKey: Integer;
    begin
        // 08/10/2012 New Function
        // determine if file already open. if not open it and add a new record to temp file.
        if OpenFile.Count <> 0 then begin
            OpenFile.FindFirst;
            repeat
                if OpenFile."File Path" = LocationString then
                    exit(false);
            until OpenFile.Next = 0;
            OpenFile.FindLast;
            nKey := OpenFile."Key" + 1;
        end;

        // Insert record
        OpenFile.Reset;
        OpenFile.Init;
        OpenFile."Key" := nKey;
        OpenFile."File Path" := LocationString;
        OpenFile."User ID" := UserId;
        OpenFile.Insert;
        // Open file
        //if Exists(LocationString) then
        if LocationString <> '' then  //ICE-MPC 09/01/20
            HyperLink(LocationString)
        else begin
            Message(FILE_DOES_NOT_EXIST, LocationString);
            exit(false);
        end;

        exit(true);
    end;

    procedure GetInstructions(DetStep: Enum DetailStep; var WInstr: array[50] of Code[250])
    var
        tInstr: Text[250];
    begin

        CLEAR(LineCount);
        CLEAR(Length);
        CLEAR(wInstr);

        IF WODInstructions(DetStep, tInstr) THEN BEGIN
            LineCount := LineCount + 1;
            wInstr[LineCount] := tInstr;
        END;

        // 11/02/2010 Start
        // Step,Model
        GetInstructionPerStep(DetStep, '', '', WorkOrderDetail."Model No.", '', WInstr);

        // Step,Customer
        GetInstructionPerStep(DetStep, WorkOrderDetail."Customer ID", '', '', '', WInstr);

        // Step,Customer,Part No.
        IF (WorkOrderDetail."Customer Part No." <> '') THEN
            GetInstructionPerStep(DetStep, WorkOrderDetail."Customer ID", '', '', WorkOrderDetail."Customer Part No.", WInstr);

        // Step,Customer,Model
        GetInstructionPerStep(DetStep, WorkOrderDetail."Customer ID", '', WorkOrderDetail."Model No.", '', WInstr);

        // Step,Customer,ShipTo
        GetInstructionPerStep(DetStep, WorkOrderDetail."Customer ID", WOM."Ship To Code", '', '', WInstr);

        // Step,Customer,ShipTo,Model
        GetInstructionPerStep(DetStep, WorkOrderDetail."Customer ID", WOM."Ship To Code", WorkOrderDetail."Model No.", '', WInstr);
        // 11/02/2010 End

        IF WInstr[4] <> '' THEN
            AddNotes := 'Check Computer'
        else
            AddNotes := '';

        //lShowInstr := NOT (WInstr[1] = '');
    end;

    procedure WODInstructions(DStep: Enum DetailStep; var tInstr: Text[250]): Boolean
    begin
        case DStep of
            DStep::RCV:
                if WorkOrderDetail.RCV <> '' then begin
                    tInstr := WorkOrderDetail.RCV;
                    exit(true);
                end;
            DStep::DIS:
                if WorkOrderDetail.DIS <> '' then begin
                    tInstr := WorkOrderDetail.DIS;
                    exit(true);
                end;
            DStep::QOT:
                if WorkOrderDetail.QOT <> '' then begin
                    tInstr := WorkOrderDetail.QOT;
                    exit(true);
                end;
            DStep::CLN:
                if WorkOrderDetail.CLN <> '' then begin
                    tInstr := WorkOrderDetail.CLN;
                    exit(true);
                end;
            DStep::ASM:
                if WorkOrderDetail.ASM <> '' then begin
                    tInstr := WorkOrderDetail.ASM;
                    exit(true);
                end;
            DStep::TST:
                if WorkOrderDetail.TST <> '' then begin
                    tInstr := WorkOrderDetail.TST;
                    exit(true);
                end;
            ///
            DStep::PNT:
                if WorkOrderDetail.PNT <> '' then begin
                    tInstr := WorkOrderDetail.PNT;
                    exit(true);
                end;
            DStep::QC:
                if WorkOrderDetail.QC <> '' then begin
                    tInstr := WorkOrderDetail.QC;
                    exit(true);
                end;
            DStep::SHP:
                if WorkOrderDetail.SHP <> '' then begin
                    tInstr := WorkOrderDetail.SHP;
                    exit(true);
                end;
            else
                exit(false);
        end;
    end;

    procedure MachineBalanceSet(var lMachineBalance: Boolean; var MachBalance: Text[30])
    begin

        lMachineBalance := NOT (WorkOrderDetail."Vendor Repair");
        IF (WorkOrderDetail."Income Code" = IncomeCode::CRYO) OR
           (WorkOrderDetail."Income Code" = IncomeCode::ELECTRONIC) then
            lMachineBalance := false
        else begin
            IF (WorkOrderDetail."Income Code" <> IncomeCode::TURBO) then begin
                MachBalance := 'MACHINE SHOP';
                BalanceProcedure := '';
            end else begin
                MachBalance := 'BALANCING';
                BalanceProcedure := 'ADVACO-GMP-2005..2006';
            end;
        end;
    end;

    procedure TestProcedureSet()
    begin

        IF (WorkOrderDetail."Income Code" = IncomeCode::Turbo) THEN
            TestProcedure := 'ADVACO-GTP-1007';

        IF (WorkOrderDetail."Income Code" = IncomeCode::Cryo) THEN
            TestProcedure := 'ADVACO-GTP-1004';

        IF (WorkOrderDetail."Income Code" = IncomeCode::Electronic) THEN
            TestProcedure := 'ADVACO-GTP-1008';

        IF (WorkOrderDetail."Income Code" = IncomeCode::Service) THEN
            TestProcedure := 'ADVACO-GTP-1002';

        IF (WorkOrderDetail."Income Code" = IncomeCode::Sales) THEN
            TestProcedure := 'ADVACO-GTP-1002';

        IF (WorkOrderDetail."Income Code" = IncomeCode::Dry) THEN
            TestProcedure := 'ADVACO-GTP-1002';
    end;
}

