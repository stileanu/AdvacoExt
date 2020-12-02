report 50027 "OCX Sales Analysis"
{
    UseRequestPage = true;
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    //RDLCLayout = './Reports/50027_OCX Sales Analysis.Rpt.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Posting Date", "shortcut dimension 2 Code", "Sell-to Customer No.", "Ship-to Code";
            PrintOnlyIfDetail = true;
            column(Parts___InvoiceCaption; Parts___InvoiceCaptionLbl)
            {
            }
            column(Profit___LossCaption; Profit___LossCaptionLbl)
            {
            }
            column(Parts_CostCaption; Parts_CostCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Invoice_No_Caption; Invoice_No_CaptionLbl)
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(Header_No_; "No.")
            {
            }
            dataitem(Lines; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = "Gen. Prod. Posting Group";
                column(PartsCostInvoiceP; PartsCostInvoiceP)
                {
                }
                column(Amount___TotalUnitCost; Amount - TotalUnitCost)
                {
                }
                column(TotalUnitCost; TotalUnitCost)
                {
                }
                column(Lines_Amount; Amount)
                {
                }
                column(Header__No__; Header."No.")
                {
                }
                column(Header__Sell_to_Customer_No__; Header."Sell-to Customer No.")
                {
                }
                column(OrderNo; OrderNo)
                {
                }
                column(Lines_Document_No_; "Document No.")
                {
                }
                column(Lines_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TotalUnitCost := Quantity * "Unit Cost (lcy)";
                    FillExcelRow(TempExcelBuf, Lines);
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.CREATETOTALS(TotalUnitCost,Amount);  //ICE-MPC 09/11/20
                end;
            }

            trigger OnAfterGetRecord()
            begin
                OrderNo := '';
                IF "Order No." <> '' THEN
                    OrderNo := "Order No."
                ELSE
                    OrderNo := "Pre-Assigned No.";
            end;

            trigger OnPreDataItem()
            begin
                // Excel
                /*  CREATE(Excel);
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
        PartsCostInvoiceP: Decimal;
        TotalUnitCost: Decimal;
        ok: Boolean;
        TotalAmount: Decimal;
        OrderNo: Code[20];
        BookNameTxt: Label 'Sales Analysis';
        SheetNameTxt: Label 'Sales';
        HeaderTxt: Label 'Sales Analysis';
        TempExcelBuf: Record "Excel Buffer" temporary;
        LaunchExcel: Boolean;
        AlphabetArray: array[26] of Text[1];
        CellRow: Integer;
        CellColumn: Integer;
        CellValue: Text[30];
        HeaderDone: Boolean;
        Parts___InvoiceCaptionLbl: Label 'Parts / Invoice';
        Profit___LossCaptionLbl: Label 'Profit / Loss';
        Parts_CostCaptionLbl: Label 'Parts Cost';
        AmountCaptionLbl: Label 'Amount';
        Invoice_No_CaptionLbl: Label 'Invoice No.';
        CustomerCaptionLbl: Label 'Customer';
        Order_No_CaptionLbl: Label 'Order No.';

    local procedure DownloadAndOpenExcel(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        TempExcelBuf.SetFriendlyFilename(BookNameTxt);
        TempExcelBuf.OpenExcel();
    end;

    local procedure FillExcelRow(
        var TempExcelBuf: Record "Excel Buffer" temporary;
        Lines: Record "Sales Invoice Line")
    begin
        /*
        IF Amount > 0 THEN BEGIN
        PartsCostInvoiceP := TotalUnitCost / Amount;
        END ELSE
        PartsCostInvoiceP := 0;

        CellRow := CellRow + 1;
        Sheet.Range('A' + FORMAT(CellRow)).Value := Header."No.";
        Sheet.Range('B' + FORMAT(CellRow)).Value := OrderNo;
        Sheet.Range('C' + FORMAT(CellRow)).Value := Header."Sell-to Customer No.";
        Sheet.Range('D' + FORMAT(CellRow)).Value := Amount;
        Sheet.Range('E' + FORMAT(CellRow)).Value := TotalUnitCost;
        Sheet.Range('F' + FORMAT(CellRow)).Value := (Amount - TotalUnitCost);
        Sheet.Range('G' + FORMAT(CellRow)).Value := PartsCostInvoiceP;
        */

        //with SalInvHeader do begin
        if Lines.Amount > 0 then
            PartsCostInvoiceP := TotalUnitCost / Lines.Amount
        else
            PartsCostInvoiceP := 0;

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn(Header."No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(OrderNo, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Header."Sell-to Customer No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Lines.Amount, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn(TotalUnitCost, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn((Lines.Amount - TotalUnitCost), false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn(PartsCostInvoiceP, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        //end;
    end;

    local procedure FillHeaderData(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        /*

        Sheet.Range('A' + FORMAT(CellRow)).Value := 'Invoice #';
        Sheet.Range('B' + FORMAT(CellRow)).Value := 'Order #';
        Sheet.Range('C' + FORMAT(CellRow)).Value := 'Customer';
        Sheet.Range('D' + FORMAT(CellRow)).Value := 'Amount';
        Sheet.Range('E' + FORMAT(CellRow)).Value := 'Parts Cost';
        Sheet.Range('F' + FORMAT(CellRow)).Value := 'Profit/Loss';
        Sheet.Range('G' + FORMAT(CellRow)).Value := 'Parts/Invoice';
        */

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn('Invoice #', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Order #', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Customer', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Amount', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Parts Cost', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Profit/Loss', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Parts/Invoice', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);

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
}

