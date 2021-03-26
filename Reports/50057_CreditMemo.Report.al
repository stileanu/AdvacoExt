report 50057 "Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50057_CreditMemo.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Document Type", "No.";
            RequestFilterHeading = 'Purchase Document';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyAddress_3_; CompanyAddress[3])
                {
                }
                column(CompanyAddress_2_; CompanyAddress[2])
                {
                }
                column(CompanyAddress_1_; CompanyAddress[1])
                {
                }
                column(Purchase_Header___No__; "Purchase Header"."No.")
                {
                }
                column(Purchase_Header___Document_Date_; "Purchase Header"."Document Date")
                {
                }
                column(Phone_____CompanyInformation__Phone_No__; 'Phone ' + CompanyInformation."Phone No.")
                {
                }
                column(Fax_____CompanyInformation__Fax_No__; 'Fax ' + CompanyInformation."Fax No.")
                {
                }
                column(ShipToAddress_1_; ShipToAddress[1])
                {
                }
                column(ShipToAddress_2_; ShipToAddress[2])
                {
                }
                column(BuyFromAddress_1_; BuyFromAddress[1])
                {
                }
                column(BuyFromAddress_2_; BuyFromAddress[2])
                {
                }
                column(BuyFromAddress_3_; BuyFromAddress[3])
                {
                }
                column(ShipToAddress_3_; ShipToAddress[3])
                {
                }
                column(BuyFromAddress_4_; BuyFromAddress[4])
                {
                }
                column(ShipToAddress_4_; ShipToAddress[4])
                {
                }
                column(BuyFromAddress_5_; BuyFromAddress[5])
                {
                }
                column(ShipToAddress_5_; ShipToAddress[5])
                {
                }
                column(BuyFromAddress_6_; BuyFromAddress[6])
                {
                }
                column(ShipToAddress_6_; ShipToAddress[6])
                {
                }
                column(InvoiceNo; InvoiceNo)
                {
                }
                column(v_Contact; v.Contact)
                {
                }
                column(OrderNo; OrderNo)
                {
                }
                column(v__Phone_No__; v."Phone No.")
                {
                }
                column(v__Fax_No__; v."Fax No.")
                {
                }
                column(PURCHASE_CREDIT_MEMOCaption; PURCHASE_CREDIT_MEMOCaptionLbl)
                {
                }
                column(Credit_Memo_Number_Caption; Credit_Memo_Number_CaptionLbl)
                {
                }
                column(Credit_Memo_Date_Caption; Credit_Memo_Date_CaptionLbl)
                {
                }
                column(Page_Caption; Page_CaptionLbl)
                {
                }
                column(ShipCaption; ShipCaptionLbl)
                {
                }
                column(To_Caption; To_CaptionLbl)
                {
                }
                column(To_Caption_Control47; To_Caption_Control47Lbl)
                {
                }
                column(PayCaption; PayCaptionLbl)
                {
                }
                column(Applies_To_Invoice_Caption; Applies_To_Invoice_CaptionLbl)
                {
                }
                column(Contact_Caption; Contact_CaptionLbl)
                {
                }
                column(Applies_To_Order_Caption; Applies_To_Order_CaptionLbl)
                {
                }
                column(Phone_Caption; Phone_CaptionLbl)
                {
                }
                column(Fax_Caption; Fax_CaptionLbl)
                {
                }
                column(PageCounter_Number; Number)
                {
                }
                dataitem(HeaderErrorCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    trigger OnPostDataItem()
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Number, 1, ErrorCounter);
                    end;
                }
                dataitem("Purchase Line"; "Purchase Line")
                {
                    //DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    DataItemLinkReference = "Purchase Header";
                    DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
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
                    column(Purchase_Line_QuantityCaption; FieldCaption(Quantity))
                    {
                    }
                    column(PriceCaption; PriceCaptionLbl)
                    {
                    }
                    column(Amount__Inv__Discount_Amount_Caption; Amount__Inv__Discount_Amount_CaptionLbl)
                    {
                    }
                    column(Our_records__show_that_a_credit_is_due_for_the_above_item_s__Caption; Our_records__show_that_a_credit_is_due_for_the_above_item_s__CaptionLbl)
                    {
                    }
                    column(However__we_have_not_received_a_credit_document_to_apply_against_the_item_s__Caption; However__we_have_not_received_a_credit_document_to_apply_against_the_item_s__CaptionLbl)
                    {
                    }
                    column(If_we_do_not_receive_a_credit_document_by_the_end_of_the_current_month_Caption; If_we_do_not_receive_a_credit_document_by_the_end_of_the_current_month_CaptionLbl)
                    {
                    }
                    column(we_will_be_posting_a_credit_against_your_account_for_the_total_amount_below_Caption; we_will_be_posting_a_credit_against_your_account_for_the_total_amount_below_CaptionLbl)
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
                    dataitem(LineErrorCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnPostDataItem()
                        begin
                            ErrorCounter := 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, ErrorCounter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        TaxAmountLine.Init;
                        TaxAmountLine."VAT %" := "VAT %";
                        TaxAmountLine."VAT Base" := Amount;
                        TaxAmountLine."Amount Including VAT" := "Amount Including VAT";
                        TaxAmountLine.InsertLine;

                        if "Document Type" <> "Document Type"::Order then begin
                            if "Qty. to Receive" <> Quantity then
                                AddError(StrSubstNo('%1 must be %2.', FieldName("Qty. to Receive"), Quantity));
                            if "Qty. to Invoice" <> Quantity then
                                AddError(StrSubstNo('%1 must be %2.', FieldName("Qty. to Invoice"), Quantity));
                        end;

                        if not "Purchase Header".Receive then
                            "Qty. to Receive" := 0;

                        if ("Document Type" = "Document Type"::Invoice) and ("Receipt No." <> '') then begin
                            "Quantity Received" := Quantity;
                            "Qty. to Receive" := 0;
                        end;

                        if "Purchase Header".Invoice then begin
                            MaxQtyToBeInvoiced := "Qty. to Receive" + "Quantity Received" - "Quantity Invoiced";
                            if Abs("Qty. to Invoice") > Abs(MaxQtyToBeInvoiced) then
                                "Qty. to Invoice" := MaxQtyToBeInvoiced;
                        end else
                            "Qty. to Invoice" := 0;

                        if "Gen. Prod. Posting Group" <> '' then begin
                            Clear(GenPostingSetup);
                            GenPostingSetup.Reset;
                            GenPostingSetup.SetRange("Gen. Bus. Posting Group", "Gen. Bus. Posting Group");
                            GenPostingSetup.SetRange("Gen. Prod. Posting Group", "Gen. Prod. Posting Group");
                            if not GenPostingSetup.Find('+') then
                                AddError(
                                  StrSubstNo(
                                    '%1 %2 %3 does not exist.',
                                    GenPostingSetup.TableName, "Gen. Bus. Posting Group", "Gen. Prod. Posting Group"));
                        end;

                        if Quantity <> 0 then begin
                            if "No." = '' then
                                AddError(StrSubstNo('%1 must be specified.', FieldName("No.")));
                            if Type.AsInteger() = 0 then
                                AddError(StrSubstNo('%1 must be specified.', FieldName(Type)));
                        end else
                            if Amount <> 0 then
                                AddError(StrSubstNo('%1 must be 0 when %2 is 0.', FieldName(Amount), FieldName(Quantity)));

                        PurchLine := "Purchase Line";
                        if "Document Type" = "Document Type"::"Credit Memo" then begin
                            PurchLine."Qty. to Receive" := -PurchLine."Qty. to Receive";
                            PurchLine."Qty. to Invoice" := -PurchLine."Qty. to Invoice";
                        end;

                        RemQtyToBeInvoiced := PurchLine."Qty. to Invoice";

                        if Abs(RemQtyToBeInvoiced) > Abs("Qty. to Receive") then begin
                            PurchReceiptLine.Reset;
                            case "Document Type" of
                                "Document Type"::Order:
                                    begin
                                        PurchReceiptLine.SetCurrentKey("Order No.", "Order Line No.");
                                        PurchReceiptLine.SetRange("Order No.", "Document No.");
                                        PurchReceiptLine.SetRange("Order Line No.", "Line No.");
                                    end;
                                "Document Type"::Invoice:
                                    begin
                                        PurchReceiptLine.SetRange("Document No.", "Receipt No.");
                                        PurchReceiptLine.SetRange("Line No.", "Receipt Line No.");
                                    end;
                            end;
                            if PurchReceiptLine.Find('-') then
                                repeat
                                    if PurchReceiptLine."Quantity Invoiced" <> PurchReceiptLine.Quantity then begin
                                        if PurchReceiptLine."Buy-from Vendor No." <> "Buy-from Vendor No." then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Buy-from Vendor No.")));
                                        if PurchReceiptLine.Type <> Type then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName(Type)));
                                        if PurchReceiptLine."No." <> "No." then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("No.")));
                                        if PurchReceiptLine."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Gen. Bus. Posting Group")));
                                        if PurchReceiptLine."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Gen. Prod. Posting Group")));
                                        if PurchReceiptLine."Location Code" <> "Location Code" then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Location Code")));
                                        if PurchReceiptLine."Shortcut Dimension 1 Code" <> "Shortcut Dimension 1 Code" then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Shortcut Dimension 1 Code")));
                                        if PurchReceiptLine."Shortcut Dimension 2 Code" <> "Shortcut Dimension 2 Code" then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Shortcut Dimension 2 Code")));
                                        if PurchReceiptLine."Job No." <> "Job No." then
                                            AddError(
                                              StrSubstNo(
                                                'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                                FieldName("Job No.")));
                                        //        IF PurchReceiptLine."Serial No." <> "Serial No." THEN
                                        //          AddError(
                                        //            STRSUBSTNO(
                                        //              'The %1 on the receipt is not the same as the %1 on the purchase header.',
                                        //              FIELDNAME("Serial No.")));

                                        if PurchLine."Qty. to Invoice" * PurchReceiptLine.Quantity < 0 then
                                            AddError(StrSubstNo('%1 must have the same sign as the receipt.', FieldName("Qty. to Invoice")));

                                        QtyToBeInvoiced := RemQtyToBeInvoiced - PurchLine."Qty. to Receive";
                                        if Abs(QtyToBeInvoiced) > Abs(PurchReceiptLine.Quantity - PurchReceiptLine."Quantity Invoiced") then
                                            QtyToBeInvoiced := PurchReceiptLine.Quantity - PurchReceiptLine."Quantity Invoiced";
                                        RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
                                        PurchReceiptLine."Quantity Invoiced" := PurchReceiptLine."Quantity Invoiced" + QtyToBeInvoiced;
                                    end;
                                until (PurchReceiptLine.Next = 0) or (Abs(RemQtyToBeInvoiced) <= Abs("Qty. to Receive"));
                        end;

                        if Abs(RemQtyToBeInvoiced) > Abs("Qty. to Receive") then
                            if "Document Type" = "Document Type"::Invoice then
                                AddError(StrSubstNo('Receipt %1 has been invoiced since it was received.', "Purchase Line"."Receipt No."))
                            else
                                AddError('Receipt lines have been deleted.');

                        if (Type >= Type::"G/L Account") and ("Qty. to Invoice" <> 0) then
                            if GLSetup."VAT in Use" then
                                if not GenPostingSetup.Get("Gen. Bus. Posting Group", "Gen. Prod. Posting Group") then
                                    AddError(
                                      StrSubstNo(
                                        '%1 %2 %3 does not exist.',
                                        GenPostingSetup.TableName, "Gen. Bus. Posting Group", "Gen. Prod. Posting Group"));

                        case Type of
                            Type::"G/L Account":
                                begin
                                    if ("No." = '') and (Amount = 0) then
                                        exit;

                                    if "No." <> '' then
                                        if GLAcc.Get("No.") then begin
                                            if GLAcc.Blocked then
                                                AddError(
                                                  StrSubstNo(
                                                    '%1 must be %2 for %3 %4.',
                                                    GLAcc.FieldName(Blocked), false, GLAcc.TableName, "No."));
                                            if not GLAcc."Direct Posting" then
                                                AddError(
                                                  StrSubstNo(
                                                    '%1 must be %2 for %3 %4.',
                                                    GLAcc.FieldName("Direct Posting"), true, GLAcc.TableName, "No."));
                                        end else
                                            AddError(
                                              StrSubstNo(
                                                '%1 %2 does not exist.',
                                                GLAcc.TableName, "No."));
                                end;
                            Type::Item:
                                begin
                                    if ("No." = '') and (Quantity = 0) then
                                        exit;

                                    if "No." <> '' then
                                        if Item.Get("No.") then begin
                                            if Item.Blocked then
                                                AddError(
                                                  StrSubstNo(
                                                    '%1 must be %2 for %3 %4.',
                                                    Item.FieldName(Blocked), false, Item.TableName, "No."));
                                            if Item."Costing Method" = Item."Costing Method"::Specific then begin
                                                //IF "Serial No." = '' THEN
                                                //  AddError(
                                                //    STRSUBSTNO(
                                                //      '%1 must be filled in when %2 is %3.',
                                                //      FIELDNAME("Serial No."),Item.FIELDNAME("Costing Method"),Item."Costing Method"));
                                                if Item.Reserve = Item.Reserve::Always then
                                                    if (Signed(Quantity) < 0) and (Abs("Reserved Quantity") < Abs("Qty. to Receive")) then
                                                        AddError(
                                                          StrSubstNo(
                                                            '%1 must be %2.',
                                                            FieldName("Reserved Quantity"), Signed("Qty. to Receive")));
                                            end;
                                        end else
                                            AddError(
                                              StrSubstNo(
                                                '%1 %2 does not exist.',
                                                Item.TableName, "No."));
                                end;
                            Type::"Fixed Asset":
                                begin
                                    if ("No." = '') and (Quantity = 0) then
                                        exit;

                                    if "No." <> '' then
                                        if FA.Get("No.") then begin
                                            if FA.Blocked then
                                                AddError(
                                                  StrSubstNo(
                                                    '%1 must be %2 for %3 %4.',
                                                    FA.FieldName(Blocked), false, FA.TableName, "No."));
                                            if FA.Inactive then
                                                AddError(
                                                  StrSubstNo(
                                                    '%1 must be %2 for %3 %4.',
                                                    FA.FieldName(Inactive), false, FA.TableName, "No."));
                                        end else
                                            AddError(
                                              StrSubstNo(
                                                '%1 %2 does not exist.',
                                                FA.TableName, "No."));
                                end;
                        end;

                        //IF ((Type = Type::Item) OR (Type = Type::"Fixed Asset")) AND ("Serial No." <> '') THEN
                        //  IF (Quantity = "Quantity Invoiced") OR ("Quantity Invoiced" = 0) THEN BEGIN
                        //    IF ABS(Quantity) <> 1 THEN
                        //      AddError(
                        //        STRSUBSTNO(
                        //         '%1 must be 1 or -1 when %2 has been specified.',
                        //         FIELDNAME(Quantity),FIELDNAME("Serial No.")));
                        //     END ELSE BEGIN
                        //       IF ABS("Quantity Invoiced") <> 1 THEN
                        //         AddError(
                        //           STRSUBSTNO(
                        //          '%1 must be 1 or -1 when %2 has been specified.',
                        //          FIELDNAME("Quantity Invoiced"),FIELDNAME("Serial No.")));
                        //     END;

                        //IF Type = Type::"G/L Account" THEN
                        //  ItemNumberToPrint := "Cross Reference Item"
                        //ELSE
                        ItemNumberToPrint := "No.";
                    end;

                    trigger OnPreDataItem()
                    begin
                        TaxAmountLine.DeleteAll;
                        CurrReport.CreateTotals(Amount, "Amount Including VAT", "Inv. Discount Amount");
                    end;
                }
                dataitem(TaxCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);

                    trigger OnAfterGetRecord()
                    begin
                        TaxAmountLine.GetLine(Number);
                    end;

                    trigger OnPreDataItem()
                    begin
                        if TaxAmountLine.Count <= 1 then
                            CurrReport.Break;
                        SetRange(Number, 1, TaxAmountLine.Count);
                        CurrReport.CreateTotals(TaxAmountLine."VAT Base", TaxAmountLine."VAT Amount");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if PurchaseInvoice.Get("Purchase Header"."Applies-to Doc. No.") then begin
                        InvoiceNo := PurchaseInvoice."Vendor Invoice No.";
                        OrderNo := PurchaseInvoice."Order No.";
                    end else begin
                        InvoiceNo := '';
                        OrderNo := '';
                    end;

                    if v.Get("Purchase Header"."Pay-to Vendor No.") then
                        ok := true;
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

                Invoice := InvOnNextPostReq;
                Receive := ReceiveOnNextPostReq;

                if "Buy-from Vendor No." = '' then
                    AddError(StrSubstNo('%1 must be specified.', FieldName("Buy-from Vendor No.")))
                else begin
                    if Vend.Get("Buy-from Vendor No.") then begin
                        if Vend.Blocked <> Vend.Blocked::" " then
                            AddError(
                              StrSubstNo(
                                '%1 must be %2 for %3 %4.',
                                Vend.FieldName(Blocked), false, Vend.TableName, "Buy-from Vendor No."));
                    end else
                        AddError(
                          StrSubstNo(
                            '%1 %2 does not exist.',
                            Vend.TableName, "Buy-from Vendor No."));
                end;

                if "Pay-to Vendor No." = '' then
                    AddError(StrSubstNo('%1 must be specified.', FieldName("Pay-to Vendor No.")))
                else begin
                    if Vend.Get("Pay-to Vendor No.") then begin
                        if Vend.Blocked <> Vend.Blocked::" " then
                            AddError(
                              StrSubstNo(
                                '%1 must be %2 for %3 %4.',
                                Vend.FieldName(Blocked), false, Vend.TableName, "Pay-to Vendor No."));
                    end else
                        AddError(
                          StrSubstNo(
                            '%1 %2 does not exist.',
                            Vend.TableName, "Pay-to Vendor No."));
                end;

                PurchSetup.Get;
                GLSetup.Get;

                if "Posting Date" = 0D then
                    AddError(StrSubstNo('%1 must be specified.', FieldName("Posting Date")))
                else
                    if "Posting Date" <> NormalDate("Posting Date") then
                        AddError(StrSubstNo('%1 must not be a closing date.', FieldName("Posting Date")))
                    else begin
                        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                            if UserId <> '' then
                                if UserSetup.Get(UserId) then begin
                                    AllowPostingFrom := UserSetup."Allow Posting From";
                                    AllowPostingTo := UserSetup."Allow Posting To";
                                end;
                            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                                AllowPostingFrom := GLSetup."Allow Posting From";
                                AllowPostingTo := GLSetup."Allow Posting To";
                            end;
                            if AllowPostingTo = 0D then
                                AllowPostingTo := 99991231D;
                        end;
                        if ("Posting Date" < AllowPostingFrom) or ("Posting Date" > AllowPostingTo) then
                            AddError(StrSubstNo('%1 is not within your allowed range of posting dates.', FieldName("Posting Date")));
                    end;

                if ("Document Date" <> 0D) then
                    if ("Document Date" <> NormalDate("Document Date")) then
                        AddError(StrSubstNo('%1 must not be a closing date.', FieldName("Document Date")));

                if "Document Type" in ["Document Type"::Invoice, "Document Type"::"Credit Memo"] then begin
                    Receive := true;
                    Invoice := true;
                end;

                if not (Receive or Invoice) then
                    AddError(
                      StrSubstNo(
                        'Please enter "Yes" in %1 and/or %2.',
                        FieldName(Receive), FieldName(Invoice)));

                if Invoice then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter(Quantity, '<>0');
                    if "Document Type" = "Document Type"::Order then
                        PurchLine.SetFilter("Qty. to Invoice", '<>0');
                    Invoice := PurchLine.Find('-');
                    if Invoice and not Receive then begin
                        Invoice := false;
                        repeat
                            Invoice := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced" <> 0;
                        until Invoice or (PurchLine.Next = 0);
                    end;
                end;

                if Receive then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter(Quantity, '<>0');
                    if "Document Type" = "Document Type"::Order then
                        PurchLine.SetFilter("Qty. to Receive", '<>0');
                    PurchLine.SetRange("Receipt No.", '');
                    Receive := PurchLine.Find('-');
                end;

                if not (Receive or Invoice) then
                    AddError('There is nothing to post.');

                if Invoice then begin
                    PurchLine.Reset;
                    PurchLine.SetRange("Document Type", "Document Type");
                    PurchLine.SetRange("Document No.", "No.");
                    PurchLine.SetFilter("Sales Order Line No.", '<>0');
                    if PurchLine.Find('-') then
                        repeat
                            SalesOrderLine.Get(SalesOrderLine."Document Type"::Order, PurchLine."Sales Order No.", PurchLine."Sales Order Line No.");
                            if Receive and
                              Invoice and
                              (PurchLine."Qty. to Invoice" <> 0) and
                              (PurchLine."Qty. to Receive" <> 0)
                            then begin
                                AddError('A drop shipment from a purchase order cannot be received and invoiced at the same time.');
                            end;
                            if Abs(PurchLine."Quantity Received" - PurchLine."Quantity Invoiced") <
                               Abs(PurchLine."Qty. to Invoice")
                            then
                                PurchLine."Qty. to Invoice" := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced";
                            if Abs(PurchLine.Quantity - (PurchLine."Qty. to Invoice" + PurchLine."Quantity Invoiced")) <
                               Abs(SalesOrderLine.Quantity - SalesOrderLine."Quantity Invoiced")
                            then
                                AddError(
                                  StrSubstNo(
                                    'Please invoice sales order %1 before invoicing this purchase order.',
                                    PurchLine."Sales Order No."));
                        until PurchLine.Next = 0;
                end;

                if Invoice then
                    if "Document Type" <> "Document Type"::"Credit Memo" then
                        if "Due Date" = 0D then
                            AddError(StrSubstNo('%1 must be specified.', FieldName("Due Date")));

                if Receive and ("Receiving No." = '') then
                    if ("Document Type" = "Document Type"::Order) or
                       (("Document Type" = "Document Type"::Invoice) and PurchSetup."Receipt on Invoice")
                    then
                        if "Receiving No. Series" = '' then
                            AddError(
                              StrSubstNo(
                                '%1 must be entered.',
                                FieldName("Receiving No. Series")));

                if Invoice and ("Posting No." = '') then
                    if "Document Type" = "Document Type"::Order then
                        if "Posting No. Series" = '' then
                            AddError(
                              StrSubstNo(
                                '%1 must be entered.',
                                FieldName("Posting No. Series")));

                PurchLine.Reset;
                PurchLine.SetRange("Document Type", "Document Type");
                PurchLine.SetRange("Document No.", "No.");
                PurchLine.SetFilter("Sales Order Line No.", '<>0');
                if PurchLine.Find('-') then begin
                    DropShipOrder := true;
                    if Receive then
                        repeat
                            if SalesOrderHeader."No." <> PurchLine."Sales Order No." then begin
                                SalesOrderHeader.Get(1, PurchLine."Sales Order No.");
                                if SalesOrderHeader."Bill-to Customer No." = '' then
                                    AddError(
                                      StrSubstNo(
                                        '%1 must be entered on the sales order header.',
                                        SalesOrderHeader.FieldName("Bill-to Customer No.")));
                                if SalesOrderHeader."Shipping No." = '' then
                                    if SalesOrderHeader."Shipping No. Series" = '' then
                                        AddError(
                                          StrSubstNo(
                                            '%1 must be entered on the sales order header.',
                                            SalesOrderHeader.FieldName("Shipping No. Series")));
                            end;
                        until PurchLine.Next = 0;
                end;

                if Invoice then
                    if "Document Type" in ["Document Type"::Order, "Document Type"::Invoice] then begin
                        if PurchSetup."Ext. Doc. No. Mandatory" and ("Vendor Invoice No." = '') then
                            AddError(StrSubstNo('%1 must be specified.', FieldName("Vendor Invoice No.")));
                    end else
                        if PurchSetup."Ext. Doc. No. Mandatory" and ("Vendor Cr. Memo No." = '') then
                            AddError(StrSubstNo('%1 must be specified.', FieldName("Vendor Cr. Memo No.")));

                if "Vendor Invoice No." <> '' then begin
                    VendLedgEntry.SetCurrentKey("Document Type", "Document No.", "Vendor No.");
                    VendLedgEntry.SetRange("Document Type", "Document Type");
                    VendLedgEntry.SetRange("Document No.", "Vendor Invoice No.");
                    VendLedgEntry.SetRange("Vendor No.", "Pay-to Vendor No.");
                    if VendLedgEntry.Find('-') then
                        AddError(
                          StrSubstNo(
                            'Purchase %1 %2 already exists for this vendor.',
                            "Document Type", "Vendor Invoice No."));
                end;
            end;

            trigger OnPreDataItem()
            begin
                PurchHeader.Copy("Purchase Header");
                PurchHeader.FilterGroup := 2;
                PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                if PurchHeader.Find('-') then begin
                    case true of
                        ReceiveOnNextPostReq and InvOnNextPostReq:
                            ReceiveInvoiceText := 'Receive and Invoice';
                        ReceiveOnNextPostReq:
                            ReceiveInvoiceText := 'Receive';
                        InvOnNextPostReq:
                            ReceiveInvoiceText := 'Invoice';
                    end;
                    ReceiveInvoiceText := StrSubstNo('Order Posting: %1', ReceiveInvoiceText);
                end;

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
        PURCHASE_CREDIT_MEMOCaptionLbl: Label 'PURCHASE CREDIT MEMO';
        Credit_Memo_Number_CaptionLbl: Label 'Credit Memo Number:';
        Credit_Memo_Date_CaptionLbl: Label 'Credit Memo Date:';
        Page_CaptionLbl: Label 'Page:';
        ShipCaptionLbl: Label 'Ship';
        To_CaptionLbl: Label 'To:';
        To_Caption_Control47Lbl: Label 'To:';
        PayCaptionLbl: Label 'Pay';
        Applies_To_Invoice_CaptionLbl: Label 'Applies To Invoice:';
        Contact_CaptionLbl: Label 'Contact:';
        Applies_To_Order_CaptionLbl: Label 'Applies To Order:';
        Phone_CaptionLbl: Label 'Phone:';
        Fax_CaptionLbl: Label 'Fax:';
        Item_No_CaptionLbl: Label 'Item No.';
        PriceCaptionLbl: Label 'Price';
        Amount__Inv__Discount_Amount_CaptionLbl: Label 'Amount';
        Our_records__show_that_a_credit_is_due_for_the_above_item_s__CaptionLbl: Label 'Our records, show that a credit is due for the above item(s).';
        However__we_have_not_received_a_credit_document_to_apply_against_the_item_s__CaptionLbl: Label 'However, we have not received a credit document to apply against the item(s).';
        If_we_do_not_receive_a_credit_document_by_the_end_of_the_current_month_CaptionLbl: Label 'If we do not receive a credit document by the end of the current month,';
        we_will_be_posting_a_credit_against_your_account_for_the_total_amount_below_CaptionLbl: Label 'we will be posting a credit against your account for the total amount below.';

    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;
}

