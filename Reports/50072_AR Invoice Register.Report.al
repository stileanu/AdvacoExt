report 50072 "A/R Invoice Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50072_AR Invoice Register.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date") ORDER(Ascending) WHERE("G/L Account No." = CONST('116'), "Document Type" = CONST(Invoice));
            RequestFilterFields = "Posting Date", "Global Dimension 2 Code";
            column(Accounts_Receivable_Invoice_Register_; 'Accounts Receivable Invoice Register')
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
            column(G_L_Entry__TABLENAME__________GLEntryFilter; "G/L Entry".TableName + ': ' + GLEntryFilter)
            {
            }
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(Debits; Debits)
            {
            }
            column(Customer; Customer)
            {
            }
            column(WO; WO)
            {
            }
            column(Freight; Freight)
            {
            }
            column(Total_of_____FORMAT_Entries______entries_for_Accounts_Receivables_; 'Total of ' + Format(Entries) + ' entries for Accounts Receivables')
            {
            }
            column(Debits_Control23; Debits)
            {
            }
            column(Freight_Control14; Freight)
            {
            }
            column(Total_of_____FORMAT_Entries______entries_; 'Total of ' + Format(Entries) + ' entries')
            {
            }
            column(Debits_Control26; Debits)
            {
            }
            column(Freight_Control15; Freight)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Entry__Posting_Date_Caption; FieldCaption("Posting Date"))
            {
            }
            column(G_L_Entry__Document_No__Caption; FieldCaption("Document No."))
            {
            }
            column(Invoice_TotalCaption; Invoice_TotalCaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(Work_OrderCaption; Work_OrderCaptionLbl)
            {
            }
            column(Freight___HandlingCaption; Freight___HandlingCaptionLbl)
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Customer := '';
                WO := '';
                Freight := 0;



                SalesHeader.SetRange(SalesHeader."No.", "Document No.");
                if SalesHeader.Find('-') then begin
                    Customer := SalesHeader."Sell-to Customer No.";
                    WO := SalesHeader."Order No.";
                    if WO = '' then
                        WO := SalesHeader."Pre-Assigned No.";
                    SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
                    SalesLine.SetFilter(SalesLine."No.", '311');
                    if SalesLine.Find('-') then begin
                        repeat
                            Freight := Freight + SalesLine.Amount;
                        until SalesLine.Next = 0;
                    end;
                    SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
                    SalesLine.SetFilter(SalesLine."No.", '312');
                    if SalesLine.Find('-') then begin
                        repeat
                            Freight := Freight + SalesLine.Amount;
                        until SalesLine.Next = 0;
                    end;
                end;

                Debits := Amount;
                Entries := 1;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Debits,Entries,Freight); ICE-MPC 09/01/20
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
        GLEntryFilter := "G/L Entry".GetFilters;
    end;

    var
        CompanyInformation: Record "Company Information";
        GLAccount: Record "G/L Account";
        SalesHeader: Record "Sales Invoice Header";
        SalesLine: Record "Sales Invoice Line";
        Customer: Code[20];
        WO: Code[20];
        Freight: Decimal;
        GLEntryFilter: Text[250];
        Debits: Decimal;
        Credits: Decimal;
        Entries: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Invoice_TotalCaptionLbl: Label 'Invoice Total';
        CustomerCaptionLbl: Label 'Customer';
        Work_OrderCaptionLbl: Label 'Work Order';
        Freight___HandlingCaptionLbl: Label 'Freight / Handling';
}

