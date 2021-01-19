report 50180 "Invoice Statement PO Number"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50180_Invoice Statement PO Number.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Invoice));
            RequestFilterFields = "Customer No.", "Posting Date";
            column(CompanyAddress_5_; CompanyAddress[5])
            {
            }
            column(CompanyAddress_4_; CompanyAddress[4])
            {
            }
            column(CompanyAddress_3_; CompanyAddress[3])
            {
            }
            column(CompanyAddress_2_; CompanyAddress[2])
            {
            }
            column(CompanyAddress_1_; CompanyAddress[1])
            {
            }
            column(BillToAddress_1_; BillToAddress[1])
            {
            }
            column(BillToAddress_2_; BillToAddress[2])
            {
            }
            column(BillToAddress_3_; BillToAddress[3])
            {
            }
            column(BillToAddress_4_; BillToAddress[4])
            {
            }
            column(BillToAddress_5_; BillToAddress[5])
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(Cust__Ledger_Entry__Document_No__; "Document No.")
            {
            }
            column(Cust__Ledger_Entry__Amount_____; "Amount (LCY)")
            {
            }
            column(SalesHeader__Order_No__; SalesHeader."Order No.")
            {
            }
            column(SalesHeader__Your_Reference_; SalesHeader."Your Reference")
            {
            }
            column(Cust__Ledger_Entry__Amount______Control24; "Amount (LCY)")
            {
            }
            column(Invoices_Total__; 'Invoices Total:')
            {
            }
            column(Cust__Ledger_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(INVOICES_STATEMENTCaption; INVOICES_STATEMENTCaptionLbl)
            {
            }
            column(Purchase_Order_No_Caption; Purchase_Order_No_CaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                Model := '';
                Desc := '';
                SerialNo := '';

                if Customer.Get("Customer No.") then
                    FormatAddress.Customer(BillToAddress, Customer);


                if SalesHeader.Get("Document No.") then begin
                    SalesLine.SetRange("Document No.", SalesHeader."No.");
                    if SalesHeader."Shortcut Dimension 2 Code" = 'WO' then begin
                        if SalesLine.Find('-') then begin
                            repeat
                                //      IF SalesLine."Cross Reference Item" <> '' THEN
                                //        Model := SalesLine."Cross Reference Item";
                                Desc := CopyStr(SalesLine.Description, 1, 3);
                                if Desc = 'S/N' then
                                    SerialNo := CopyStr(SalesLine.Description, 4, 30);
                            until SalesLine.Next = 0;
                        end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get('');
                FormatAddress.Company(CompanyAddress, CompanyInformation);
                //CurrReport.CreateTotals("Amount (LCY)"); ICE-MPC 09/09/20

                StartDate := "Cust. Ledger Entry".GetRangeMin("Posting Date");
                EndDate := "Cust. Ledger Entry".GetRangeMax("Posting Date");
                PeriodText := 'For the Period from ' + Format(StartDate, 0, 1) + ' to ' + Format(EndDate, 0, 1);
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
        Customer: Record Customer;
        OK: Boolean;
        CompanyInformation: Record "Company Information";
        FormatAddress: Codeunit "Format Address";
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        SalesHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Invoice Line";
        Model: Code[20];
        SerialNo: Code[30];
        Desc: Code[10];
        StartDate: Date;
        EndDate: Date;
        PeriodText: Text[250];
        AmountCaptionLbl: Label 'Amount';
        Order_No_CaptionLbl: Label 'Order No.';
        INVOICES_STATEMENTCaptionLbl: Label 'INVOICES STATEMENT';
        Purchase_Order_No_CaptionLbl: Label 'Purchase Order No.';
}

