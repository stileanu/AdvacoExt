report 50126 "Outstanding EFT Purch.Invoices"
{
    // 01/02/13 ADV
    //   New Report
    // 08/13/13 ADV
    //   Modified the field (Use "Remaining Amount" field).
    //   Eliminated detail lines.
    //   Original report stored as report 50187.
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50126_OutstandingEFTPurchInvoices.rdl';
    caption = 'Outstanding EFT Purch. Invoices';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Priority;
            column(Outstanding_Purchase_Invoices_; 'Outstanding Purchase Invoices')
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
            column(Vendor_TABLENAME__________FilterString; Vendor.TableName + ': ' + FilterString)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__Phone_No__; "Phone No.")
            {
            }
            column(Vendor_Contact; Contact)
            {
            }
            column(RI; RI)
            {
            }
            column(ABS_RemainingAmount_; Abs(RemainingAmount))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(Inv__NumberCaption; Inv__NumberCaptionLbl)
            {
            }
            column(Vendor_Ledger_Entry__Posting_Date_Caption; "Vendor Ledger Entry".FieldCaption("Posting Date"))
            {
            }
            column(Vendor_Ledger_Entry_DescriptionCaption; "Vendor Ledger Entry".FieldCaption(Description))
            {
            }
            column(ABS__Remaining_Amount__Caption; ABS__Remaining_Amount__CaptionLbl)
            {
            }
            column(Phone_Caption; Phone_CaptionLbl)
            {
            }
            column(Contact_Caption; Contact_CaptionLbl)
            {
            }
            column(Report_Total_____Caption; Report_Total_____CaptionLbl)
            {
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code") WHERE(Open = CONST(true), "Document Type" = FILTER(Invoice | "Credit Memo"));
                //RequestFilterFields = '';
                column(PurchaseInvHeader__Vendor_Invoice_No__; PurchaseInvHeader."Vendor Invoice No.")
                {
                }
                column(Vendor_Ledger_Entry__Posting_Date_; "Posting Date")
                {
                }
                column(Vendor_Ledger_Entry_Description; Description)
                {
                }
                column(ABS__Remaining_Amount__; Abs("Remaining Amount"))
                {
                }
                column(ABS__Remaining_Amount___Control1000000016; Abs("Remaining Amount"))
                {
                }
                column(Vendor_Remaining_AmountCaption; Vendor_Remaining_AmountCaptionLbl)
                {
                }
                column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                {
                }
                column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CalcFields("Remaining Amount");
                    RemainingAmount += "Remaining Amount";
                    if PurchaseInvHeader.Get("Document No.") then;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals("Remaining Amount"); ICE-MPC 08/21/20
                end;
            }

            trigger OnPreDataItem()
            begin
                //CurrReport.NewPagePerRecord := OnlyOnePerPage;  ICE-MPC 08/21/20
                if Vendor.GetFilter("Payment Terms Code") = '' then begin
                    Vendor.SetRange("Payment Method Code", 'EFT');
                    FilterString := CopyStr(Vendor.GetFilters, 1, MaxStrLen(FilterString));
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
                    field(OnlyOnePerPage; OnlyOnePerPage)
                    {
                        Caption = 'New Page per Vendor';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            Vendor.SetRange("Payment Method Code", 'EFT');
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompanyInformation.Get('');
        FilterString := CopyStr(Vendor.GetFilters, 1, MaxStrLen(FilterString));
        RemainingAmount := 0;
    end;

    var
        PurchaseInvHeader: Record "Purch. Inv. Header";
        FilterString: Text[250];
        PeriodText: Text[100];
        RemainingAmount: Decimal;
        OnlyOnePerPage: Boolean;
        CompanyInformation: Record "Company Information";
        RI: Code[30];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        VendorCaptionLbl: Label 'Vendor';
        Inv__NumberCaptionLbl: Label 'Inv. Number';
        ABS__Remaining_Amount__CaptionLbl: Label 'Remaining Amount';
        Phone_CaptionLbl: Label 'Phone:';
        Contact_CaptionLbl: Label 'Contact:';
        Report_Total_____CaptionLbl: Label 'Report Total ($) ';
        Vendor_Remaining_AmountCaptionLbl: Label 'Vendor Remaining Amount';
}

