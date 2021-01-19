report 50199 "Work Order Detail Overview"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50199_Work Order Detail Overview.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(WorkOrderMaster; WorkOrderMaster)
        {
            DataItemTableView = SORTING("Work Order Master No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Work Order Master No.", Customer, "Date Required", "Inside Sales", Rep;
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Work_Order_Detail_Report_; 'Work Order Detail Report')
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
            column(Work_Order_Master__Inside_Sales_; "Inside Sales")
            {
            }
            column(Work_Order_Master__Customer_Payment_Terms_; "Customer Payment Terms")
            {
            }
            column(Work_Order_Master__Date_Required_; "Date Required")
            {
            }
            column(Work_Order_Master_Attention; Attention)
            {
            }
            column(Work_Order_Master__Phone_No__; "Phone No.")
            {
            }
            column(Work_Order_Master__Customer_Address_2_; "Customer Address 2")
            {
            }
            column(Work_Order_Master__Ship_To_Address_2_; "Ship To Address 2")
            {
            }
            column(Customer_City___________Customer_State___________Customer_Zip_Code_; "Customer City" + ' ' + "Customer State" + ' ' + "Customer Zip Code")
            {
            }
            column(Ship_To_City___________Ship_To_State___________Ship_To_Zip_Code_; "Ship To City" + ' ' + "Ship To State" + ' ' + "Ship To Zip Code")
            {
            }
            column(Work_Order_Master__Customer_Name_; "Customer Name")
            {
            }
            column(Work_Order_Master__Customer_Address_1_; "Customer Address 1")
            {
            }
            column(Work_Order_Master__Ship_To_Name_; "Ship To Name")
            {
            }
            column(Work_Order_Master__Ship_To_Address_1_; "Ship To Address 1")
            {
            }
            column(Work_Order_Master__Work_Order_Master_No__; "Work Order Master No.")
            {
            }
            column(Work_Order_Master_Customer; Customer)
            {
            }
            column(Work_Order_Master__Date_Ordered_; "Date Ordered")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Work_Order_Master__Inside_Sales_Caption; FieldCaption("Inside Sales"))
            {
            }
            column(Work_Order_Master__Customer_Payment_Terms_Caption; FieldCaption("Customer Payment Terms"))
            {
            }
            column(Work_Order_Master__Date_Required_Caption; FieldCaption("Date Required"))
            {
            }
            column(Work_Order_Master_AttentionCaption; FieldCaption(Attention))
            {
            }
            column(Work_Order_Master__Phone_No__Caption; FieldCaption("Phone No."))
            {
            }
            column(Address_2Caption; Address_2CaptionLbl)
            {
            }
            column(City__State__ZipCaption; City__State__ZipCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Address_1Caption; Address_1CaptionLbl)
            {
            }
            column(Work_Order_Master__Work_Order_Master_No__Caption; FieldCaption("Work Order Master No."))
            {
            }
            column(Work_Order_Master_CustomerCaption; FieldCaption(Customer))
            {
            }
            column(Work_Order_Master__Date_Ordered_Caption; FieldCaption("Date Ordered"))
            {
            }
            dataitem(WorkOrderDetail; WorkOrderDetail)
            {
                CalcFields = "Labor Hours Quoted", "Parts Cost", "Labor Quoted", "Original Parts Cost", "Parts Quoted";
                DataItemLink = "Work Order Master No." = FIELD("Work Order Master No.");
                DataItemTableView = SORTING("Work Order Master No.");
                RequestFilterFields = "Work Order No.", "Model No.", "Order Type";
                column(Work_Order_Detail_Freightin; Freightin)
                {
                }
                column(Work_Order_Detail__Order_Adj__; "Order Adj.")
                {
                }
                column(Work_Order_Detail__Parts_Cost_; "Parts Cost")
                {
                }
                column(Work_Order_Detail__Labor_Quoted_; "Labor Quoted")
                {
                }
                column(Work_Order_Detail__Original_Parts_Cost_; "Original Parts Cost")
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
                column(Work_Order_Detail__Detail_No__; "Detail No.")
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
                column(Parts_Cost_____Original_Parts_Cost_; "Parts Cost" - "Original Parts Cost")
                {
                }
                column(Work_Order_Detail__Parts_Quoted_; "Parts Quoted")
                {
                }
                column(Work_Order_Detail__Parts_Cost__Control24; "Parts Cost")
                {
                }
                column(Work_Order_Detail__Parts_Quoted__Control117; "Parts Quoted")
                {
                }
                column(Parts_Quoted_____Parts_Cost_; "Parts Quoted" - "Parts Cost")
                {
                }
                column(Parts_Quoted_____Parts_Cost__Control120; "Parts Quoted" - "Parts Cost")
                {
                }
                column(Work_Order_Detail__Order_Adj___Control123; "Order Adj.")
                {
                }
                column(Order_Adj______Parts_Quoted_____Parts_Cost_; "Order Adj." + "Parts Quoted" - "Parts Cost")
                {
                }
                column(Work_Order_Detail_FreightinCaption; FieldCaption(Freightin))
                {
                }
                column(Work_Order_Detail__Order_Adj__Caption; FieldCaption("Order Adj."))
                {
                }
                column(Current_Parts_CostCaption; Current_Parts_CostCaptionLbl)
                {
                }
                column(Work_Order_Detail__Labor_Quoted_Caption; FieldCaption("Labor Quoted"))
                {
                }
                column(Work_Order_Detail__Original_Parts_Cost_Caption; FieldCaption("Original Parts Cost"))
                {
                }
                column(Work_Order_Detail_NotesCaption; FieldCaption(Notes))
                {
                }
                column(Work_Order_Detail__Labor_Hours_Quoted_Caption; FieldCaption("Labor Hours Quoted"))
                {
                }
                column(Work_Order_Detail__Customer_PO_No__Caption; FieldCaption("Customer PO No."))
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
                column(Work_Order_Detail__Detail_No__Caption; FieldCaption("Detail No."))
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
                column(Work_Order_Detail__Current_Reg_Hours_Used_Caption; FieldCaption("Current Reg Hours Used"))
                {
                }
                column(Work_Order_Detail__Current_OT_Hours_Used_Caption; FieldCaption("Current OT Hours Used"))
                {
                }
                column(VarianceCaption; VarianceCaptionLbl)
                {
                }
                column(VarianceCaption_Control11; VarianceCaption_Control11Lbl)
                {
                }
                column(Work_Order_Detail__Parts_Quoted_Caption; FieldCaption("Parts Quoted"))
                {
                }
                column(Current_Parts_CostCaption_Control51; Current_Parts_CostCaption_Control51Lbl)
                {
                }
                column(Work_Order_Detail__Parts_Quoted__Control117Caption; FieldCaption("Parts Quoted"))
                {
                }
                column(VarianceCaption_Control119; VarianceCaption_Control119Lbl)
                {
                }
                column(Parts_VarianceCaption; Parts_VarianceCaptionLbl)
                {
                }
                column(Work_Order_Detail__Order_Adj___Control123Caption; FieldCaption("Order Adj."))
                {
                }
                column(Gross_ProfitCaption; Gross_ProfitCaptionLbl)
                {
                }
                column(Work_Order_Detail_Work_Order_Master_No_; "Work Order Master No.")
                {
                }
                dataitem(Parts; Parts)
                {
                    DataItemLink = "Work Order No." = FIELD("Work Order No.");
                    DataItemTableView = SORTING("Work Order No.", "Part Type") WHERE("Part Type" = CONST(Item));
                    column(Parts__Part_No__; "Part No.")
                    {
                    }
                    column(Parts_Description; Description)
                    {
                    }
                    column(Parts__Quantity_Backorder_; "Quantity Backorder")
                    {
                    }
                    column(Parts__Quoted_Price_; "Quoted Price")
                    {
                    }
                    column(Parts__Part_Cost_; "Part Cost")
                    {
                    }
                    column(Parts__BOM_Quantity_; "BOM Quantity")
                    {
                    }
                    column(Parts__Quoted_Quantity_; "Quoted Quantity")
                    {
                    }
                    column(Parts__Committed_Quantity_; "Committed Quantity")
                    {
                    }
                    column(Parts__In_Process_Quantity_; "In-Process Quantity")
                    {
                    }
                    column(Parts__Pulled_Quantity_; "Pulled Quantity")
                    {
                    }
                    column(Parts__Total_Quote_Price_; "Total Quote Price")
                    {
                    }
                    column(Parts__Total_Quote_Cost_; "Total Quote Cost")
                    {
                    }
                    column(Parts__Part_No__Caption; FieldCaption("Part No."))
                    {
                    }
                    column(Parts_DescriptionCaption; FieldCaption(Description))
                    {
                    }
                    column(BOMCaption; BOMCaptionLbl)
                    {
                    }
                    column(QOTCaption; QOTCaptionLbl)
                    {
                    }
                    column(COMCaption; COMCaptionLbl)
                    {
                    }
                    column(B_OCaption; B_OCaptionLbl)
                    {
                    }
                    column(INPCaption; INPCaptionLbl)
                    {
                    }
                    column(PULCaption; PULCaptionLbl)
                    {
                    }
                    column(Parts__Quoted_Price_Caption; FieldCaption("Quoted Price"))
                    {
                    }
                    column(Parts__Part_Cost_Caption; FieldCaption("Part Cost"))
                    {
                    }
                    column(Parts__Total_Quote_Price_Caption; FieldCaption("Total Quote Price"))
                    {
                    }
                    column(Parts__Total_Quote_Cost_Caption; FieldCaption("Total Quote Cost"))
                    {
                    }
                    column(Parts_Work_Order_No_; "Work Order No.")
                    {
                    }
                    column(Parts_Part_Type; "Part Type")
                    {
                    }
                }
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
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Address_2CaptionLbl: Label 'Address 2';
        City__State__ZipCaptionLbl: Label 'City, State, Zip';
        NameCaptionLbl: Label 'Name';
        Address_1CaptionLbl: Label 'Address 1';
        Current_Parts_CostCaptionLbl: Label 'Current Parts Cost';
        VarianceCaptionLbl: Label 'Variance';
        VarianceCaption_Control11Lbl: Label 'Variance';
        Current_Parts_CostCaption_Control51Lbl: Label 'Current Parts Cost';
        VarianceCaption_Control119Lbl: Label 'Variance';
        Parts_VarianceCaptionLbl: Label 'Parts Variance';
        Gross_ProfitCaptionLbl: Label 'Gross Profit';
        BOMCaptionLbl: Label 'BOM';
        QOTCaptionLbl: Label 'QOT';
        COMCaptionLbl: Label 'COM';
        B_OCaptionLbl: Label 'B-O';
        INPCaptionLbl: Label 'INP';
        PULCaptionLbl: Label 'PUL';
}

