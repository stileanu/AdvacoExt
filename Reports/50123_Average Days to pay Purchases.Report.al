report 50123 "Average Days to pay Purchases"
{
    // 2012-12-06 ADV
    //   New Report
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50123_Average Days to pay Purchases.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(VendorLedgerEntry; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code") WHERE(Open = FILTER(false), "Document Type" = FILTER(Invoice));
            RequestFilterFields = "Vendor No.", "Document No.", "Posting Date", "Closed at Date";
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
            column(VendorLedgerEntry__Document_No__; "Document No.")
            {
            }
            column(DescriptionToPrint; DescriptionToPrint)
            {
            }
            column(VendorLedgerEntry__Posting_Date_; "Posting Date")
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
            column(ABS_Amount__Control1000000016; Abs(Amount))
            {
            }
            column(Purchases___Average_days_to_payCaption; Purchases___Average_days_to_payCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(VendorLedgerEntry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(DescriptionToPrintCaption; DescriptionToPrintCaptionLbl)
            {
            }
            column(VendorLedgerEntry__Posting_Date_Caption; FieldCaption("Posting Date"))
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
            column(VendorLedgerEntry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Amount = 0 then
                    exit;
                NoOfDaysToClose := 0;
                if "Closed at Date" <> 0D then begin
                    NoOfDaysToClose := "Closed at Date" - "Posting Date";
                    CloseByDate := "Closed at Date";
                end else begin
                    // Look for a Payment closed by Invoice
                    CloseByDate := 0D;
                    VendLedgerEntryByDate.Reset;
                    VendLedgerEntryByDate.SetCurrentKey("Closed by Entry No.");
                    VendLedgerEntryByDate.SetRange("Closed by Entry No.", "Entry No.");
                    if VendLedgerEntryByDate.FindFirst then
                        repeat
                            if CloseByDate <= VendLedgerEntryByDate."Closed at Date" then
                                CloseByDate := VendLedgerEntryByDate."Closed at Date";
                        until VendLedgerEntryByDate.Next = 0;
                    NoOfDaysToClose := CloseByDate - "Posting Date"
                end;
                NoOfDocs += 1;
                if NoOfDaysToClose <= 0 then begin
                    NoOfDaysToClose := 0;
                    NoOfDocs -= 1;
                end;
                DescriptionToPrint := Description + ' - Ext.Doc # ' + "External Document No.";
                TotalNoOfDaysToClose += NoOfDaysToClose;
                SerialNo += 1;
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
        if VendorLedgerEntry.GetFilter("Vendor No.") = '' then
            Error(ADVMsg01);
        if (VendorLedgerEntry.GetFilter("Posting Date") = '') and
           (VendorLedgerEntry.GetFilter("Closed at Date") = '') then
            Error(ADVMsg02);

        FilterString := VendorLedgerEntry.GetFilters;
    end;

    var
        ADVMsg01: Label 'Vendor Code missing. This report should be run for a specific Vendor.';
        ADVMsg02: Label 'You need to enter a time interval for <Posting Date> or <Closed at Date> fields. This report should be run for a timeframe.';
        VendLedgerEntryByDate: Record "Vendor Ledger Entry";
        NoOfDaysToClose: Integer;
        TotalNoOfDaysToClose: Integer;
        AverageDaysToPay: Decimal;
        NoOfDocs: Integer;
        DocsToExclude: Text[250];
        FilterString: Text[127];
        SerialNo: Integer;
        CloseByDate: Date;
        DescriptionToPrint: Text[127];
        Purchases___Average_days_to_payCaptionLbl: Label 'Purchases - Average days to pay';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        DescriptionToPrintCaptionLbl: Label 'Description';
        CloseByDateCaptionLbl: Label 'Closed at date';
        AmountCaptionLbl: Label 'Amount';
        No_of_DaysCaptionLbl: Label 'No of Days';
        No_CaptionLbl: Label 'No.';
        Average_No_of_Days_to_closeCaptionLbl: Label 'Average No of Days to close';
}

