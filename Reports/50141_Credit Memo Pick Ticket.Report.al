report 50141 "Credit Memo Pick Ticket"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50141_Credit Memo Pick Ticket.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER("Credit Memo"));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Purchase Document';
            column(Purchase_Header__No__; "No.")
            {
            }
            column(Purchase_Header__Shipping_Agent_; "Shipping Agent")
            {
            }
            column(Purchase_Header__Shipping_Charge_; "Shipping Charge")
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
            column(Purchase_Header__Shipping_Account_; "Shipping Account")
            {
            }
            column(Purchase_Header__Purchase_Header___Document_Date_; "Purchase Header"."Document Date")
            {
            }
            column(Purchase_Header__RMA_No__; "RMA No.")
            {
            }
            column(Credit_Memo___Caption; Credit_Memo___CaptionLbl)
            {
            }
            column(CREDIT_MEMO_______PICK_TICKETCaption; CREDIT_MEMO_______PICK_TICKETCaptionLbl)
            {
            }
            column(ADVACOCaption; ADVACOCaptionLbl)
            {
            }
            column(Shipping_Agent_Caption; Shipping_Agent_CaptionLbl)
            {
            }
            column(V410_876_8200Caption; V410_876_8200CaptionLbl)
            {
            }
            column(WESTMINSTER__MD_21157Caption; WESTMINSTER__MD_21157CaptionLbl)
            {
            }
            column(V1215_BUSINESS_PKWY_N_Caption; V1215_BUSINESS_PKWY_N_CaptionLbl)
            {
            }
            column(ADVANCED_VACUUM_COMPANY__INCCaption; ADVANCED_VACUUM_COMPANY__INCCaptionLbl)
            {
            }
            column(Ship_From_Caption; Ship_From_CaptionLbl)
            {
            }
            column(Shipping_Charge_Caption; Shipping_Charge_CaptionLbl)
            {
            }
            column(Ship_To_Caption; Ship_To_CaptionLbl)
            {
            }
            column(Shipping_Account_Caption; Shipping_Account_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Vendor_RMA___Caption; Vendor_RMA___CaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(ItemNumberToPrint; ItemNumberToPrint)
                {
                }
                column(Purchase_Line_Description; Description)
                {
                }
                column(Purchase_Line_Quantity; Quantity)
                {
                }
                column(Purchase_Line__Direct_Unit_Cost_; "Direct Unit Cost")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(Amount__Inv__Discount_Amount_; Amount + "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Purchase_Line__Bin_Code_; "Bin Code")
                {
                }
                column(EmptyString; '______________')
                {
                }
                column(Purchase_Line_Amount; Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Purchase_Line__Amount_Including_Tax_; "Amount Including VAT")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalText; TotalText)
                {
                }
                column(TotalInclTaxText; TotalInclTaxText)
                {
                }
                column(TaxAmountLine_TaxAmountText; TaxAmountLine.VATAmountText)
                {
                }
                column(Amount_Including_Tax____Amount; "Amount Including VAT" - Amount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(Item_No_Caption; Item_No_CaptionLbl)
                {
                }
                column(Purchase_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(QtyCaption; QtyCaptionLbl)
                {
                }
                column(PriceCaption; PriceCaptionLbl)
                {
                }
                column(Amount__Inv__Discount_Amount_Caption; Amount__Inv__Discount_Amount_CaptionLbl)
                {
                }
                column(BinCaption; BinCaptionLbl)
                {
                }
                column(SHPCaption; SHPCaptionLbl)
                {
                }
                column(Purchase_Line_Document_Type; "Document Type")
                {
                }
                column(Purchase_Line_Document_No_; "Document No.")
                {
                }
                column(Purchase_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TaxAmountLine.Init;
                    TaxAmountLine."VAT %" := "VAT %";
                    TaxAmountLine."VAT Base" := Amount;
                    TaxAmountLine."Amount Including VAT" := "Amount Including VAT";
                    TaxAmountLine.InsertLine;

                    case Type of
                        Type::"G/L Account":
                            begin

                            end;
                        Type::Item:
                            begin

                            end;
                    end;

                    if Type <> Type::"G/L Account" then
                        //  ItemNumberToPrint := "Cross Reference Item"
                        //ELSE
                        ItemNumberToPrint := "No.";
                end;

                trigger OnPreDataItem()
                begin
                    TaxAmountLine.DeleteAll;
                    //CurrReport.CreateTotals(Amount,"Amount Including VAT","Inv. Discount Amount"); ICE-MPC 08/13/20
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FormatAddr.PurchHeaderPayTo(PayToAddress, "Purchase Header");
                FormatAddr.PurchHeaderBuyFrom(BuyFromAddress, "Purchase Header");
                FormatAddr.PurchHeaderShipTo(ShipToAddress, "Purchase Header");
                if "Currency Code" = '' then begin
                    TotalText := 'Total';
                    TotalInclTaxText := 'Total Incl. Tax';
                end else begin
                    TotalText := StrSubstNo('Total %1', "Currency Code");
                    TotalInclTaxText := StrSubstNo('Total %1 Incl. Tax', "Currency Code");
                end;
            end;

            trigger OnPreDataItem()
            begin
                FormatAddress.Company(CompanyAddress, CompanyInformation)
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
        PurchHeaderFilter := "Purchase Header".GetFilters;
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        PurchSetup: Record "Purchases & Payables Setup";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        Vend: Record Vendor;
        VendLedgEntry: Record "Vendor Ledger Entry";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        PurchReceiptLine: Record "Purch. Rcpt. Line";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        GenPostingSetup: Record "General Posting Setup";
        TaxAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        CompanyAddress: array[8] of Text[50];
        PayToAddress: array[8] of Text[50];
        BuyFromAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        PurchHeaderFilter: Text[250];
        InvOnNextPostReq: Boolean;
        ReceiveOnNextPostReq: Boolean;
        ReceiveInvoiceText: Text[50];
        TotalText: Text[50];
        TotalInclTaxText: Text[50];
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        MaxQtyToBeInvoiced: Decimal;
        RemQtyToBeInvoiced: Decimal;
        QtyToBeInvoiced: Decimal;
        DropShipOrder: Boolean;
        ErrorCounter: Integer;
        ErrorText: array[99] of Text[250];
        FormatAddress: Codeunit "Format Address";
        ItemNumberToPrint: Text[30];
        PurchaseInvoice: Record "Purch. Inv. Header";
        InvoiceNo: Code[30];
        OrderNo: Code[30];
        v: Record Vendor;
        ok: Boolean;
        Credit_Memo___CaptionLbl: Label 'Credit Memo #:';
        CREDIT_MEMO_______PICK_TICKETCaptionLbl: Label 'CREDIT MEMO   -   PICK TICKET';
        ADVACOCaptionLbl: Label 'ADVACO';
        Shipping_Agent_CaptionLbl: Label 'Shipping Agent:';
        V410_876_8200CaptionLbl: Label '410 876-8200';
        WESTMINSTER__MD_21157CaptionLbl: Label 'WESTMINSTER, MD 21157';
        V1215_BUSINESS_PKWY_N_CaptionLbl: Label '1215 BUSINESS PKWY N.';
        ADVANCED_VACUUM_COMPANY__INCCaptionLbl: Label 'ADVANCED VACUUM COMPANY, INC';
        Ship_From_CaptionLbl: Label 'Ship From:';
        Shipping_Charge_CaptionLbl: Label 'Shipping Charge:';
        Ship_To_CaptionLbl: Label 'Ship To:';
        Shipping_Account_CaptionLbl: Label 'Shipping Account:';
        Date_CaptionLbl: Label 'Date:';
        Vendor_RMA___CaptionLbl: Label 'Vendor RMA #:';
        Item_No_CaptionLbl: Label 'Item No.';
        QtyCaptionLbl: Label 'Qty';
        PriceCaptionLbl: Label 'Price';
        Amount__Inv__Discount_Amount_CaptionLbl: Label 'Amount';
        BinCaptionLbl: Label 'Bin';
        SHPCaptionLbl: Label 'SHP';

    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;
}

