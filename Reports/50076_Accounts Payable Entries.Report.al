report 50076 "Accounts Payable Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50076_Accounts Payable Entries.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Vendor No.", "Document Type") ORDER(Ascending);
            RequestFilterFields = "Document Type", "Posting Date", "Vendor No.", "On Hold";
            column(Subtitle; Subtitle)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {

            }
            column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
            {
            }
            column(Vendor_Ledger_Entry__Vendor_No__; "Vendor No.")
            {
            }
            column(Vendor_Ledger_Entry_Description; Description)
            {
            }
            column(Vendor_Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Vendor_Ledger_Entry__Original_Amt______; "Original Amt. (LCY)")
            {
            }
            column(Reference; Reference)
            {
            }
            column(Vendor_Ledger_Entry__Original_Amt_______Control41; "Original Amt. (LCY)")
            {
            }
            column(External_No_Caption; External_No_CaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Vendor_No__Caption; FieldCaption("Vendor No."))
            {
            }
            column(Vendor_Ledger_Entry_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Vendor_Ledger_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ReferenceCaption; ReferenceCaptionLbl)
            {
            }
            column(Vendor_Total_Amount_DueCaption; Vendor_Total_Amount_DueCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Reference := '';
                VPI.SetRange(VPI."Vendor Invoice No.", "Vendor Ledger Entry"."External Document No.");
                if VPI.Find('-') then begin
                    Reference := VPI."Order No.";
                end;

                if Reference = '' then begin
                    if VPI.Get("Vendor Ledger Entry"."Applies-to Doc. No.") then
                        Reference := VPI."Vendor Invoice No.";
                end;
                //if "Vendor Ledger Entry"."Document Type" = 1 then // PAYMENT  ICE-MPC 08/18/20
                if "Vendor Ledger Entry"."Document Type".AsInteger() = 1 then // PAYMENT
                    Reference := '';
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals("Original Amt. (LCY)");  ICE-MPC 08/18/20
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
    end;

    var
        Subtitle: Text[126];
        CompanyInformation: Record "Company Information";
        VPI: Record "Purch. Inv. Header";
        Reference: Code[20];
        APFilter: Code[20];
        External_No_CaptionLbl: Label 'External No.';
        DateCaptionLbl: Label 'Date';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
        ReferenceCaptionLbl: Label 'Reference';
        Vendor_Total_Amount_DueCaptionLbl: Label 'Vendor Total Amount Due';
}

