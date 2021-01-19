report 50074 "A/R Adjustments Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50074_AR Adjustments Register.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date") ORDER(Ascending) WHERE("G/L Account No." = CONST('116'), "Document Type" = CONST("Credit Memo"));
            RequestFilterFields = "Posting Date", "Global Dimension 2 Code";
            column(Accounts_Receivable_Adjustments_Register_; 'Accounts Receivable Adjustments Register')
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
            column(G_L_Entry__TABLENAME__________GLEntryFilter; "G/L Entry".TableName + ': ' + GLEntryFilter)
            {
            }
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(G_L_Entry_Description; Description)
            {
            }
            column(Credits; Credits)
            {
            }
            column(G_L_Entry__External_Document_No__; "External Document No.")
            {
            }
            column(Total_of_____FORMAT_Entries______entries_for_Accounts_Receivables_; 'Total of ' + Format(Entries) + ' entries for Accounts Receivables')
            {
            }
            column(Credits_Control24; Credits)
            {
            }
            column(Total_of_____FORMAT_Entries______entries_; 'Total of ' + Format(Entries) + ' entries')
            {
            }
            column(Credits_Control27; Credits)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(G_L_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(G_L_Entry_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(G_L_Entry__External_Document_No__Caption; FieldCaption("External Document No."))
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Credits := -Amount;
                Entries := 1;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Credits,Entries);  ICE-MPC 08/13/20
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
        GLEntryFilter := "G/L Entry".GetFilters;
    end;

    var
        CompanyInformation: Record "Company Information";
        GLAccount: Record "G/L Account";
        GLEntryFilter: Text[250];
        Debits: Decimal;
        Credits: Decimal;
        Entries: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
}

