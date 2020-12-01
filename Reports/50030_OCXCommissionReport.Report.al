report 50030 "OCX Commission Report"
{
    UseRequestPage = true;
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    //RDLCLayout = './OCX Commission Report.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date", Rep, "Salesperson Code";

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Commision Amount");
                FillExcelRow(TempExcelBuf, "Sales Invoice Header");
            end;

            trigger OnPreDataItem()
            begin
                // Excel
                /*CREATE(Excel);
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
        BookNameTxt: Label 'Export Commissions';
        SheetNameTxt: Label 'Commissions';
        HeaderTxt: Label 'Export Commissions';
        TempExcelBuf: Record "Excel Buffer" temporary;
        AlphabetArray: array[26] of Text[1];
        CellRow: Integer;
        CellColumn: Integer;
        CellValue: Text[30];
        HeaderDone: Boolean;

    local procedure DownloadAndOpenExcel(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        TempExcelBuf.SetFriendlyFilename(BookNameTxt);
        TempExcelBuf.OpenExcel();
    end;

    local procedure FillExcelRow(
        var TempExcelBuf: Record "Excel Buffer" temporary;
        SalInvHeader: Record "Sales Invoice Header")
    begin
        //with SalInvHeader do begin
        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn(SalInvHeader."No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(SalInvHeader."Bill-to Customer No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(SalInvHeader."Bill-to Name", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(SalInvHeader."Commision Amount", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn(SalInvHeader."Salesperson Code", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(SalInvHeader.Rep, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(SalInvHeader."Ship-to Code", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        //end;
    end;

    local procedure FillHeaderData(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn('Invoice#', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('CustID', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Customer Name', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Net Amount', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Inside Sales', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Rep', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Ship To', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);

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

