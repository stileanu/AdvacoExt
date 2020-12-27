report 50050 "Outstanding PO  by SO/WO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50050_OutstandingPObySOWO.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Outstanding PO by SO/WO';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Work Order No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order), "Outstanding Quantity" = FILTER(<> 0), "Order No." = FILTER(<> ''));
            RequestFilterFields = "Document No.", "Order No.";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Outstanding_Purchase_Order_By_WO___SO_; 'Outstanding Purchase Order By WO / SO')
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

            column(Purchase_Line__Expected_Receipt_Date_; "Expected Receipt Date")
            {
            }
            column(Purchase_Line__No__; "No.")
            {
            }
            column(Purchase_Line_Description; Description)
            {
            }
            column(Purchase_Line_Quantity; Quantity)
            {
            }
            column(Purchase_Line__Outstanding_Quantity_; "Outstanding Quantity")
            {
            }
            column(Cross_Reference_No_; "Cross-Reference No.")
            {

            }
            column(Purchase_Line__Order_No__; "Order No.")
            {
            }
            column(Purchase_Line__Document_No__; "Document No.")
            {
            }
            column(Purchase_Line__Buy_from_Vendor_No__; "Buy-from Vendor No.")
            {
            }
            column(Model; Model)
            {
            }
            column(WO___SOCaption; WO___SOCaptionLbl)
            {
            }
            column(PO_No_Caption; PO_No_CaptionLbl)
            {
            }
            column(ExpectedCaption; ExpectedCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Ord_Caption; Ord_CaptionLbl)
            {
            }
            column(Rem_Caption; Rem_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(ModelCaption; ModelCaptionLbl)
            {
            }
            column(Purchase_Line_Document_Type; "Document Type")
            {
            }
            column(Purchase_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Expected Receipt Date" <= WorkDate then
                    BackOrderQuantity := "Outstanding Quantity"
                else
                    BackOrderQuantity := 0;
                OutstandingExclTax := Round("Outstanding Quantity" * Amount / Quantity);
                OutstandExclInvDisc := Round("Outstanding Quantity" * "Unit Cost");

                if "Currency Code" = '' then begin
                    "OutstandingExclTax$" := OutstandingExclTax;
                    "OutstandExclInvDisc$" := OutstandExclInvDisc;
                    "UnitCost($)" := "Unit Cost";
                end else begin
                    "OutstandingExclTax$" :=
                      Round(
                        CurrencyExchRate.ExchangeAmtFCYToFCY(
                          WorkDate,
                          "Currency Code",
                          '',
                          OutstandingExclTax));
                    "OutstandExclInvDisc$" :=
                      Round(
                        CurrencyExchRate.ExchangeAmtFCYToFCY(
                          WorkDate,
                          "Currency Code",
                          '',
                          OutstandExclInvDisc));
                    "UnitCost($)" :=
                      Round(
                        CurrencyExchRate.ExchangeAmtFCYToFCY(
                          WorkDate,
                          "Currency Code",
                          '',
                          "Unit Cost"),
                        0.00001);
                end;

                if PrintAmountsInLocal then begin
                    OutstandingExclTax := "OutstandingExclTax$";
                    OutstandExclInvDisc := "OutstandExclInvDisc$";
                    "Unit Cost" := "UnitCost($)";
                end else begin
                    OutstandingExclTax := "OutstandingExclTax$";
                    OutstandExclInvDisc := "OutstandExclInvDisc$";
                    "Unit Cost" := "UnitCost($)";
                end;

                //HEF Insert
                Model := '';

                WOD.SetRange(WOD."Work Order No.", "Purchase Line"."Order No.");
                if WOD.Find('-') then
                    Model := WOD."Model No.";
            end;

            trigger OnPreDataItem()
            begin

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
        PeriodText := "Purchase Line".GetFilter("Expected Receipt Date");
    end;

    var
        PurchaseHeader: Record "Purchase Header";
        Currency: Record Currency;
        CurrencyExchRate: Record "Currency Exchange Rate";
        FilterString: Text[250];
        PeriodText: Text[100];
        CurrencyCodeToPrint: Text[20];
        OutstandExclInvDisc: Decimal;
        "OutstandExclInvDisc$": Decimal;
        OutstandingExclTax: Decimal;
        "OutstandingExclTax$": Decimal;
        BackOrderQuantity: Decimal;
        "UnitCost($)": Decimal;
        PrintAmountsInLocal: Boolean;
        OnlyOnePerPage: Boolean;
        CompanyInformation: Record "Company Information";
        Header: Record "Purchase Header";
        Model: Code[20];
        WOD: Record "WorkOrderDetail";
        WO___SOCaptionLbl: Label 'WO / SO';
        PO_No_CaptionLbl: Label 'PO No.';
        ExpectedCaptionLbl: Label 'Expected';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Ord_CaptionLbl: Label 'Ord.';
        Rem_CaptionLbl: Label 'Rem.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        VendorCaptionLbl: Label 'Vendor';
        ModelCaptionLbl: Label 'Model';
}

