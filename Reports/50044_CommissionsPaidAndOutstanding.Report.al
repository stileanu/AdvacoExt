report 50044 "Commissions Paid & Outstanding"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50044_CommissionsPaidAndOutstanding.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("No." = FILTER('ADV-01'));
            RequestFilterFields = "Date Filter";
            column(Customer_Name; Customer.Name)
            {
            }
            column(Customer_Address; Address)
            {
            }
            column(City__________State__________ZIP_Code_; City + ', ' + County + ' ' + "Post Code")
            {
            }
            column(Commissions_Statement_; 'Commissions Statement')
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
            column(PeriodText; PeriodText)
            {
            }
            column(Total_; 'Total')
            {
            }
            column(Sales_Department_; 'Sales Department')
            {
            }
            column(Service_Department_; 'Service Department')
            {
            }
            column(ServiceCommission; ServiceCommission)
            {
            }
            column(SalesCommission; SalesCommission)
            {
            }
            column(ServiceCommission___SalesCommission; ServiceCommission + SalesCommission)
            {
            }
            column(Paid_Commissions_; 'Paid Commissions')
            {
            }
            column(Open_Commissions_; 'Open Commissions')
            {
            }
            column(OpenService; OpenService)
            {
            }
            column(OpenSales; OpenSales)
            {
            }
            column(OpenCommission; OpenCommission)
            {
            }
            column(Total_Commissions_; 'Total Commissions')
            {
            }
            column(OpenService___ServiceCommission; OpenService + ServiceCommission)
            {
            }
            column(OpenSales___SalesCommission; OpenSales + SalesCommission)
            {
            }
            column(OpenCommission__ServiceCommission___SalesCommission; OpenCommission + ServiceCommission + SalesCommission)
            {
            }
            column(Field_Service_; 'Field Service')
            {
            }
            column(FieldServiceCommission; FieldServiceCommission)
            {
            }
            column(OpenFieldService; OpenFieldService)
            {
            }
            column(OpenFieldService___FieldServiceCommission; OpenFieldService + FieldServiceCommission)
            {
            }
            column(g; g)
            {
            }
            column(i; i)
            {
            }
            column(l; l)
            {
            }
            column(s; s)
            {
            }
            column(te; te)
            {
            }
            column(tr; tr)
            {
            }
            column(ts; ts)
            {
            }
            column(va; va)
            {
            }
            column(vj; vj)
            {
            }
            column(g_; 'g')
            {
            }
            column(i_; 'i')
            {
            }
            column(l_; 'l')
            {
            }
            column(s_; 's')
            {
            }
            column(te_; 'te')
            {
            }
            column(tr_; 'tr')
            {
            }
            column(ts_; 'ts')
            {
            }
            column(va_; 'va')
            {
            }
            column(vj_; 'vj')
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Paid_CommissionsCaption; Paid_CommissionsLbl)
            {
            }
            column(Open_CommissionsCaption; Open_CommissionsLbl)
            {
            }
            column(Total_CommissionsCaption; Total_CommissionsLbl)
            {
            }
            column(Customer_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ///--?  ?????????????????? - ask Kaye
                if UserId = 'HARLEN' then
                    ShowReps := true
                else
                    ShowReps := false;
                //Message('Customer Name is %1 and No. is %2', Customer.Name, Customer."No.");

                // Search for open g/l entries
                GLEntry.Reset;
                GLEntry.SetCurrentKey("Include for Commissions", Rep, "Document No.", "Posting Date");
                GLEntry.SetRange("Include for Commissions", true);
                GLEntry.SetFilter(GLEntry.Rep, '<>%1', '');
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
                                DateClosed := CustLedgerEntry2."Closed at Date";
                            end;
                            // Update either paid-to-date or paid via this statement.
                            if (DateClosed >= FromPeriod) and (DateClosed <= ThruPeriod) then begin
                                GetRep;
                                CurrentDueTotalAmount := CurrentDueTotalAmount + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                //Determine Commission Department
                                if GLEntry."Commission Dept. Code" = 'SERVICE' then
                                    ServiceCommission := ServiceCommission + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                if GLEntry."Commission Dept. Code" = 'SALES' then
                                    SalesCommission := SalesCommission + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                if GLEntry."Commission Dept. Code" = 'FIELDSERVICE' then
                                    FieldServiceCommission := FieldServiceCommission + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)))
                            ;

                            end;

                            if (DateClosed > ThruPeriod) and (GLEntry."Posting Date" <= ThruPeriod) then begin
                                GetRep;
                                REPComm;
                                OpenCommission := OpenCommission + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                //Determine Commission Department
                                if GLEntry."Commission Dept. Code" = 'SERVICE' then
                                    OpenService := OpenService + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                if GLEntry."Commission Dept. Code" = 'SALES' then
                                    OpenSales := OpenSales + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                                if GLEntry."Commission Dept. Code" = 'FIELDSERVICE' then
                                    OpenFieldService := OpenFieldService + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            end;
                        end;
                        // Calculate all Open Commissions Due by G/L Account
                        if (GLEntry.Open) and (GLEntry."Posting Date" <= ThruPeriod) then begin
                            GetRep;
                            REPComm;
                            OpenCommission := OpenCommission + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            //Determine Commission Department
                            if GLEntry."Commission Dept. Code" = 'SERVICE' then
                                OpenService := OpenService + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            if GLEntry."Commission Dept. Code" = 'SALES' then
                                OpenSales := OpenSales + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
                            if GLEntry."Commission Dept. Code" = 'FIELDSERVICE' then
                                OpenFieldService := OpenFieldService + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));

                        end;
                    until GLEntry.Next = 0;
            end;

            trigger OnPreDataItem()
            begin
                FromPeriod := GetRangeMin("Date Filter");
                ThruPeriod := GetRangeMax("Date Filter");
                PeriodText := 'Current Period from ' + Format(FromPeriod, 0, 4) + ' to ' + Format(ThruPeriod, 0, 4);
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
        AccountingPeriod: Record "Accounting Period";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntry2: Record "Cust. Ledger Entry";
        FormatAddress: Codeunit "Format Address";
        DateClosed: Date;
        FromPeriod: Date;
        ThruPeriod: Date;
        BegYearPeriod: Date;
        FirstTime: Boolean;
        ServiceCommission: Decimal;
        SalesCommission: Decimal;
        FieldServiceCommission: Decimal;
        CurrentDueTotalAmount: Decimal;
        OpenCommission: Decimal;
        OpenService: Decimal;
        OpenSales: Decimal;
        OpenFieldService: Decimal;
        "Outside Sales Reps": Record "Outside Sales Reps";
        PeriodText: Text[100];
        OK: Boolean;
        g: Decimal;
        i: Decimal;
        l: Decimal;
        s: Decimal;
        te: Decimal;
        tr: Decimal;
        ts: Decimal;
        va: Decimal;
        vj: Decimal;
        ShowReps: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Paid_CommissionsLbl: Label 'PAID COMMISSIONS';
        Total_CommissionsLbl: Label 'TOTAL COMMISSIONS';
        Open_CommissionsLbl: Label 'OPEN COMMISSIONS';

    procedure GetRep()
    begin
        if "Outside Sales Reps".Get(GLEntry.Rep) then
            OK := true;
    end;

    procedure REPComm()
    begin
        case GLEntry.Rep of
            'GLT':
                g := g + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'IES':
                i := i + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'LIG':
                l := l + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'SCH':
                s := s + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'TEL':
                te := te + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'TRI':
                tr := tr + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'TST':
                ts := ts + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'VAC':
                va := va + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
            'VJR':
                vj := vj + -(Round(GLEntry.Amount * ("Outside Sales Reps"."Commission %" / 100)));
        end;
    end;
}

