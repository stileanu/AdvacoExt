report 50043 "Quote Sent Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50043_QuoteSentReport.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            DataItemTableView = SORTING("Work Order No.") ORDER(Ascending) WHERE("Quote Sent Date" = FILTER(010198 .. 123125), Quote = FILTER(" "));
            RequestFilterFields = "Quote Sent Date", "Customer ID", "Model No.";
            column(Quotes_Sent_to_Customers_; 'Quotes Sent to Customers')
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
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(Work_Order_Detail__Quote_Sent_Date_; "Quote Sent Date")
            {
            }
            column(Work_Order_Detail__Serial_No__; FORMAT("Serial No."))
            {
            }
            column(Work_Order_Detail__Customer_ID_; "Customer ID")
            {
            }
            column(QuotePrice; QuotePrice)
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Work_Order_Detail__Pump_Module_Processed_; "Pump Module Processed")
            {
            }
            column(Total_Quote_Price_; "Total Quote Price")
            {
            }
            column(Work_OrderCaption; Work_OrderCaptionLbl)
            {
            }
            column(Work_Order_Detail__Model_No__Caption; FieldCaption("Model No."))
            {
            }
            column(Work_Order_Detail__Order_Type_Caption; FieldCaption("Order Type"))
            {
            }
            column(Date_SentCaption; Date_SentCaptionLbl)
            {
            }
            column(Work_Order_Detail__Serial_No__Caption; FieldCaption("Serial No."))
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Quote_PriceCaption; Quote_PriceCaptionLbl)
            {
            }
            column(CustomerCaption_Control22; CustomerCaption_Control22Lbl)
            {
            }
            column(ModuleCaption; ModuleCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Cust.Get(WorkOrderDetail."Customer ID") then
                    ok := true;


                CalcFields("Labor Quoted", "Parts Quoted");
                QuotePrice := "Parts Quoted" + "Labor Quoted" + "Order Adj.";
                "Total Quote Price" := "Total Quote Price" + QuotePrice;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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
        QuotePrice: Decimal;
        "Total Quote Price": Decimal;
        Cust: Record Customer;
        ok: Boolean;
        Work_OrderCaptionLbl: Label 'Work Order';
        Date_SentCaptionLbl: Label 'Date Sent';
        CustomerCaptionLbl: Label 'Customer';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Quote_PriceCaptionLbl: Label 'Quote Price';
        CustomerCaption_Control22Lbl: Label 'Customer';
        ModuleCaptionLbl: Label 'Module';
}

