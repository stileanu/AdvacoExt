report 50025 "Work Order Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50025_WorkOrderAnalysis.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            RequestFilterFields = "Ship Date", "Model No.", "Order Type", Quote, "Customer ID";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Work_Order_Analysis_; 'Work Order Analysis')
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail__Parts_Cost_; "Parts Cost")
            {
            }
            column(LaborHours; LaborHours)
            {
            }
            column(Work_Order_Detail__Order_Adj__; "Order Adj.")
            {
            }
            column(ResourceQuoted; ResourceQuoted)
            {
            }
            column(PartsQuoted; PartsQuoted)
            {
            }
            column(LaborCost; LaborCost)
            {
            }
            column(LaborVarD; LaborVarD)
            {
            }
            column(LaborHoursUsed; LaborHoursUsed)
            {
            }
            column(LaborQuoted; LaborQuoted)
            {
            }
            column(LaborHoursVarD; LaborHoursVarD)
            {
            }
            column(LaborVarP; LaborVarP)
            {
            }
            column(LaborHoursVarP; LaborHoursVarP)
            {
            }
            column(TotalQuote; TotalQuote)
            {
            }
            column(TotalCost; TotalCost)
            {
            }
            column(TotalVarD; TotalVarD)
            {
            }
            column(TotalVarP; TotalVarP)
            {
            }
            column(Invoice; Invoice)
            {
            }
            column(PartsVarD; PartsVarD)
            {
            }
            column(PartsVarP; PartsVarP)
            {
            }
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail_Quote; Quote)
            {
            }
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(PartsCostInvoiceP; PartsCostInvoiceP)
            {
            }
            column(ResourceCost; ResourceCost)
            {
            }
            column(Work_Order_Detail__Customer_PO_No__; "Customer PO No.")
            {
            }
            column(TotalQuotedHours; TotalQuotedHours)
            {
            }
            column(TotalActualHours; TotalActualHours)
            {
            }
            column(TotalQuotedParts; TotalQuotedParts)
            {
            }
            column(TotalActualParts; TotalActualParts)
            {
            }
            column(TotalAdjustments; TotalAdjustments)
            {
            }
            column(TotalPartsCostPercentage; TotalPartsCostPercentage)
            {
            }
            column(TotalFreight; TotalFreight)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(InvoiceCaption; InvoiceCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(ResourceCaption; ResourceCaptionLbl)
            {
            }
            column(PartsCaption; PartsCaptionLbl)
            {
            }
            column(HoursCaption; HoursCaptionLbl)
            {
            }
            column(LaborCaption; LaborCaptionLbl)
            {
            }
            column(AdjustmentCaption; AdjustmentCaptionLbl)
            {
            }
            column(QuotedCaption; QuotedCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }
            column(Var___Caption; Var___CaptionLbl)
            {
            }
            column(Var___Caption_Control21; Var___Caption_Control21Lbl)
            {
            }
            column(InvoiceCaption_Control22; InvoiceCaption_Control22Lbl)
            {
            }
            column(Parts_at_Cost___as___of_InvoiceCaption; Parts_at_Cost___as___of_InvoiceCaptionLbl)
            {
            }
            column(Quoted_HoursCaption; Quoted_HoursCaptionLbl)
            {
            }
            column(Actual_HoursCaption; Actual_HoursCaptionLbl)
            {
            }
            column(Quoted_PartsCaption; Quoted_PartsCaptionLbl)
            {
            }
            column(Actual_PartsCaption; Actual_PartsCaptionLbl)
            {
            }
            column(AdjusmentsCaption; AdjusmentsCaptionLbl)
            {
            }
            column(Total_Parts_at_Cost___as___of_InvoiceCaption; Total_Parts_at_Cost___as___of_InvoiceCaptionLbl)
            {
            }
            column(FreightCaption; FreightCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Complete then begin
                    CalcFields("Original Parts Price", "Original Labor Price", "Current Reg Hours Used",
                               "Current OT Hours Used", "Labor Quoted", "Parts Quoted", "Parts Cost");

                    Parts.SetRange(Parts."Work Order No.", "Work Order No.");
                    Parts.SetRange(Parts."Part No.", '1');
                    if Parts.Find('-') then
                        LaborHours := Parts."Quoted Quantity"
                    else
                        LaborHours := 0;
                    LaborQuoted := Parts."Quoted Quantity" * 65;
                    LaborHoursUsed := "Current Reg Hours Used" + "Current OT Hours Used" + "Current Extra Time Used";
                    LaborCost := LaborHoursUsed * 65;
                    LaborVarD := LaborQuoted - LaborCost;
                    LaborHoursVarD := LaborHours - LaborHoursUsed;
                    if LaborQuoted > 0 then begin
                        LaborVarP := (100 * (LaborCost / LaborQuoted) - 100) * -1;
                        LaborHoursVarP := (100 * (LaborHoursUsed / LaborQuoted) - 100) * -1;
                    end else begin
                        LaborVarP := 0;
                        LaborHoursVarP := 0;
                    end;
                    TotalQuotedHours := LaborHours;
                    TotalActualHours := LaborHoursUsed;


                    //if Quote = 2 then begin // UNREPAIRABLE
                    if Quote.AsInteger() = 2 then begin // UNREPAIRABLE ICE-MPC 09/01/20
                        PartsQuoted := "Parts Quoted";
                        ResourceQuoted := "Labor Quoted" - LaborQuoted;
                        ResourceCost := (ResourceQuoted / 1.86);
                    end else begin
                        PartsQuoted := "Original Parts Price";
                        ResourceQuoted := "Original Labor Price" - LaborQuoted;
                        ResourceCost := (ResourceQuoted / 1.86);
                        TotalQuotedParts := "Original Parts Price";
                        TotalActualParts := "Parts Quoted";
                        TotalAdjustments := "Order Adj.";
                    end;

                    PartsVarD := PartsQuoted - "Parts Cost";
                    if PartsQuoted > 0 then
                        PartsVarP := (100 * ("Parts Cost" / PartsQuoted) - 100) * -1
                    else
                        PartsVarP := 0;


                    TotalQuote := "Original Parts Price" + "Original Labor Price";
                    TotalCost := LaborCost + "Parts Cost";
                    TotalVarD := TotalQuote - TotalCost;
                    if TotalQuote > 0 then
                        TotalVarP := (100 * (TotalCost / TotalQuote) - 100) * -1
                    else
                        TotalVarP := 0;

                    //if Quote = 2 then begin// UNREPAIRABLE
                    if Quote.AsInteger() = 2 then begin // UNREPAIRABLE ICE-MPC 09/01/20
                        Invoice := "Unrepairable Charge";
                        PartsCostInvoiceP := 0;
                    end else begin
                        Invoice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";
                        TotalPartsCost := TotalPartsCost + ("Parts Cost" + ResourceCost);
                        TotalInvoice := TotalInvoice + Invoice;
                        if Invoice > 0 then begin
                            PartsCostInvoiceP := (ResourceCost + "Parts Cost") / Invoice;
                        end else
                            PartsCostInvoiceP := 0;
                    end;

                    TotalFreight := TotalFreight + WorkOrderDetail.Freightin + WorkOrderDetail.Freightout;

                    IF TotalInvoice > 0 THEN
                        TotalPartsCostPercentage := TotalPartsCost / TotalInvoice
                    ELSE
                        TotalPartsCostPercentage := 0;

                end else begin
                    CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(TotalQuotedHours,TotalActualHours,TotalQuotedParts,
                //TotalActualParts,TotalAdjustments);  ICE-MPC 09/01/20
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        WOS: Record Status;
        Parts: Record Parts;
        LaborQuoted: Decimal;
        LaborCost: Decimal;
        LaborVarD: Decimal;
        LaborVarP: Decimal;
        LaborHoursUsed: Decimal;
        LaborHoursVarD: Decimal;
        LaborHoursVarP: Decimal;
        PartsQuoted: Decimal;
        PartsVarD: Decimal;
        PartsVarP: Decimal;
        ResourceQuoted: Decimal;
        ResourceCost: Decimal;
        TotalVarD: Decimal;
        TotalVarP: Decimal;
        TotalQuote: Decimal;
        TotalCost: Decimal;
        Invoice: Decimal;
        PartsCostInvoiceP: Decimal;
        TotalQuotedHours: Decimal;
        TotalActualHours: Decimal;
        TotalQuotedParts: Decimal;
        TotalActualParts: Decimal;
        TotalAdjustments: Decimal;
        TotalPartsCost: Decimal;
        TotalInvoice: Decimal;
        LaborHours: Decimal;
        TotalFreight: Decimal;
        TotalPartsCostPercentage: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        InvoiceCaptionLbl: Label 'Invoice';
        TotalCaptionLbl: Label 'Total';
        ResourceCaptionLbl: Label 'Resource';
        PartsCaptionLbl: Label 'Parts';
        HoursCaptionLbl: Label 'Hours';
        LaborCaptionLbl: Label 'Labor';
        AdjustmentCaptionLbl: Label 'Adjustment';
        QuotedCaptionLbl: Label 'Quoted';
        CostCaptionLbl: Label 'Cost';
        Var___CaptionLbl: Label 'Var $$';
        Var___Caption_Control21Lbl: Label 'Var %%';
        InvoiceCaption_Control22Lbl: Label 'Invoice';
        Parts_at_Cost___as___of_InvoiceCaptionLbl: Label 'Parts at Cost / as % of Invoice';
        Quoted_HoursCaptionLbl: Label 'Quoted Hours';
        Actual_HoursCaptionLbl: Label 'Actual Hours';
        Quoted_PartsCaptionLbl: Label 'Quoted Parts';
        Actual_PartsCaptionLbl: Label 'Actual Parts';
        AdjusmentsCaptionLbl: Label 'Adjusments';
        Total_Parts_at_Cost___as___of_InvoiceCaptionLbl: Label 'Total Parts at Cost / as % of Invoice';
        FreightCaptionLbl: Label 'Freight';
}

