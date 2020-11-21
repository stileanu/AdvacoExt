report 50004 "Vendor Responsiveness"
{
    // 04/24/16 New report
    // 11/29/16 Test for "Orig. Expected Receipt Date" <> 0D
    // 06/03/18 Skip Receipts without any date
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50004_VendorResponsiveness.rdl';


    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Vendor_Responsivness_; 'Vendor Responsivness')
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(TIME; TIME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PAGENO)
            //{
            //}
            column(Vendor_TABLENAME__________VendorFilter; Vendor.TABLENAME + ': ' + VendorFilter)
            {
            }
            column(PurchRcptHeader_TABLENAME__________PurchRcptHeaderFilter; PurchRcptHeader.TABLENAME + ': ' + PurchRcptHeaderFilter)
            {
            }
            column(PurchRcptLine_TABLENAME__________PurchRcptLineFilter; PurchRcptLine.TABLENAME + ': ' + PurchRcptLineFilter)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Vendor_CodeCaption; Vendor_CodeCaptionLbl)
            {
            }
            column(Total_OrdersCaption; Total_OrdersCaptionLbl)
            {
            }
            column(Average_Lead_TimeCaption; Average_Lead_TimeCaptionLbl)
            {
            }
            column(No__of_Late_DeliveriesCaption; No__of_Late_DeliveriesCaptionLbl)
            {
            }
            column(No__of_B_OCaption; No__of_B_OCaptionLbl)
            {
            }
            column(Total_ReceiptsCaption; Total_ReceiptsCaptionLbl)
            {
            }
            column(Late_DeliveriesCaption; Late_DeliveriesCaptionLbl)
            {
            }
            column(Total_Receipts_LinesCaption; Total_Receipts_LinesCaptionLbl)
            {
            }
            column(Vendor_No_; "No.")
            {
            }
            column(Show_Details; ShowDetails)
            {
            }
            dataitem(PurchRcptHeader; "Purch. Rcpt. Header")
            {
                DataItemLink = "Buy-from Vendor No." = FIELD("No.");
                //DataItemTableView = SORTING("Buy-from Vendor No.", "Location Code", "Order Date");
                DataItemTableView = SORTING("Buy-from Vendor No.", "Location Code");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Order Date", "Posting Date";
                column(Vendor__No__; Vendor."No.")
                {
                }
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(NoBO; NoBO)
                {
                }
                column(NoLateDeliveries; NoLateDeliveries)
                {
                }
                column(AverageTA; AverageTA)
                {
                }
                column(TotalOrders; TotalOrders)
                {
                }
                column(Vendor_Name_Control1000000062; Vendor.Name)
                {
                }
                column(Vendor__No___Control1000000063; Vendor."No.")
                {
                }
                column(TotalReceipts; TotalReceipts)
                {
                }
                column(FORMAT_PercentLate_; '%' + FORMAT(PercentLate))
                {
                }
                column(NoOfDeliveries; NoOfDeliveries)
                {
                }
                column(Vendor_Name_Control1000000069; Vendor.Name)
                {
                }
                column(TotalOrders_Control1000000070; TotalOrders)
                {
                }
                column(AverageTA_Control1000000071; AverageTA)
                {
                }
                column(NoLateDeliveries_Control1000000072; NoLateDeliveries)
                {
                }
                column(NoBO_Control1000000073; NoBO)
                {
                }
                column(Vendor__No___Control1000000074; Vendor."No.")
                {
                }
                column(TotalReceipts_Control1000000028; TotalReceipts)
                {
                }
                column(FORMAT_PercentLate__Control1000000031; '%' + FORMAT(PercentLate))
                {
                }
                column(NoOfDeliveries_Control1000000035; NoOfDeliveries)
                {
                }
                column(Expected_Delivery_DateCaption; Expected_Delivery_DateCaptionLbl)
                {
                }
                column(Order_DateCaption; Order_DateCaptionLbl)
                {
                }
                column(Receipt_DateCaption; Receipt_DateCaptionLbl)
                {
                }
                column(Order_No_Caption; Order_No_CaptionLbl)
                {
                }
                column(Vendor_CodeCaption_Control1000000001; Vendor_CodeCaption_Control1000000001Lbl)
                {
                }
                column(Vendor_NameCaption_Control1000000003; Vendor_NameCaption_Control1000000003Lbl)
                {
                }
                column(DurationCaption; DurationCaptionLbl)
                {
                }
                column(Late_DeliveryCaption; Late_DeliveryCaptionLbl)
                {
                }
                column(Back_OrderedCaption; Back_OrderedCaptionLbl)
                {
                }
                column(Receipt_No_Caption; Receipt_No_CaptionLbl)
                {
                }
                column(Vendor_NameCaption_Control1000000068; Vendor_NameCaption_Control1000000068Lbl)
                {
                }
                column(Vendor_CodeCaption_Control1000000075; Vendor_CodeCaption_Control1000000075Lbl)
                {
                }
                column(No__of_B_OCaption_Control1000000076; No__of_B_OCaption_Control1000000076Lbl)
                {
                }
                column(No__of_Late_DeliveriesCaption_Control1000000077; No__of_Late_DeliveriesCaption_Control1000000077Lbl)
                {
                }
                column(Average_Lead_TimeCaption_Control1000000078; Average_Lead_TimeCaption_Control1000000078Lbl)
                {
                }
                column(Total_OrdersCaption_Control1000000079; Total_OrdersCaption_Control1000000079Lbl)
                {
                }
                column(Total_ReceiptsCaption_Control1000000021; Total_ReceiptsCaption_Control1000000021Lbl)
                {
                }
                column(Late_DeliveriesCaption_Control1000000029; Late_DeliveriesCaption_Control1000000029Lbl)
                {
                }
                column(Total_Receipts_LinesCaption_Control1000000034; Total_Receipts_LinesCaption_Control1000000034Lbl)
                {
                }
                column(PurchRcptHeader_No_; "No.")
                {
                }
                column(PurchRcptHeader_Buy_from_Vendor_No_; "Buy-from Vendor No.")
                {
                }
                dataitem(PurchRcptLine; "Purch. Rcpt. Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(<> 0));
                    RequestFilterFields = Type;
                    column(PurchRcptLine__Order_No__; "Order No.")
                    {
                    }
                    column(PurchRcptHeader__Order_Date_; PurchRcptHeader."Order Date")
                    {
                    }
                    column(PurchRcptLine_PurchRcptLine__Orig__Expected_Receipt_Date_; PurchRcptLine."Orig. Expected Receipt Date")
                    {
                    }
                    column(PurchRcptHeader__Posting_Date_; PurchRcptHeader."Posting Date")
                    {
                    }
                    column(Duration; Duration)
                    {
                    }
                    column(LateDelivery; LateDelivery)
                    {
                    }
                    column(BackOrdered; BackOrdered)
                    {
                    }
                    column(PurchRcptLine_PurchRcptLine__Document_No__; PurchRcptLine."Document No.")
                    {
                    }
                    column(PurchRcptLine_Line_No_; "Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        LateDelivery := FALSE;
                        BackOrdered := FALSE;

                        //11/29/16 Start test for 0D
                        //Duration :=  PurchRcptHeader."Posting Date" - PurchRcptLine."Orig. Expected Receipt Date"
                        IF PurchRcptLine."Orig. Expected Receipt Date" <> 0D THEN
                            Duration := PurchRcptHeader."Posting Date" - PurchRcptLine."Orig. Expected Receipt Date"
                        //06/03/18 start
                        //ELSE
                        ELSE
                            IF PurchRcptLine."Expected Receipt Date" <> 0D THEN
                                //Duration :=  PurchRcptHeader."Posting Date" - PurchRcptLine."Expected Receipt Date";
                                Duration := PurchRcptHeader."Posting Date" - PurchRcptLine."Expected Receipt Date"
                            ELSE
                                CurrReport.SKIP;
                        //06/03/18 end
                        //11/29/16 End

                        TotalDuration += Duration;
                        NoOfDeliveries += 1;
                        IF CurrOrder <> PurchRcptLine."Order No." THEN BEGIN
                            TotalOrders += 1;
                            CurrOrder := PurchRcptLine."Order No.";
                        END;
                        IF CurrRcpt <> PurchRcptLine."Document No." THEN BEGIN
                            TotalReceipts += 1;
                            CurrRcpt := PurchRcptLine."Document No.";
                        END;
                        IF (PurchRcptLine."Orig. Expected Receipt Date" <> 0D) AND
                           (PurchRcptHeader."Posting Date" > PurchRcptLine."Orig. Expected Receipt Date") THEN BEGIN
                            LateDelivery := TRUE;
                            NoLateDeliveries += 1;
                        END;
                        IF PurchOrderLine.GET(PurchOrderLine."Document Type"::Order, "Order No.", "Order Line No.") THEN BEGIN
                            IF PurchOrderLine."Outstanding Quantity" > 0 THEN BEGIN
                                NoBO += 1;
                                BackOrdered := TRUE;
                            END;
                        END ELSE
                            IF PurchOrderLine.GET(PurchOrderLine."Document Type"::"Blanket Order", "Order No.", "Order Line No.") THEN BEGIN
                                IF PurchOrderLine."Outstanding Quantity" > 0 THEN BEGIN
                                    NoBO += 1;
                                    BackOrdered := TRUE;
                                END;
                            END;

                        AverageTA := ROUND(TotalDuration / NoOfDeliveries, 1);
                        PercentLate := ROUND(NoLateDeliveries / NoOfDeliveries * 100, 0.01);
                    end;

                    trigger OnPreDataItem()
                    begin
                        CurrOrder := '';
                        CurrRcpt := '';
                        IF PurchRcptLine.GETFILTER(Type) = '' THEN
                            PurchRcptLine.SETFILTER(Type, '%1|%2', PurchRcptLine.Type::Item, PurchRcptLine.Type::"g/l Account");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    TotalOrders := 0;
                    TotalReceipts := 0;
                    AverageTA := 0;
                    NoLateDeliveries := 0;
                    NoBO := 0;
                    TotalDuration := 0;
                    NoOfDeliveries := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                IF ExportToExcel THEN BEGIN
                    // Excel
                    /*
                    CREATE(Excel);
                    Excel.Visible(TRUE);
                    Book := Excel.Workbooks.Add(-4167);
                    Sheet := Excel.ActiveSheet;
                    */
                END;
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
                    field(ShowDetails; ShowDetails)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Details';

                        trigger OnValidate()
                        begin
                            IF ShowDetails THEN BEGIN
                                ExportToExcel := FALSE;
                            END;
                        end;
                    }
                    field(ExportToExcel; ExportToExcel)
                    {
                        ApplicationArea = All;
                        Caption = 'Export to Excel';

                        trigger OnValidate()
                        begin
                            IF ShowDetails THEN BEGIN
                                ExportToExcel := FALSE;
                                MESSAGE('Cannot export to Excel when Details are selected.');
                            END;
                        end;
                    }
                }
            }
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
        CompanyInformation.GET;
        VendorFilter := Vendor.GETFILTERS;
        PurchRcptHeaderFilter := PurchRcptHeader.GETFILTERS;
        PurchRcptLineFilter := PurchRcptLine.GETFILTERS;
    end;

    var
        CompanyInformation: Record "Company Information";
        PurchOrderLine: Record "Purchase Line";
        VendorFilter: Text[250];
        PurchRcptHeaderFilter: Text[250];
        PurchRcptLineFilter: Text[250];
        ShowDetails: Boolean;
        ExportToExcel: Boolean;
        HeaderDone: Boolean;
        TotalOrders: Integer;
        TotalReceipts: Integer;
        AverageTA: Integer;
        NoLateDeliveries: Integer;
        NoBO: Integer;
        Duration: Integer;
        LateDelivery: Boolean;
        BackOrdered: Boolean;
        CurrOrder: Code[20];
        CurrRcpt: Code[20];
        TotalDuration: Integer;
        NoOfDeliveries: Integer;
        PercentLate: Decimal;
        //Excel: Automation;
        //Book: Automation;
        //Sheet: Automation;
        //Range: Automation;
        LaunchExcel: Boolean;
        CellRow: Integer;
        CellColumn: Integer;
        CellValue: Text[30];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Vendor_CodeCaptionLbl: Label 'Vendor Code';
        Total_OrdersCaptionLbl: Label 'Total Orders';
        Average_Lead_TimeCaptionLbl: Label 'Average Lead Time';
        No__of_Late_DeliveriesCaptionLbl: Label 'No. of Late Deliveries';
        No__of_B_OCaptionLbl: Label 'No. of B-O';
        Total_ReceiptsCaptionLbl: Label 'Total Receipts';
        Late_DeliveriesCaptionLbl: Label '% Late Deliveries';
        Total_Receipts_LinesCaptionLbl: Label 'Total Receipts Lines';
        Expected_Delivery_DateCaptionLbl: Label 'Expected Delivery Date';
        Order_DateCaptionLbl: Label 'Order Date';
        Receipt_DateCaptionLbl: Label 'Receipt Date';
        Order_No_CaptionLbl: Label 'Order No.';
        Vendor_CodeCaption_Control1000000001Lbl: Label 'Vendor Code';
        Vendor_NameCaption_Control1000000003Lbl: Label 'Vendor Name';
        DurationCaptionLbl: Label 'Duration';
        Late_DeliveryCaptionLbl: Label 'Late Delivery';
        Back_OrderedCaptionLbl: Label 'Back Ordered';
        Receipt_No_CaptionLbl: Label 'Receipt No.';
        Vendor_NameCaption_Control1000000068Lbl: Label 'Vendor Name';
        Vendor_CodeCaption_Control1000000075Lbl: Label 'Vendor Code';
        No__of_B_OCaption_Control1000000076Lbl: Label 'No. of B-O';
        No__of_Late_DeliveriesCaption_Control1000000077Lbl: Label 'No. of Late Deliveries';
        Average_Lead_TimeCaption_Control1000000078Lbl: Label 'Average Lead Time';
        Total_OrdersCaption_Control1000000079Lbl: Label 'Total Orders';
        Total_ReceiptsCaption_Control1000000021Lbl: Label 'Total Receipts';
        Late_DeliveriesCaption_Control1000000029Lbl: Label '% Late Deliveries';
        Total_Receipts_LinesCaption_Control1000000034Lbl: Label 'Total Receipts Lines';
}

