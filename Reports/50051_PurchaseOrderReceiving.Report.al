report 50051 "Purchase Order Receiving Rpt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50051_PurchaseOrderReceiving.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "Posting Date", "Document Date", "Order No.";
            RequestFilterHeading = 'Purchase Receipt';
            column(USERID; UserId)
            {

            }
            column(TIME; Time)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Purchase_Order_Receiving_Report_; 'Purchase Order Receiving Report')
            {
            }
            column(Purch__Rcpt__Header__Purch__Rcpt__Header___No__; "Purch. Rcpt. Header"."No.")
            {
            }
            column(Purch__Rcpt__Header__Purch__Rcpt__Header___Posting_Date_; "Purch. Rcpt. Header"."Posting Date")
            {
            }
            column(Purch__Rcpt__Header__Purch__Rcpt__Header___Buy_from_Vendor_No__; "Purch. Rcpt. Header"."Buy-from Vendor No.")
            {
            }
            column(Purch__Rcpt__Header__Purch__Rcpt__Header___Order_No__; "Purch. Rcpt. Header"."Order No.")
            {
            }
            column(Receipt_No_Caption; Receipt_No_CaptionLbl)
            {
            }
            column(Receipt_DateCaption; Receipt_DateCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vendor_IDCaption; Vendor_IDCaptionLbl)
            {
            }
            column(P_O__NumberCaption; P_O__NumberCaptionLbl)
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purch. Rcpt. Header";
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(ItemNumberToPrint; ItemNumberToPrint)
                {
                }
                column(Purch__Rcpt__Line_Quantity; Quantity)
                {
                }
                column(OrderedQuantity; OrderedQuantity)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(BackOrderedQuantity; BackOrderedQuantity)
                {
                    DecimalPlaces = 0 : 5;
                }
                column(Purch__Rcpt__Line_Description; Description)
                {
                }
                column(Item_No_Caption; Item_No_CaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(ReceivedCaption; ReceivedCaptionLbl)
                {
                }
                column(OrderedCaption; OrderedCaptionLbl)
                {
                }
                column(Back_OrderedCaption; Back_OrderedCaptionLbl)
                {
                }
                column(Purch__Rcpt__Line_Document_No_; "Document No.")
                {
                }
                column(Purch__Rcpt__Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    OnLineNumber := OnLineNumber + 1;

                    OrderedQuantity := 0;
                    BackOrderedQuantity := 0;
                    if "Order No." = '' then
                        OrderedQuantity := Quantity
                    else begin
                        if OrderLine.Get(1, "Order No.", "Line No.") then begin
                            OrderedQuantity := OrderLine.Quantity;
                            BackOrderedQuantity := OrderLine."Outstanding Quantity";
                        end else begin
                            ReceiptLine.SetCurrentKey("Order No.", "Order Line No.");
                            ReceiptLine.SetRange("Order No.", "Order No.");
                            ReceiptLine.SetRange("Order Line No.", "Line No.");
                            ReceiptLine.Find('-');
                            repeat
                                OrderedQuantity := OrderedQuantity + ReceiptLine.Quantity;
                            until 0 = ReceiptLine.Next;
                        end;
                    end;

                    //if Type = 0 then begin ICE-MPC 09/02/20
                    if Type.AsInteger() = 0 then begin
                        ItemNumberToPrint := '';
                        "Unit of Measure" := '';
                        OrderedQuantity := 0;
                        BackOrderedQuantity := 0;
                        Quantity := 0;
                    end else
                        if Type = Type::"G/L Account" then
                            ItemNumberToPrint := "Vendor Item No."
                        else
                            ItemNumberToPrint := "No.";

                    if Quantity = 0 then
                        CurrReport.Skip;
                end;

                trigger OnPreDataItem()
                begin
                    NumberOfLines := Count;
                    OnLineNumber := 0;
                    PrintFooter := false;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Purchaser Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Purchaser Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                FormatAddress.PurchRcptBuyFrom(BuyFromAddress, "Purch. Rcpt. Header");
                FormatAddress.PurchRcptShipTo(ShipToAddress, "Purch. Rcpt. Header");
            end;

            trigger OnPreDataItem()
            begin
                if PrintCompany then
                    FormatAddress.Company(CompanyAddress, CompanyInformation)
                else
                    Clear(CompanyAddress);
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
        ShipmentMethod: Record "Shipment Method";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        ReceiptLine: Record "Purch. Rcpt. Line";
        OrderLine: Record "Purchase Line";
        CompanyAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        ItemNumberToPrint: Text[20];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        PurchaseRcptPrinted: Codeunit "Purch.Rcpt.-Printed";
        FormatAddress: Codeunit "Format Address";
        OrderedQuantity: Decimal;
        BackOrderedQuantity: Decimal;
        Receipt_No_CaptionLbl: Label 'Receipt No.';
        Receipt_DateCaptionLbl: Label 'Receipt Date';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Vendor_IDCaptionLbl: Label 'Vendor ID';
        P_O__NumberCaptionLbl: Label 'P.O. Number';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaptionLbl: Label 'Description';
        ReceivedCaptionLbl: Label 'Received';
        OrderedCaptionLbl: Label 'Ordered';
        Back_OrderedCaptionLbl: Label 'Back Ordered';
}

