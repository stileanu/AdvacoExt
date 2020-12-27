report 50055 "Outstanding Blanket Orders"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50055_Outstanding Blanket Orders.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Buy-from Vendor No.", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = CONST("Blanket Order"), "Outstanding Quantity" = FILTER(<> 0));
            RequestFilterFields = "Buy-from Vendor No.";
            column(by_Vendor__; '(by Vendor)')
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Blanket_Order_Status_; 'Blanket Order Status')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
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
            column(Purchase_Line_Quantity; Quantity)
            {
            }
            column(Purchase_Line__Outstanding_Quantity_; "Outstanding Quantity")
            {
            }
            column(Purchase_Line__Unit_Cost_; "Unit Cost")
            {
            }
            column(OutstandExclInvDisc; OutstandExclInvDisc)
            {
            }
            column(Header__Buy_from_Vendor_No__; Header."Buy-from Vendor No.")
            {
            }
            column(Header__No__; Header."No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(OrderedCaption; OrderedCaptionLbl)
            {
            }
            column(Qty_RemainingCaption; Qty_RemainingCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(Remaining_AmountCaption; Remaining_AmountCaptionLbl)
            {
            }
            column(Purchase_Line_Document_Type; "Document Type")
            {
            }
            column(Purchase_Line_Document_No_; "Document No.")
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
                if "Outstanding Amount" = 0 then
                    "OutstandingExclTax$" := 0
                else
                    "OutstandingExclTax$" := Round(OutstandingExclTax * "Outstanding Amount (LCY)" / "Outstanding Amount");
                "OutstandExclInvDisc$" := Round("Outstanding Quantity" * "Unit Cost (LCY)");
                OutstandExclInvDisc := Round("Outstanding Quantity" * "Unit Cost");

                Header.Get("Document Type", "Document No.");
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(OutstandExclInvDisc,OutstandingExclTax,
                //"OutstandExclInvDisc$","OutstandingExclTax$"); ICE-MPC 08/25/20
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
        PeriodText := "Purchase Line".GetFilter("Expected Receipt Date");
        CompanyInformation.Get('');
    end;

    var
        FilterString: Text[250];
        PeriodText: Text[100];
        OutstandExclInvDisc: Decimal;
        "OutstandExclInvDisc$": Decimal;
        OutstandingExclTax: Decimal;
        "OutstandingExclTax$": Decimal;
        BackOrderQuantity: Decimal;
        LocalUnitCost: Decimal;
        CompanyInformation: Record "Company Information";
        Header: Record "Purchase Header";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Order_No_CaptionLbl: Label 'Order No.';
        ItemCaptionLbl: Label 'Item';
        VendorCaptionLbl: Label 'Vendor';
        DescriptionCaptionLbl: Label 'Description';
        OrderedCaptionLbl: Label 'Ordered';
        Qty_RemainingCaptionLbl: Label 'Qty Remaining';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        Remaining_AmountCaptionLbl: Label 'Remaining Amount';
}

