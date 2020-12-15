report 50020 "Sales Order Pick Ticket"
{
    // 2011-05-26 ADV
    //   Modified CC Footer to be of Footer Type not TransFooter type
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50020_SalesOrderPickTicket.rdl';


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
            column(Sales_Header_Rep; Rep)
            {
            }
            column(Sales_Header__Shipping_Agent_Code_; "Shipping Agent Code")
            {
            }
            column(Sales_Header__Salesperson_Code_; "Salesperson Code")
            {
            }
            column(Sales_Header__Ship_to_Contact_; "Ship-to Contact")
            {
            }
            column(BillTo; BillTo)
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Sales_Header__Ship_to_Code_; "Ship-to Code")
            {
            }
            column(FORMAT_TODAY_0_; Format(Today, 0))
            {
            }
            column(Sales_Header__Shipment_Method_Code_; "Shipment Method Code")
            {
            }
            column(Sales_Header__Shipping_Account_; "Shipping Account")
            {
            }
            column(Sales_Header__Shipment_Request_Date_; "Shipment Request Date")
            {
            }
            column(Sales_Header__Shipping_Advice_; "Shipping Advice")
            {
            }
            column(Sales_Header__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(Sales_Header__Work_Order_No__; "Work Order No.")
            {
            }
            column(CC; CC)
            {
            }
            column(S_O____Caption; S_O____CaptionLbl)
            {
            }
            column(Terms_Caption; Terms_CaptionLbl)
            {
            }
            column(Rep_Caption; Rep_CaptionLbl)
            {
            }
            column(Carrier_Caption; Carrier_CaptionLbl)
            {
            }
            column(ADVACOCaption; ADVACOCaptionLbl)
            {
            }
            column(Inside_Sales_Caption; Inside_Sales_CaptionLbl)
            {
            }
            column(Attention_Caption; Attention_CaptionLbl)
            {
            }
            column(Ship_To_Caption; Ship_To_CaptionLbl)
            {
            }
            column(Bill_To_Caption; Bill_To_CaptionLbl)
            {
            }
            column(SALES_ORDER_______PICK_TICKETCaption; SALES_ORDER_______PICK_TICKETCaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Method_Caption; Method_CaptionLbl)
            {
            }
            column(Account_No__Caption; Account_No__CaptionLbl)
            {
            }
            column(Due_Date__Caption; Due_Date__CaptionLbl)
            {
            }
            column(Instructions_Caption; Instructions_CaptionLbl)
            {
            }
            column(Charge_Caption; Charge_CaptionLbl)
            {
            }
            column(W_O____Caption; W_O____CaptionLbl)
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
                column(ITEMNO; ITEMNO)
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Line__Gen__Prod__Posting_Group_; "Gen. Prod. Posting Group")
                {
                }
                column(EmptyString; '_________________________')
                {
                }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Unit_Price_; "Unit Price")
                {
                }
                column(EmptyString_Control43; '_________________________')
                {
                }
                column(Bin; Bin)
                {
                }
                column(PostingCaption; PostingCaptionLbl)
                {
                }
                column(Sales_Line__Unit_Price_Caption; FieldCaption("Unit Price"))
                {
                }
                column(Sales_Line_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(QtyCaption; QtyCaptionLbl)
                {
                }
                column(Item_No_Caption; Item_No_CaptionLbl)
                {
                }
                column(SHPCaption; SHPCaptionLbl)
                {
                }
                column(B_OCaption; B_OCaptionLbl)
                {
                }
                column(Serial_No_Caption; Serial_No_CaptionLbl)
                {
                }
                column(BinCaption; BinCaptionLbl)
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
                    Bin := '';
                    if Type = Type::"G/L Account" then begin
                        if ("No." <> '311') or ("No." <> '312') then begin
                            //    ITEMNO := "Cross Reference Item";
                            //  END ELSE BEGIN
                            //    ITEMNO := '';
                        end;
                    end else begin
                        ITEMNO := "No.";
                        if Item.Get("No.") then
                            Bin := Item."Shelf No.";
                    end;
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                column(Sales_Comment_Line_Comment; Comment)
                {
                }
                column(Notes_Caption; Notes_CaptionLbl)
                {
                }
                column(Sales_Comment_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Comment_Line_No_; "No.")
                {
                }
                column(Sales_Comment_Line_Line_No_; "Line No.")
                {
                }
            }
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
        WO_Serial_No: Code[50];
        BillTo: Text[50];
        ShipTo: Text[50];
        BillToAd2: Text[50];
        ShipToAd2: Text[50];
        CC: Text[150];
        ITEMNO: Code[30];
        Item: Record Item;
        Bin: Code[20];
        S_O____CaptionLbl: Label 'S/O # :';
        Terms_CaptionLbl: Label 'Terms:';
        Rep_CaptionLbl: Label 'Rep:';
        Carrier_CaptionLbl: Label 'Carrier:';
        ADVACOCaptionLbl: Label 'ADVACO';
        Inside_Sales_CaptionLbl: Label 'Inside Sales:';
        Attention_CaptionLbl: Label 'Attention:';
        Ship_To_CaptionLbl: Label 'Ship To:';
        Bill_To_CaptionLbl: Label 'Bill To:';
        SALES_ORDER_______PICK_TICKETCaptionLbl: Label 'SALES ORDER   -   PICK TICKET';
        Date_CaptionLbl: Label 'Date:';
        Method_CaptionLbl: Label 'Method:';
        Account_No__CaptionLbl: Label 'Account No.:';
        Due_Date__CaptionLbl: Label 'Due Date';
        Instructions_CaptionLbl: Label 'Instructions:';
        Charge_CaptionLbl: Label 'Charge:';
        W_O____CaptionLbl: Label 'W/O # :';
        PostingCaptionLbl: Label 'Posting';
        QtyCaptionLbl: Label 'Qty';
        Item_No_CaptionLbl: Label 'Item No.';
        SHPCaptionLbl: Label 'SHP';
        B_OCaptionLbl: Label 'B/O';
        BinCaptionLbl: Label 'Bin';
        Notes_CaptionLbl: Label 'Notes:';
        Serial_No_CaptionLbl: Label 'Serial No.';
}

