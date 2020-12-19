report 50041 "Quote Review"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50041_QuoteReview.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;

    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            CalcFields = "Labor Hours Quoted", "Parts Cost", "Labor Quoted", "Original Parts Cost", "Parts Quoted";
            RequestFilterFields = "Work Order No.";
            column(Work_Order_Detail__Labor_Quoted_; "Labor Quoted")
            {
            }
            column(Work_Order_Detail_Notes; Notes)
            {
            }
            column(Work_Order_Detail__Labor_Hours_Quoted_; "Labor Hours Quoted")
            {
            }
            column(Work_Order_Detail__Customer_PO_No__; "Customer PO No.")
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail__Income_Code_; "Income Code")
            {
            }
            column(Work_Order_Detail__Serial_No__; "Serial No.")
            {
            }
            column(Work_Order_Detail__Oil_Type_; "Oil Type")
            {
            }
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(Work_Order_Detail_Description; Description)
            {
            }
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Current_Reg_Hours_Used_; "Current Reg Hours Used")
            {
            }
            column(Work_Order_Detail__Current_OT_Hours_Used_; "Current OT Hours Used")
            {
            }
            column(Labor_Hours_Quoted_____Current_Reg_Hours_Used____Current_OT_Hours_Used_; "Labor Hours Quoted" - "Current Reg Hours Used" - "Current OT Hours Used")
            {
            }
            column(Work_Order_Detail__Parts_Quoted_; "Parts Quoted")
            {
            }
            column(Work_Order_Detail__Ship_To_Name_; "Ship To Name")
            {
            }
            column(Work_Order_Detail__Ship_To_Address_1_; "Ship To Address 1")
            {
            }
            column(Work_Order_Detail__Ship_To_Address_2_; "Ship To Address 2")
            {
            }
            column(Ship_To_City___________Ship_To_State___________Ship_To_Zip_Code_; "Ship To City" + ' ' + "Ship To State" + ' ' + "Ship To Zip Code")
            {
            }
            column(Work_Order_Detail__Customer_ID_; "Customer ID")
            {
            }
            column(Work_Order_Detail__Work_Order_Date_; "Work Order Date")
            {
            }
            column(Work_Order_Detail_Attention; Attention)
            {
            }
            column(Work_Order_Detail__Payment_Terms_; "Payment Terms")
            {
            }
            column(Work_Order_Detail_Carrier; Carrier)
            {
            }
            column(Work_Order_Detail__Shipping_Method_; "Shipping Method")
            {
            }
            column(Work_Order_Detail__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(EmptyString; '_________')
            {
            }
            column(EmptyString_Control11; '_________')
            {
            }
            column(Quote_TotalCaption; Quote_TotalCaptionLbl)
            {
            }
            column(AdjustmentCaption; AdjustmentCaptionLbl)
            {
            }
            column(Work_Order_Detail__Labor_Quoted_Caption; FieldCaption("Labor Quoted"))
            {
            }
            column(Work_Order_Detail_NotesCaption; FieldCaption(Notes))
            {
            }
            column(Hours_QuotedCaption; Hours_QuotedCaptionLbl)
            {
            }
            column(PO_No_Caption; PO_No_CaptionLbl)
            {
            }
            column(Work_Order_Detail__Model_No__Caption; FieldCaption("Model No."))
            {
            }
            column(Work_Order_Detail__Income_Code_Caption; FieldCaption("Income Code"))
            {
            }
            column(Work_Order_Detail__Serial_No__Caption; FieldCaption("Serial No."))
            {
            }
            column(Work_Order_Detail__Oil_Type_Caption; FieldCaption("Oil Type"))
            {
            }
            column(Work_Order_Detail__Order_Type_Caption; FieldCaption("Order Type"))
            {
            }
            column(Work_Order_Detail_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Work_Order_Detail__Work_Order_No__Caption; FieldCaption("Work Order No."))
            {
            }
            column(Reg_Hours_UsedCaption; Reg_Hours_UsedCaptionLbl)
            {
            }
            column(O_T_Hours_UsedCaption; O_T_Hours_UsedCaptionLbl)
            {
            }
            column(VarianceCaption; VarianceCaptionLbl)
            {
            }
            column(Work_Order_Detail__Parts_Quoted_Caption; FieldCaption("Parts Quoted"))
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(Order_DateCaption; Order_DateCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(Address2Caption; Address2CaptionLbl)
            {
            }
            column(City__St__ZipCaption; City__St__ZipCaptionLbl)
            {
            }
            column(AttentionCaption; AttentionCaptionLbl)
            {
            }
            column(TermsCaption; TermsCaptionLbl)
            {
            }
            column(CarrierCaption; CarrierCaptionLbl)
            {
            }
            column(MethodCaption; MethodCaptionLbl)
            {
            }
            column(ChargeCaption; ChargeCaptionLbl)
            {
            }
            column(Parts__Part_No__Caption; Parts_NoLbl)
            {
            }
            column(Parts_DescriptionCaption; Parts_DescriptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }
            column(PriceCaption; PriceCaptionLbl)
            {
            }
            column(Total_PriceCaption; Total_PriceCaptionLbl)
            {
            }
            dataitem(Parts; Parts)
            {
                DataItemLink = "Work Order No." = FIELD("Work Order No.");
                DataItemTableView = SORTING("Work Order No.", "Part Type") ORDER(Ascending) WHERE("Part Type" = CONST(Item));
                column(Parts__Part_No__; "Part No.")
                {
                }
                column(Parts_Description; Description)
                {
                }
                column(Parts__Quoted_Price_; "Quoted Price")
                {
                }
                column(Parts__Part_Cost_; "Part Cost")
                {
                }
                column(Parts__Quoted_Quantity_; "Quoted Quantity")
                {
                }
                column(Parts__Total_Quote_Price_; "Total Quote Price")
                {
                }
                column(TotalPrice; PartsTotal)
                {
                }
                column(Parts_TotalCaption; Parts_TotalCaptionLbl)
                {
                }
                column(Parts_Work_Order_No_; "Work Order No.")
                {
                }
                column(Parts_Part_Type; "Part Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Parts."Quoted Quantity" = 0 then begin
                        CurrReport.Skip;
                    end else begin
                        PartPrice := (Parts."Quoted Quantity" * Parts."Quoted Price");
                        PartsTotal := PartsTotal + PartPrice;
                        PartPrice := 0;
                    end;
                end;
            }
            dataitem(Parts2; Parts)
            {
                DataItemLink = "Work Order No." = FIELD("Work Order No.");
                DataItemTableView = SORTING("Work Order No.", "Part Type") ORDER(Ascending) WHERE("Part Type" = CONST(Resource));
                column(Parts2__Total_Quote_Price_; "Total Quote Price")
                {
                }
                column(Parts2__Quoted_Price_; "Quoted Price")
                {
                }
                column(Parts2__Part_Cost_; "Part Cost")
                {
                }
                column(Parts2__Quoted_Quantity_; "Quoted Quantity")
                {
                }
                column(Parts2_Description; Description)
                {
                }
                column(Parts2__Part_No__; "Part No.")
                {
                }
                column(TotalPrice_Control18; LaborTotal)
                {
                }
                column(TotalPrice_Control4; LaborTotal + PartsTotal)
                {
                }
                column(Resouce_TotalCaption; Resouce_TotalCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Parts2_Work_Order_No_; "Work Order No.")
                {
                }
                column(Parts2_Part_Type; "Part Type")
                {
                }
                column(show_TotParts; showTotParts)
                {
                }

                trigger OnPreDataItem()
                begin
                    showTotParts := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    showTotParts += 1;

                    if Parts2."Quoted Quantity" = 0 then begin
                        CurrReport.Skip;
                    end else begin
                        LaborPrice := (Parts2."Quoted Quantity" * Parts2."Quoted Price");
                        LaborTotal := LaborTotal + LaborPrice;
                        LaborPrice := 0;
                    end;
                end;
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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        TotalPrice: Decimal;
        TotalCost: Decimal;
        PartsTotal: Decimal;
        LaborTotal: Decimal;
        PartPrice: Decimal;
        LaborPrice: Decimal;
        Quote_TotalCaptionLbl: Label 'Quote Total';
        AdjustmentCaptionLbl: Label 'Adjustment';
        Hours_QuotedCaptionLbl: Label 'Hours Quoted';
        PO_No_CaptionLbl: Label 'PO No.';
        Reg_Hours_UsedCaptionLbl: Label 'Reg Hours Used';
        O_T_Hours_UsedCaptionLbl: Label 'O/T Hours Used';
        VarianceCaptionLbl: Label 'Variance';
        CustomerCaptionLbl: Label 'Customer';
        Order_DateCaptionLbl: Label 'Order Date';
        NameCaptionLbl: Label 'Name';
        AddressCaptionLbl: Label 'Address';
        Address2CaptionLbl: Label 'Address2';
        City__St__ZipCaptionLbl: Label 'City, St, Zip';
        AttentionCaptionLbl: Label 'Attention';
        TermsCaptionLbl: Label 'Terms';
        CarrierCaptionLbl: Label 'Carrier';
        MethodCaptionLbl: Label 'Method';
        ChargeCaptionLbl: Label 'Charge';
        QuantityCaptionLbl: Label 'Quantity';
        PriceCaptionLbl: Label 'Price';
        CostCaptionLbl: Label 'Cost';
        Total_PriceCaptionLbl: Label 'Total Price';
        Parts_TotalCaptionLbl: Label 'Parts Total';
        Resouce_TotalCaptionLbl: Label 'Resource Total';
        TotalCaptionLbl: Label 'Total';
        Parts_NoLbl: Label 'Part No.';
        Parts_DescriptionLbl: Label 'Description';
        showTotParts: Integer;
}

