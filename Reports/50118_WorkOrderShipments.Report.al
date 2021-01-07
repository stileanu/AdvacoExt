report 50118 "Work Order Shipments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50118_WorkOrderShipments.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Work Order Detail"; WorkOrderDetail)
        {
            DataItemTableView = SORTING("Model No.") ORDER(Ascending) WHERE(Complete = CONST(true));
            RequestFilterFields = "Ship Date", "Order Type", "Warranty Type", "Model No.";
            column(Work_Order_Shipments_; 'Work Order Shipments')
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
            ///--!
            //column(CurrReport_PAGENO;CurrReport.PageNo)
            //{
            //}
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(FORMAT_DateOut_0___Month_2___Day_2___Year_2___; Format(DateOut, 0, '<Month,2>/<Day,2>/<Year,2>'))
            {
            }
            column(Work_Order_Detail__Work_Order_Date_; "Work Order Date")
            {
            }
            column(WarTotal; WarTotal)
            {
            }
            column(RebTotal; RebTotal)
            {
            }
            column(RepTotal; RepTotal)
            {
            }
            column(RebTotal_RepTotal_WarTotal; RebTotal + RepTotal + WarTotal)
            {
            }
            column(WarPer; WarPer)
            {
            }
            column(RebPer; RebPer)
            {
            }
            column(RepPer; RepPer)
            {
            }
            column(V100_00_; '100.00')
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Ship_DateCaption; Ship_DateCaptionLbl)
            {
            }
            column(Model_No_Caption; Model_No_CaptionLbl)
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
            column(Warranty_Caption; Warranty_CaptionLbl)
            {
            }
            column(Rebuild_Caption; Rebuild_CaptionLbl)
            {
            }
            column(Repair_Caption; Repair_CaptionLbl)
            {
            }
            column(Total_Orders_Caption; Total_Orders_CaptionLbl)
            {
            }
            column(Order_TypeCaption; Order_TypeCaptionLbl)
            {
            }
            column(QuantitiesCaption; QuantitiesCaptionLbl)
            {
            }
            column(PercentageCaption; PercentageCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Work Order Detail".Complete = false then
                    CurrReport.Skip;

                if WOM.Get("Work Order Detail"."Work Order Master No.") then
                    Cust.Get(WOM.Customer);

                ReceiveStep := DetailStep.FromInteger(100);
                CompleteStep := DetailStep.FromInteger(100);
                DateIn := 0D;
                DateOut := 0D;
                NoWorkDays := 0;
                QuoteSentDate := 0D;
                QuoteReleaseDate := 0D;
                QuoteWorkDays := 0;

                //Work Order Received Date
                WOS2.SetCurrentKey("Order No.", "Line No.");
                WOS2.SetRange(WOS2."Order No.", "Work Order Detail"."Work Order No.");
                if WOS2.Find('-') then begin
                    ReceiveStep := WOS2.Step;
                    DateIn := WOS2."Date In";
                end;

                //Work Order Quote Sent Date
                QuoteSentDate := "Work Order Detail"."Quote Sent Date";

                //Work Order Quote Release Date
                WOS3.SetCurrentKey("Order No.", "Line No.");
                WOS3.SetRange(WOS3."Order No.", "Work Order Detail"."Work Order No.");
                WOS3.SetRange(WOS3.Step, WOS3.Step::QOT);
                if WOS3.Find('+') then
                    QuoteReleaseDate := WOS3."Date Out";

                //Work Order Ship Date
                WOS.SetCurrentKey("Order No.", "Line No.");
                WOS.SetRange(WOS."Order No.", "Work Order Detail"."Work Order No.");
                if WOS.Find('+') then begin
                    CompleteStep := WOS.Step;
                    DateOut := WOS."Date Out";
                end;

                //Calculate Work Days
                Date.Reset;
                Date.SetCurrentKey("Period Type", "Period Start");
                Date.SetRange("Period Start", DateIn, DateOut);
                Date.SetRange("Period Type", Date."Period Type"::Date); //Days Only
                Date.SetRange("Period No.", 1, 5); // Only Mon through Fri
                TotalDays := Date.Count;

                //Calculate Quote Days
                if (QuoteSentDate > 0D) and (QuoteReleaseDate > 0D) then begin
                    Date.Reset;
                    Date.SetCurrentKey("Period Type", "Period Start");
                    Date.SetRange("Period Start", QuoteSentDate, QuoteReleaseDate);
                    Date.SetRange("Period Type", Date."Period Type"::Date); //Days Only
                    Date.SetRange("Period No.", 1, 5); // Only Mon through Fri
                    QuoteWorkDays := Date.Count;

                    //Work Days - Quote Days
                    NoWorkDays := TotalDays - QuoteWorkDays;
                end;

                if "Work Order Detail"."Date Required" < DateOut then begin
                    Late := true;
                    LateCount := LateCount + 1;
                end else begin
                    Late := false;
                end;

                ReceiveOrder;
                CompleteOrder;


                case "Work Order Detail"."Order Type" of
                    OrderType::Rebuild:
                        Rebuild;
                    OrderType::Repair:
                        Repair;
                    OrderType::Warranty:
                        WarrantyCount;
                end;

                CalcPercent();
            end;

            trigger OnPreDataItem()
            begin
                OrderCount := "Work Order Detail".Count;
            end;

        }
        dataitem("Integer"; "Integer")
        {
            MaxIteration = 1;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
    end;

    var
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        WOS3: Record Status;
        Late: Boolean;
        LateCount: Integer;
        LateRebuild: Integer;
        LateRepair: Integer;
        LateWarranty: Integer;
        Ok: Boolean;
        OrderCount: Integer;
        RebTotal: Integer;
        RebPer: Decimal;
        RepTotal: Integer;
        RepPer: Decimal;
        WarTotal: Integer;
        WarPer: Decimal;
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
        ReceiveStep: Enum DetailStep;
        CompleteStep: Enum DetailStep;
        CStep: Code[10];
        RStep: Code[10];
        DateIn: Date;
        DateOut: Date;
        QuotePrice: Decimal;
        Date: Record Date;
        NoWorkDays: Integer;
        QuoteSentDate: Date;
        QuoteReleaseDate: Date;
        QuoteWorkDays: Integer;
        TotalDays: Integer;
        FilterString: Text[250];
        CompanyInformation: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Ship_DateCaptionLbl: Label 'Ship Date';
        Model_No_CaptionLbl: Label 'Model No.';
        W_O_DateCaptionLbl: Label 'W/O Date';
        TypeCaptionLbl: Label 'Type';
        W_O_No_CaptionLbl: Label 'W/O No.';
        Warranty_CaptionLbl: Label 'Warranty:';
        Rebuild_CaptionLbl: Label 'Rebuild:';
        Repair_CaptionLbl: Label 'Repair:';
        Total_Orders_CaptionLbl: Label 'Total Orders:';
        Order_TypeCaptionLbl: Label 'Order Type';
        QuantitiesCaptionLbl: Label 'Quantities';
        PercentageCaptionLbl: Label 'Percentage';

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
        end;

        if "Work Order Detail"."Date Required" < WorkDate then begin
            LateWarranty := LateWarranty + 1;
        end;
    end;

    procedure ReceiveOrder()
    begin
        case ReceiveStep of
            DetailStep::RCV:
                RStep := 'REC';
            DetailStep::DIS:
                RStep := 'DIS';
            DetailStep::QOT:
                RStep := 'QOT';
            DetailStep::"B-O":
                RStep := 'B-O';
            DetailStep::CLN:
                RStep := 'CLN';
            DetailStep::ASM:
                RStep := 'ASM';
            DetailStep::TST:
                RStep := 'TST';
            DetailStep::REP:
                RStep := 'REP';
            DetailStep::RET:
                RStep := 'RET';
            DetailStep::PNT:
                RStep := 'MSP';
            DetailStep::MSP:
                RStep := 'PNT';
            DetailStep::QC:
                RStep := 'QC';
            DetailStep::SHP:
                RStep := 'SHP';
            DetailStep::NON:
                RStep := '';
        end;
    end;

    procedure CompleteOrder()
    begin
        case CompleteStep of
            DetailStep::RCV:
                RStep := 'REC';
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

    procedure CalcPercent()
    begin

        IF RebTotal > 0 THEN
            RebPer := ROUND(RebTotal / (RebTotal + RepTotal + WarTotal) * 100, 0.01, '>')
        ELSE
            RebPer := 0;


        IF RepTotal > 0 THEN
            RepPer := ROUND(RepTotal / (RebTotal + RepTotal + WarTotal) * 100, 0.01, '>')
        ELSE
            RepPer := 0;

        IF WarTotal > 0 THEN
            WarPer := ROUND(WarTotal / (RebTotal + RepTotal + WarTotal) * 100, 0.01, '>')
        ELSE
            WarPer := 0;
    end;

}

