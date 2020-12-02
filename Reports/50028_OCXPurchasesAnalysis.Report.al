report 50028 "OCX Purchases Analysis"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    //DefaultLayout = RDLC;
    //RDLCLayout = './Reports/OCXPurchasesAnalysis.rdl';
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Header; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "Posting Date", "Buy-from Vendor No.", "Order No.";
            dataitem(Line; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                RequestFilterFields = "Gen. Prod. Posting Group", Type, "No.", "Work Order No.";

                trigger OnAfterGetRecord()
                begin
                    FillExcelRow(TempExcelBuf, Line);
                end;
            }

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
        LaunchExcel: Boolean;
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
        Lines: Record "Purch. Inv. Line")
    begin
        /*
        Sheet.Range('A' + FORMAT(CellRow)).Value := Header."No.";
        Sheet.Range('B' + FORMAT(CellRow)).Value := Header."Order No.";
        Sheet.Range('C' + FORMAT(CellRow)).Value := Header."Buy-from Vendor No.";
        Sheet.Range('D' + FORMAT(CellRow)).Value := "No.";
        Sheet.Range('E' + FORMAT(CellRow)).Value := Description;
        Sheet.Range('F' + FORMAT(CellRow)).Value := Quantity;
        Sheet.Range('G' + FORMAT(CellRow)).Value := "Unit Cost ($)";
        Sheet.Range('H' + FORMAT(CellRow)).Value := "Serial No.";
        Sheet.Range('I' + FORMAT(CellRow)).Value := "Work Order No.";
        */
        //with SalInvHeader do begin
        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn(Header."No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Header."Order No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Header."Buy-from Vendor No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Lines."No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn(Lines.Description, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Lines.Quantity, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn(Lines."Unit Cost", false, '', false, false, false, '$#,##0.00_);($#,##0.00)', TempExcelBuf."Cell Type"::Number);
        ///--! Comment blank line when activate Serial No. line!!!
        TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        //TempExcelBuf.AddColumn(Lines."Serial No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(Lines."Work Order No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        //end;
    end;

    local procedure FillHeaderData(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        /*
        Sheet.Range('A' + FORMAT(CellRow)).Value := 'Document No.';
        Sheet.Range('B' + FORMAT(CellRow)).Value := 'PO No.';
        Sheet.Range('C' + FORMAT(CellRow)).Value := 'Vendor';
        Sheet.Range('D' + FORMAT(CellRow)).Value := 'No.';
        Sheet.Range('E' + FORMAT(CellRow)).Value := 'Description';
        Sheet.Range('F' + FORMAT(CellRow)).Value := 'Quantity';
        Sheet.Range('G' + FORMAT(CellRow)).Value := 'Unit Cost';
        Sheet.Range('H' + FORMAT(CellRow)).Value := 'Serial No.';
        Sheet.Range('I' + FORMAT(CellRow)).Value := 'Order No.';
        */

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn('Document No.', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('PO No.', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Vendor', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('No.', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Description', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Quantity', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Unit Cost', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Serial No.', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Order No.', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);

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

