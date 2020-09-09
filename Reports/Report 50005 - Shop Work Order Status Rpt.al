report 50005 "Shop Work Order Status Rpt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Shop Work Order Status Rpt.rdl';

    dataset
    {
        dataitem("Work Order Detail"; WorkOrderDetail)
        {
            DataItemTableView = WHERE(Complete = CONST(false));
            column(SHOP_WORK_ORDER_STATUS_REPORT_; 'SHOP WORK ORDER STATUS REPORT')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TIME; Time)
            {
            }
            //column(CurrReport_PAGENO;CurrReport.PageNo)
            //{
            //}
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(Work_Order_Detail__Date_Required_; "Date Required")
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(CStep; CStep)
            {
            }
            column(FORMAT_DateIn_0___Month_2___Day_2___; Format(DateIn, 0, '<Month,2>/<Day,2>'))
            {
            }
            column(FORMAT_DateOut_0___Month_2___Day_2___; Format(DateOut, 0, '<Month,2>/<Day,2>'))
            {
            }
            column(PStep; PStep)
            {
            }
            column(Late; Late)
            {
            }
            column(Work_Order_Detail__Work_Order_Date_; "Work Order Date")
            {
            }
            column(Serial_No__; "Serial No.")
            {
            }
            column(Work_Order_Detail__Tool_ID_; "Tool ID")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(LATECaption; LATECaptionLbl)
            {
            }
            column(Date_InCaption; Date_InCaptionLbl)
            {
            }
            column(QueCaption; QueCaptionLbl)
            {
            }
            column(Date_OutCaption; Date_OutCaptionLbl)
            {
            }
            column(Control83Caption; Control83CaptionLbl)
            {
            }
            column(PreCaption; PreCaptionLbl)
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(W_O_DateCaption; W_O_DateCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(W_O_No_Caption; W_O_No_CaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(Work_Order_Detail__Tool_ID_Caption; FieldCaption("Tool ID"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Work Order Detail".Complete = true then
                    CurrReport.Skip;
                if "Work Order Detail".Boxed = true then
                    CurrReport.Skip;

                if WOM.Get("Work Order Detail"."Work Order Master No.") then
                    Cust.Get(WOM.Customer);
                PreviousStep := PreviousStep::NON;
                CurrentStep := CurrentStep::NON;
                DateIn := 0D;
                DateOut := 0D;

                WOS.SetCurrentKey("Order No.", "Line No.");
                WOS.SetRange(WOS."Order No.", "Work Order Detail"."Work Order No.");
                if WOS.Find('+') then begin
                    CurrentStep := WOS.Step;
                    DateIn := WOS."Date In";
                    PreviousLine := WOS."Line No." - 10000;
                    if PreviousLine >= 10000 then begin
                        WOS2.SetCurrentKey("Order No.", "Line No.");
                        WOS2.SetRange(WOS2."Order No.", "Work Order Detail"."Work Order No.");
                        WOS2.SetRange(WOS2."Line No.", PreviousLine);
                        if WOS2.Find('+') then
                            PreviousStep := WOS2.Step;
                        DateOut := WOS2."Date Out";
                    end;
                end;

                if "Work Order Detail"."Date Required" < WorkDate then begin
                    Late := true;
                    LateCount := LateCount + 1;
                end else begin
                    Late := false;
                end;

                Previous;
                Current;


                case "Work Order Detail"."Order Type" of
                    OrderType::Rebuild:
                        Rebuild;
                    OrderType::Repair:
                        Repair;
                    OrderType::Warranty:
                        WarrantyCount;
                end;
            end;

            trigger OnPreDataItem()
            begin
                OrderCount := "Work Order Detail".Count;
            end;
        }
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;
            column(Reb0; Reb0)
            {
            }
            column(Reb1; Reb1)
            {
            }
            column(Reb2; Reb2)
            {
            }
            column(Reb3; Reb3)
            {
            }
            column(Reb4; Reb4)
            {
            }
            column(Reb5; Reb5)
            {
            }
            column(Reb6; Reb6)
            {
            }
            column(Reb7; Reb7)
            {
            }
            column(Reb8; Reb8)
            {
            }
            column(Reb10; Reb10)
            {
            }
            column(Reb11; Reb11)
            {
            }
            column(LateRebuild; LateRebuild)
            {
            }
            column(Rep7; Rep7)
            {
            }
            column(Rep5; Rep5)
            {
            }
            column(Rep6; Rep6)
            {
            }
            column(Rep4; Rep4)
            {
            }
            column(Rep3; Rep3)
            {
            }
            column(Rep2; Rep2)
            {
            }
            column(Rep1; Rep1)
            {
            }
            column(Rep0; Rep0)
            {
            }
            column(LateRepair; LateRepair)
            {
            }
            column(Rep11; Rep11)
            {
            }
            column(Rep10; Rep10)
            {
            }
            column(Rep8; Rep8)
            {
            }
            column(LateWarranty; LateWarranty)
            {
            }
            column(War11; War11)
            {
            }
            column(War10; War10)
            {
            }
            column(War8; War8)
            {
            }
            column(War7; War7)
            {
            }
            column(War5; War5)
            {
            }
            column(War6; War6)
            {
            }
            column(War4; War4)
            {
            }
            column(War3; War3)
            {
            }
            column(War2; War2)
            {
            }
            column(War1; War1)
            {
            }
            column(War0; War0)
            {
            }
            column(RebTotal; RebTotal)
            {
            }
            column(RepTotal; RepTotal)
            {
            }
            column(WarTotal; WarTotal)
            {
            }
            column(WarTotal_RepTotal_RebTotal; WarTotal + RepTotal + RebTotal)
            {
            }
            column(War0_Rep0_Reb0; War0 + Rep0 + Reb0)
            {
            }
            column(War1_Rep1_Reb1; War1 + Rep1 + Reb1)
            {
            }
            column(War3_Rep3_Reb3; War3 + Rep3 + Reb3)
            {
            }
            column(War2_Rep2_Reb2; War2 + Rep2 + Reb2)
            {
            }
            column(War4_Rep4_Reb4; War4 + Rep4 + Reb4)
            {
            }
            column(War5_Rep5_Reb5; War5 + Rep5 + Reb5)
            {
            }
            column(War6_Rep6_Reb6; War6 + Rep6 + Reb6)
            {
            }
            column(War7_Rep7_Reb7; War7 + Rep7 + Reb7)
            {
            }
            column(War8_Rep8_Reb8; War8 + Rep8 + Reb8)
            {
            }
            column(War10_Rep10_Reb10; War10 + Rep10 + Reb10)
            {
            }
            column(War11_Rep11_Reb11; War11 + Rep11 + Reb11)
            {
            }
            column(LateWarranty_LateRepair_LateRebuild; LateWarranty + LateRepair + LateRebuild)
            {
            }
            column(Reb9; Reb9)
            {
            }
            column(Rep9; Rep9)
            {
            }
            column(War9; War9)
            {
            }
            column(War9_Rep9_Reb9; War9 + Rep9 + Reb9)
            {
            }
            column(Reb12; Reb12)
            {
            }
            column(Rep12; Rep12)
            {
            }
            column(War12; War12)
            {
            }
            column(War12_Rep12_Reb12; War12 + Rep12 + Reb12)
            {
            }
            column(REBUILDCaption; REBUILDCaptionLbl)
            {
            }
            column(REPAIRCaption; REPAIRCaptionLbl)
            {
            }
            column(WARRANTYCaption; WARRANTYCaptionLbl)
            {
            }
            column(ORDERSCaption; ORDERSCaptionLbl)
            {
            }
            column(RECEIVINGCaption; RECEIVINGCaptionLbl)
            {
            }
            column(DISASSEMBLYCaption; DISASSEMBLYCaptionLbl)
            {
            }
            column(QUOTINGCaption; QUOTINGCaptionLbl)
            {
            }
            column(BACK_ORDERCaption; BACK_ORDERCaptionLbl)
            {
            }
            column(CLEANINGCaption; CLEANINGCaptionLbl)
            {
            }
            column(TESTINGCaption; TESTINGCaptionLbl)
            {
            }
            column(RETESTINGCaption; RETESTINGCaptionLbl)
            {
            }
            column(REPAIRCaption_Control77; REPAIRCaption_Control77Lbl)
            {
            }
            column(PAINT_SHOPCaption; PAINT_SHOPCaptionLbl)
            {
            }
            column(QUALITY_CONTROLCaption; QUALITY_CONTROLCaptionLbl)
            {
            }
            column(SHIPPINGCaption; SHIPPINGCaptionLbl)
            {
            }
            column(LATECaption_Control81; LATECaption_Control81Lbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(MACHINE_SHOPCaption; MACHINE_SHOPCaptionLbl)
            {
            }
            column(ASSEMBLYCaption; ASSEMBLYCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }
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
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        Late: Boolean;
        LateCount: Integer;
        LateRebuild: Integer;
        LateRepair: Integer;
        LateWarranty: Integer;
        Ok: Boolean;
        OrderCount: Integer;
        RebTotal: Integer;
        RepTotal: Integer;
        WarTotal: Integer;
        Reb0: Integer;
        Reb1: Integer;
        Reb2: Integer;
        Reb3: Integer;
        Reb4: Integer;
        Reb5: Integer;
        Reb6: Integer;
        Reb7: Integer;
        Reb8: Integer;
        Reb9: Integer;
        Reb10: Integer;
        Reb11: Integer;
        Reb12: Integer;
        Rep0: Integer;
        Rep1: Integer;
        Rep2: Integer;
        Rep3: Integer;
        Rep4: Integer;
        Rep5: Integer;
        Rep6: Integer;
        Rep7: Integer;
        Rep8: Integer;
        Rep9: Integer;
        Rep10: Integer;
        Rep11: Integer;
        Rep12: Integer;
        War0: Integer;
        War1: Integer;
        War2: Integer;
        War3: Integer;
        War4: Integer;
        War5: Integer;
        War6: Integer;
        War7: Integer;
        War8: Integer;
        War9: Integer;
        War10: Integer;
        War11: Integer;
        War12: Integer;
        Cust: Record Customer;
        PreviousLine: Integer;
        PreviousStep: Enum DetailStep;
        CurrentStep: Enum DetailStep;
        CStep: Code[10];
        PStep: Code[10];
        DateIn: Date;
        DateOut: Date;
        QuotePrice: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        LATECaptionLbl: Label 'LATE';
        Date_InCaptionLbl: Label 'Date In';
        QueCaptionLbl: Label 'Que';
        Date_OutCaptionLbl: Label 'Date Out';
        Control83CaptionLbl: Label 'Label83';
        PreCaptionLbl: Label 'Pre';
        Due_DateCaptionLbl: Label 'Due Date';
        W_O_DateCaptionLbl: Label 'W/O Date';
        TypeCaptionLbl: Label 'Type';
        W_O_No_CaptionLbl: Label 'W/O No.';
        Serial_No_CaptionLbl: Label 'Serial No.';
        REBUILDCaptionLbl: Label 'REBUILD';
        REPAIRCaptionLbl: Label 'REPAIR';
        WARRANTYCaptionLbl: Label 'WARRANTY';
        ORDERSCaptionLbl: Label 'ORDERS';
        RECEIVINGCaptionLbl: Label 'RECEIVING';
        DISASSEMBLYCaptionLbl: Label 'DISASSEMBLY';
        QUOTINGCaptionLbl: Label 'QUOTING';
        BACK_ORDERCaptionLbl: Label 'BACK ORDER';
        CLEANINGCaptionLbl: Label 'CLEANING';
        TESTINGCaptionLbl: Label 'TESTING';
        RETESTINGCaptionLbl: Label 'RETESTING';
        REPAIRCaption_Control77Lbl: Label 'REPAIR';
        PAINT_SHOPCaptionLbl: Label 'PAINT SHOP';
        QUALITY_CONTROLCaptionLbl: Label 'QUALITY CONTROL';
        SHIPPINGCaptionLbl: Label 'SHIPPING';
        LATECaption_Control81Lbl: Label 'LATE';
        TOTALSCaptionLbl: Label 'TOTALS';
        MACHINE_SHOPCaptionLbl: Label 'MACHINE SHOP';
        ASSEMBLYCaptionLbl: Label 'ASSEMBLY';

    procedure Rebuild()
    begin
        "Work Order Detail".CalcFields("Work Order Detail"."Detail Step");
        RebTotal := RebTotal + 1;
        case "Work Order Detail"."Detail Step" of
            DetailStep::RCV:
                Reb0 := Reb0 + 1;
            DetailStep::DIS:
                Reb1 := Reb1 + 1;
            DetailStep::QOT:
                Reb2 := Reb2 + 1;
            DetailStep::"B-O":
                Reb3 := Reb3 + 1;
            DetailStep::CLN:
                Reb4 := Reb4 + 1;
            DetailStep::ASM:
                Reb5 := Reb5 + 1;
            DetailStep::TST:
                Reb6 := Reb6 + 1;
            DetailStep::REP:
                Reb7 := Reb7 + 1;
            DetailStep::RET:
                Reb8 := Reb8 + 1;
            DetailStep::PNT:
                Reb9 := Reb9 + 1;
            DetailStep::MSP:
                Reb10 := Reb10 + 1;
            DetailStep::QC:
                Reb11 := Reb11 + 1;
            DetailStep::SHP:
                Reb12 := Reb12 + 1;
            DetailStep::NON:
                ;
        end;

        if "Work Order Detail"."Date Required" < WorkDate then begin
            LateRebuild := LateRebuild + 1;
        end;
    end;

    procedure Repair()
    begin
        "Work Order Detail".CalcFields("Work Order Detail"."Detail Step");
        RepTotal := RepTotal + 1;
        case "Work Order Detail"."Detail Step" of
            DetailStep::RCV:
                Rep0 := Rep0 + 1;
            DetailStep::DIS:
                Rep1 := Rep1 + 1;
            DetailStep::QOT:
                Rep2 := Rep2 + 1;
            DetailStep::"B-O":
                Rep3 := Rep3 + 1;
            DetailStep::CLN:
                Rep4 := Rep4 + 1;
            DetailStep::ASM:
                Rep5 := Rep5 + 1;
            DetailStep::TST:
                Rep6 := Rep6 + 1;
            DetailStep::REP:
                Rep7 := Rep7 + 1;
            DetailStep::RET:
                Rep8 := Rep8 + 1;
            DetailStep::PNT:
                Rep9 := Rep9 + 1;
            DetailStep::MSP:
                Rep10 := Rep10 + 1;
            DetailStep::QC:
                Rep11 := Rep11 + 1;
            DetailStep::SHP:
                Rep12 := Rep12 + 1;
            DetailStep::NON:
                ;
        end;

        if "Work Order Detail"."Date Required" < WorkDate then begin
            LateRepair := LateRepair + 1;
        end;
    end;

    procedure WarrantyCount()
    begin
        "Work Order Detail".CalcFields("Work Order Detail"."Detail Step");
        WarTotal := WarTotal + 1;
        case "Work Order Detail"."Detail Step" of
            DetailStep::RCV:
                War0 := War0 + 1;
            DetailStep::DIS:
                War1 := War1 + 1;
            DetailStep::QOT:
                War2 := War2 + 1;
            DetailStep::"B-O":
                War3 := War3 + 1;
            DetailStep::CLN:
                War4 := War4 + 1;
            DetailStep::ASM:
                War5 := War5 + 1;
            DetailStep::TST:
                War6 := War6 + 1;
            DetailStep::REP:
                War7 := War7 + 1;
            DetailStep::RET:
                War8 := War8 + 1;
            DetailStep::PNT:
                War9 := War9 + 1;
            DetailStep::MSP:
                War10 := War10 + 1;
            DetailStep::QC:
                War11 := War11 + 1;
            DetailStep::SHP:
                War12 := War12 + 1;
            DetailStep::NON:
                ;
        end;

        if "Work Order Detail"."Date Required" < WorkDate then begin
            LateWarranty := LateWarranty + 1;
        end;
    end;

    procedure Previous()
    begin
        case PreviousStep of
            DetailStep::RCV:
                PStep := 'REC';
            DetailStep::DIS:
                PStep := 'DIS';
            DetailStep::QOT:
                PStep := 'QOT';
            DetailStep::"B-O":
                PStep := 'B-O';
            DetailStep::CLN:
                PStep := 'CLN';
            DetailStep::ASM:
                PStep := 'ASM';
            DetailStep::TST:
                PStep := 'TST';
            DetailStep::REP:
                PStep := 'REP';
            DetailStep::RET:
                PStep := 'RET';
            DetailStep::PNT:
                PStep := 'MSP';
            DetailStep::MSP:
                PStep := 'PNT';
            DetailStep::QC:
                PStep := 'QC';
            DetailStep::SHP:
                PStep := 'SHP';
            DetailStep::NON:
                PStep := '';
        end;
    end;

    procedure Current()
    begin
        case CurrentStep of
            DetailStep::RCV:
                CStep := 'REC';
            DetailStep::DIS:
                CStep := 'DIS';
            DetailStep::QOT:
                CStep := 'QOT';
            DetailStep::"B-O":
                CStep := 'B-O';
            DetailStep::CLN:
                CStep := 'CLN';
            DetailStep::ASM:
                CStep := 'ASM';
            DetailStep::TST:
                CStep := 'TST';
            DetailStep::REP:
                CStep := 'REP';
            DetailStep::RET:
                CStep := 'RET';
            DetailStep::PNT:
                CStep := 'MSP';
            DetailStep::MSP:
                CStep := 'PNT';
            DetailStep::QC:
                CStep := 'QC';
            DetailStep::SHP:
                CStep := 'SHP';
            DetailStep::NON:
                CStep := '';
        end;
    end;
}

