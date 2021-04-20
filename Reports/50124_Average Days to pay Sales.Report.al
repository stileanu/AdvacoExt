report 50124 "Average Days to pay Sales"
{
    // 2012-12-06 ADV
    //   New Report
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50124_Average Days to pay Sales.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date", "Currency Code") WHERE("Document Type" = FILTER(Invoice), Open = FILTER(false));
            RequestFilterFields = "Customer No.", "Document No.", "Posting Date", "Closed at Date";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(CustLedgerEntry__Document_No__; "Document No.")
            {
            }
            column(DescriptionToPrint; DescriptionToPrint)
            {
            }
            column(CustLedgerEntry__Posting_Date_; "Posting Date")
            {
            }
            column(CloseByDate; CloseByDate)
            {
            }
            column(ABS_Amount_; Abs(Amount))
            {
            }
            column(NoOfDaysToClose; NoOfDaysToClose)
            {
            }
            column(SerialNo; SerialNo)
            {
            }
            column(AverageDaysToPay; AverageDaysToPay)
            {
            }
            column(CustLedgerEntry_Amount; Amount)
            {
            }
            column(Sales___Average_days_to_payCaption; Sales___Average_days_to_payCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CustLedgerEntry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(DescriptionToPrintCaption; DescriptionToPrintCaptionLbl)
            {
            }
            column(CustLedgerEntry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(CloseByDateCaption; CloseByDateCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(No_of_DaysCaption; No_of_DaysCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Average_No_of_Days_to_closeCaption; Average_No_of_Days_to_closeCaptionLbl)
            {
            }
            column(CustLedgerEntry_Entry_No_; "Entry No.")
            {
            }
            column(BlankLine; BlankLine)
            {
            }

            trigger OnAfterGetRecord()
            var
                CustName: Record Customer;
                InvHeader: Record "Sales Invoice Header";

            begin
                BlankLine := false;
                CalcFields(Amount);
                if Amount = 0 then exit;
                NoOfDaysToClose := 0;
                if "Closed at Date" <> 0D then begin
                    NoOfDaysToClose := "Closed at Date" - "Posting Date";
                    CloseByDate := "Closed at Date";
                end else begin
                    // Look for a Payment closed by Invoice
                    CloseByDate := 0D;
                    CustLedgEntryCloseDoc.Reset;
                    CustLedgEntryCloseDoc.SetCurrentKey("Closed by Entry No.");
                    CustLedgEntryCloseDoc.SetRange("Closed by Entry No.", "Entry No.");
                    if CustLedgEntryCloseDoc.FindFirst then
                        repeat
                            if CloseByDate <= CustLedgEntryCloseDoc."Closed at Date" then
                                CloseByDate := CustLedgEntryCloseDoc."Closed at Date";
                        until CustLedgEntryCloseDoc.Next = 0;
                    NoOfDaysToClose := CloseByDate - "Posting Date"
                end;
                NoOfDocs += 1;
                if NoOfDaysToClose <= 0 then begin
                    NoOfDaysToClose := 0;
                    NoOfDocs -= 1;
                end;

                //CalcFields("Customer Name", "Work Order No.");  //ICE RSK 1/18/21
                CalcFields("Work Order No.");
                // ICE SII 4/13/21 start
                DescriptionToPrint := '';
                if CustName.Get("Customer No.") then
                    DescriptionToPrint := CustName.Name;
                DescriptionToPrint += ' WO - ';
                if InvHeader.Get("Document No.") then
                    DescriptionToPrint += InvHeader."Order No.";
                //DescriptionToPrint := "Customer Name" + ' WO - ' + "Work Order No.";
                // ICE SII 4/13/21 end
                TotalNoOfDaysToClose += NoOfDaysToClose;
                SerialNo += 1;
                if (((SerialNo - 1) MOD 5) = 0) AND (SerialNo <> 1) then
                    BlankLine := true;
                IF NoOfDocs <> 0 THEN
                    AverageDaysToPay := TotalNoOfDaysToClose / NoOfDocs
                ELSE
                    AverageDaysToPay := 0;
            end;

            trigger OnPreDataItem()
            begin
                TotalNoOfDaysToClose := 0;
                NoOfDocs := 0;
                SerialNo := 0;
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
        if CustLedgerEntry.GetFilter("Customer No.") = '' then
            Error(ADVMsg01);
        if (CustLedgerEntry.GetFilter("Posting Date") = '') and
           (CustLedgerEntry.GetFilter("Closed at Date") = '') then
            Error(ADVMsg02);

        FilterString := CustLedgerEntry.GetFilters;
    end;

    var
        CustLedgEntryCloseDoc: Record "Cust. Ledger Entry";
        NoOfDaysToClose: Integer;
        TotalNoOfDaysToClose: Integer;
        AverageDaysToPay: Decimal;
        NoOfDocs: Integer;
        DocsToExclude: Text[250];
        FilterString: Text[127];
        SerialNo: Integer;
        ADVMsg01: Label 'Customer Code missing. This report should be run for a specific Customer.';
        ADVMsg02: Label 'You need to enter a time interval for <Posting Date> or <Closed at Date> fields. This report should be run for a timeframe.';
        CloseByDate: Date;
        DescriptionToPrint: Text[127];
        Sales___Average_days_to_payCaptionLbl: Label 'Sales - Average days to pay';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DescriptionToPrintCaptionLbl: Label 'Description';
        CloseByDateCaptionLbl: Label 'Close at date';
        AmountCaptionLbl: Label 'Amount';
        No_of_DaysCaptionLbl: Label 'No of Days';
        No_CaptionLbl: Label 'No.';
        Average_No_of_Days_to_closeCaptionLbl: Label 'Average No of Days to close';
        BlankLine: Boolean;
}

