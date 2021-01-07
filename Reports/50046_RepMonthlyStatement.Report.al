report 50046 "Rep. Monthly Statement"
{
    // // Removed Commission Paid to Date Until 2003
    // 
    // // Label  FORMAT(ThruPeriod,0,'<Year4>')+' COMMISSIONS PAID TO DATE'
    // // Value  CommPaidToDate
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50046_RepMonthlyStatement.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Outside Sales Reps"; "Outside Sales Reps")
        {
            DataItemTableView = SORTING("Rep Code");
            RequestFilterFields = "Rep Code", "Date Filter";
            column(RepAddress_1_; RepAddress[1])
            {
            }
            column(RepAddress_2_; RepAddress[2])
            {
            }
            column(RepAddress_3_; RepAddress[3])
            {
            }
            column(RepAddress_4_; RepAddress[4])
            {
            }
            column(RepAddress_5_; RepAddress[5])
            {
            }
            ///--!
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(CURRENT_INVOICES_FOR___UPPERCASE_FORMAT_ThruPeriod_0___Month_Text____Year4____; 'CURRENT INVOICES FOR ' + UpperCase(Format(ThruPeriod, 0, '<Month Text>, <Year4>')))
            {
            }
            column(ThisPeriodSales; ThisPeriodSales)
            {
            }
            column(COMMISSIONS_DUE_FOR___UPPERCASE_FORMAT_ThruPeriod_0___Month_Text____Year4____; 'COMMISSIONS DUE FOR ' + UpperCase(Format(ThruPeriod, 0, '<Month Text>, <Year4>')))
            {
            }
            column(ThisPeriodComm; ThisPeriodComm)
            {
            }
            column(COMMISSIONS_PAST_DUE_BY_CUSTOMERS_; 'COMMISSIONS PAST DUE BY CUSTOMERS')
            {
            }
            column(PastDueComm; PastDueComm)
            {
            }
            column(REPRESENTATIVE_MONTHLY_STATEMENT_OF_ACCOUNTSCaption; REPRESENTATIVE_MONTHLY_STATEMENT_OF_ACCOUNTSCaptionLbl)
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            column(Outside_Sales_Reps_Rep_Code; "Rep Code")
            {
            }
            dataitem("Past Due Commissions"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 999;
                column(PastDueAmount_Number_; PastDueAmount[Number])
                {
                }
                column(Customer_Name; Customer.Name)
                {
                }
                column(PastDueSourceNo_Number_; PastDueSourceNo[Number])
                {
                }
                column(PastDueDocNo_Number_; PastDueDocNo[Number])
                {
                }
                column(PastDueDate_Number_; PastDueDate[Number])
                {
                }
                column(Past_Due_Commissions_Number; Number)
                {
                }


                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, PastDueCount);
                end;
            }
            dataitem("Past Due Footer"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 1;
                column(ThisPeriodComm_PastDueComm_CurrentPeriodComm; ThisPeriodComm + PastDueComm - CurrentPeriodComm)
                {
                }
                column(TOTAL_COMMISSIONS_OWED_TO_DATE_; 'TOTAL COMMISSIONS OWED TO DATE')
                {
                }
                column(Past_Due_Footer_Number; Number)
                {
                }
            }
            dataitem("Current Due Commissions"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                MaxIteration = 999;
                column(ENCLOSED_ARE_COMMISSIONS_TO_REP_FOR_THE_FOLLOWING_INVOICES__; 'ENCLOSED ARE COMMISSIONS TO REP FOR THE FOLLOWING INVOICES:')
                {
                }
                column(CurrentDueTotalAmount; CurrentDueTotalAmount)
                {
                }
                column(CurrentDueAmount_Number_; CurrentDueAmount[Number])
                {
                }
                column(Customer_Name_Control16; Customer.Name)
                {
                }
                column(CurrentDueSourceNo_Number_; CurrentDueSourceNo[Number])
                {
                }
                column(CurrentDueDocNo_Number_; CurrentDueDocNo[Number])
                {
                }
                column(CurrentDueDate_Number_; CurrentDueDate[Number])
                {
                }
                column(Check__________Caption; Check__________CaptionLbl)
                {
                }
                column(Date_________Caption; Date_________CaptionLbl)
                {
                }
                column(Current_Due_Commissions_Number; Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange(Number, 1, CurrentDueCount);
                end;
            }

            trigger OnAfterGetRecord()

            begin
                FormatAddress.OutsideRep(RepAddress, "Outside Sales Reps");

                Clear(ThisPeriodSales);
                Clear(ThisPeriodComm);
                Clear(PastDueComm);
                Clear(PastDueDate);
                Clear(PastDueDocNo);
                Clear(PastDueSourceNo);
                Clear(PastDueAmount);
                Clear(PastDueCount);
                Clear(CurrentDueTotalAmount);
                Clear(CurrentDueDate);
                Clear(CurrentDueDocNo);
                Clear(CurrentDueSourceNo);
                Clear(CurrentDueAmount);
                Clear(CurrentDueCount);
                Clear(CommPaidToDate);
                Clear(CurrentPeriodComm);

                // Current Period Sales and Commission Calc.
                SetRange("Date Filter", FromPeriod, ThruPeriod);
                CalcFields("Sales Amount");
                ThisPeriodSales := "Sales Amount";
                ThisPeriodComm := Round(ThisPeriodSales * ("Outside Sales Reps"."Commission %" / 100));

                // Search for open g/l entries
                GLEntry.Reset;
                GLEntry.SetCurrentKey("Include for Commissions", Rep, "Document No.", "Posting Date");
                GLEntry.SetRange("Include for Commissions", true);
                GLEntry.SetRange(Rep, "Rep Code");
                GLEntry.SetRange("Posting Date", 0D, ThruPeriod);
                GLEntry.SetFilter(Amount, '<>%1', 0);

                if GLEntry.Find('-') then
                    repeat
                        GLEntry.CalcFields(Open);
                        Clear(DateClosed);
                        // Analyze paid Commissions for whether paid previously to current period vs paid in current period.
                        if not GLEntry.Open then begin
                            // Find Date Closed
                            CustLedgerEntry.Reset;
                            CustLedgerEntry.SetCurrentKey("Document Type", "Document No.", "Customer No.");
                            CustLedgerEntry.SetRange("Document Type", GLEntry."Document Type");
                            CustLedgerEntry.SetRange("Document No.", GLEntry."Document No.");
                            CustLedgerEntry.SetRange("Customer No.", GLEntry."Source No.");
                            CustLedgerEntry.Find('-');
                            if CustLedgerEntry."Closed at Date" <> 0D then
                                DateClosed := CustLedgerEntry."Closed at Date"
                            else begin
                                CustLedgerEntry2.Reset;
                                CustLedgerEntry2.SetCurrentKey("Closed by Entry No.");
                                CustLedgerEntry2.SetRange("Closed by Entry No.", CustLedgerEntry."Entry No.");
                                CustLedgerEntry2.Find('-');
                                // DateClosed := CustLedgerEntry2."Posting Date"; // HEF Replaced
                                DateClosed := CustLedgerEntry2."Closed at Date";
                            end;
                            // Update either paid-to-date or paid via this statement.
                            if (DateClosed >= BegYearPeriod) and (DateClosed < FromPeriod) then
                                CommPaidToDate := CommPaidToDate + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            if (DateClosed >= FromPeriod) and (DateClosed <= ThruPeriod) then begin
                                CurrentDueTotalAmount := CurrentDueTotalAmount + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                CurrentDueCount := CurrentDueCount + 1;
                                CurrentDueDate[CurrentDueCount] := GLEntry."Posting Date";
                                CurrentDueDocNo[CurrentDueCount] := GLEntry."Document No.";
                                CurrentDueSourceNo[CurrentDueCount] := GLEntry."Source No.";
                                CurrentDueAmount[CurrentDueCount] := -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                // HEF INSERT
                                // Calculate Commissions Payed for Invoices from the Current Period
                                if (GLEntry."Posting Date" >= FromPeriod) and (GLEntry."Posting Date" <= ThruPeriod) then
                                    CurrentPeriodComm := CurrentPeriodComm + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                // HEF END INSERT
                            end;
                            if (DateClosed > ThruPeriod) and (GLEntry."Posting Date" < FromPeriod) then begin
                                PastDueComm := PastDueComm + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                PastDueCount := PastDueCount + 1;
                                PastDueDate[PastDueCount] := GLEntry."Posting Date";
                                PastDueDocNo[PastDueCount] := GLEntry."Document No.";
                                PastDueSourceNo[PastDueCount] := GLEntry."Source No.";
                                PastDueAmount[PastDueCount] := -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            end;
                        end;
                        // Past Due Commissions Calc.
                        if (GLEntry.Open) and (GLEntry."Posting Date" < FromPeriod) then begin
                            PastDueComm := PastDueComm + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            PastDueCount := PastDueCount + 1;
                            PastDueDate[PastDueCount] := GLEntry."Posting Date";
                            PastDueDocNo[PastDueCount] := GLEntry."Document No.";
                            PastDueSourceNo[PastDueCount] := GLEntry."Source No.";
                            PastDueAmount[PastDueCount] := -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                        end;
                    until GLEntry.Next = 0;

                if not FirstTime then
                    ///--!
                    //CurrReport.PageNo := 0
                    //else
                    FirstTime := true;
            end;

            trigger OnPreDataItem()
            begin
                FromPeriod := GetRangeMin("Date Filter");
                ThruPeriod := GetRangeMax("Date Filter");
                BegYearPeriod := BegOfYear(ThruPeriod);

                SetRange("Date Filter");
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

    var
        GLEntry: Record "G/L Entry";
        Customer: Record Customer;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        AccountingPeriod: Record "Accounting Period";
        RepAddress: array[8] of Text[100];
        FormatAddress: Codeunit FormatAddrExt;
        ThisPeriodSales: Decimal;
        ThisPeriodComm: Decimal;
        PastDueComm: Decimal;
        PastDueCommDoc: Decimal;
        CommPaidToDate: Decimal;
        PastDueDate: array[999] of Date;
        PastDueDocNo: array[999] of Code[20];
        PastDueSourceNo: array[999] of Code[20];
        PastDueAmount: array[999] of Decimal;
        PastDueCount: Integer;
        CurrentDueTotalAmount: Decimal;
        CurrentDueDate: array[999] of Date;
        CurrentDueDocNo: array[999] of Code[20];
        CurrentDueSourceNo: array[999] of Code[20];
        CurrentDueAmount: array[999] of Decimal;
        CurrentDueCount: Integer;
        DateClosed: Date;
        FromPeriod: Date;
        ThruPeriod: Date;
        BegYearPeriod: Date;
        FirstTime: Boolean;
        CurrentPeriodComm: Decimal;
        REPRESENTATIVE_MONTHLY_STATEMENT_OF_ACCOUNTSCaptionLbl: Label 'REPRESENTATIVE MONTHLY STATEMENT OF ACCOUNTS';
        Page_CaptionLbl: Label 'Page:';
        Check__________CaptionLbl: Label 'Check # _______';
        Date_________CaptionLbl: Label 'Date  _______';

    procedure BegOfYear(DateInYear: Date): Date
    begin
        //with AccountingPeriod do begin
        /* Returns the Beginning Date of the Fiscal Year which contains DateInYear */
        AccountingPeriod.SetFilter("New Fiscal Year", 'Yes');
        AccountingPeriod.Find('+');          // start at end of file
        while AccountingPeriod."Starting Date" > DateInYear do     // walk backward through the file
            if AccountingPeriod.Next(-1) = 0 then
                exit(0D);                             // no more dates, so set to earliest time
        exit(AccountingPeriod."Starting Date");
        //end;

    end;
}

