report 50084 "Customers Exceed Credit Limit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50084_Customers Exceed Credit Limit.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(Customers_Exceeding_Credit_Limit_; 'Customers Exceeding Credit Limit')
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
            column(Customer_TABLENAME__________FilterString; Customer.TableName + ': ' + FilterString)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(PaymentTerms__Due_Date_Calculation_; PaymentTerms."Due Date Calculation")
            {
            }
            column(Customer__Credit_Limit_____; "Credit Limit (LCY)")
            {
                DecimalPlaces = 2 : 2;
            }
            column(Customer__Balance_____; "Balance (LCY)")
            {
            }
            column(Customer_Blocked; Blocked)
            {
            }
            column(Customer_Contact; Contact)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(Customer__Customer_Since_; "Customer Since")
            {
            }
            column(AvgDaysToPay_1_; AvgDaysToPay[1])
            {
                DecimalPlaces = 0 : 0;
            }
            column(D_; 'D')
            {
                //DecimalPlaces = 0:0;  ICE-MPC 08/20/20
            }
            column(D__Control6; 'D')
            {
                //DecimalPlaces = 0:0;  ICE-MPC 08/20/20
            }
            column(AvgDaysToPay_2_; AvgDaysToPay[2])
            {
                DecimalPlaces = 0 : 0;
            }
            column(D__Control9; 'D')
            {
                //DecimalPlaces = 0:0;  ICE-MPC 08/20/20
            }
            column(AvgDaysToPay_3_; AvgDaysToPay[3])
            {
                DecimalPlaces = 0 : 0;
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customers_without_balances_are_not_listed_Caption; Customers_without_balances_are_not_listed_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(PaymentTerms__Due_Date_Calculation_Caption; PaymentTerms__Due_Date_Calculation_CaptionLbl)
            {
            }
            column(Customer__Credit_Limit_____Caption; FieldCaption("Credit Limit (LCY)"))
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(ContactCaption; ContactCaptionLbl)
            {
            }
            column(Customer_BlockedCaption; FieldCaption(Blocked))
            {
            }
            column(Customer__Balance_____Caption; FieldCaption("Balance (LCY)"))
            {
            }
            column(Phone_No_Caption; Phone_No_CaptionLbl)
            {
            }
            column(Customer__Customer_Since_Caption; FieldCaption("Customer Since"))
            {
            }
            column(V6_Month_CollectionsCaption; V6_Month_CollectionsCaptionLbl)
            {
            }
            column(V12_Month_CollectionsCaption; V12_Month_CollectionsCaptionLbl)
            {
            }
            column(Last_Year_CollectionsCaption; Last_Year_CollectionsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetRange("No.");
                ClearAll;

                if "Payment Terms Code" <> '' then
                    PaymentTerms.Get("Payment Terms Code")
                else
                    Clear(PaymentTerms);

                CalcFields("Balance (LCY)", Comment);
                if (AllHavingBalance) and ("Balance (LCY)" = 0) then
                    CurrReport.Skip;

                if ("Balance (LCY)" > "Credit Limit (LCY)") then
                    OverLimit := true
                else
                    OverLimit := false;

                CustDateFilter[1] := Format(WorkDate - 182) + '..' + Format(99991231D);
                CustDateFilter[2] := Format(WorkDate - 365) + '..' + Format(99991231D);
                CustDateFilter[3] := Format(WorkDate - 730) + '..' + Format(WorkDate - 365);
                DateFilterCalc.CreateFiscalYearFilter(CustDateFilter[4], CustDateName[4], WorkDate, 0);

                for i := 1 to 3 do begin
                    CustLedgEntry2.Reset;
                    CustLedgEntry2.SetCurrentKey("Customer No.", "Posting Date");
                    CustLedgEntry2.SetRange("Customer No.", "No.");

                    CustLedgEntry2.SetFilter("Posting Date", CustDateFilter[i]);
                    CustLedgEntry2.SetRange("Posting Date", 0D, CustLedgEntry2.GetRangeMax("Posting Date"));
                    CustLedgEntry2.CalcSums("Amount (LCY)");
                    CustBalanceUSD := CustLedgEntry2."Amount (LCY)";
                    HighestBalanceUSD[i] := CustBalanceUSD;
                    DaysToPay := 0;
                    NoOfInv := 0;

                    CustLedgEntry2.SetFilter("Posting Date", CustDateFilter[i]);
                    if CustLedgEntry2.Find('+') then
                        repeat
                            //j := CustLedgEntry2."Document Type"; ICE-MPC 08/20/20
                            j := CustLedgEntry2."Document Type".AsInteger();
                            if j > 0 then
                                NoOfDoc[i] [j] := NoOfDoc[i] [j] + 1;

                            CustBalanceUSD := CustBalanceUSD - CustLedgEntry2."Amount (LCY)";
                            if CustBalanceUSD > HighestBalanceUSD[i] then
                                HighestBalanceUSD[i] := CustBalanceUSD;

                            // Optimized Approximation
                            if (CustLedgEntry2."Document Type" = CustLedgEntry2."Document Type"::Invoice) and
                               not CustLedgEntry2.Open
                            then
                                if CustLedgEntry2."Closed at Date" > CustLedgEntry2."Posting Date" then
                                    UpdateDaysToPay(CustLedgEntry2."Closed at Date" - CustLedgEntry2."Posting Date")
                                else
                                    if CustLedgEntry2."Closed by Entry No." <> 0 then begin
                                        if CustLedgEntry3.Get(CustLedgEntry2."Closed by Entry No.") then
                                            UpdateDaysToPay(CustLedgEntry3."Posting Date" - CustLedgEntry2."Posting Date");
                                    end else begin
                                        CustLedgEntry3.SetCurrentKey("Closed by Entry No.");
                                        CustLedgEntry3.SetRange("Closed by Entry No.", CustLedgEntry2."Entry No.");
                                        if CustLedgEntry3.Find('+') then
                                            UpdateDaysToPay(CustLedgEntry3."Posting Date" - CustLedgEntry2."Posting Date");
                                    end;
                        until CustLedgEntry2.Next(-1) = 0;
                    if NoOfInv <> 0 then
                        AvgDaysToPay[i] := DaysToPay / NoOfInv;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AllHavingBalance; AllHavingBalance)
                    {
                        ApplicationArea = All;
                        Caption = 'Cust. with Balances Only';
                    }
                }
            }
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
        CompanyInformation.Get('');
        FilterString := CopyStr(Customer.GetFilters, 1, MaxStrLen(FilterString));
        PrintAmountsInLocal := false;  // until FlowFields work for this
    end;

    var
        CustLedgEntry2: Record "Cust. Ledger Entry";
        CustLedgEntry3: Record "Cust. Ledger Entry";
        PrintAmountsInLocal: Boolean;
        AllHavingBalance: Boolean;
        FilterString: Text[250];
        OverLimit: Boolean;
        Address3: Text[80];
        PaymentTerms: Record "Payment Terms";
        CompanyInformation: Record "Company Information";
        DateFilterCalc: Codeunit "DateFilter-Calc";
        CustDateFilter: array[4] of Text[30];
        CustDateName: array[4] of Text[30];
        TotalRemainAmountUSD: array[5] of Decimal;
        AvgDaysToPay: array[3] of Decimal;
        DaysToPay: Decimal;
        NoOfInv: Integer;
        NoOfDoc: array[3, 5] of Integer;
        HighestBalanceUSD: array[3] of Decimal;
        CustBalanceUSD: Decimal;
        i: Integer;
        j: Integer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customers_without_balances_are_not_listed_CaptionLbl: Label 'Customers without balances are not listed.';
        NameCaptionLbl: Label 'Name';
        PaymentTerms__Due_Date_Calculation_CaptionLbl: Label 'Terms';
        ContactCaptionLbl: Label 'Contact';
        Phone_No_CaptionLbl: Label 'Phone No.';
        V6_Month_CollectionsCaptionLbl: Label '6 Month Collections';
        V12_Month_CollectionsCaptionLbl: Label '12 Month Collections';
        Last_Year_CollectionsCaptionLbl: Label 'Last Year Collections';

    local procedure UpdateDaysToPay(NoOfDays: Integer)
    begin
        DaysToPay := DaysToPay + NoOfDays;
        NoOfInv := NoOfInv + 1;
    end;
}

