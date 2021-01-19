report 50087 "Posted Sales Credit Memos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50087_Posted Sales Credit Memos.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "Bill-to County";
            RequestFilterHeading = 'Posted Sales Credit Memos';
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Posted_Sales_Credit_Memo_Report_; 'Posted Sales Credit Memo Report')
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
            column(FilterString; FilterString)
            {
            }
            column(Sales_Cr_Memo_Header_Amount; Amount)
            {
            }
            column(Sales_Cr_Memo_Header__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Sales_Cr_Memo_Header_Rep; Rep)
            {
            }
            column(Sales_Cr_Memo_Header__Sell_to_State_; "Sell-to County")
            {
            }
            column(Sales_Cr_Memo_Header__Ship_to_State_; "Ship-to County")
            {
            }
            column(Sales_Cr_Memo_Header_Name; "Bill-to Name")
            {
            }
            column(Sales_Cr_Memo_Header__Bill_to_Customer_No__; "Bill-to Customer No.")
            {
            }
            column(Sales_Cr_Memo_Header__Posting_Date_; "Posting Date")
            {
            }
            column(Sales_Cr_Memo_Header__No__; "No.")
            {
            }
            column(Sales_Cr_Memo_Header_Amount_Control49; Amount)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(SalesCaption; SalesCaptionLbl)
            {
            }
            column(RepCaption; RepCaptionLbl)
            {
            }
            column(Sell_toCaption; Sell_toCaptionLbl)
            {
            }
            column(Ship_toCaption; Ship_toCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Cust_IDCaption; Cust_IDCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
            {
            }

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Amount); ICE-MPC 9/10/20
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
        SalesInvHeaderFilter := "Sales Cr.Memo Header".GetFilters;
        CompanyInformation.Get;
        FilterString := CopyStr("Sales Cr.Memo Header".GetFilters, 1, MaxStrLen(FilterString));
    end;

    var
        CompanyInformation: Record "Company Information";
        NoSeriesRecord: Record "No. Series";
        SalesInvHeaderFilter: Text[250];
        FilterString: Text[126];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
        SalesCaptionLbl: Label 'Sales';
        RepCaptionLbl: Label 'Rep';
        Sell_toCaptionLbl: Label 'Sell-to';
        Ship_toCaptionLbl: Label 'Ship-to';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Cust_IDCaptionLbl: Label 'Cust ID';
        Posting_DateCaptionLbl: Label 'Posting Date';
        No_CaptionLbl: Label 'No.';
        Total_CaptionLbl: Label 'Total:';
}

