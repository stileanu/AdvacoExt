report 50054 "PO Received not Invoiced"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50054_PO Received not Invoiced.rdl';
    caption = 'PO Received not Invoiced';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            ;
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Purchase_Orders_Received_but_no_Invoiced_; 'Purchase Orders Received but no Invoiced')
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
            column(by_Purchase_Order_Number__; '(by Purchase Order Number)')
            {
            }
            column(Purchase_Header__No__; "No.")
            {
            }
            column(Purchase_Header__Order_Date_; "Order Date")
            {
            }
            column(Purchase_Header__Buy_from_Vendor_No__; "Buy-from Vendor No.")
            {
            }
            column(CurrencyCodeToPrint; CurrencyCodeToPrint)
            {
            }
            column(Total; Total)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Purchase_Header__No__Caption; Purchase_Header__No__CaptionLbl)
            {
            }
            column(Amount_Not_InvoicedCaption; Amount_Not_InvoicedCaptionLbl)
            {
            }
            column(Purchase_Line_TypeCaption; Purchase_Line_TypeCaptionLbl)
            {
            }
            column(Purchase_Line__No__Caption; Purchase_Line__No__CaptionLbl)
            {
            }
            column(Purchase_Line_DescriptionCaption; "Purchase Line".FieldCaption(Description))
            {
            }
            column(Purchase_Line_QuantityCaption; Purchase_Line_QuantityCaptionLbl)
            {
            }
            column(ReceivedCaption; ReceivedCaptionLbl)
            {
            }
            column(Purchase_Line__Unit_Cost_Caption; "Purchase Line".FieldCaption("Unit Cost"))
            {
            }
            column(InvoicedCaption; InvoicedCaptionLbl)
            {
            }
            column(Not_InvoicedCaption; Not_InvoicedCaptionLbl)
            {
            }
            column(Order_Date_Caption; Order_Date_CaptionLbl)
            {
            }
            column(Vendor_Caption; Vendor_CaptionLbl)
            {
            }
            column(Report_Total____Caption; Report_Total____CaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
                column(ItemTotal; ItemTotal)
                {
                }
                column(Purchase_Line_Type; Type)
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
                column(Purchase_Line__Unit_Cost_; "Unit Cost")
                {
                }
                column(Purchase_Line__Qty__Received__Base__; "Qty. Received (Base)")
                {
                }
                column(Purchase_Line__Quantity_Invoiced_; "Quantity Invoiced")
                {
                }
                column(Purchase_Line__Qty__Rcd__Not_Invoiced_; "Qty. Rcd. Not Invoiced")
                {
                }
                column(Purchase_Line__Amt__Rcd__Not_Invoiced_; "Amt. Rcd. Not Invoiced")
                {
                }
                column(ItemTotal_Control44; ItemTotal)
                {
                }
                column(Purchase_Order______Purchase_Header___No_______Total_; 'Purchase Order ' + "Purchase Header"."No." + ' Total')
                {
                }
                column(ItemTotal_Control49; ItemTotal)
                {
                }
                column(CurrencyCodeToPrint_Control1; CurrencyCodeToPrint)
                {
                }
                column(Balance_ForwardCaption; Balance_ForwardCaptionLbl)
                {
                }
                column(Balance_to_Carry_ForwardCaption; Balance_to_Carry_ForwardCaptionLbl)
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
                    if "Purchase Line"."Amt. Rcd. Not Invoiced" > 0 then begin
                        ItemTotal := "Purchase Line"."Amt. Rcd. Not Invoiced";
                        Total := ItemTotal;
                    end else begin
                        CurrReport.Skip;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CreateTotals(ItemTotal);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Currency Code" <> '' then
                    CurrencyCodeToPrint := 'Currency: ' + "Currency Code"
                else
                    CurrencyCodeToPrint := '';
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Total);
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
        FilterString: Text[250];
        PeriodText: Text[100];
        CurrencyCodeToPrint: Text[20];
        OutstandExclInvDisc: Decimal;
        "OutstandExclInvDisc$": Decimal;
        OutstandingExclTax: Decimal;
        "OutstandingExclTax$": Decimal;
        BackOrderQuantity: Decimal;
        LocalUnitCost: Decimal;
        CompanyInformation: Record "Company Information";
        ItemTotal: Decimal;
        Total: Decimal;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Purchase_Header__No__CaptionLbl: Label 'P.O. Number';
        Amount_Not_InvoicedCaptionLbl: Label 'Amount Not Invoiced';
        Purchase_Line_TypeCaptionLbl: Label 'Item Type';
        Purchase_Line__No__CaptionLbl: Label 'Item';
        Purchase_Line_QuantityCaptionLbl: Label 'Ordered';
        ReceivedCaptionLbl: Label 'Received';
        InvoicedCaptionLbl: Label 'Invoiced';
        Not_InvoicedCaptionLbl: Label 'Not Invoiced';
        Order_Date_CaptionLbl: Label 'Order Date:';
        Vendor_CaptionLbl: Label 'Vendor:';
        Report_Total____CaptionLbl: Label 'Report Total ($)';
        Balance_ForwardCaptionLbl: Label 'Balance Forward';
        Balance_to_Carry_ForwardCaptionLbl: Label 'Balance to Carry Forward';
}

