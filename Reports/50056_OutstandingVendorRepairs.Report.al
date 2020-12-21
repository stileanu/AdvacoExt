report 50056 "Outstanding Vendor Repairs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50056_OutstandingVendorRepairs.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            //DataItemTableView = SORTING("Document Type","Order No.","Line No.") ORDER(Ascending) WHERE("Document Type"=CONST(Order),"Outstanding Quantity"=FILTER(<>0),"Order No."=FILTER(<>''));
            //ICE-MPC 08/25/20 Need to have Order No. added back to the key on the table before go-live
            DataItemTableView = SORTING("Document Type", "Line No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order), "Outstanding Quantity" = FILTER(<> 0), "Order No." = FILTER(<> ''));
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Outstanding_Vendor_Repairs_; 'Outstanding Vendor Repairs')
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
            column(Purchase_Line__No__; "No.")
            {
            }
            column(Purchase_Line_Description; Description)
            {
            }
            column(Purchase_Line__Outstanding_Quantity_; "Outstanding Quantity")
            {
            }
            column(Purchase_Line__Order_No__; "Order No.")
            {
            }
            column(Purchase_Line__Document_No__; "Document No.")
            {
            }
            column(Purchase_Line__Cross_Ref_Item; "Cross-Reference Type No.")
            {
            }
            column(rma; rma)
            {
            }
            column(WO___SOCaption; WO___SOCaptionLbl)
            {
            }
            column(PO_No_Caption; PO_No_CaptionLbl)
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
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(RMA_No_Caption; RMA_No_CaptionLbl)
            {
            }
            column(Purchase_Line_Document_Type; "Document Type")
            {
            }
            column(Purchase_Line_Line_No_; "Line No.")
            {
            }
            column(Vendor_Item_No__Caption; Vendor_Item_No__CaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if PurchaseHeader.Get("Document Type", "Document No.") then begin
                    if PurchaseHeader."Vendor Repair" then begin
                        if WOD.Get("Purchase Line"."Order No.") then
                            rma := WOD."RMA No."
                        else
                            rma := '';


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
                    end else
                        CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(OutstandExclInvDisc,OutstandingExclTax,
                // "OutstandExclInvDisc$","OutstandingExclTax$"); ICE-MPC 08/225/20
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
        WOD: Record WorkOrderDetail;
        rma: Text[30];
        OK: Boolean;
        WO___SOCaptionLbl: Label 'WO / SO';
        PO_No_CaptionLbl: Label 'PO No.';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        RMA_No_CaptionLbl: Label 'RMA No.';
        Vendor_Item_No__CaptionLbl: Label 'Vendor Item No';
}

