report 50121 "Sales Invoice New - ADVACO"
{
    // htcs, rca: Various changes to alignments and locations
    // 
    // 2/13/01, htcs, rca - added code to Sales Invoice Line, OnAfterGetRecord()
    //                       added code to SalesInvoiceLine, Body (2), OnPreSection
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50121_SalesInvoiceNewADVACO.Rpt.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "Bill-to Customer No.", "Ship-to Code", "No. Printed";
            RequestFilterHeading = 'Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
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
            column(CompanyAddress_7_; CompanyAddress[7])
            {
            }
            column(CompanyAddress_8_; CompanyAddress[8])
            {
            }
            column(BillToAddress_1_; BillToAddress[1])
            {
            }
            column(Sales_Invoice_Header___No__; "Sales Invoice Header"."No.")
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
            column(Sales_Invoice_Header___Posting_Date_; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Sales_Invoice_Header___Due_Date_; "Sales Invoice Header"."Due Date")
            {
            }
            column(PaymentTerms_Description; PaymentTerms.Description)
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
            column(Sales_Invoice_Header___Bill_to_Customer_No__; "Sales Invoice Header"."Bill-to Customer No.")
            {
            }
            column(Sales_Invoice_Header___Your_Reference_; "Sales Invoice Header"."Your Reference")
            {
            }
            column(Sales_Invoice_Header___Order_Date_; "Sales Invoice Header"."Order Date")
            {
            }
            column(Sales_Invoice_Header___Order_No__; "Sales Invoice Header"."Order No.")
            {
            }
            column(OutsideRep__Rep_Name_; OutsideRep."Rep Name")
            {
            }


            column(ShippingAgent_Name; ShippingAgent.Name)
            {
            }
            column(Sales_Invoice_Header___Bill_of_Lading_; "Sales Invoice Header"."Bill of Lading")
            {
            }
            column(SalesPurchPerson_Name; SalesPurchPerson.Name)
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                begin
                    if (("Sales Invoice Header"."Shortcut Dimension 2 Code" = 'WO') or ("Sales Invoice Header"."Shortcut Dimension 2 Code" = 'FS')) and (Type.AsInteger > 1) then
                        CurrReport.Skip;

                    TempSalesInvoiceLine := "Sales Invoice Line";
                    TempSalesInvoiceLine.Insert;
                    HighestLineNo := "Line No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempSalesInvoiceLine.Reset;
                    TempSalesInvoiceLine.DeleteAll;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Print On Invoice" = CONST(true));

                trigger OnAfterGetRecord()
                begin
                    //with TempSalesInvoiceLine do begin  ICE-MPC
                    TempsalesInvoiceline.Init;
                    tempsalesinvoiceline."Document No." := "Sales Invoice Header"."No.";
                    TempSalesInvoiceLine."Line No." := HighestLineNo + 1000;
                    HighestLineNo := TempSalesInvoiceLine."Line No.";
                    //end;
                    if StrLen(Comment) <= MaxStrLen(TempSalesInvoiceLine.Description) then begin
                        TempSalesInvoiceLine.Description := Comment;
                        TempSalesInvoiceLine."Description 2" := '';
                    end else begin
                        SpacePointer := MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                        while (SpacePointer > 1) and (Comment[SpacePointer] <> ' ') do
                            SpacePointer := SpacePointer - 1;
                        if SpacePointer = 1 then
                            SpacePointer := MaxStrLen(TempSalesInvoiceLine.Description) + 1;
                        TempSalesInvoiceLine.Description := CopyStr(Comment, 1, SpacePointer - 1);
                        TempSalesInvoiceLine."Description 2" :=
                          CopyStr(CopyStr(Comment, SpacePointer + 1), 1, MaxStrLen(TempSalesInvoiceLine."Description 2"));
                    end;
                    TempSalesInvoiceLine.Insert;
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                    column(CopyTxt; CopyTxt)
                    {
                    }



                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(SalesInvoiceLine; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(HighDescription; HighDescriptionToPrint)
                        {
                        }
                        column(LowDescription; LowDescriptionToPrint)
                        {
                        }
                        column(UnitPriceToPrint; UnitPriceToPrint)
                        {
                            DecimalPlaces = 2 : 5;
                        }
                        column(TempSalesInvoiceLine_Quantity; TempSalesInvoiceLine.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(OrderedQuantity; OrderedQuantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(ModelNo; ModelNo)
                        {
                        }
                        column(LowDescription_Control35; AmountToPrint)
                        {
                        }
                        column(Amount2; Amount2)
                        {
                        }
                        column(AmountExclInvDisc___Miscellaneous___Freight; AmountExclInvDisc - Miscellaneous - Freight)
                        {
                        }
                        column(Miscellaneous; Miscellaneous)
                        {
                        }
                        column(TempSalesInvoiceLine__Amount_Including_Tax____TempSalesInvoiceLine_Amount; TempSalesInvoiceLine."Amount Including VAT" - TempSalesInvoiceLine.Amount)
                        {
                        }
                        column(TempSalesInvoiceLine__Amount_Including_Tax_; TempSalesInvoiceLine."Amount Including VAT")
                        {
                        }
                        column(Freight; Freight)
                        {
                        }
                        column(THANK_YOU_FOR_ALLOWING_US_TO_BE_OF_SERVICE_TO_YOU_; 'THANK YOU FOR ALLOWING US TO BE OF SERVICE TO YOU')
                        {
                        }
                        column(Subtotal_Caption; Subtotal_CaptionLbl)
                        {
                        }
                        column(Miscellaneous_Charges_Caption; Miscellaneous_Charges_CaptionLbl)
                        {
                        }
                        column(Sales_Tax_Caption; Sales_Tax_CaptionLbl)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(Freight_Charges_Caption; Freight_Charges_CaptionLbl)
                        {
                        }
                        column(SalesInvoiceLine_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            GLCode := '';
                            ModelNo := '';


                            OnLineNumber := OnLineNumber + 1;

                            //with TempSalesInvoiceLine do begin
                            No := '';

                            if OnLineNumber = 1 then
                                tempsalesInvoiceLine.Find('-')
                            else
                                tempsalesInvoiceline.Next;

                            OrderedQuantity := 0;
                            if "Sales Invoice Header"."Order No." = '' then
                                OrderedQuantity := TempSalesInvoiceLine.Quantity
                            else begin
                                if OrderLine.Get(1, "Sales Invoice Header"."Order No.", TempsalesInvoiceLine."Line No.") then
                                    OrderedQuantity := OrderLine.Quantity
                                else begin
                                    ShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
                                    ShipmentLine.SetRange("Order Line No.", TempSalesInvoiceLine."Line No.");
                                    if ShipmentLine.Find('-') then;
                                    repeat
                                        OrderedQuantity := OrderedQuantity + ShipmentLine.Quantity;
                                    until 0 = ShipmentLine.Next;
                                end;
                            end;

                            DescriptionToPrint := TempSalesInvoiceLine.Description + ' ' + TempSalesInvoiceline."Description 2";
                            if TempSalesInvoiceLine.Type.AsInteger() = 0 then begin
                                // HEF REMOVED 07/02/01 Combined Lines which isn't what we want
                                /*  IF OnLineNumber < NumberOfLines THEN BEGIN
                                  NEXT;
                                  IF Type = 0 THEN BEGIN
                                    DescriptionToPrint :=
                                      COPYSTR(DescriptionToPrint + ' ' + Description + ' ' + "Description 2",1,MAXSTRLEN(DescriptionToPrint));
                                    OnLineNumber := OnLineNumber + 1;
                                  END ELSE
                                    NEXT(-1);
                                END;
                                */
                                // END REMOVE
                                TempSalesInvoiceLine."No." := '';
                                TempSalesInvoiceLine."Unit of Measure" := '';
                                TempSalesInvoiceLine.Amount := 0;
                                TempSalesInvoiceLine."Amount Including VAT" := 0;
                                TempSalesInvoiceLine."Inv. Discount Amount" := 0;
                                TempSalesInvoiceLine.Quantity := 0;
                                //ModelNo := "Cross Reference Item";
                            end;
                            // HEF INSERT FOR Shipping Charges after SubTotal
                            if TempSalesInvoiceLine.Type = TempSalesInvoiceLine.Type::"G/L Account" then begin
                                if TempSalesInvoiceLine."No." = '311' then begin
                                    Miscellaneous := Miscellaneous + TempSalesInvoiceLine.Amount;
                                    GLCode := TempSalesInvoiceLine."No.";
                                end;
                                if TempSalesInvoiceLine."No." = '312' then begin
                                    Freight := Freight + TempSalesInvoiceLine.Amount;
                                    GLCode := TempSalesInvoiceLine."No.";
                                end;
                                if (TempSalesInvoiceLine."No." = '312') or (TempSalesInvoiceLine."No." = '311') then begin
                                    ok := true;
                                end else begin
                                    //ModelNo := "Cross Reference Item";
                                end;
                                No := TempSalesInvoiceLine."No.";
                            end;


                            if No <> '' then begin
                                if GLCode = '' then begin
                                    if ("Sales Invoice Header"."Shortcut Dimension 2 Code" = 'WO') or ("Sales Invoice Header"."Shortcut Dimension 2 Code" = 'FS') then begin
                                        if "Sales Invoice Header"."Work Order No." = '' then begin
                                            HighDescriptionToPrint := DescriptionToPrint;  // Moves GL Description to Item Number
                                            LowDescriptionToPrint := '';
                                            AmountToPrint := 0;
                                        end else begin
                                            HighDescriptionToPrint := '';
                                            LowDescriptionToPrint := DescriptionToPrint;  // Description
                                            AmountToPrint := 0;
                                        end;
                                    end else begin
                                        HighDescriptionToPrint := '';
                                        LowDescriptionToPrint := DescriptionToPrint;  // Description
                                        AmountToPrint := 0;
                                    end;
                                end else begin
                                    HighDescriptionToPrint := DescriptionToPrint;  // Moves GL Description to Item Number
                                    LowDescriptionToPrint := '';
                                    AmountToPrint := TempSalesInvoiceLine.Amount;
                                end;
                            end else begin
                                HighDescriptionToPrint := TempSalesInvoiceLine."No.";                  // IF Not GL then acts as normal
                                LowDescriptionToPrint := DescriptionToPrint;
                                AmountToPrint := 0;
                            end;

                            if TempSalesInvoiceLine.Amount <> TempSalesInvoiceLine."Amount Including VAT" then begin
                                TaxFlag := true;
                                TaxLiable := TempSalesInvoiceLine.Amount;
                            end else begin
                                TaxFlag := false;
                                TaxLiable := 0;
                            end;

                            AmountExclInvDisc := TempSalesInvoiceLine.Amount + TempSalesInvoiceLine."Inv. Discount Amount";

                            if TempSalesInvoiceLine.Quantity = 0 then
                                UnitPriceToPrint := 0  // so it won't print
                            else
                                UnitPriceToPrint := Round(AmountExclInvDisc / TempSalesInvoiceLine.Quantity, 0.00001);
                            //end;

                            IF (GLCode = '312') OR (GLCode = '311') THEN BEGIN
                                UnitPriceToPrint := 0;
                                Amount2 := 0;
                            END ELSE BEGIN
                                Amount2 := AmountExclInvDisc;
                            END;

                        end;

                        trigger OnPostDataItem()
                        begin
                            Freight := 0;
                            Miscellaneous := 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //(TaxLiable,AmountExclInvDisc,TempSalesInvoiceLine.Amount,TempSalesInvoiceLine."Amount Including VAT");
                            NumberOfLines := TempSalesInvoiceLine.Count;
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
                            SalesInvPrinted.Run("Sales Invoice Header");
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
                    NoLoops := 1 + Abs(NoCopies) + Customer."Invoice Copies";
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Rep = '' then
                    Clear(OutsideRep)
                else
                    OutsideRep.Get(Rep);

                if "Salesperson Code" = '' then
                    Clear(SalesPurchPerson)
                else
                    SalesPurchPerson.Get("Salesperson Code");

                if (Rep = '') and ("Salesperson Code" <> '') then
                    SalesPeople := SalesPurchPerson.Name;

                if (Rep <> '') and ("Salesperson Code" = '') then
                    SalesPeople := OutsideRep."Rep Name";

                if (Rep <> '') and ("Salesperson Code" <> '') then
                    SalesPeople := "Salesperson Code" + ' / ' + OutsideRep."Rep Name";

                if (Rep = '') and ("Salesperson Code" = '') then
                    SalesPeople := '';

                FormatAddress.SalesInvBillTo(BillToAddress, "Sales Invoice Header");
                FormatAddress.SalesInvShipTo(ShipToAddress, ShipToAddress, "Sales Invoice Header");

                if "Payment Terms Code" = '' then
                    Clear(PaymentTerms)
                else
                    PaymentTerms.Get("Payment Terms Code");

                if "Shipment Method Code" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipment Method Code");

                Customer.Get("Bill-to Customer No.");

                // HEF INSERT
                if "Shipping Agent Code" = '' then
                    Clear(ShippingAgent)
                else
                    ShippingAgent.Get("Shipping Agent Code");
            end;

            trigger OnPreDataItem()
            begin
                //if PrintCompany then begin
                CompanyInformation.Get();
                FormatAddress.Company(CompanyAddress, CompanyInformation);
                //end else
                //Clear(CompanyAddress);
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
                    field(PrintCompany; PrintCompany)
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

    trigger OnPreReport()
    begin
        ShipmentLine.SetCurrentKey("Order No.", "Order Line No.");
    end;

    var
        TaxLiable: Decimal;
        OrderedQuantity: Decimal;
        UnitPriceToPrint: Decimal;
        AmountExclInvDisc: Decimal;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        OutsideRep: Record "Outside Sales Reps";
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        OrderLine: Record "Sales Line";
        ShipmentLine: Record "Sales Shipment Line";
        TempSalesInvoiceLine: Record "Sales Invoice Line" temporary;
        CompanyAddress: array[8] of Text[50];
        BillToAddress: array[8] of Text[50];
        ShipToAddress: array[8] of Text[50];
        CopyTxt: Text[10];
        DescriptionToPrint: Text[210];
        HighDescriptionToPrint: Text[210];
        LowDescriptionToPrint: Text[210];
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
        SalesInvPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddress: Codeunit "Format Address";
        ShippingAgent: Record "Shipping Agent";
        ModelNo: Code[20];
        Miscellaneous: Decimal;
        Freight: Decimal;
        GLCode: Code[10];
        AmountToPrint: Decimal;
        Amount2: Decimal;
        ok: Boolean;
        No: Code[10];
        SalesPeople: Code[100];
        Page_CaptionLbl: Label 'Page:';
        Subtotal_CaptionLbl: Label 'Subtotal:';
        Miscellaneous_Charges_CaptionLbl: Label 'Miscellaneous Charges:';
        Sales_Tax_CaptionLbl: Label 'Sales Tax:';
        Total_CaptionLbl: Label 'Total:';
        Freight_Charges_CaptionLbl: Label 'Freight Charges:';
}

