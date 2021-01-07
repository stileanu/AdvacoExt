report 50023 "Sales Credit Memo - ADVACO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50023_SalesCreditMemo_ADVACO.rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Credit Memo';
            column(Sales_Cr_Memo_Header_No_; "No.")
            {
            }
            //ICE RSK 12/23/20 begin
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {

            }
            //ICE RSK 12/23/20 end
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    TempSalesCrMemoLine := "Sales Cr.Memo Line";
                    TempSalesCrMemoLine.Insert;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesCrMemoLine.Reset;
                    TempSalesCrMemoLine.DeleteAll;
                end;
            }

            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Print On Credit Memo" = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    //with TempSalesCrMemoLine do begin
                    tempsalescrmemoline.Init;
                    TempSalesCrMemoLine."Document No." := "Sales Cr.Memo Header"."No.";
                    tempsalescrmemoline."Line No." := HighestLineNo + 1000;
                    HighestLineNo := "Line No.";
                    //end;
                    if StrLen(Comment) <= MaxStrLen(TempSalesCrMemoLine.Description) then begin
                        TempSalesCrMemoLine.Description := Comment;
                        TempSalesCrMemoLine."Description 2" := '';
                    end else begin
                        SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do
                            SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then
                            SpacePointer := MaxStrLen(TempSalesCrMemoLine.Description) + 1;
                        TempSalesCrMemoLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesCrMemoLine."Description 2" :=
                          CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesCrMemoLine."Description 2"));
                    end;
                    TempSalesCrMemoLine.Insert;
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyAddress_1_; CompanyAddress[1])
                    {
                    }
                    column(CompanyAddress_2_; CompanyAddress[2])
                    {
                    }
                    column(CompanyAddress_3_; CompanyAddress[3])
                    {
                    }
                    column(CompanyAddress_4_; CompanyAddress[4])
                    {
                    }
                    column(CompanyAddress_5_; CompanyAddress[5])
                    {
                    }
                    column(CompanyAddress_6_; CompanyAddress[6])
                    {
                    }
                    column(CopyTxt; CopyTxt)
                    {
                    }
                    column(BillToAddress_1_; BillToAddress[1])
                    {
                    }
                    column(BillToAddress_2_; BillToAddress[2])
                    {
                    }
                    column(BillToAddress_3_; BillToAddress[3])
                    {
                    }
                    column(BillToAddress_4_; BillToAddress[4])
                    {
                    }
                    column(BillToAddress_5_; BillToAddress[5])
                    {
                    }
                    column(BillToAddress_6_; BillToAddress[6])
                    {
                    }
                    column(BillToAddress_7_; BillToAddress[7])
                    {
                    }
                    column(Sales_Cr_Memo_Header___Applies_to_Doc__No__; "Sales Cr.Memo Header"."Applies-to Doc. No.")
                    {
                    }
                    column(ShipToAddress_1_; ShipToAddress[1])
                    {
                    }
                    column(ShipToAddress_2_; ShipToAddress[2])
                    {
                    }
                    column(ShipToAddress_3_; ShipToAddress[3])
                    {
                    }
                    column(ShipToAddress_4_; ShipToAddress[4])
                    {
                    }
                    column(ShipToAddress_5_; ShipToAddress[5])
                    {
                    }
                    column(ShipToAddress_6_; ShipToAddress[6])
                    {
                    }
                    column(ShipToAddress_7_; ShipToAddress[7])
                    {
                    }
                    column(Sales_Cr_Memo_Header___Bill_to_Customer_No__; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Cr_Memo_Header___No__; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    //column(CurrReport_PAGENO;CurrReport.PageNo)
                    //{
                    //}
                    column(CompanyAddress_7_; CompanyAddress[7])
                    {
                    }
                    column(CompanyAddress_8_; CompanyAddress[8])
                    {
                    }
                    column(BillToAddress_8_; BillToAddress[8])
                    {
                    }
                    column(ShipToAddress_8_; ShipToAddress[8])
                    {
                    }
                    column(Sales_Cr_Memo_Header___Posting_Date_; "Sales Cr.Memo Header"."Posting Date")
                    {
                    }
                    column(Sales_Cr_Memo_Header___Your_Reference_; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    column(Credit_MemoCaption; Credit_MemoCaptionLbl)
                    {
                    }
                    column(Page_Caption; Page_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(SalesCrMemoLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(TempSalesCrMemoLine_Quantity; TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(AmountExclInvDisc; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine_Description_________TempSalesCrMemoLine__Description_2_; TempSalesCrMemoLine.Description + ' ' + TempSalesCrMemoLine."Description 2")
                        {
                        }
                        column(TempSalesCrMemoLine_Quantity_Control28; TempSalesCrMemoLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(AmountExclInvDisc_Control79; AmountExclInvDisc)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_Tax____TempSalesCrMemoLine_Amount; TempSalesCrMemoLine."Amount Including VAT" - TempSalesCrMemoLine.Amount)
                        {
                        }
                        column(TempSalesCrMemoLine__Amount_Including_Tax_; TempSalesCrMemoLine."Amount Including VAT")
                        {
                        }
                        column(Subtotal_Caption; Subtotal_CaptionLbl)
                        {
                        }
                        column(Sales_Tax_Caption; Sales_Tax_CaptionLbl)
                        {
                        }
                        column(Credit_Total_Caption; Credit_Total_CaptionLbl)
                        {
                        }
                        column(SalesCrMemoLine_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            //with TempSalesCrMemoLine do begin
                            if OnLineNumber = 1 then
                                TempSalesCrMemoLine.Find('-')
                            else
                                TempSalesCrMemoLine.Next;

                            //if Type = 0 then begin
                            if TempSalesCrMemoLine.Type.AsInteger() = 0 then begin
                                TempSalesCrMemoLine."No." := '';
                                TempSalesCrMemoLine."Unit of Measure" := '';
                                TempSalesCrMemoLine.Amount := 0;
                                TempSalesCrMemoLine."Amount Including VAT" := 0;
                                TempSalesCrMemoLine."Inv. Discount Amount" := 0;
                                TempSalesCrMemoLine.Quantity := 0;
                            end else
                                if TempSalesCrMemoLine.Type = TempSalesCrMemoLine.Type::"G/L Account" then
                                    TempSalesCrMemoLine."No." := '';

                            if TempSalesCrMemoLine.Amount <> TempSalesCrMemoLine."Amount Including VAT" then begin
                                TaxFlag := true;
                                TaxLiable := TempSalesCrMemoLine.Amount;
                            end else begin
                                TaxFlag := false;
                                TaxLiable := 0;
                            end;

                            AmountExclInvDisc := TempSalesCrMemoLine.Amount + TempSalesCrMemoLine."Inv. Discount Amount";

                            if TempSalesCrMemoLine.Quantity = 0 then
                                UnitPriceToPrint := 0  // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempSalesCrMemoLine.Quantity, 0.00001);
                            //end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.CreateTotals(TaxLiable,AmountExclInvDisc,TempSalesCrMemoLine.Amount,TempSalesCrMemoLine."Amount Including VAT");
                            NumberOfLines := TempSalesCrMemoLine.Count;
                            SetRange(Number, 1, NumberOfLines);
                            OnLineNumber := 0;
                            PrintFooter := false;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    //CurrReport.PageNo := 1;

                    if CopyNo = NoLoops then begin
                        if not CurrReport.Preview then
                            SalesCrMemoPrinted.Run("Sales Cr.Memo Header");
                        CurrReport.Break;
                    end else
                        CopyNo := CopyNo + 1;
                    if CopyNo = 1 then // Original
                        Clear(CopyTxt)
                    else
                        CopyTxt := 'COPY';
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1 + Abs(NoCopies);
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");

                FormatAddress.SalesCrMemoBillTo(BillToAddress, "Sales Cr.Memo Header");
                //FormatAddress.SalesCrMemoShipTo(ShipToAddress, ShipToAddress, "Sales Cr.Memo Header");
                FormatAddress.SalesCrMemoShipTo(ShipToAddress, BillToAddress, "Sales Cr.Memo Header");
                CalcFields("Amount Including VAT"); //ICE RSK 12/23/20
            end;

            trigger OnPreDataItem()
            begin
                //if PrintCompany then begin
                CompanyInformation.Get('');
                FormatAddress.Company(CompanyAddress, CompanyInformation);
                //end else
                //    Clear(CompanyAddress);
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
                    field(NoCopies; NoCopies)
                    {
                        Caption = 'Number of Copies';
                    }
                    field(PrintCompanyAddress; PrintCompany)
                    {
                        Caption = 'Print Company Address';
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

    var
        TaxLiable: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInformation: Record "Company Information";
        TempSalesCrMemoLine: Record "Sales Cr.Memo Line" temporary;
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        PrintCompany: Boolean;
        PrintFooter: Boolean;
        TaxFlag: Boolean;
        NoCopies: Integer;
        NoLoops: Integer;
        CopyNo: Integer;
        NumberOfLines: Integer;
        OnLineNumber: Integer;
        HighestLineNo: Integer;
        SpacePointer: Integer;
        SalesCrMemoPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddress: Codeunit "Format Address";
        Credit_MemoCaptionLbl: Label 'Credit Memo';
        Page_CaptionLbl: Label 'Page:';
        Subtotal_CaptionLbl: Label 'Subtotal:';
        Sales_Tax_CaptionLbl: Label 'Sales Tax:';
        Credit_Total_CaptionLbl: Label 'Credit Total:';
}

