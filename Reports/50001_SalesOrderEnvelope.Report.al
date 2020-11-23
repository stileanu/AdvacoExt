report 50001 "Sales Order Envelope"
{
    // 04/28/2011 ADV
    //   Added Name on Card, Bill-to Address and Comments fields for CC billing.
    // 
    // 05/04/211 ADV
    //   Added "Tax Liable" information to the envelope.
    // 
    // 05/02/2013 ADV
    //   Added Email Invoice text and Credit Card Fee line.
    // 
    // 06/09/19
    //    Modified CC Message to include CC Fee Waived to indicate Credit Card fee is waived.
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50001_SalesOrderEnvelope.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Sales Order Envelope';
            column(Sales_Header__Sell_to_Customer_No__; "Sell-to Customer No.")
            {
            }
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header_Name; "Bill-to Name")
            {
            }
            column(Sales_Header_Address; "Bill-to Address")
            {
            }
            column(BillToAd2; BillToAd2)
            {
            }
            column(Sales_Header__Ship_to_Name_; "Ship-to Name")
            {
            }
            column(Sales_Header__Ship_to_Address_; "Ship-to Address")
            {
            }
            column(ShipToAd2; ShipToAd2)
            {
            }
            column(Sales_Header__Payment_Terms_Code_; "Payment Terms Code")
            {
            }
            column(Sales_Header__Card_Type_; "Card Type")
            {
            }
            column(Sales_Header__Credit_Card_No__; "Credit Card No.")
            {
            }
            column(Sales_Header__Credit_Card_Exp__; "Credit Card Exp.")
            {
            }
            column(Sales_Header_Rep; Rep)
            {
            }
            column(Sales_Header__Shipping_Agent_Code_; "Shipping Agent Code")
            {
            }
            column(Sales_Header__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Sales_Header__Order_Date_; "Order Date")
            {
            }
            column(Sales_Header_Date_Required_; "shipment request date")
            {
            }
            column(Sales_Header__Ship_to_Contact_; "Ship-to Contact")
            {
            }
            column(Sales_Header__Your_Reference_; "Your Reference")
            {
            }
            column(BillTo; BillTo)
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(EmptyString; '_________________________')
            {
            }
            column(Sales_Header__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(Internet; Invoicing)
            {
            }
            column(Sales_Header__Phone_No__; "Phone No.")
            {
            }
            column(Sales_Header__Credit_Card_SC_; "Credit Card SC")
            {
            }
            column(Sales_Header__Name_on_Card_; "Name on Card")
            {
            }
            column(Sales_Header__Bill_to_Address_1_; "Bill-to Address")
            {
            }
            column(Sales_Header__Bill_to_Address_2_; "Bill-to Address 2")
            {
            }
            column(Sales_Header__Bill_to_Address_3_; "Bill-to Address_3")
            {
            }
            column(Sales_Header__Bill_to_Address_4_; "Bill-to Address_4")
            {
            }
            column(CCComments; CCComments)
            {
            }
            column(Sales_Header__CC_Comments_2_; "CC Comments 2")
            {
            }
            column(Sales_Header__CC_Comments_3_; "CC Comments 3")
            {
            }
            column(TaxLiable; TaxLiable)
            {
            }
            column(Customer__Caption; Customer__CaptionLbl)
            {
            }
            column(S_O__Caption; S_O__CaptionLbl)
            {
            }
            column(Terms_Caption; Terms_CaptionLbl)
            {
            }
            column(Credit_Card_Caption; Credit_Card_CaptionLbl)
            {
            }
            column(Account_Caption; Account_CaptionLbl)
            {
            }
            column(Exp__Date_Caption; Exp__Date_CaptionLbl)
            {
            }
            column(Rep_Caption; Rep_CaptionLbl)
            {
            }
            column(Carrier_Caption; Carrier_CaptionLbl)
            {
            }
            column(SALES_ORDER___Caption; SALES_ORDER___CaptionLbl)
            {
            }
            column(Inside_Sales_Caption; Inside_Sales_CaptionLbl)
            {
            }
            column(Order_Date_Caption; Order_Date_CaptionLbl)
            {
            }
            column(Attention_Caption; Attention_CaptionLbl)
            {
            }
            column(PO_No__Caption; PO_No__CaptionLbl)
            {
            }
            column(Ship_To_CustomerCaption; Ship_To_CustomerCaptionLbl)
            {
            }
            column(Bill_To_CustomerCaption; Bill_To_CustomerCaptionLbl)
            {
            }
            column(Weight_Caption; Weight_CaptionLbl)
            {
            }
            column(Charge_Caption; Charge_CaptionLbl)
            {
            }
            column(Sales_Header__Phone_No__Caption; FieldCaption("Phone No."))
            {
            }
            column(Credit_Card_SC_Caption; Credit_Card_SC_CaptionLbl)
            {
            }
            column(Name_on_Card_Caption; Name_on_Card_CaptionLbl)
            {
            }
            column(Bill_to_Address_Caption; Bill_to_Address_CaptionLbl)
            {
            }
            column(Comments_Caption; Comments_CaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order));
                column(ItemNo; ItemNo)
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Line__Gen__Prod__Posting_Group_; "Gen. Prod. Posting Group")
                {
                }
                column(EmptyString_Control21; '_________________________')
                {
                }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Unit_Price_; "Unit Price")
                {
                }
                column(Sales_Line_Amount; Amount)
                {
                }
                column(EmptyString_Control43; '_________________________')
                {
                }
                column(CCFeeText; CCFeeText)
                {
                }
                column(Surcharge; Surcharge)
                {
                }
                column(Item_No_Caption; Item_No_CaptionLbl)
                {
                }
                column(Sales_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Posting_GroupCaption; Posting_GroupCaptionLbl)
                {
                }
                column(Invoice__Caption; Invoice__CaptionLbl)
                {
                }
                column(Sales_Line_QuantityCaption; FieldCaption(Quantity))
                {
                }
                column(Sales_Line__Unit_Price_Caption; FieldCaption("Unit Price"))
                {
                }
                column(Total_PriceCaption; Total_PriceCaptionLbl)
                {
                }
                column(InitialsCaption; InitialsCaptionLbl)
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Surcharge := '';
                    SurchargeItem := false;

                    if Type = Type::"G/L Account" then begin
                        if ("No." <> '311') or ("No." <> '312') then begin
                            //    ItemNo := "Cross Reference Item";
                        end else begin
                            ItemNo := '';
                        end;
                    end else begin
                        ItemNo := "No.";
                    end;

                    if "Sales Header"."Shipping Agent Code" = 'UPS' then begin
                        if ("Sales Header"."Shipping Charge" = "Sales Header"."Shipping Charge"::"Pre-Paid") or
                           ("Sales Header"."Shipping Charge" = "Sales Header"."Shipping Charge"::"Pre-Paid & Add") then begin
                            if Type = Type::Item then begin
                                if Item.Get("Sales Line"."No.") then begin
                                    if Item."UPS Shipping Surcharge" = true then begin
                                        SalesSetup.Get();
                                        SurchargeAmount := Format(SalesSetup."UPS Shipping Surcharge");
                                        Surcharge := ('$') + (SurchargeAmount) + (' / EACH ') + ('UPS Shipping Surcharge');
                                        SurchargeItem := true;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Tax Liable" then
                    TaxLiable := '*** TAX LIABLE ***'
                else
                    TaxLiable := '                  ';
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
        GLSetup.Get;
    end;

    var
        BillTo: Text[50];
        ShipTo: Text[50];
        BillToAd2: Text[50];
        ShipToAd2: Text[50];
        TaxLiable: Text[30];
        ExemptNo: Text[30];
        ItemNo: Code[30];
        Item: Record Item;
        Surcharge: Text[50];
        SalesSetup: Record "Sales & Receivables Setup";
        SurchargeAmount: Code[10];
        SurchargeItem: Boolean;
        Invoicing: Text[30];
        Cust: Record Customer;
        CCComments: Text[127];
        CCFeeText: Text[30];
        GLSetup: Record "General Ledger Setup";
        Customer__CaptionLbl: Label 'Customer #';
        S_O__CaptionLbl: Label 'S/O #';
        Terms_CaptionLbl: Label 'Terms:';
        Credit_Card_CaptionLbl: Label 'Credit Card:';
        Account_CaptionLbl: Label 'Account#';
        Exp__Date_CaptionLbl: Label 'Exp. Date:';
        Rep_CaptionLbl: Label 'Rep:';
        Carrier_CaptionLbl: Label 'Carrier:';
        SALES_ORDER___CaptionLbl: Label '** SALES ORDER **';
        Inside_Sales_CaptionLbl: Label 'Inside Sales:';
        Order_Date_CaptionLbl: Label 'Order Date:';
        Attention_CaptionLbl: Label 'Attention:';
        PO_No__CaptionLbl: Label 'PO No.:';
        Ship_To_CustomerCaptionLbl: Label 'Ship To Customer';
        Bill_To_CustomerCaptionLbl: Label 'Bill To Customer';
        Weight_CaptionLbl: Label 'Weight:';
        Charge_CaptionLbl: Label 'Charge:';
        Credit_Card_SC_CaptionLbl: Label 'Credit Card SC:';
        Name_on_Card_CaptionLbl: Label 'Name on Card:';
        Bill_to_Address_CaptionLbl: Label 'Bill-to Address:';
        Comments_CaptionLbl: Label 'Comments:';
        Item_No_CaptionLbl: Label 'Item No.';
        Posting_GroupCaptionLbl: Label 'Posting Group';
        Invoice__CaptionLbl: Label 'Invoice #';
        Total_PriceCaptionLbl: Label 'Total Price';
        InitialsCaptionLbl: Label 'Initials';
        Shipment_Request_Date_CaptionLbl: Label 'Date Required';
}

