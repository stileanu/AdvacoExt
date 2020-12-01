report 50031 "OCX Billing List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OCX Billing List.rdlc';

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
                        IF WOS.Step > 1 THEN BEGIN
                            IF WOS.Step > 2 THEN BEGIN
                                IF Quote = 2 THEN BEGIN  // UnRepairable
                                    QuotePrice := "Unrepairable Charge";
                                END ELSE BEGIN
                                    IF Quote > 0 THEN BEGIN
                                        CALCFIELDS("Original Parts Price", "Original Labor Price");
                                        QuotePrice := "Original Parts Price" + "Original Labor Price" + "Order Adj.";
                                    END ELSE BEGIN
                                        CALCFIELDS("Labor Quoted", "Parts Quoted");
                                        QuotePrice := "Labor Quoted" + "Parts Quoted" + "Order Adj.";
                                    END;
                                END;
                            END ELSE BEGIN
                                IF "Quote Phase" = 3 THEN BEGIN
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
            end;

            trigger OnPreDataItem()
            begin
                // Excel
                /*  CREATE(Excel);
                  Excel.Visible(TRUE);
                  Book := Excel.Workbooks.Add(-4167);
                  Sheet := Excel.ActiveSheet;
                  */
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

    var
        WOS: Record Status;
        QuotePrice: Decimal;
        CurrentStep: Option;
        CStep: Code[10];
        IncomeCode: Option;
        ICode: Code[10];
        Excel: Automation;
        Book: Automation;
        Sheet: Automation;
        Range: Automation;
        LaunchExcel: Boolean;
        AlphabetArray: array[26] of Text[1];
        CellRow: Integer;
        CellColumn: Integer;
        CellValue: Text[30];
        HeaderDone: Boolean;

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
            0:
                CStep := 'REC';
            1:
                CStep := 'DIS';
            2:
                CStep := 'QOT';
            3:
                CStep := 'B-O';
            4:
                CStep := 'CLN';
            5:
                CStep := 'ASM';
            6:
                CStep := 'TST';
            7:
                CStep := 'REP';
            8:
                CStep := 'RET';
            9:
                CStep := 'MSP';
            10:
                CStep := 'PNT';
            11:
                CStep := 'QC';
            12:
                CStep := 'SHP';
            100:
                CStep := '';
        END;
    end;

    procedure "Code"()
    begin
        CASE IncomeCode OF
            0:
                ICode := '';
            1:
                ICode := 'SERVICE';
            2:
                ICode := 'SALES';
            3:
                ICode := 'TURBO';
            4:
                ICode := 'ELECTRONIC';
            5:
                ICode := 'DRY';
            6:
                ICode := 'CRYO';
        END;
    end;
}

