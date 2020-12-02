report 50031 "OCX Billing List"
{
    //DefaultLayout = RDLC;
    //RDLCLayout = './OCX Billing List.rdlc';
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Work Order Detail"; WorkOrderDetail)
        {

            trigger OnAfterGetRecord()
            begin
                QuotePrice := 0;

                IF Complete THEN BEGIN
                    CurrReport.SKIP;
                END ELSE BEGIN
                    CALCFIELDS("Detail Step");
                    CurrentStep := "Detail Step";
                    Current;
                    IncomeCode := "Income Code";
                    Code;
                    WOS.SETCURRENTKEY("Order No.", "Line No.");
                    WOS.SETRANGE(WOS."Order No.", "Work Order No.");
                    IF WOS.FIND('+') THEN BEGIN
                        IF WOS.Step.AsInteger() > 1 THEN BEGIN
                            IF WOS.Step.AsInteger() > 2 THEN BEGIN
                                IF Quote.AsInteger() = 2 THEN BEGIN  // UnRepairable
                                    QuotePrice := "Unrepairable Charge";
                                END ELSE BEGIN
                                    IF Quote.AsInteger() > 0 THEN BEGIN
                                        CALCFIELDS("Original Parts Price", "Original Labor Price");
                                        QuotePrice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";
                                    END ELSE BEGIN
                                        CALCFIELDS("Labor Quoted", "Parts Quoted");
                                        QuotePrice := "Labor Quoted" + "Parts Quoted" + "Order Adj.";
                                    END;
                                END;
                            END ELSE BEGIN
                                IF "Quote Phase".AsInteger() = 3 THEN BEGIN
                                    CALCFIELDS("Labor Quoted", "Parts Quoted");
                                    QuotePrice := "Labor Quoted" + "Parts Quoted" + "Order Adj.";
                                END ELSE BEGIN
                                    CurrReport.SKIP;
                                END;
                            END;
                        END ELSE BEGIN
                            CurrReport.SKIP;
                        END;
                    END ELSE BEGIN
                        CurrReport.SKIP;
                    END;
                END;
                FillExcelRow(TempExcelBuf, "Work Order Detail");
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
        BookNameTxt: Label 'Billing List';
        SheetNameTxt: Label 'Billing';
        HeaderTxt: Label 'Billing List';
        TempExcelBuf: Record "Excel Buffer" temporary;
        DetailStep: Enum DetailStep;
        WOS: Record Status;
        QuotePrice: Decimal;
        //CurrentStep: Option;
        CurrentStep: Enum DetailStep;
        CStep: Code[10];
        //IncomeCode: Option;
        IncomeCode: Enum IncomeCode;
        ICode: Code[10];
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
        "Work Order Detail": Record WorkOrderDetail)
    begin
        /*
          CellRow := CellRow + 1;
          Sheet.Range('A' + FORMAT(CellRow)).Value := "Work Order Detail"."Work Order No.";
          Sheet.Range('B' + FORMAT(CellRow)).Value := "Work Order Detail"."Model No.";
          Sheet.Range('C' + FORMAT(CellRow)).Value := CStep;
          Sheet.Range('D' + FORMAT(CellRow)).Value := "Build Ahead";
          Sheet.Range('E' + FORMAT(CellRow)).Value := QuotePrice;
          Sheet.Range('F' + FORMAT(CellRow)).Value := '';
          Sheet.Range('G' + FORMAT(CellRow)).Value := ICode;
          IF "Income Code" = 2 THEN  // SALES
            Sheet.Range('H' + FORMAT(CellRow)).Value := QuotePrice
          ELSE
            Sheet.Range('I' + FORMAT(CellRow)).Value := QuotePrice;
        */
        //with SalInvHeader do begin
        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn("Work Order Detail"."Work Order No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Work Order Detail"."Model No.", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(CStep, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn("Work Order Detail"."Build Ahead", false, '', false, false, false, '', TempExcelBuf."Cell Type"::Number);
        TempExcelBuf.AddColumn(QuotePrice, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn(ICode, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        if "Work Order Detail"."Income Code".AsInteger() = 2 then
            TempExcelBuf.AddColumn(QuotePrice, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text)
        else begin
            TempExcelBuf.AddColumn('', false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
            TempExcelBuf.AddColumn(QuotePrice, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
        end;
        //end;
    end;

    local procedure FillHeaderData(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        /*
        Sheet.Range('A' + FORMAT(CellRow)).Value := 'Work Order #';
        Sheet.Range('B' + FORMAT(CellRow)).Value := 'Model No.';
        Sheet.Range('C' + FORMAT(CellRow)).Value := 'Queue';
        Sheet.Range('D' + FORMAT(CellRow)).Value := 'Build Ahead';
        Sheet.Range('E' + FORMAT(CellRow)).Value := 'Value';
        Sheet.Range('F' + FORMAT(CellRow)).Value := 'Comments';
        Sheet.Range('G' + FORMAT(CellRow)).Value := 'Income Code';
        Sheet.Range('H' + FORMAT(CellRow)).Value := 'Sales';
        Sheet.Range('I' + FORMAT(CellRow)).Value := 'Service';
        */

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn('Work Order #', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Model No.', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Queue', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Build Ahead', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Value', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Comments', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Income Code', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Sales', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);
        TempExcelBuf.AddColumn('Service', false, '', true, false, true, '', TempExcelBuf."Cell Type"::Text);

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

    procedure Current()
    begin
        CASE CurrentStep OF
            CurrentStep::RCV:
                CStep := 'REC';
            CurrentStep::DIS:
                CStep := 'DIS';
            CurrentStep::QOT:
                CStep := 'QOT';
            CurrentStep::"B-O":
                CStep := 'B-O';
            CurrentStep::CLN:
                CStep := 'CLN';
            CurrentStep::ASM:
                CStep := 'ASM';
            CurrentStep::TST:
                CStep := 'TST';
            CurrentStep::REP:
                CStep := 'REP';
            CurrentStep::RET:
                CStep := 'RET';
            CurrentStep::MSP:
                CStep := 'MSP';
            CurrentStep::PNT:
                CStep := 'PNT';
            CurrentStep::QC:
                CStep := 'QC';
            CurrentStep::SHP:
                CStep := 'SHP';
            CurrentStep::NON:
                CStep := '';
        END;
    end;

    procedure "Code"()
    begin
        CASE IncomeCode OF
            IncomeCode::" ":
                ICode := '';
            IncomeCode::Service:
                ICode := 'SERVICE';
            IncomeCode::Sales:
                ICode := 'SALES';
            IncomeCode::Turbo:
                ICode := 'TURBO';
            IncomeCode::Electronic:
                ICode := 'ELECTRONIC';
            IncomeCode::Dry:
                ICode := 'DRY';
            IncomeCode::Cryo:
                ICode := 'CRYO';
        END;
    end;
}

