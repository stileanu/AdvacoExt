report 50058 "Sales Rep Monthly Invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50058_SalesRepMonthlyInvoices.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Outside Sales Reps"; "Outside Sales Reps")
        {
            DataItemTableView = SORTING("Rep Code");
            RequestFilterFields = "Rep Code", "Date Filter";
            column(RepAddress_1_; RepAddress[1])
            {
            }
            column(RepAddress_2_; RepAddress[2])
            {
            }
            column(RepAddress_3_; RepAddress[3])
            {
            }
            column(RepAddress_4_; RepAddress[4])
            {
            }
            ///--!
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(CURRENT_INVOICES_FOR___UPPERCASE_FORMAT_ThruPeriod_0___Month_Text____Year4____; 'CURRENT INVOICES FOR ' + UpperCase(Format(ThruPeriod, 0, '<Month Text>, <Year4>')))
            {
            }
            column(ThisPeriodSales; ThisPeriodSales)
            {
            }
            column(COMMISSIONS_DUE_FOR___UPPERCASE_FORMAT_ThruPeriod_0___Month_Text____Year4____; 'COMMISSIONS DUE FOR ' + UpperCase(Format(ThruPeriod, 0, '<Month Text>, <Year4>')))
            {
            }
            column(ThisPeriodComm; ThisPeriodComm)
            {
            }
            column(REPRESENTATIVE_MONTHLY_INVOICE_STATEMENTCaption; REPRESENTATIVE_MONTHLY_INVOICE_STATEMENTCaptionLbl)
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            column(Outside_Sales_Reps_Rep_Code; "Rep Code")
            {
            }
            column(Outside_Sales_Reps_Date_Filter; "Date Filter")
            {
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = Rep = FIELD("Rep Code"), "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("No.") ORDER(Ascending);
                column(Sales_Invoice_Header__No__; "No.")
                {
                }
                column(Sales_Invoice_Header__Posting_Date_; "Posting Date")
                {
                }
                column(Sales_Invoice_Header__Your_Reference_; "Your Reference")
                {
                }
                column(BillToAddress_1_; BillToAddress[1])
                {
                }
                column(ShipToAddress_1_; ShipToAddress[1])
                {
                }
                column(BillToAddress_2_; BillToAddress[2])
                {
                }
                column(ShipToAddress_2_; ShipToAddress[2])
                {
                }
                column(BillToAddress_3_; BillToAddress[3])
                {
                }
                column(ShipToAddress_3_; ShipToAddress[3])
                {
                }
                column(BillToAddress_4_; BillToAddress[4])
                {
                }
                column(ShipToAddress_4_; ShipToAddress[4])
                {
                }
                column(Bill_To__; 'Bill To:')
                {
                }
                column(Ship_To__; 'Ship To:')
                {
                }
                column(OrderNo; OrderNo)
                {
                }
                column(PO_No__Caption; PO_No__CaptionLbl)
                {
                }
                column(Date_Caption; Date_CaptionLbl)
                {
                }
                column(Order_No__Caption; Order_No__CaptionLbl)
                {
                }
                column(Sales_Invoice_Header_Rep; Rep)
                {
                }
                dataitem("Sales Lines"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 999;
                    column(Item_No__; 'Item No.')
                    {
                    }
                    column(Description_; 'Description')
                    {
                    }
                    column(Quantity_; 'Quantity')
                    {
                    }
                    column(Unit_Price_; 'Unit Price')
                    {
                    }
                    column(Amount_; 'Amount')
                    {
                    }
                    column(Item_No___Control40; 'Item No.')
                    {
                    }
                    column(Description__Control49; 'Description')
                    {
                    }
                    column(Amount__Control57; 'Amount')
                    {
                    }
                    column(LinePartNumber_Number_; LinePartNumber[Number])
                    {
                    }
                    column(LineDescription_Number__; LineDescription[Number])
                    {
                    }
                    column(LineUnitPrice_Number_; LineUnitPrice[Number])
                    {
                    }
                    column(LinePrice_Number_; LinePrice[Number])
                    {
                    }
                    column(LineQuantity_Number_; LineQuantity[Number])
                    {
                    }
                    column(LinePartNumber_Number__Control38; LinePartNumber[Number])
                    {
                    }
                    column(LineDescription_Number__________LineDescription2_Number__; LineDescription[Number] + ' ' + LineDescription2[Number])
                    {
                    }
                    column(LinePrice_Number__Control8; LinePrice[Number])
                    {
                    }
                    column(TotalPrice; TotalPrice)
                    {
                    }
                    column(Total_Amount_; 'Total Amount')
                    {
                    }
                    column(Sales_Lines_Number; Number)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, LineCount);
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Clear(TempPrice);
                    Clear(LineNumber);
                    Clear(LinePartNumber);
                    Clear(LineDescription2);
                    Clear(LineDescription);
                    Clear(LineQuantity);
                    Clear(LineUnitPrice);
                    Clear(LinePrice);
                    Clear(TotalPrice);
                    Clear(LineCount);
                    Clear(LineCount2);
                    Clear(OrderNo);
                    WO := false;

                    FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                    FormatAddress.SalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");

                    if "Order No." <> '' then
                        OrderNo := "Order No."
                    else
                        OrderNo := "Pre-Assigned No.";

                    // Determine if Sale Header is for Work Order or Sales Order to Determine Line Handling.
                    //Work Order Handling
                    if "Shortcut Dimension 2 Code" = 'WO' then begin
                        WO := true;
                        SalesLine.SetRange("Document No.", "No.");
                        if SalesLine.Find('-') then begin
                            //Determine if WO is Normal or Work Order Sell on Sales Order
                            //WO Handling
                            if SalesLine."No." = '' then begin
                                // Determine How many Work Orders on Invoice
                                SalesLine2.SetRange("Document No.", "No.");
                                //SalesLine2.SETFILTER("Cross Reference Item",'<>%1','');
                                if SalesLine2.Find('-') then begin
                                    repeat
                                        LineCount := LineCount + 1;
                                        //LinePartNumber[LineCount] := SalesLine2."Cross Reference Item";
                                        LineDescription2[LineCount] := SalesLine2.Description;
                                        LineNumber[LineCount] := SalesLine2."Line No.";
                                    until SalesLine2.Next = 0;
                                end;

                                // Goto Line after Model to Retrieve the Pump Description
                                case LineCount of
                                    1:
                                        begin
                                            SalesLine3.SetRange("Document No.", "No.");
                                            SalesLine3.SetFilter("Line No.", '%1', (LineNumber[1] + 10000));
                                            if SalesLine3.Find('-') then begin
                                                LineCount2 := LineCount2 + 1;
                                                LineDescription[LineCount2] := SalesLine3.Description;
                                            end;

                                            SalesLine1st.SetRange("Document No.", "No.");
                                            if SalesLine1st.Find('-') then begin
                                                repeat
                                                    if SalesLine1st.Type = SalesLine1st.Type::"G/L Account" then begin
                                                        if GLAccount.Get(SalesLine1st."No.") then begin
                                                            if GLAccount."Include for Commissions" = true then
                                                                TempPrice := TempPrice + SalesLine1st.Amount;
                                                        end;
                                                    end;
                                                until SalesLine1st.Next = 0;
                                                LinePrice[1] := TempPrice;
                                                Clear(TempPrice);
                                            end;
                                        end;
                                    2:
                                        begin
                                            SalesLine3.SetRange("Document No.", "No.");
                                            SalesLine3.SetFilter("Line No.", '%1|%2', (LineNumber[1] + 10000), (LineNumber[2] + 10000));
                                            if SalesLine3.Find('-') then begin
                                                repeat
                                                    LineCount2 := LineCount2 + 1;
                                                    LineDescription[LineCount2] := SalesLine3.Description;
                                                until SalesLine3.Next = 0;
                                            end;

                                            SalesLine1st.SetRange("Document No.", "No.");
                                            SalesLine1st.SetFilter("Line No.", '%1..%2', (LineNumber[1]), (LineNumber[2]));
                                            if SalesLine1st.Find('-') then begin
                                                repeat
                                                    if SalesLine1st.Type = SalesLine1st.Type::"G/L Account" then begin
                                                        if GLAccount.Get(SalesLine1st."No.") then begin
                                                            if GLAccount."Include for Commissions" = true then
                                                                TempPrice := TempPrice + SalesLine1st.Amount;
                                                        end;
                                                    end;
                                                until SalesLine1st.Next = 0;
                                                LinePrice[1] := TempPrice;
                                                TotalPrice := TempPrice;
                                                Clear(TempPrice);
                                            end;

                                            SalesLine2nd.SetRange("Document No.", "No.");
                                            SalesLine2nd.SetFilter("Line No.", '%1..%2', (LineNumber[2]), 9990000);
                                            if SalesLine2nd.Find('-') then begin
                                                repeat
                                                    if SalesLine2nd.Type = SalesLine2nd.Type::"G/L Account" then begin
                                                        if GLAccount.Get(SalesLine2nd."No.") then begin
                                                            if GLAccount."Include for Commissions" = true then
                                                                TempPrice := TempPrice + SalesLine2nd.Amount;
                                                        end;
                                                    end;
                                                until SalesLine2nd.Next = 0;
                                                LinePrice[2] := TempPrice;
                                                TotalPrice := TotalPrice + TempPrice;
                                                Clear(TempPrice);
                                            end;
                                        end;
                                    3:
                                        begin
                                            SalesLine3.SetRange("Document No.", "No.");
                                            SalesLine3.SetFilter("Line No.", '%1|%2|%3', (LineNumber[1] + 10000), (LineNumber[2] + 10000), (LineNumber[3] + 10000));
                                            if SalesLine3.Find('-') then begin
                                                repeat
                                                    LineCount2 := LineCount2 + 1;
                                                    LineDescription[LineCount2] := SalesLine3.Description;
                                                until SalesLine3.Next = 0;
                                            end;

                                            SalesLine1st.SetRange("Document No.", "No.");
                                            SalesLine1st.SetFilter("Line No.", '%1..%2', (LineNumber[1]), (LineNumber[2]));
                                            if SalesLine1st.Find('-') then begin
                                                repeat
                                                    if SalesLine1st.Type = SalesLine1st.Type::"G/L Account" then begin
                                                        if GLAccount.Get(SalesLine1st."No.") then begin
                                                            if GLAccount."Include for Commissions" = true then
                                                                TempPrice := TempPrice + SalesLine1st.Amount;
                                                        end;
                                                    end;
                                                until SalesLine1st.Next = 0;
                                                LinePrice[1] := TempPrice;
                                                TotalPrice := TempPrice;
                                                Clear(TempPrice);
                                            end;

                                            SalesLine2nd.SetRange("Document No.", "No.");
                                            SalesLine2nd.SetFilter("Line No.", '%1..%2', (LineNumber[2]), (LineNumber[3]));
                                            if SalesLine2nd.Find('-') then begin
                                                repeat
                                                    if SalesLine2nd.Type = SalesLine2nd.Type::"G/L Account" then begin
                                                        if GLAccount.Get(SalesLine2nd."No.") then begin
                                                            if GLAccount."Include for Commissions" = true then
                                                                TempPrice := TempPrice + SalesLine2nd.Amount;
                                                        end;
                                                    end;
                                                until SalesLine2nd.Next = 0;
                                                LinePrice[2] := TempPrice;
                                                TotalPrice := TotalPrice + TempPrice;
                                                Clear(TempPrice);
                                            end;

                                            SalesLine3rd.SetRange("Document No.", "No.");
                                            SalesLine3rd.SetFilter("Line No.", '%1..%2', (LineNumber[3]), 9990000);
                                            if SalesLine3rd.Find('-') then begin
                                                repeat
                                                    if SalesLine3rd.Type = SalesLine3rd.Type::"G/L Account" then begin
                                                        if GLAccount.Get(SalesLine3rd."No.") then begin
                                                            if GLAccount."Include for Commissions" = true then
                                                                TempPrice := TempPrice + SalesLine3rd.Amount;
                                                        end;
                                                    end;
                                                until SalesLine3rd.Next = 0;
                                                LinePrice[3] := TempPrice;
                                                TotalPrice := TotalPrice + TempPrice;
                                                Clear(TempPrice);
                                            end;
                                        end;
                                end;


                                // Work Order Sell on Sales Order Handling
                            end else begin
                                LineCount := LineCount + 1;
                                //LinePartNumber[LineCount] := SalesLine."Cross Reference Item";
                                LineDescription[LineCount] := SalesLine.Description;
                                LinePrice[LineCount] := SalesLine.Amount;
                            end;
                        end;
                        // Sales Order Handling
                    end else begin
                        SalesLine.SetRange(SalesLine."Document No.", "No.");
                        if SalesLine.Find('-') then begin
                            repeat
                                if SalesLine."No." <> '' then begin
                                    if SalesLine.Amount <> 0 then begin
                                        case SalesLine.Type of
                                            SalesLine.Type::Item:
                                                begin
                                                    LineCount := LineCount + 1;
                                                    LinePartNumber[LineCount] := SalesLine."No.";
                                                    LineDescription[LineCount] := SalesLine.Description;
                                                    LineQuantity[LineCount] := SalesLine.Quantity;
                                                    LineUnitPrice[LineCount] := SalesLine."Unit Price";
                                                    LinePrice[LineCount] := SalesLine.Amount;
                                                    TotalPrice := TotalPrice + SalesLine.Amount;
                                                end;
                                            SalesLine.Type::"G/L Account":
                                                begin
                                                    if GLAccount.Get(SalesLine."No.") then begin
                                                        if GLAccount."Include for Commissions" = true then begin
                                                            LineCount := LineCount + 1;
                                                            //LinePartNumber[LineCount] := SalesLine."Cross Reference Item";
                                                            LineDescription[LineCount] := SalesLine.Description;
                                                            LineQuantity[LineCount] := SalesLine.Quantity;
                                                            LineUnitPrice[LineCount] := SalesLine."Unit Price";
                                                            LinePrice[LineCount] := SalesLine.Amount;
                                                            TotalPrice := TotalPrice + SalesLine.Amount;
                                                        end;
                                                    end;
                                                end;
                                            SalesLine.Type::Resource:
                                                begin
                                                    LineCount := LineCount + 1;
                                                    LinePartNumber[LineCount] := SalesLine."No.";
                                                    LineDescription[LineCount] := SalesLine.Description;
                                                    LineQuantity[LineCount] := SalesLine.Quantity;
                                                    LineUnitPrice[LineCount] := SalesLine."Unit Price";
                                                    LinePrice[LineCount] := SalesLine.Amount;
                                                    TotalPrice := TotalPrice + SalesLine.Amount;
                                                end;
                                        end;
                                    end;
                                end;
                            until SalesLine.Next = 0;
                        end;
                    end;

                    if LineCount = 0 then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord()
            var
                FormatAddress: codeunit FormatAddrExt;

            begin
                FormatAddress.OutsideRep(RepAddress, "Outside Sales Reps");

                Clear(ThisPeriodSales);
                Clear(ThisPeriodComm);

                // Current Period Sales and Commission Calc.
                SetRange("Date Filter", FromPeriod, ThruPeriod);
                CalcFields("Sales Amount");
                ThisPeriodSales := "Sales Amount";
                ThisPeriodComm := Round(ThisPeriodSales * ("Outside Sales Reps"."Commission %" / 100));

                ///--!
                //if FirstTime then
                //    CurrReport.PageNo := 0
                //else
                //    FirstTime := true;
            end;

            trigger OnPreDataItem()
            begin
                FromPeriod := GetRangeMin("Date Filter");
                ThruPeriod := GetRangeMax("Date Filter");

                SetRange("Date Filter");
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
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        SalesLine: Record "Sales Invoice Line";
        SalesLine2: Record "Sales Invoice Line";
        SalesLine3: Record "Sales Invoice Line";
        SalesLine1st: Record "Sales Invoice Line";
        SalesLine2nd: Record "Sales Invoice Line";
        SalesLine3rd: Record "Sales Invoice Line";
        GLAccount: Record "G/L Account";
        TempPrice: Decimal;
        LineNumber: array[999] of Integer;
        LinePartNumber: array[999] of Code[20];
        LineDescription2: array[999] of Text[50];
        LineDescription: array[999] of Text[50];
        LineQuantity: array[999] of Decimal;
        LineUnitPrice: array[999] of Decimal;
        LinePrice: array[999] of Decimal;
        TotalPrice: Decimal;
        WO: Boolean;
        OrderNo: Code[10];
        LineCount: Integer;
        LineCount2: Integer;
        RepAddress: array[8] of Text[50];
        FormatAddress: Codeunit "Format Address";
        ThisPeriodSales: Decimal;
        ThisPeriodComm: Decimal;
        FromPeriod: Date;
        ThruPeriod: Date;
        FirstTime: Boolean;
        REPRESENTATIVE_MONTHLY_INVOICE_STATEMENTCaptionLbl: Label 'REPRESENTATIVE MONTHLY INVOICE STATEMENT';
        Page_CaptionLbl: Label 'Page:';
        PO_No__CaptionLbl: Label 'PO No.:';
        Date_CaptionLbl: Label 'Date:';
        Order_No__CaptionLbl: Label 'Order No.:';
}

