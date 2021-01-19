report 50114 "PIP Account Detail Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50114_PIP Account Detail Report.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting), "No." = FILTER('120'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Date Filter";
            column(MainTitle; MainTitle)
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
            column(PeriodText; PeriodText)
            {
            }
            column(SubTitle; SubTitle)
            {
            }
            column(G_L_Account__TABLENAME__________GLFilter; "G/L Account".TableName + ': ' + GLFilter)
            {
            }
            column(G_L_Entry__TABLENAME__________GLEntryFilter; "G/L Entry".TableName + ': ' + GLEntryFilter)
            {
            }
            column(Account_______No__; 'Account: ' + "No.")
            {
            }
            column(G_L_Account_Name; Name)
            {
            }
            column(BeginningBalance; BeginningBalance)
            {
            }
            column(Account_______No___Control47; 'Account: ' + "No.")
            {
            }
            column(G_L_Account_Name_Control48; Name)
            {
            }
            column(BeginBalTotal; BeginBalTotal)
            {
            }
            column(DebitAmount; DebitAmount)
            {
            }
            column(CreditAmount; CreditAmount)
            {
            }
            column(DebitAmount___CreditAmount; DebitAmount - CreditAmount)
            {
            }
            column(EndBalTotal; EndBalTotal)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Accounts_without_activities_or_balances_during_the_above_period_are_not_included_Caption; Accounts_without_activities_or_balances_during_the_above_period_are_not_included_CaptionLbl)
            {
            }
            column(Accounts_without_activities_during_the_above_period_are_not_included_Caption; Accounts_without_activities_during_the_above_period_are_not_included_CaptionLbl)
            {
            }
            column(Beginning_Balances_are_set_to_zero_due_to_existance_of_G_L_Entry_filters_Caption; Beginning_Balances_are_set_to_zero_due_to_existance_of_G_L_Entry_filters_CaptionLbl)
            {
            }
            column(G_L_Entry__Posting_Date_Caption; "G/L Entry".FieldCaption("Posting Date"))
            {
            }
            column(G_L_Entry__Document_Type_Caption; "G/L Entry".FieldCaption("Document Type"))
            {
            }
            column(G_L_Entry__Source_No__Caption; "G/L Entry".FieldCaption("Source No."))
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(G_L_Entry_AmountCaption; G_L_Entry_AmountCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Entry__Document_No__Caption; "G/L Entry".FieldCaption("Document No."))
            {
            }
            column(Beginning_BalanceCaption; Beginning_BalanceCaptionLbl)
            {
            }
            column(Report_Total_Beginning_BalanceCaption; Report_Total_Beginning_BalanceCaptionLbl)
            {
            }
            column(Report_Total_ActivitiesCaption; Report_Total_ActivitiesCaptionLbl)
            {
            }
            column(Report_Total_Ending_BalanceCaption; Report_Total_Ending_BalanceCaptionLbl)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(G_L_Account_Department_Filter; "Global Dimension 1 Filter")
            {
            }
            column(G_L_Account_Project_Filter; "Global Dimension 2 Filter")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                RequestFilterFields = "Document Type", "Document No.";
                column(Account_______G_L_Account___No__; 'Account: ' + "G/L Account"."No.")
                {
                }
                column(G_L_Account__Name; "G/L Account".Name)
                {
                }
                column(DebitAmount_Control64; DebitAmount)
                {
                }
                column(CreditAmount_Control65; CreditAmount)
                {
                }
                column(BeginningBalance_Control66; BeginningBalance)
                {
                }
                column(G_L_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(G_L_Entry__Document_Type_; "Document Type")
                {
                }
                column(G_L_Entry__Document_No__; "Document No.")
                {
                }
                column(G_L_Entry__Source_No__; "Source No.")
                {
                }
                column(G_L_Entry_Description; Description)
                {
                }
                column(G_L_Entry_Amount; Amount)
                {
                }
                column(Amount; -Amount)
                {
                }
                column(SourceName; SourceName)
                {
                }
                column(DebitAmount_Control78; DebitAmount)
                {
                }
                column(CreditAmount_Control79; CreditAmount)
                {
                }
                column(BeginningBalance_Control80; BeginningBalance)
                {
                }
                column(Balance_ForwardCaption; Balance_ForwardCaptionLbl)
                {
                }
                column(Balance_to_Carry_ForwardCaption; Balance_to_Carry_ForwardCaptionLbl)
                {
                }
                column(G_L_Entry_Entry_No_; "Entry No.")
                {
                }
                column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
                {
                }
                column(G_L_Entry_Department_Code; "Global Dimension 1 Code")
                {
                }
                column(G_L_Entry_Project_Code; "Global Dimension 2 Code")
                {
                }
                dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE("No." = FILTER('120'), Quantity = FILTER(> 0));
                    PrintOnlyIfDetail = false;
                    column(Purch__Inv__Line_Quantity; Quantity)
                    {
                    }
                    column(Purch__Inv__Line_Description; Description)
                    {
                    }
                    column(Purch__Inv__Line_Amount; Amount)
                    {
                    }
                    column(Purch__Inv__Line__Unit_Cost_____; "Unit Cost (LCY)")
                    {
                    }
                    column(Amount__Caption; Amount__CaptionLbl)
                    {
                    }
                    column(Cost__Caption; Cost__CaptionLbl)
                    {
                    }
                    column(QuantityCaption; QuantityCaptionLbl)
                    {
                    }
                    column(DescriptionCaption_Control37; DescriptionCaption_Control37Lbl)
                    {
                    }
                    column(Purch__Inv__Line_Document_No_; "Document No.")
                    {
                    }
                    column(Purch__Inv__Line_Line_No_; "Line No.")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if UseAddRptCurr then
                        Amount := "Additional-Currency Amount";
                end;

                trigger OnPostDataItem()
                begin
                    if GLEntryFilter <> '' then begin
                        EndingBalance := DebitAmount - CreditAmount;
                        EndBalTotal := EndBalTotal + EndingBalance;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    SetRange("Posting Date", FromDate, ToDate);
                    DebitAmount := 0;
                    CreditAmount := 0;
                end;
            }
            dataitem(Blank; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(DebitAmount_Control88; DebitAmount)
                {
                }
                column(CreditAmount_Control89; CreditAmount)
                {
                }
                column(DebitAmount___CreditAmount_Control90; DebitAmount - CreditAmount)
                {
                }
                column(Account_______G_L_Account___No___Control92; 'Account: ' + "G/L Account"."No.")
                {
                }
                column(G_L_Account__Name_Control93; "G/L Account".Name)
                {
                }
                column(DebitAmount_Control94; DebitAmount)
                {
                }
                column(CreditAmount_Control95; CreditAmount)
                {
                }
                column(DebitAmount___CreditAmount_Control96; DebitAmount - CreditAmount)
                {
                }
                column(Account_______G_L_Account___No___Control98; 'Account: ' + "G/L Account"."No.")
                {
                }
                column(G_L_Account__Name_Control99; "G/L Account".Name)
                {
                }
                column(EndingBalance; EndingBalance)
                {
                }
                column(Total_ActivitiesCaption; Total_ActivitiesCaptionLbl)
                {
                }
                column(Total_ActivitiesCaption_Control97; Total_ActivitiesCaption_Control97Lbl)
                {
                }
                column(Ending_BalanceCaption; Ending_BalanceCaptionLbl)
                {
                }
                column(Blank_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                // Sets filter to only get Net Change up to closing date of
                // previous period which is the beginnig balance for this period
                SetRange("Date Filter", 0D, ClosingDate(FromDate - 1));
                if UseAddRptCurr then begin
                    CalcFields("Additional-Currency Net Change");
                    BeginningBalance := "Additional-Currency Net Change";
                end else begin
                    CalcFields("Net Change");
                    BeginningBalance := "Net Change";
                end;

                // Sets filter to only get Ending Balance at end of period
                SetRange("Date Filter", FromDate, ToDate);
                if UseAddRptCurr then begin
                    CalcFields("Add.-Currency Balance at Date");
                    EndingBalance := "Add.-Currency Balance at Date";
                end else begin
                    CalcFields("Balance at Date");
                    EndingBalance := "Balance at Date";
                end;

                // Are there any Activities (entries) for this account?
                "G/L Entry".CopyFilters(TempGLEntry);            // get saved user filters
                "G/L Entry".SetFilter("G/L Account No.", "No.");  // then add our own
                "G/L Entry".SetRange("Posting Date", FromDate, ToDate);
                CopyFilter("Global Dimension 1 Filter", "G/L Entry"."Global Dimension 1 Code");
                CopyFilter("Global Dimension 2 Filter", "G/L Entry"."Global Dimension 2 Code");
                //with "G/L Entry" do ICE-MPC removed deprecated with statement
                "g/l entry".SetCurrentKey("G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
                AnyEntries := "G/L Entry".Find('-');

                // Is there any reason to skip this account?
                if (PrintType = PrintType::"Accounts with Activities") and not AnyEntries then
                    CurrReport.Skip;
                if (PrintType = PrintType::"Accounts with Balances") and
                   not AnyEntries and
                   (BeginningBalance = 0)
                then
                    CurrReport.Skip;

                // Having determined that we are really going to print this account,
                // we must not track beginning or ending balances if the user has
                // selected ledger entry filters, since they would then be meaningless.
                if GLEntryFilter = '' then begin
                    BeginBalTotal := BeginBalTotal + BeginningBalance;
                    EndBalTotal := EndBalTotal + EndingBalance;
                end else begin
                    BeginningBalance := 0;
                    EndingBalance := 0;
                end;

                // Will generate a new page if Chart of Accounts account is set to yes for New Page.
                //if "New Page" then
                //CurrReport.NewPage;  ICE-MPC 09/01/20
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(DebitAmount,CreditAmount,BeginningBalance,EndingBalance);
                // CurrReport.NewPagePerRecord(OnlyOnePerPage); ICE-MPC 09/01/20
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
        FromDate := "G/L Account".GetRangeMin("Date Filter");
        ToDate := "G/L Account".GetRangeMax("Date Filter");
        PeriodText := 'Includes Activities from ' + Format(FromDate, 0, 4) +
                      ' to ' + Format(ToDate, 0, 4);
        "G/L Account".SetRange("Date Filter");
        GLFilter := "G/L Account".GetFilters;
        GLEntryFilter := "G/L Entry".GetFilters;
        EndBalTotal := 0;
        BeginBalTotal := 0;
        if (GLEntryFilter <> '') then begin
            TempGLEntry.CopyFilters("G/L Entry");  // save user filters for later
                                                   //  accounts w/o activities are never printed if all the
                                                   //  user is interested in are certain activities.
            if PrintType = PrintType::"All Accounts" then
                PrintType := PrintType::"Accounts with Activities";
        end;
        if UseAddRptCurr then begin
            GLSetup.Get;
            Currency.Get(GLSetup."Additional Reporting Currency");
            SubTitle := 'Amounts are in ' + Currency.Description;
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        TempGLEntry: Record "G/L Entry";
        GLFilter: Text[250];
        GLEntryFilter: Text[250];
        FromDate: Date;
        ToDate: Date;
        PeriodText: Text[80];
        MainTitle: Text[88];
        SubTitle: Text[132];
        SourceName: Text[30];
        OnlyOnePerPage: Boolean;
        PrintType: Option "All Accounts","Accounts with Balances","Accounts with Activities";
        BeginningBalance: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        EndingBalance: Decimal;
        BeginBalTotal: Decimal;
        EndBalTotal: Decimal;
        AnyEntries: Boolean;
        UseAddRptCurr: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Accounts_without_activities_or_balances_during_the_above_period_are_not_included_CaptionLbl: Label 'Accounts without activities or balances during the above period are not included.';
        Accounts_without_activities_during_the_above_period_are_not_included_CaptionLbl: Label 'Accounts without activities during the above period are not included.';
        Beginning_Balances_are_set_to_zero_due_to_existance_of_G_L_Entry_filters_CaptionLbl: Label 'Beginning Balances are set to zero due to existance of G/L Entry filters.';
        DescriptionCaptionLbl: Label 'Description';
        G_L_Entry_AmountCaptionLbl: Label 'Debit Activities';
        AmountCaptionLbl: Label 'Credit Activities';
        BalanceCaptionLbl: Label 'Balance';
        Beginning_BalanceCaptionLbl: Label 'Beginning Balance';
        Report_Total_Beginning_BalanceCaptionLbl: Label 'Report Total Beginning Balance';
        Report_Total_ActivitiesCaptionLbl: Label 'Report Total Activities';
        Report_Total_Ending_BalanceCaptionLbl: Label 'Report Total Ending Balance';
        Balance_ForwardCaptionLbl: Label 'Balance Forward';
        Balance_to_Carry_ForwardCaptionLbl: Label 'Balance to Carry Forward';
        Amount__CaptionLbl: Label 'Amount $';
        Cost__CaptionLbl: Label 'Cost $';
        QuantityCaptionLbl: Label 'Quantity';
        DescriptionCaption_Control37Lbl: Label 'Description';
        Total_ActivitiesCaptionLbl: Label 'Total Activities';
        Total_ActivitiesCaption_Control97Lbl: Label 'Total Activities';
        Ending_BalanceCaptionLbl: Label 'Ending Balance';
}

