report 50027 "OCX Sales Analysis"
{
    UseRequestPage = true;
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    //RDLCLayout = './50027_OCX Sales Analysis.Rpt.rdl';
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
                // Excel  Removed ICE-MPC 09/11/20
                /*  CREATE(Excel);
                  Excel.Visible(TRUE);
                  Book := Excel.Workbooks.Add(-4167);
                  Sheet := Excel.ActiveSheet;*/
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
        PartsCostInvoiceP: Decimal;
        TotalUnitCost: Decimal;
        ok: Boolean;
        TotalAmount: Decimal;
        OrderNo: Code[20];
        //Excel: Automation ;
        //Book: Automation ;
        //Sheet: Automation ;
        //Range: Automation ;
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

