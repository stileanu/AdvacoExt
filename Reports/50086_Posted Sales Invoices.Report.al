report 50086 "Posted Sales Invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50086_Posted Sales Invoices.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "Bill-to County";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Posted_Sales_Invoice_Report_; 'Posted Sales Invoice Report')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(USERID; UserId)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(Sales_Invoice_Header__No__; "No.")
            {
            }
            column(Sales_Invoice_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Invoice_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
            {
            }
            column(Sales_Invoice_Header_Name; "Bill-to Name")
            {
            }
            column(Sales_Invoice_Header__Ship_to_State_; "Ship-to County")
            {
            }
            column(Sales_Invoice_Header__Sell_to_State_; "Sell-to County")
            {
            }
            column(Sales_Invoice_Header_Rep; Rep)
            {
            }
            column(Sales_Invoice_Header__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Sales_Invoice_Header_Amount; Amount)
            {
            }
            column(Sales_Invoice_Header_Amount_Control14; Amount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Cust_IDCaption; Cust_IDCaptionLbl)
            {
            }
            column(Sales_Invoice_Header__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(Ship_toCaption; Ship_toCaptionLbl)
            {
            }
            column(Sell_toCaption; Sell_toCaptionLbl)
            {
            }
            column(Sales_Invoice_Header_RepCaption; FieldCaption(Rep))
            {
            }
            column(SalesCaption; SalesCaptionLbl)
            {
            }
            column(Sales_Invoice_Header_AmountCaption; FieldCaption(Amount))
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Amount); ICE-MPC 09/01/20
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
        SalesInvHeaderFilter := "Sales Invoice Header".GetFilters;
        CompanyInformation.Get;
        FilterString := CopyStr("Sales Invoice Header".GetFilters, 1, MaxStrLen(FilterString));
    end;

    var
        CompanyInformation: Record "Company Information";
        NoSeriesRecord: Record "No. Series";
        SalesInvHeaderFilter: Text[250];
        FilterString: Text[126];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Cust_IDCaptionLbl: Label 'Cust ID';
        Ship_toCaptionLbl: Label 'Ship-to';
        Sell_toCaptionLbl: Label 'Sell-to';
        SalesCaptionLbl: Label 'Sales';
        Total_CaptionLbl: Label 'Total:';

    local procedure AddError(Text: Text[250])
    begin
    end;
}

