report 50077 "Sales Analysis by Salesperson"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50077_Sales Analysis by Salesperson.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            //DataItemTableView = SORTING("Include for Commissions","Salesperson Code","Commission Dept. Code","G/L Account No.","Posting Date") WHERE("Include for Commissions"=CONST(true),Amount=FILTER(<>0));
            //ICE-MPC 09/03/20 Key doesn't exist yet.
            RequestFilterFields = "Posting Date", "Salesperson Code";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(USERID; UserId)
            {
            }
            column(GETFILTERS; GetFilters)
            {
            }
            column(Salesperson_Name; Salesperson.Name)
            {
            }
            column(G_L_Entry__Commission_Dept__Code_; "Commission Dept. Code")
            {
            }
            column(GLAccount_Name; GLAccount.Name)
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry__Source_No__; "Source No.")
            {
            }
            column(G_L_Entry__Document_Type_; "Document Type")
            {
            }
            column(Amount; -Amount)
            {
            }
            column(G_L_Entry_Open; Open)
            {
            }
            column(Total_for___GLAccount_Name; 'Total for ' + GLAccount.Name)
            {
            }
            column(Amount_Control30; -Amount)
            {
            }
            column(Amount_Control26; -Amount)
            {
            }
            column(Total_for____Commission_Dept__Code_; 'Total for ' + "Commission Dept. Code")
            {
            }
            column(Amount_Control19; -Amount)
            {
            }
            column(Total_for___Salesperson_Name; 'Total for ' + Salesperson.Name)
            {
            }
            column(Amount_Control23; -Amount)
            {
            }
            column(Total_for_Report_; 'Total for Report')
            {
            }
            column(Sales_Analysis_by_SalespersonCaption; Sales_Analysis_by_SalespersonCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(G_L_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(G_L_Entry__Source_No__Caption; G_L_Entry__Source_No__CaptionLbl)
            {
            }
            column(G_L_Entry__Document_Type_Caption; FieldCaption("Document Type"))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(G_L_Entry_OpenCaption; FieldCaption(Open))
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(G_L_Entry_Salesperson_Code; "Salesperson Code")
            {
            }
            column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
            {
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
        Salesperson: Record "Salesperson/Purchaser";
        GLAccount: Record "G/L Account";
        FirstTime: Boolean;
        Sales_Analysis_by_SalespersonCaptionLbl: Label 'Sales Analysis by Salesperson';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        G_L_Entry__Source_No__CaptionLbl: Label 'Customer No.';
        AmountCaptionLbl: Label 'Sale Amount';
}

