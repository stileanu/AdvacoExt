report 50075 "A/R Adjustments Detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50075_AR Adjustments Detail.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date") WHERE("Document Type" = CONST("Credit Memo"));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Posting Date", "Global Dimension 2 Code";
            column(Adjustments_Detail_Report_; 'Adjustments Detail Report')
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
            column(Cust__Ledger_Entry__TABLENAME__________FilterString; "Cust. Ledger Entry".TableName + ': ' + FilterString)
            {
            }
            column(Cust__Ledger_Entry__Customer_No__; "Customer No.")
            {
            }
            column(Customer_Name; Customer.Name)
            {
            }
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Amount_____; -"Amount (LCY)")
            {
            }
            column(Amount______Control31; -"Amount (LCY)")
            {
            }
            column(Cust__Ledger_Entry___Amount_____; -"Cust. Ledger Entry"."Amount (LCY)")
            {
            }
            column(TotalDiscounts; TotalDiscounts)
            {
            }
            column(TotalApplied; -TotalApplied)
            {
            }
            column(Cust__Ledger_Entry___Amount________TotalApplied; -"Cust. Ledger Entry"."Amount (LCY)" + TotalApplied)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(Applied_To_DocumentCaption; Applied_To_DocumentCaptionLbl)
            {
            }
            column(Discount_DateCaption; Discount_DateCaptionLbl)
            {
            }
            column(Discount_TakenCaption; Discount_TakenCaptionLbl)
            {
            }
            column(Amount_AppliedCaption; Amount_AppliedCaptionLbl)
            {
            }
            column(Amount_Not_Yet_AppliedCaption; Amount_Not_Yet_AppliedCaptionLbl)
            {
            }
            column(NumberCaption; NumberCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(NumberCaption_Control19; NumberCaption_Control19Lbl)
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(Amount_____Caption; Amount_____CaptionLbl)
            {
            }
            column(Customer_Caption; Customer_CaptionLbl)
            {
            }
            column(Report_TotalsCaption; Report_TotalsCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Cust__Ledger_Entry_Closed_by_Entry_No_; "Closed by Entry No.")
            {
            }
            dataitem(FirstLoop; "Cust. Ledger Entry")
            {
                DataItemLink = "Entry No." = FIELD("Closed by Entry No.");
                DataItemTableView = SORTING("Entry No.");
                column(FirstLoop__Document_Type_; "Document Type")
                {
                }
                column(FirstLoop__Document_No__; "Document No.")
                {
                }
                column(FirstLoop__Due_Date_; "Due Date")
                {
                }
                column(FirstLoop__Pmt__Discount_Date_; "Pmt. Discount Date")
                {
                }
                column(FirstLoop__Pmt__Disc__Given_____; "Pmt. Disc. Given (LCY)")
                {
                }
                column(Cust__Ledger_Entry___Closed_by_Amount_____; -"Cust. Ledger Entry"."Closed by Amount (LCY)")
                {
                }
                column(Cust__Ledger_Entry___Amount________TotalApplied_Control43; -"Cust. Ledger Entry"."Amount (LCY)" + TotalApplied)
                {
                }
                column(FirstLoop_Entry_No_; "Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalApplied := TotalApplied + "Cust. Ledger Entry"."Closed by Amount (LCY)";
                    "Pmt. Disc. Given (LCY)" := 0;
                end;
            }
            dataitem(SecondLoop; "Cust. Ledger Entry")
            {
                DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Closed by Entry No.");
                column(SecondLoop__Document_Type_; "Document Type")
                {
                }
                column(SecondLoop__Document_No__; "Document No.")
                {
                }
                column(SecondLoop__Due_Date_; "Due Date")
                {
                }
                column(SecondLoop__Pmt__Discount_Date_; "Pmt. Discount Date")
                {
                }
                column(SecondLoop__Pmt__Disc__Given_____; "Pmt. Disc. Given (LCY)")
                {
                }
                column(SecondLoop__Closed_by_Amount_____; "Closed by Amount (LCY)")
                {
                }
                column(Cust__Ledger_Entry___Amount________TotalApplied_Control50; -"Cust. Ledger Entry"."Amount (LCY)" + TotalApplied)
                {
                }
                column(SecondLoop_Entry_No_; "Entry No.")
                {
                }
                column(SecondLoop_Closed_by_Entry_No_; "Closed by Entry No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalApplied := TotalApplied - "Closed by Amount (LCY)";
                    TotalDiscounts := TotalDiscounts + "Pmt. Disc. Given (LCY)"
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
            }

            trigger OnAfterGetRecord()
            begin
                TotalApplied := 0;
                TotalDiscounts := 0;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals("Amount (LCY)",TotalApplied,TotalDiscounts); ICE-MPC 08/21/20
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
        CompanyInformation.Get('');
        FilterString := CopyStr("Cust. Ledger Entry".GetFilters, 1, MaxStrLen(FilterString));
    end;

    var
        FilterString: Text[250];
        TotalApplied: Decimal;
        TotalDiscounts: Decimal;
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        CustomerLedgerEntry2: Record "Cust. Ledger Entry";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        PaymentCaptionLbl: Label 'Payment';
        Applied_To_DocumentCaptionLbl: Label 'Applied-To Document';
        Discount_DateCaptionLbl: Label 'Discount Date';
        Discount_TakenCaptionLbl: Label 'Discount Taken';
        Amount_AppliedCaptionLbl: Label 'Amount Applied';
        Amount_Not_Yet_AppliedCaptionLbl: Label 'Amount Not Yet Applied';
        NumberCaptionLbl: Label 'Number';
        TypeCaptionLbl: Label 'Type';
        NumberCaption_Control19Lbl: Label 'Number';
        Due_DateCaptionLbl: Label 'Due Date';
        Amount_____CaptionLbl: Label 'Payment Amount';
        Customer_CaptionLbl: Label 'Customer:';
        Report_TotalsCaptionLbl: Label 'Report Totals';
}

