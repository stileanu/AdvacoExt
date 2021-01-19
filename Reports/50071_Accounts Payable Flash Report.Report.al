report 50071 "Accounts Payable Flash Report"
{
    // 10/18/11 ADV
    //   Modified layout (increasd fields size)
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50071_Accounts Payable Flash Report.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = false;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting), "No." = CONST('205'));
            PrintOnlyIfDetail = true;
            column(Accounts_Payable_Flash_Report_; 'Accounts Payable Flash Report')
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
            column(BeginningBalance; BeginningBalance)
            {
            }
            column(EndingBalance; EndingBalance)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(A_P_BalanceCaption; A_P_BalanceCaptionLbl)
            {
            }
            column(Beginning_BalanceCaption; Beginning_BalanceCaptionLbl)
            {
            }
            column(Month_to_Date_Accounts_Payable_SummaryCaption; Month_to_Date_Accounts_Payable_SummaryCaptionLbl)
            {
            }
            column(Year_to_Date_Accounts_Payable_SummaryCaption; Year_to_Date_Accounts_Payable_SummaryCaptionLbl)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD("No."), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                DataItemTableView = SORTING("G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");

                trigger OnAfterGetRecord()
                begin
                    //case "G/L Entry"."Document Type" of ICE-MPC 08/20/20
                    case "G/L Entry"."Document Type".AsInteger() of
                        0:
                            if "G/L Entry".Amount < 0 then begin
                                Invoice := (Invoice + "G/L Entry".Amount);
                                InvoiceTotal := (InvoiceTotal + "G/L Entry".Amount);
                            end else begin
                                Payment := (Payment + "G/L Entry".Amount);
                                PaymentTotal := (PaymentTotal + "G/L Entry".Amount);
                            end;
                        1:
                            begin
                                Payment := (Payment + "G/L Entry".Amount);
                                PaymentTotal := (PaymentTotal + "G/L Entry".Amount);
                            end;
                        2:
                            begin
                                Invoice := (Invoice + "G/L Entry".Amount);
                                InvoiceTotal := (InvoiceTotal + "G/L Entry".Amount);
                            end;
                        3:
                            begin
                                CreditMemos := (CreditMemos + "G/L Entry".Amount);
                                PaymentTotal := (PaymentTotal + "G/L Entry".Amount);
                            end;
                        4:
                            begin
                                "Finance Charge Memo" := ("Finance Charge Memo" + "G/L Entry".Amount);
                                InvoiceTotal := (InvoiceTotal + "G/L Entry".Amount);
                            end;
                        5:
                            if "G/L Entry".Amount > 0 then begin
                                Invoice := (Invoice + "G/L Entry".Amount);
                                InvoiceTotal := (InvoiceTotal + "G/L Entry".Amount);
                            end else begin
                                Payment := (Payment + "G/L Entry".Amount);
                                PaymentTotal := (PaymentTotal + "G/L Entry".Amount);
                            end;
                    end;

                    Difference := (InvoiceTotal + PaymentTotal) * -1;
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
                    SetRange("Posting Date", MonthDate, ToDate);
                    DebitAmount := 0;
                    CreditAmount := 0;
                end;
            }
            dataitem(Blank; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(InvoiceTotal___CreditMemos; InvoiceTotal + CreditMemos)
                {
                }
                column(InvoiceTotal___BeginningBalance___PaymentTotal; InvoiceTotal + BeginningBalance + PaymentTotal)
                {
                }
                column(Payment; Payment)
                {
                }
                column(Invoice; Invoice)
                {
                }
                column(CreditMemos; CreditMemos)
                {
                }
                column(Finance_Charge_Memo_; "Finance Charge Memo")
                {
                }
                column(Difference; Difference)
                {
                }
                column(InvoiceTotal___CreditMemos___BeginningBalance; InvoiceTotal + CreditMemos + BeginningBalance)
                {
                }
                column(PurchasesCaption; PurchasesCaptionLbl)
                {
                }
                column(Finance_ChargesCaption; Finance_ChargesCaptionLbl)
                {
                }
                column(Invoice___Credit_TotalCaption; Invoice___Credit_TotalCaptionLbl)
                {
                }
                column(CreditsCaption; CreditsCaptionLbl)
                {
                }
                column(PaymentsCaption; PaymentsCaptionLbl)
                {
                }
                column(Ending_BalanceCaption; Ending_BalanceCaptionLbl)
                {
                }
                column(Net_ChangeCaption; Net_ChangeCaptionLbl)
                {
                }
                column(Sub_TotalCaption; Sub_TotalCaptionLbl)
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
                SetRange("Date Filter", 0D, ClosingDate(MonthDate - 1));
                CalcFields("Net Change");
                BeginningBalance := "Net Change" * -1;


                // Sets filter to only get Ending Balance at end of period
                SetRange("Date Filter", MonthDate, ToDate);
                CalcFields("Balance at Date");
                EndingBalance := "Balance at Date" * -1;




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
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(DebitAmount,CreditAmount,BeginningBalance,EndingBalance);  ICE-MPC 08/20/20
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
        YearDate := CalcDate('CY-12M+1D', WorkDate);
        MonthDate := CalcDate('CM+1D-1M', WorkDate);
        ToDate := CalcDate('CM', WorkDate);

        "G/L Account".SetRange("Date Filter");
        GLFilter := "G/L Account".GetFilters;
        GLEntryFilter := "G/L Entry".GetFilters;
        EndBalTotal := 0;
        BeginBalTotal := 0;
    end;

    var
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        Currency: Record Currency;
        TempGLEntry: Record "G/L Entry";
        GLFilter: Text[250];
        GLEntryFilter: Text[250];
        MonthDate: Date;
        YearDate: Date;
        ToDate: Date;
        MainTitle: Text[88];
        SourceName: Text[30];
        PrintType: Option "All Accounts","Accounts with Balances","Accounts with Activities";
        BeginningBalance: Decimal;
        DebitAmount: Decimal;
        CreditAmount: Decimal;
        EndingBalance: Decimal;
        BeginBalTotal: Decimal;
        EndBalTotal: Decimal;
        AnyEntries: Boolean;
        Invoice: Decimal;
        Payment: Decimal;
        CreditMemos: Decimal;
        "Finance Charge Memo": Decimal;
        InvoiceTotal: Decimal;
        PaymentTotal: Decimal;
        Difference: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        A_P_BalanceCaptionLbl: Label 'A/P Balance';
        Beginning_BalanceCaptionLbl: Label 'Beginning Balance';
        Month_to_Date_Accounts_Payable_SummaryCaptionLbl: Label 'Month-to-Date Accounts Payable Summary';
        Year_to_Date_Accounts_Payable_SummaryCaptionLbl: Label 'Year-to-Date Accounts Payable Summary';
        PurchasesCaptionLbl: Label 'Purchases';
        Finance_ChargesCaptionLbl: Label 'Finance Charges';
        Invoice___Credit_TotalCaptionLbl: Label 'Invoice / Credit Total';
        CreditsCaptionLbl: Label 'Credits';
        PaymentsCaptionLbl: Label 'Payments';
        Ending_BalanceCaptionLbl: Label 'Ending Balance';
        Net_ChangeCaptionLbl: Label 'Net Change';
        Sub_TotalCaptionLbl: Label 'Sub Total';
}

