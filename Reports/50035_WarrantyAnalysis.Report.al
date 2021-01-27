report 50035 "Warranty Analysis"
{
    // 0  1           2          3                4
    //   ,Key Account,Legitimate,No Trouble Found,Process
    // 
    // 7/26/15 add code to select only first detail of a system shipment
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50035_WarrantyAnalysis.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Work Order Detail"; WorkOrderDetail)
        {
            RequestFilterFields = "Ship Date", "Model No.", "Customer ID";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Warranty_Analysis_; 'Warranty Analysis')
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Warranty_Type_; "Warranty Type")
            {
            }
            column(Work_Order_Detail__Warranty_Reason_; "Warranty Reason")
            {
            }
            column(Work_Order_Detail__Customer_ID_; "Customer ID")
            {
            }
            column(Work_Order_Detail__Parts_Cost_; "Parts Cost")
            {
            }
            column(Type1; Type1)
            {
            }
            column(Type2; Type2)
            {
            }
            column(Type3; Type3)
            {
            }
            column(Type4; Type4)
            {
            }
            column(TotalOrders; TotalOrders)
            {
            }
            column(TotalRebuilds; TotalRebuilds)
            {
            }
            column(Type1_TotalWarranties__100; (Type1 / TotalWarranties) * 100)
            {
            }
            column(Type2_TotalWarranties__100; (Type2 / TotalWarranties) * 100)
            {
            }
            column(Type3_TotalWarranties__100; (Type3 / TotalWarranties) * 100)
            {
            }
            column(Type4_TotalWarranties__100; (Type4 / TotalWarranties) * 100)
            {
            }
            column(TotalWarranties; TotalWarranties)
            {
            }
            column(TotalWarranties_TotalOrders__100; (TotalWarranties / TotalOrders) * 100)
            {
            }
            column(TotalRebuilds_TotalOrders__100; (TotalRebuilds / TotalOrders) * 100)
            {
            }
            column(Type1_TotalOrders__100; (Type1 / TotalOrders) * 100)
            {
            }
            column(Type2_TotalOrders__100; (Type2 / TotalOrders) * 100)
            {
            }
            column(Type3_TotalOrders__100; (Type3 / TotalOrders) * 100)
            {
            }
            column(Type4_TotalOrders__100; (Type4 / TotalOrders) * 100)
            {
            }
            column(TotalParts; TotalParts)
            {
            }
            column(Type1Parts; Type1Parts)
            {
            }
            column(Type2Parts; Type2Parts)
            {
            }
            column(Type3Parts; Type3Parts)
            {
            }
            column(Type4Parts; Type4Parts)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Model_No_Caption; Model_No_CaptionLbl)
            {
            }
            column(Work_Order_No_Caption; Work_Order_No_CaptionLbl)
            {
            }
            column(Work_Order_Detail__Warranty_Type_Caption; FieldCaption("Warranty Type"))
            {
            }
            column(Work_Order_Detail__Warranty_Reason_Caption; FieldCaption("Warranty Reason"))
            {
            }
            column(Work_Order_Detail__Customer_ID_Caption; FieldCaption("Customer ID"))
            {
            }
            column(Work_Order_Detail__Parts_Cost_Caption; FieldCaption("Parts Cost"))
            {
            }
            column(Warranty_TypesCaption; Warranty_TypesCaptionLbl)
            {
            }
            column(Key_AccountCaption; Key_AccountCaptionLbl)
            {
            }
            column(LegitimateCaption; LegitimateCaptionLbl)
            {
            }
            column(No_Trouble_FoundCaption; No_Trouble_FoundCaptionLbl)
            {
            }
            column(ProcessCaption; ProcessCaptionLbl)
            {
            }
            column(QuantitiesCaption; QuantitiesCaptionLbl)
            {
            }
            column(Total_OrdersCaption; Total_OrdersCaptionLbl)
            {
            }
            column(WarrantiesCaption; WarrantiesCaptionLbl)
            {
            }
            column(RebuildsCaption; RebuildsCaptionLbl)
            {
            }
            column(QuantitiesCaption_Control22; QuantitiesCaption_Control22Lbl)
            {
            }
            column(of_WarrantiesCaption; of_WarrantiesCaptionLbl)
            {
            }
            column(Order_TypeCaption; Order_TypeCaptionLbl)
            {
            }
            column(PercentageCaption; PercentageCaptionLbl)
            {
            }
            column(of_Total_OrdersCaption; of_Total_OrdersCaptionLbl)
            {
            }
            column(Parts_CostCaption; Parts_CostCaptionLbl)
            {
            }
            column(Total_PartsCaption; Total_PartsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Complete then begin
                    // 7/25/15 Start
                    SkipRec := false;
                    if OneDetail then begin
                        if (not "System Shipment") or ((PrevMasterOrder <> "Work Order Master No.")) then begin
                            SkipRec := false;
                            PrevMasterOrder := "Work Order Master No.";
                        end else
                            SkipRec := true;
                    end;
                    if not SkipRec then
                        // 7/25/15 End
                        TotalOrders := TotalOrders + 1;
                    if "Order Type" = "Order Type"::Warranty then begin
                        CalcFields("Parts Cost");
                        TotalParts := TotalParts + "Parts Cost";
                        // 7/25/15 Start
                        if not SkipRec then
                            // 7/25/15 End
                            TotalWarranties := TotalWarranties + 1;
                        case "Warranty Type" of
                            "Warranty Type"::"Key Account":
                                begin
                                    // 7/25/15 Start
                                    if not SkipRec then
                                        // 7/25/15 END
                                        Type1 := Type1 + 1;
                                    Type1Parts := Type1Parts + "Parts Cost"
                                end;
                            "Warranty Type"::Legitimate:
                                begin
                                    // 7/25/15 Start
                                    if not SkipRec then
                                        // 7/25/15 END
                                        Type2 := Type2 + 1;
                                    Type2Parts := Type2Parts + "Parts Cost"
                                end;
                            "Warranty Type"::"No Trouble Found":
                                begin
                                    // 7/25/15 Start
                                    if not SkipRec then
                                        // 7/25/15 END
                                        Type3 := Type3 + 1;
                                    Type3Parts := Type3Parts + "Parts Cost"
                                end;
                            "Warranty Type"::Process:
                                begin
                                    // 7/25/15 Start
                                    if not SkipRec then
                                        // 7/25/15 END
                                        Type4 := Type4 + 1;
                                    Type4Parts := Type4Parts + "Parts Cost"
                                end;
                        end;
                    end else begin
                        // 7/25/15 Start
                        if not SkipRec then
                            // 7/25/15 End
                            TotalRebuilds := TotalRebuilds + 1;
                    end;
                end else begin
                    CurrReport.Skip;
                end;

                // 7/25/15 Start
                if SkipRec then
                    CurrReport.Skip;
                // 7/25/15 End
            end;

            trigger OnPreDataItem()
            begin
                StartDate := GetRangeMin("Ship Date");
                EndDate := GetRangeMax("Ship Date");
                PeriodText := 'Period from ' + Format(StartDate, 0, 4) + ' to ' + Format(EndDate, 0, 4);
                PrevMasterOrder := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(OneDetail; OneDetail)
                    {
                        ApplicationArea = All;
                        Caption = 'First Detail Only';
                    }
                }
            }
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
        CompanyInformation: Record "Company Information";
        WOS: Record Status;
        TotalOrders: Integer;
        TotalRebuilds: Integer;
        TotalWarranties: Integer;
        Type1: Integer;
        Type2: Integer;
        Type3: Integer;
        Type4: Integer;
        Type1Parts: Decimal;
        Type2Parts: Decimal;
        Type3Parts: Decimal;
        Type4Parts: Decimal;
        StartDate: Date;
        EndDate: Date;
        PeriodText: Text[200];
        TotalParts: Decimal;
        OneDetail: Boolean;
        PrevMasterOrder: Code[7];
        SkipRec: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Model_No_CaptionLbl: Label 'Model No.';
        Work_Order_No_CaptionLbl: Label 'Work Order No.';
        Warranty_TypesCaptionLbl: Label 'Warranty Types';
        Key_AccountCaptionLbl: Label 'Key Account';
        LegitimateCaptionLbl: Label 'Legitimate';
        No_Trouble_FoundCaptionLbl: Label 'No Trouble Found';
        ProcessCaptionLbl: Label 'Process';
        QuantitiesCaptionLbl: Label 'Quantities';
        Total_OrdersCaptionLbl: Label 'Total Orders';
        WarrantiesCaptionLbl: Label 'Warranties';
        RebuildsCaptionLbl: Label 'Rebuilds';
        QuantitiesCaption_Control22Lbl: Label 'Quantities';
        of_WarrantiesCaptionLbl: Label '% of Warranties';
        Order_TypeCaptionLbl: Label 'Order Type';
        PercentageCaptionLbl: Label 'Percentage';
        of_Total_OrdersCaptionLbl: Label '% of Total Orders';
        Parts_CostCaptionLbl: Label 'Parts Cost';
        Total_PartsCaptionLbl: Label 'Total Parts';
}

