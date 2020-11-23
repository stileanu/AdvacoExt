report 50000 "Work Order Envelope"
{
    // 04/28/2011 ADV
    //   Added Name on Card, Bill-to Address and Comments fields for CC billing.
    // 
    // 05/04/2011 ADV
    //   Added "Tax Liable" information to the envelope.
    // 
    // 05/02/2013 ADV
    //   Added Email Invoice text and Credit Card Fee line.
    // 
    // 03/30/2018
    //   Added code to allow one WO Master with multiple envelopes print, increasing the detail numbers to up to 99.
    // 
    // 06/09/19
    //    Modified CC Message to include CC Fee Waived to indicate Credit Card fee is waived. 
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50000_WorkOrderEnvelope.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(WorkOrderMaster; WorkOrderMaster)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Work Order Master No.";
            column(Work_Order_Master_Work_Order_Master_No_; "Work Order Master No.")
            {
            }
            dataitem(WorkOrderDetail; WorkOrderDetail)
            {
                DataItemLink = "Work Order Master No." = FIELD("Work Order Master No.");
                DataItemTableView = SORTING("Work Order Master No.");
                RequestFilterFields = "Work Order No.";

                trigger OnAfterGetRecord()
                begin
                    TempWorkOrderDetail := WorkOrderDetail;
                    TempWorkOrderDetail.Insert;
                    HighestDetailNo := "Detail No.";
                end;

                trigger OnPreDataItem()
                begin
                    TempWorkOrderDetail.Reset;
                    TempWorkOrderDetail.DeleteAll;
                    HighestDetailNo := '';
                end;
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(MasterLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(Internet; Invoicing)
                    {
                    }
                    column(Work_Order_Master___Name_on_Card_; WorkOrderMaster."Name on Card")
                    {
                    }
                    column(Work_Order_Master___Bill_to_Address_1_; WorkOrderMaster."Bill-to Address 1")
                    {
                    }
                    column(Work_Order_Master___Bill_to_Address_2_; WorkOrderMaster."Bill-to Address 2")
                    {
                    }
                    column(Work_Order_Master___Bill_to_Address_3_; WorkOrderMaster."Bill-to Address 3")
                    {
                    }
                    column(Work_Order_Master___Bill_to_Address_4_; WorkOrderMaster."Bill-to Address 4")
                    {
                    }
                    column(CCComments; CCComments)
                    {
                    }
                    column(Work_Order_Master___CC_Comments_2_; WorkOrderMaster."CC Comments 2")
                    {
                    }
                    column(Work_Order_Master___Date_Ordered_; WorkOrderMaster."Date Ordered")
                    {
                    }
                    column(Work_Order_Master___Date_Required_; WorkOrderMaster."Date Required")
                    {
                    }
                    column(Work_Order_Master___Credit_Card_Exp__; WorkOrderMaster."Credit Card Exp.")
                    {
                    }
                    column(Work_Order_Master__Rep; WorkOrderMaster.Rep)
                    {
                    }
                    column(TaxLiable; TaxLiable)
                    {
                    }
                    column(Work_Order_Master___Ship_To_Name_; WorkOrderMaster."Ship To Name")
                    {
                    }
                    column(Work_Order_Master___Ship_To_Address_1_; WorkOrderMaster."Ship To Address 1")
                    {
                    }
                    column(ShipToAd2; ShipToAd2)
                    {
                    }
                    column(ShipTo; ShipTo)
                    {
                    }
                    column(Work_Order_Master___Inside_Sales_; WorkOrderMaster."Inside Sales")
                    {
                    }
                    column(Work_Order_Master___Credit_Card_No__; WorkOrderMaster."Credit Card No.")
                    {
                    }
                    column(Work_Order_Master___Credit_Card_SC_; WorkOrderMaster."Credit Card SC")
                    {
                    }
                    column(Work_Order_Master___Customer_Payment_Terms_; WorkOrderMaster."Customer Payment Terms")
                    {
                    }
                    column(Work_Order_Master___Card_Type_; WorkOrderMaster."Card Type")
                    {
                    }
                    column(Work_Order_Master___Work_Order_Master_No__; WorkOrderMaster."Work Order Master No.")
                    {
                    }
                    column(Work_Order_Master___Customer_Name_; WorkOrderMaster."Customer Name")
                    {
                    }
                    column(Work_Order_Master___Customer_Address_1_; WorkOrderMaster."Customer Address 1")
                    {
                    }
                    column(BillToAd2; BillToAd2)
                    {
                    }
                    column(BillTo; BillTo)
                    {
                    }
                    column(Work_Order_Master___Phone_No__; WorkOrderMaster."Phone No.")
                    {
                    }
                    column(Work_Order_Master__Attention; WorkOrderMaster.Attention)
                    {
                    }
                    column(Work_Order_Master___Fax_No__; WorkOrderMaster."Fax No.")
                    {
                    }
                    column(Work_Order_Master___CC_Comments_3_; WorkOrderMaster."CC Comments 3")
                    {
                    }
                    column(Work_Order_Master__Customer; WorkOrderMaster.Customer)
                    {
                    }
                    column(EnvelopeNo; EnvelopeNo)
                    {
                    }
                    column(NoTotalEnvelopes; NoTotalEnvelopes)
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
                    column(Date_Ordered_Caption; Date_Ordered_CaptionLbl)
                    {
                    }
                    column(Date_Required_Caption; Date_Required_CaptionLbl)
                    {
                    }
                    column(Exp__Date_Caption; Exp__Date_CaptionLbl)
                    {
                    }
                    column(Rep_Caption; Rep_CaptionLbl)
                    {
                    }
                    column(Inside_Sales_Caption; Inside_Sales_CaptionLbl)
                    {
                    }
                    column(Account___Caption; Account___CaptionLbl)
                    {
                    }
                    column(Credit_Card_SC_Caption; Credit_Card_SC_CaptionLbl)
                    {
                    }
                    column(Terms_Caption; Terms_CaptionLbl)
                    {
                    }
                    column(WORK_ORDER___Caption; WORK_ORDER___CaptionLbl)
                    {
                    }
                    column(Credit_Card_Caption; Credit_Card_CaptionLbl)
                    {
                    }
                    column(Ship_To_Customer_Caption; Ship_To_Customer_CaptionLbl)
                    {
                    }
                    column(W_O__Caption; W_O__CaptionLbl)
                    {
                    }
                    column(Phone_No__Caption; Phone_No__CaptionLbl)
                    {
                    }
                    column(Attention_Caption; Attention_CaptionLbl)
                    {
                    }
                    column(Fax_No__Caption; Fax_No__CaptionLbl)
                    {
                    }
                    column(Customer__Caption; Customer__CaptionLbl)
                    {
                    }
                    column(Bill_To_Customer_Caption; Bill_To_Customer_CaptionLbl)
                    {
                    }
                    column(Envelope_Caption; Envelope_CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }
                    column(MasterLoop_Number; Number)
                    {
                    }
                    dataitem(DetailLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(FORMAT_TempWorkOrderDetail__Order_Type__; Format(TempWorkOrderDetail."Order Type"))
                        {
                        }
                        column(EmptyString; '_________________________')
                        {
                        }
                        column(TempWorkOrderDetail_Description; TempWorkOrderDetail.Description)
                        {
                        }
                        column(TempWorkOrderDetail_Notes; TempWorkOrderDetail.Notes)
                        {
                        }
                        column(FORMAT_TempWorkOrderDetail__Income_Code__; Format(TempWorkOrderDetail."Income Code"))
                        {
                        }
                        column(EmptyString_Control59; '_________________________')
                        {
                        }
                        column(EmptyString_Control71; '_________________________')
                        {
                        }
                        column(EmptyString_Control73; '_________________________')
                        {
                        }
                        column(TempWorkOrderDetail__Customer_PO_No__; TempWorkOrderDetail."Customer PO No.")
                        {
                        }
                        column(TempWorkOrderDetail__Model_No__; TempWorkOrderDetail."Model No.")
                        {
                        }
                        column(TempWorkOrderDetail__Serial_No__; TempWorkOrderDetail."Serial No.")
                        {
                        }
                        column(CCFeeText; CCFeeText)
                        {
                        }
                        column(TempWorkOrderDetail__Detail_No__; TempWorkOrderDetail."Detail No.")
                        {
                        }
                        column(Work_Order_Detail__Carrier; WorkOrderDetail.Carrier)
                        {
                        }
                        column(Work_Order_Detail___Shipping_Charge_; WorkOrderDetail."Shipping Charge")
                        {
                        }
                        column(Work_Order_Detail___Shipping_Method_; WorkOrderDetail."Shipping Method")
                        {
                        }
                        column(Initials_DateCaption; Initials_DateCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(NotesCaption; NotesCaptionLbl)
                        {
                        }
                        column(Income_Code_Caption; Income_Code_CaptionLbl)
                        {
                        }
                        column(PriceCaption; PriceCaptionLbl)
                        {
                        }
                        column(Initials_DateCaption_Control72; Initials_DateCaption_Control72Lbl)
                        {
                        }
                        column(Invoice__Caption; Invoice__CaptionLbl)
                        {
                        }
                        column(PO_No_Caption; PO_No_CaptionLbl)
                        {
                        }
                        column(Model_No_Caption; Model_No_CaptionLbl)
                        {
                        }
                        column(Serial_No_Caption; Serial_No_CaptionLbl)
                        {
                        }
                        column(Detail_No_Caption; Detail_No_CaptionLbl)
                        {
                        }
                        column(Carrier_Caption; Carrier_CaptionLbl)
                        {
                        }
                        column(DetailLoop_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            OnLineNumber := OnLineNumber + 1;
                            EnvelopeNo := Round((OnLineNumber / 3.0), 1.0) + 1;

                            //with TempWorkOrderDetail do begin ICE-MPC Removed deprecated with statement
                            if OnLineNumber = 1 then
                                tempworkorderdetail.Find('-')
                            else
                                tempworkorderdetail.Next;
                            //IF (OnLineNumber MOD 3) = 0 THEN
                            //  PrintFooter := TRUE
                            //ELSE
                            //  PrintFooter := FALSE;
                            //end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //NumberOfDetails := TempWorkOrderDetail.COUNT;
                            //NoTotalEnvelopes := ROUND(NumberOfDetails/3,0)+1;
                            SetRange(Number, 1, NumberOfDetails);
                            OnLineNumber := 0;
                            PrintFooter := true;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if CopyNo = NoLoops then
                        CurrReport.Break
                    else
                        CopyNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    NoLoops := 1;
                    if NoLoops <= 0 then
                        NoLoops := 1;
                    CopyNo := 0;
                    NumberOfDetails := TempWorkOrderDetail.Count;
                    NoTotalEnvelopes := Round((NumberOfDetails / 3.0), 1.0, '>');
                    EnvelopeNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Tax Liable" then
                    TaxLiable := '*** TAX LIABLE ***'
                else
                    TaxLiable := '                  ';

                if WorkOrderMaster."Customer Address 2" = '' then begin
                    BillToAd2 := ("Customer City") + (', ') + ("Customer State") + ('  ') + ("Customer Zip Code");
                    BillTo := '';
                end else begin
                    BillToAd2 := "Customer Address 2";
                    BillTo := ("Customer City") + (', ') + ("Customer State") + ('  ') + ("Customer Zip Code");
                end;

                if WorkOrderMaster."Ship To Address 2" = '' then begin
                    ShipToAd2 := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                    ShipTo := '';
                end else begin
                    ShipToAd2 := WorkOrderMaster."Ship To Address 2";
                    ShipTo := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                end;

                if Cust.Get(Customer) then begin
                    if Cust."Internet Invoicing" then
                        Invoicing := 'Internet Invoicing'
                    else
                        if Cust."No Internet/Paper Invoice" then
                            Invoicing := 'No Internet/Paper Invoice'
                        else
                            Invoicing := '';
                end;

                // 05/02/13 Start
                CCComments := "CC Comments 1";
                if Cust.Get(Customer) then;
                if Cust."Email Invoice" then begin
                    if StrLen(Invoicing) = 0 then begin
                        Invoicing := 'Email Invoice';
                    end else begin
                        Invoicing += '\Email Invoice';
                    end;
                    if StrLen(CCComments) = 0 then begin
                        // Invoicing email
                        //CCComments := Cust."E-Mail";
                        CCComments := Cust."Invoicing Email";
                    end else begin
                        // Invoicing email
                        //CCComments := Cust."E-Mail" + ' | ' +CCComments;
                        CCComments := Cust."Invoicing Email" + ' | ' + CCComments;
                    end;
                end;
                if "Payment Method" = GLSetup."Credit Card Payment Code" then
                    // 06/09/19 Start
                    if Cust."CC Fee Waived" then
                        CCFeeText := 'No Credit Card Fee'
                    else
                        // 06/09/19 End
                        CCFeeText := 'Credit Card Fee ' + Format(GLSetup."Credit Card Fee %") + ' % _________'
                else
                    CCFeeText := '';
                // 05/02/13 End
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
        TempWorkOrderDetail: Record WorkOrderDetail temporary;
        ShipTo: Text[50];
        BillTo: Text[50];
        ShipToAd2: Text[50];
        BillToAd2: Text[50];
        Cust: Record Customer;
        Invoicing: Text[127];
        TaxLiable: Text[30];
        CCComments: Text[127];
        CCFeeText: Text[30];
        GLSetup: Record "General Ledger Setup";
        HighestDetailNo: Code[20];
        NumberOfDetails: Integer;
        OnLineNumber: Integer;
        PrintFooter: Boolean;
        NoLoops: Integer;
        CopyNo: Integer;
        NoTotalEnvelopes: Integer;
        EnvelopeNo: Integer;
        Name_on_Card_CaptionLbl: Label 'Name on Card:';
        Bill_to_Address_CaptionLbl: Label 'Bill-to Address:';
        Comments_CaptionLbl: Label 'Comments:';
        Date_Ordered_CaptionLbl: Label 'Date Ordered:';
        Date_Required_CaptionLbl: Label 'Date Required:';
        Exp__Date_CaptionLbl: Label 'Exp. Date:';
        Rep_CaptionLbl: Label 'Rep:';
        Inside_Sales_CaptionLbl: Label 'Inside Sales:';
        Account___CaptionLbl: Label 'Account #:';
        Credit_Card_SC_CaptionLbl: Label 'Credit Card SC:';
        Terms_CaptionLbl: Label 'Terms:';
        WORK_ORDER___CaptionLbl: Label '** WORK ORDER **';
        Credit_Card_CaptionLbl: Label 'Credit Card:';
        Ship_To_Customer_CaptionLbl: Label 'Ship To Customer:';
        W_O__CaptionLbl: Label 'W/O #';
        Phone_No__CaptionLbl: Label 'Phone No.:';
        Attention_CaptionLbl: Label 'Attention:';
        Fax_No__CaptionLbl: Label 'Fax No.:';
        Customer__CaptionLbl: Label 'Customer #';
        Bill_To_Customer_CaptionLbl: Label 'Bill To Customer:';
        Envelope_CaptionLbl: Label 'Envelope ';
        EmptyStringCaptionLbl: Label '/';
        Initials_DateCaptionLbl: Label 'Initials/Date';
        DescriptionCaptionLbl: Label 'Description';
        NotesCaptionLbl: Label 'Notes';
        Income_Code_CaptionLbl: Label 'Income Code:';
        PriceCaptionLbl: Label 'Price';
        Initials_DateCaption_Control72Lbl: Label 'Initials/Date';
        Invoice__CaptionLbl: Label 'Invoice #';
        PO_No_CaptionLbl: Label 'PO No.';
        Model_No_CaptionLbl: Label 'Model No.';
        Serial_No_CaptionLbl: Label 'Serial No.';
        Detail_No_CaptionLbl: Label 'Detail No.';
        Carrier_CaptionLbl: Label 'Carrier:';
}

