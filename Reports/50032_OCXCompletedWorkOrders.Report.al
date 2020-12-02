report 50032 "OCX Completed Work Orders"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50032_OCXCompleteWorkOrders.rdl';

    dataset
    {
        dataitem(WOD; WorkOrderDetail)
        {
            RequestFilterFields = "Customer ID", "Order Type", "Model No.", "Ship Date", "Install Date";

            trigger OnAfterGetRecord()
            begin
                IF NOT Complete THEN BEGIN
                    CurrReport.SKIP;
                END ELSE BEGIN
                    CALCFIELDS("Original Parts Price", "Original Labor Price");

                    QuotePrice := 0;

                    IF Quote.AsInteger() = 1 THEN
                        QuotePrice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";

                    IF Quote.AsInteger() = 2 THEN
                        QuotePrice := "Unrepairable Charge";


                    OrderType := "Order Type";
                    code;
                    WOS.SETCURRENTKEY("Order No.", "Line No.");
                    WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                    IF WOS.FIND('+') THEN BEGIN
                    END;
                END;
                FillExcelRow(TempExcelBuf, WOD);
            end;

            trigger OnPreDataItem()
            begin
                // Excel
                /*
                CREATE(Excel);
                Excel.Visible(TRUE);
                Book := Excel.Workbooks.Add(-4167);
                Sheet := Excel.ActiveSheet;
                */
                TempExcelBuf.CreateNewBook(SheetNameTxt);
                FillHeaderData(TempExcelBuf);
            end;

            trigger OnPostDataItem()
            begin
                TempExcelBuf.WriteSheet(HeaderTxt, CompanyName(), UserId());
                TempExcelBuf.CloseBook();
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
        // Excel
        CreateAlphabet;
    end;

    trigger OnPostReport()
    begin
        DownloadAndOpenExcel(TempExcelBuf);
    end;

    var
        BookNameTxt: Label 'Purchases Analysis';
        SheetNameTxt: Label 'Purchases';
        HeaderTxt: Label 'Purchases Analysis';
        TempExcelBuf: Record "Excel Buffer" temporary;
        //Excel: Automation;
        //Book: Automation;
        //Sheet: Automation;
        //Range: Automation;
        LaunchExcel: Boolean;
        AlphabetArray: array[26] of Text[1];
        CellRow: Integer;
        CellColumn: Integer;
        CellValue: Text[30];
        HeaderDone: Boolean;
        //OrderType: Option;
        OrderType: Enum OrderType;
        Type: Code[10];
        WOS: Record Status;
        QuotePrice: Decimal;

    local procedure DownloadAndOpenExcel(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        TempExcelBuf.SetFriendlyFilename(BookNameTxt);
        TempExcelBuf.OpenExcel();
    end;

    local procedure FillExcelRow(
        var TempExcelBuf: Record "Excel Buffer" temporary;
        WOD: Record WorkOrderDetail)
    begin
        /*
        Sheet.Range('A' + FORMAT(CellRow)).Value := "Work Order No.";
        IF "Work Order Date" <> 0D THEN
          Sheet.Range('B' + FORMAT(CellRow)).Value := "Work Order Date"
        ELSE
          Sheet.Range('B' + FORMAT(CellRow)).Value := '';
        Sheet.Range('C' + FORMAT(CellRow)).Value := WOS."Date Out";
        Sheet.Range('D' + FORMAT(CellRow)).Value := "Model No.";
        Sheet.Range('E' + FORMAT(CellRow)).Value := "Serial No.";
        Sheet.Range('F' + FORMAT(CellRow)).Value := "Customer PO No.";
        Sheet.Range('G' + FORMAT(CellRow)).Value := Type;
        Sheet.Range('H' + FORMAT(CellRow)).Value := "Order Type Reason";
        Sheet.Range('I' + FORMAT(CellRow)).Value := QuotePrice;
        */
        //with SalInvHeader do begin
        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn(WOD."Work Order No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        if WOD."Work Order Date" <> 0D then
            TempExcelBuf.AddColumn(WOD."Work Order Date", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Date)
        else
            TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(WOS."Date Out", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Date);
        TempExcelBuf.AddColumn(WOD."Model No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(WOD."Serial No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(WOD."Customer PO No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Type, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(WOD."Order Type Reason", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(QuotePrice, false, '', false, false, false, '$#,##0.00_);($#,##0.00)', TempExcelBuf."Cell Type"::Number);
        //end;
    end;

    local procedure FillHeaderData(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        /*
        Sheet.Range('A' + FORMAT(CellRow)).Value := 'Work Order #';
        Sheet.Range('B' + FORMAT(CellRow)).Value := 'Order Date';
        Sheet.Range('C' + FORMAT(CellRow)).Value := 'Ship Date';
        Sheet.Range('D' + FORMAT(CellRow)).Value := 'Model';
        Sheet.Range('E' + FORMAT(CellRow)).Value := 'Serial #';
        Sheet.Range('F' + FORMAT(CellRow)).Value := 'PO #';
        Sheet.Range('G' + FORMAT(CellRow)).Value := 'Order Type';
        Sheet.Range('H' + FORMAT(CellRow)).Value := 'Reason';
        Sheet.Range('I' + FORMAT(CellRow)).Value := 'Quote Price';
        */

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn('Work Order #', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Order Date', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Ship Date', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Model', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Serial #', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('PO #', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Order Type', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Reason', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Quote Price', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);

    end;

    procedure CreateAlphabet()
    begin
        AlphabetArray[1] := 'A';
        AlphabetArray[2] := 'B';
        AlphabetArray[3] := 'C';
        AlphabetArray[4] := 'D';
        AlphabetArray[5] := 'E';
        AlphabetArray[6] := 'F';
        AlphabetArray[7] := 'G';
        AlphabetArray[8] := 'H';
        AlphabetArray[9] := 'I';
        AlphabetArray[10] := 'J';
        AlphabetArray[11] := 'K';
        AlphabetArray[12] := 'L';
        AlphabetArray[13] := 'M';
        AlphabetArray[14] := 'N';
        AlphabetArray[15] := 'O';
        AlphabetArray[16] := 'P';
        AlphabetArray[17] := 'Q';
        AlphabetArray[18] := 'R';
        AlphabetArray[19] := 'S';
        AlphabetArray[20] := 'T';
        AlphabetArray[21] := 'U';
        AlphabetArray[22] := 'V';
        AlphabetArray[23] := 'W';
        AlphabetArray[24] := 'X';
        AlphabetArray[25] := 'Y';
        AlphabetArray[26] := 'Z';
    end;

    procedure "code"()
    begin
        CASE OrderType OF
            OrderType::Rebuild:
                Type := 'Rebuild';
            OrderType::Repair:
                Type := 'Repair';
            OrderType::Warranty:
                Type := 'Warranty';
        END;
    end;
}

