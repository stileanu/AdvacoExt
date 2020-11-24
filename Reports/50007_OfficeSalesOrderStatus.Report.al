report 50007 "Office Sales Order Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50007_OfficeSalesOrderStatus.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order), "Outstanding Quantity" = FILTER(<> 0));
            RequestFilterFields = "Sell-to Customer No.";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Sales_Order_Status_Report_; 'Sales Order Status Report')
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

            column(SalesHeader__No__; SalesHeader."No.")
            {
            }
            column(SalesHeader__Order_Date_; SalesHeader."Order Date")
            {
            }
            column(SalesHeader__Sell_to_Customer_No__; SalesHeader."Sell-to Customer No.")
            {
            }
            column(SalesHeader_Name; SalesHeader."Bill-to Name")
            {
            }
            column(Sales_Line__No__; "No.")
            {
            }
            column(Sales_Line_Description; Description)
            {
            }
            column(Sales_Line_Quantity; Quantity)
            {
            }
            column(Sales_Line__Outstanding_Quantity_; "Outstanding Quantity")
            {
            }
            column(BackOrderQuantity; BackOrderQuantity)
            {
                DecimalPlaces = 0 : 5;
            }
            column(Sales_Line__Unit_Price_; "Unit Price")
            {
            }
            column(Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(BackorderCaption; BackorderCaptionLbl)
            {
            }
            column(Remaining_Back_OrderCaption; Remaining_Back_OrderCaptionLbl)
            {
            }
            column(OrderedCaption; OrderedCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(Part_No_Caption; Part_No_CaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Sales_OrderCaption; Sales_OrderCaptionLbl)
            {
            }
            column(Order_DateCaption; Order_DateCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Line_Document_Type; "Document Type")
            {
            }
            column(Sales_Line_Document_No_; "Document No.")
            {
            }
            column(Sales_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalesHeader.Get("Document Type", "Document No.");
                if (SalesHeader."Shortcut Dimension 2 Code" = 'WO') or (SalesHeader."Shortcut Dimension 2 Code" = 'FS') then begin
                    CurrReport.Skip;
                end else begin
                    if "Shipment Date" <= WorkDate then
                        BackOrderQuantity := "Outstanding Quantity"
                    else
                        BackOrderQuantity := 0;
                end;
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
        PeriodText := "Sales Line".GetFilter("Shipment Date");
    end;

    var
        FilterString: Text[250];
        PeriodText: Text[100];
        BackOrderQuantity: Decimal;
        "UnitPrice($)": Decimal;
        SalesHeader: Record "Sales Header";
        CompanyInformation: Record "Company Information";
        Unit_PriceCaptionLbl: Label 'Unit Price';
        BackorderCaptionLbl: Label 'Backorder';
        Remaining_Back_OrderCaptionLbl: Label 'Remaining Back Order';
        OrderedCaptionLbl: Label 'Ordered';
        DescriptionCaptionLbl: Label 'Description';
        Part_No_CaptionLbl: Label 'Part No.';
        CustomerCaptionLbl: Label 'Customer';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Sales_OrderCaptionLbl: Label 'Sales Order';
        Order_DateCaptionLbl: Label 'Order Date';
        QuantityCaptionLbl: Label 'Quantity';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

