report 50143 "Inspection Defect Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50143_Inspection Defect Report.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(IDRHeader; IDRHeader)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(IDR_Header__Inspector_Code_; "Inspector Code")
            {
            }
            column(IDR_Header__No__; "No.")
            {
            }
            column(IDR_Header__Document_Date_; "Document Date")
            {
            }
            column(IDR_Header__Purchase_Order_No__; "Purchase Order No.")
            {
            }
            column(IDR_Header__Return_to_Vendor_; "Return to Vendor")
            {
            }
            column(IDR_Header__RMA_No__; "RMA No.")
            {
            }
            column(IDR_Header__Invoice_No__; "Invoice No.")
            {
            }
            column(IDR_Header_Scrap; Scrap)
            {
            }
            column(IDR_Header__Scrap_Cost_; "Scrap Cost")
            {
            }
            column(IDR_Header__Vendor_No__; "Vendor No.")
            {
            }
            column(IDR_Header_Restock; Restock)
            {
            }
            column(IDR_Header__Vendor_Name_; "Vendor Name")
            {
            }
            column(IDR_Header__Rework_Repair_; "Rework/Repair")
            {
            }
            column(IDR_Header__Kit_Part_No__; "Kit Part No.")
            {
            }
            column(IDR_Header__Rework_Operator_; "Rework Operator")
            {
            }
            column(IDR_Header__Rework_Date_; "Rework Date")
            {
            }
            column(IDR_Header__Kit_Vendor_No__; "Kit Vendor No.")
            {
            }
            column(IDR_Header__ReTest_Operator_; "ReTest Operator")
            {
            }
            column(IDR_Header__ReTest_Date_; "ReTest Date")
            {
            }
            column(IDR_Header__Document_Date__Control14; "Document Date")
            {
            }
            column(IDR_Header__Inspector_Code__Control17; "Inspector Code")
            {
            }
            column(IDR_Header__Rework_Date__Control35; "Rework Date")
            {
            }
            column(IDR_Header__ReTest_Operator__Control38; "ReTest Operator")
            {
            }
            column(IDR_Header__ReTest_Date__Control41; "ReTest Date")
            {
            }
            column(IDR_Header__Return_to_Vendor__Control44; "Return to Vendor")
            {
            }
            column(IDR_Header__RMA_No___Control47; "RMA No.")
            {
            }
            column(IDR_Header_Scrap_Control50; Scrap)
            {
            }
            column(IDR_Header__Scrap_Cost__Control53; "Scrap Cost")
            {
            }
            column(IDR_Header_Restock_Control56; Restock)
            {
            }
            column(IDR_Header__Rework_Repair__Control59; "Rework/Repair")
            {
            }
            column(IDR_Header__Kit_Part_No___Control62; "Kit Part No.")
            {
            }
            column(IDR_Header__Kit_Vendor_No___Control65; "Kit Vendor No.")
            {
            }
            column(IDR_Header__No___Control16; "No.")
            {
            }
            column(IDR_Header__Rework_Operator__Control11; "Rework Operator")
            {
            }
            column(IDR_Header__Order_No__; "Order No.")
            {
            }
            column(IDR_Header__Serial_No__; "Serial No.")
            {
            }
            column(IDR_Header__Model_No__; "Model No.")
            {
            }
            column(IDR_Header__Process_Code_; "Process Code")
            {
            }
            column(Inspection_Defect_ReportCaption; Inspection_Defect_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Receiving_InspectionCaption; Receiving_InspectionCaptionLbl)
            {
            }
            column(Inspector_Caption; Inspector_CaptionLbl)
            {
            }
            column(IDR_No__Caption; IDR_No__CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Order_Information_Caption; Order_Information_CaptionLbl)
            {
            }
            column(Dispostion_Caption; Dispostion_CaptionLbl)
            {
            }
            column(Purchase_Order_No__Caption; Purchase_Order_No__CaptionLbl)
            {
            }
            column(Return_to_Vendor_Caption; Return_to_Vendor_CaptionLbl)
            {
            }
            column(RMA_No__Caption; RMA_No__CaptionLbl)
            {
            }
            column(Invoice_No__Caption; Invoice_No__CaptionLbl)
            {
            }
            column(Scrap_Caption; Scrap_CaptionLbl)
            {
            }
            column(Scrap_Cost_Caption; Scrap_Cost_CaptionLbl)
            {
            }
            column(Vendor_No__Caption; Vendor_No__CaptionLbl)
            {
            }
            column(Restock_Caption; Restock_CaptionLbl)
            {
            }
            column(Vendor_Name_Caption; Vendor_Name_CaptionLbl)
            {
            }
            column(Rework_Repair_Caption; Rework_Repair_CaptionLbl)
            {
            }
            column(QA_Close_Out_Approval_Caption; QA_Close_Out_Approval_CaptionLbl)
            {
            }
            column(Kit_Information_Caption; Kit_Information_CaptionLbl)
            {
            }
            column(Kit_Part_No__Caption; Kit_Part_No__CaptionLbl)
            {
            }
            column(Rework_Operator_Caption; Rework_Operator_CaptionLbl)
            {
            }
            column(Rework_Date_Caption; Rework_Date_CaptionLbl)
            {
            }
            column(Kit_Vendor_No__Caption; Kit_Vendor_No__CaptionLbl)
            {
            }
            column(ReTest_Operator_Caption; ReTest_Operator_CaptionLbl)
            {
            }
            column(ReTest_Date_Caption; ReTest_Date_CaptionLbl)
            {
            }
            column(Defective_Items_Caption; Defective_Items_CaptionLbl)
            {
            }
            column(Date_Caption_Control15; Date_Caption_Control15Lbl)
            {
            }
            column(Inspector_Caption_Control18; Inspector_Caption_Control18Lbl)
            {
            }
            column(Serial_No__Caption; Serial_No__CaptionLbl)
            {
            }
            column(Order_No__Caption; Order_No__CaptionLbl)
            {
            }
            column(Model_No__Caption; Model_No__CaptionLbl)
            {
            }
            column(Process_Code_Caption; Process_Code_CaptionLbl)
            {
            }
            column(Rework_Date_Caption_Control36; Rework_Date_Caption_Control36Lbl)
            {
            }
            column(ReTest_Operator_Caption_Control39; ReTest_Operator_Caption_Control39Lbl)
            {
            }
            column(ReTest_Date_Caption_Control42; ReTest_Date_Caption_Control42Lbl)
            {
            }
            column(Return_to_Vendor_Caption_Control45; Return_to_Vendor_Caption_Control45Lbl)
            {
            }
            column(RMA_No__Caption_Control48; RMA_No__Caption_Control48Lbl)
            {
            }
            column(Scrap_Caption_Control51; Scrap_Caption_Control51Lbl)
            {
            }
            column(Scrap_Cost_Caption_Control54; Scrap_Cost_Caption_Control54Lbl)
            {
            }
            column(Restock_Caption_Control57; Restock_Caption_Control57Lbl)
            {
            }
            column(Rework_Repair_Caption_Control60; Rework_Repair_Caption_Control60Lbl)
            {
            }
            column(Kit_Part_No__Caption_Control63; Kit_Part_No__Caption_Control63Lbl)
            {
            }
            column(Kit_Vendor_No__Caption_Control66; Kit_Vendor_No__Caption_Control66Lbl)
            {
            }
            column(Production___Test_InspectionCaption; Production___Test_InspectionCaptionLbl)
            {
            }
            column(IDR_No__Caption_Control13; IDR_No__Caption_Control13Lbl)
            {
            }
            column(Order_Information_Caption_Control28; Order_Information_Caption_Control28Lbl)
            {
            }
            column(Dispostion_Caption_Control31; Dispostion_Caption_Control31Lbl)
            {
            }
            column(Rework_Operator_Caption_Control12; Rework_Operator_Caption_Control12Lbl)
            {
            }
            column(QA_Close_Out_Approval_Caption_Control25; QA_Close_Out_Approval_Caption_Control25Lbl)
            {
            }
            column(Kit_Information_Caption_Control34; Kit_Information_Caption_Control34Lbl)
            {
            }
            column(Defective_Items_Caption_Control19; Defective_Items_Caption_Control19Lbl)
            {
            }
            dataitem(IDRLine; IDRLine)
            {
                DataItemLink = "Document No." = FIELD("No.");
                PrintOnlyIfDetail = false;
                column(IDR_Line__Item_No__; "Item No.")
                {
                }
                column(IDR_Line_Description; Description)
                {
                }
                column(IDR_Line_Quantity; Quantity)
                {
                }
                column(IDR_Line__Defect_code_; "Defect code")
                {
                }
                column(IDR_Line__NonConformance_Description_; "NonConformance Description")
                {
                }
                column(IDR_Line__Item_No__Caption; FieldCaption("Item No."))
                {
                }
                column(IDR_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(IDR_Line_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(IDR_Line__Defect_code_Caption; FieldCaption("Defect code"))
                {
                }
                column(IDR_Line__NonConformance_Description_Caption; FieldCaption("NonConformance Description"))
                {
                }
                column(IDR_Line_Document_Type; "Document Type")
                {
                }
                column(IDR_Line_Document_No_; "Document No.")
                {
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

    var
        Inspection_Defect_ReportCaptionLbl: Label 'Inspection Defect Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Receiving_InspectionCaptionLbl: Label 'Receiving Inspection';
        Inspector_CaptionLbl: Label 'Inspector:';
        IDR_No__CaptionLbl: Label 'IDR No.:';
        Date_CaptionLbl: Label 'Date:';
        Order_Information_CaptionLbl: Label 'Order Information:';
        Dispostion_CaptionLbl: Label 'Dispostion:';
        Purchase_Order_No__CaptionLbl: Label 'Purchase Order No.:';
        Return_to_Vendor_CaptionLbl: Label 'Return to Vendor:';
        RMA_No__CaptionLbl: Label 'RMA No.:';
        Invoice_No__CaptionLbl: Label 'Invoice No.:';
        Scrap_CaptionLbl: Label 'Scrap:';
        Scrap_Cost_CaptionLbl: Label 'Scrap Cost:';
        Vendor_No__CaptionLbl: Label 'Vendor No.:';
        Restock_CaptionLbl: Label 'Restock:';
        Vendor_Name_CaptionLbl: Label 'Vendor Name:';
        Rework_Repair_CaptionLbl: Label 'Rework/Repair:';
        QA_Close_Out_Approval_CaptionLbl: Label 'QA Close Out Approval:';
        Kit_Information_CaptionLbl: Label 'Kit Information:';
        Kit_Part_No__CaptionLbl: Label 'Kit Part No.:';
        Rework_Operator_CaptionLbl: Label 'Rework Operator:';
        Rework_Date_CaptionLbl: Label 'Rework Date:';
        Kit_Vendor_No__CaptionLbl: Label 'Kit Vendor No.:';
        ReTest_Operator_CaptionLbl: Label 'ReTest Operator:';
        ReTest_Date_CaptionLbl: Label 'ReTest Date:';
        Defective_Items_CaptionLbl: Label 'Defective Items:';
        Date_Caption_Control15Lbl: Label 'Date:';
        Inspector_Caption_Control18Lbl: Label 'Inspector:';
        Serial_No__CaptionLbl: Label 'Serial No.:';
        Order_No__CaptionLbl: Label 'Order No.:';
        Model_No__CaptionLbl: Label 'Model No.:';
        Process_Code_CaptionLbl: Label 'Process Code:';
        Rework_Date_Caption_Control36Lbl: Label 'Rework Date:';
        ReTest_Operator_Caption_Control39Lbl: Label 'ReTest Operator:';
        ReTest_Date_Caption_Control42Lbl: Label 'ReTest Date:';
        Return_to_Vendor_Caption_Control45Lbl: Label 'Return to Vendor:';
        RMA_No__Caption_Control48Lbl: Label 'RMA No.:';
        Scrap_Caption_Control51Lbl: Label 'Scrap:';
        Scrap_Cost_Caption_Control54Lbl: Label 'Scrap Cost:';
        Restock_Caption_Control57Lbl: Label 'Restock:';
        Rework_Repair_Caption_Control60Lbl: Label 'Rework/Repair:';
        Kit_Part_No__Caption_Control63Lbl: Label 'Kit Part No.:';
        Kit_Vendor_No__Caption_Control66Lbl: Label 'Kit Vendor No.:';
        Production___Test_InspectionCaptionLbl: Label 'Production / Test Inspection';
        IDR_No__Caption_Control13Lbl: Label 'IDR No.:';
        Order_Information_Caption_Control28Lbl: Label 'Order Information:';
        Dispostion_Caption_Control31Lbl: Label 'Dispostion:';
        Rework_Operator_Caption_Control12Lbl: Label 'Rework Operator:';
        QA_Close_Out_Approval_Caption_Control25Lbl: Label 'QA Close Out Approval:';
        Kit_Information_Caption_Control34Lbl: Label 'Kit Information:';
        Defective_Items_Caption_Control19Lbl: Label 'Defective Items:';
}

