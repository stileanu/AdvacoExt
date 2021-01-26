report 50150 "Field Service Envelope"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50150_Field Service Envelope.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(FieldService; FieldService)
        {
            RequestFilterFields = "Field Service No.";
            column(Field_Service_Rep; Rep)
            {
            }
            column(Field_Service__Inside_Sales_; "Inside Sales")
            {
            }
            column(Field_Service__Field_Service_No__; "Field Service No.")
            {
            }
            column(Field_Service_Customer; Customer)
            {
            }
            column(Field_Service__Customer_Name_; "Customer Name")
            {
            }
            column(Field_Service__Ship_To_Name_; "Ship To Name")
            {
            }
            column(Field_Service__Date_Ordered_; "Date Ordered")
            {
            }
            column(Field_Service__Customer_Address_1_; "Customer Address 1")
            {
            }
            column(Field_Service__Ship_To_Address_1_; "Ship To Address 1")
            {
            }
            column(BillToAd2; BillToAd2)
            {
            }
            column(ShipToAd2; ShipToAd2)
            {
            }
            column(BillTo; BillTo)
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Field_Service__Customer_Payment_Terms_; "Customer Payment Terms")
            {
            }
            column(Field_Service__Fax_No__; "Fax No.")
            {
            }
            column(Field_Service__Phone_No__; "Phone No.")
            {
            }
            column(Field_Service__Card_Type_; "Card Type")
            {
            }
            column(Field_Service_Attention; Attention)
            {
            }
            column(Field_Service__Credit_Card_No__; "Credit Card No.")
            {
            }
            column(Field_Service__Credit_Card_Exp__; "Credit Card Exp.")
            {
            }
            column(EmptyString; '_________________________')
            {
            }
            column(EmptyString_Control114; '_________________________')
            {
            }
            column(EmptyString_Control116; '_________________________')
            {
            }
            column(EmptyString_Control118; '_________________________')
            {
            }
            column(Field_Service__Service_Type_; "Service Type")
            {
            }
            column(Field_Service__Customer_PO_No__; "Customer PO No.")
            {
            }
            column(Internet; Invoicing)
            {
            }
            column(Rep_Caption; Rep_CaptionLbl)
            {
            }
            column(Inside_Sales_Caption; Inside_Sales_CaptionLbl)
            {
            }
            column(FIELD_SERVICE___Caption; FIELD_SERVICE___CaptionLbl)
            {
            }
            column(F_S__Caption; F_S__CaptionLbl)
            {
            }
            column(Customer__Caption; Customer__CaptionLbl)
            {
            }
            column(Ship_To_Customer_Caption; Ship_To_Customer_CaptionLbl)
            {
            }
            column(Bill_To_Customer_Caption; Bill_To_Customer_CaptionLbl)
            {
            }
            column(Date_Ordered_Caption; Date_Ordered_CaptionLbl)
            {
            }
            column(Terms_Caption; Terms_CaptionLbl)
            {
            }
            column(Fax_No__Caption; Fax_No__CaptionLbl)
            {
            }
            column(Phone_No__Caption; Phone_No__CaptionLbl)
            {
            }
            column(Credit_Card_Caption; Credit_Card_CaptionLbl)
            {
            }
            column(Attention_Caption; Attention_CaptionLbl)
            {
            }
            column(Account___Caption; Account___CaptionLbl)
            {
            }
            column(Exp__Date_Caption; Exp__Date_CaptionLbl)
            {
            }
            column(Initials_DateCaption; Initials_DateCaptionLbl)
            {
            }
            column(PriceCaption; PriceCaptionLbl)
            {
            }
            column(Initials_DateCaption_Control117; Initials_DateCaption_Control117Lbl)
            {
            }
            column(Invoice__Caption; Invoice__CaptionLbl)
            {
            }
            column(PO_No_Caption; PO_No_CaptionLbl)
            {
            }
            column(Income_Code_Caption; Income_Code_CaptionLbl)
            {
            }
            column(INCOME_FSCaption; INCOME_FSCaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin

                IF "FieldService"."Customer Address 2" = '' THEN BEGIN
                    BillToAd2 := ("Customer City") + (', ') + ("Customer State") + ('  ') + ("Customer Zip Code");
                    BillTo := '';
                END ELSE BEGIN
                    BillToAd2 := "Customer Address 2";
                    BillTo := ("Customer City") + (', ') + ("Customer State") + ('  ') + ("Customer Zip Code");
                END;

                IF "FieldService"."Ship To Address 2" = '' THEN BEGIN
                    ShipToAd2 := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                    ShipTo := '';
                END ELSE BEGIN
                    ShipToAd2 := "FieldService"."Ship To Address 2";
                    ShipTo := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                END;

                IF Cust.GET(Customer) THEN BEGIN
                    IF Cust."Internet Invoicing" THEN
                        Invoicing := 'Internet Invoicing'
                    ELSE
                        IF Cust."No Internet/Paper Invoice" THEN
                            Invoicing := 'No Internet/Paper Invoice'
                        ELSE
                            Invoicing := '';
                END;

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

    var
        ShipTo: Text[50];
        BillTo: Text[50];
        ShipToAd2: Text[50];
        BillToAd2: Text[50];
        Cust: Record Customer;
        Invoicing: Text[30];
        Rep_CaptionLbl: Label 'Rep:';
        Inside_Sales_CaptionLbl: Label 'Inside Sales:';
        FIELD_SERVICE___CaptionLbl: Label '** FIELD SERVICE **';
        F_S__CaptionLbl: Label 'F/S #';
        Customer__CaptionLbl: Label 'Customer #';
        Ship_To_Customer_CaptionLbl: Label 'Ship To Customer:';
        Bill_To_Customer_CaptionLbl: Label 'Bill To Customer:';
        Date_Ordered_CaptionLbl: Label 'Date Ordered:';
        Terms_CaptionLbl: Label 'Terms:';
        Fax_No__CaptionLbl: Label 'Fax No.:';
        Phone_No__CaptionLbl: Label 'Phone No.:';
        Credit_Card_CaptionLbl: Label 'Credit Card:';
        Attention_CaptionLbl: Label 'Attention:';
        Account___CaptionLbl: Label 'Account #:';
        Exp__Date_CaptionLbl: Label 'Exp. Date:';
        Initials_DateCaptionLbl: Label 'Initials/Date';
        PriceCaptionLbl: Label 'Price';
        Initials_DateCaption_Control117Lbl: Label 'Initials/Date';
        Invoice__CaptionLbl: Label 'Invoice #';
        PO_No_CaptionLbl: Label 'PO No.';
        Income_Code_CaptionLbl: Label 'Income Code:';
        INCOME_FSCaptionLbl: Label 'INCOME FS';
}

