report 50022 "Sales Order - ADVACO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50022_SalesOrder_ADVACO.rdl';
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
            column(Sales_Header__Shipping_Account_; "Shipping Account")
            {
            }
            column(Sales_Header__Shipping_Advice_; "Shipping Advice")
            {
            }
            column(Sales_Header__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(Sales_Header__Shipment_Method_Code_; "Shipment Method Code")
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
            column(Due_Date_Caption; Due_Date_CaptionLbl)
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
            column(S_A_L_E_S___O_R_D_E_RCaption; S_A_L_E_S___O_R_D_E_RCaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Account_No__Caption; Account_No__CaptionLbl)
            {
            }
            column(Instructions_Caption; Instructions_CaptionLbl)
            {
            }
            column(Charge_Caption; Charge_CaptionLbl)
            {
            }
            column(Method_Caption; Method_CaptionLbl)
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
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Unit_Price_; "Unit Price")
                {
                    DecimalPlaces = 2 : 2;
                }
                column(Sales_Line__Vendor_No__; "Vendor No.")
                {
                }
                column(Sales_Line__Unit_Cost_; "Unit Cost")
                {
                }
                column(QtyAvailable; QtyAvailable)
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
                column(VendorCaption; VendorCaptionLbl)
                {
                }
                column(Sales_Line__Unit_Cost_Caption; FieldCaption("Unit Cost"))
                {
                }
                column(Avail_Caption; Avail_CaptionLbl)
                {
                }
                column(Serial_No_Caption; Serial_No_CaptionLbl)
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; Format("Line No."))
                {
                }
                column(WO_Serial_No; WO_Serial_No)
                {
                }

                trigger OnAfterGetRecord()
                var
                    PurchLine: Record "Purchase Line";
                    WOD: Record WorkOrderDetail;

                begin
                    if Type = Type::"G/L Account" then begin
                        if ("No." <> '311') or ("No." <> '312') then begin
                            ITEMNO := "Cross Reference Item";
                        end else begin
                            ITEMNO := '';
                        end;
                    end else begin
                        ITEMNO := "No.";
                    end;

                    QtyAvailable := 0;

                    if Item.Get("Sales Line"."No.") then begin
                        Item.SetFilter("Location Filter", '%1|%2', 'MAIN', 'COMMITTED');
                        Item.CalcFields(Inventory, "Qty. on Purch. Order", "Reserved Qty. on Inventory");
                        QtyAvailable := (Item.Inventory - Item."Reserved Qty. on Inventory");
                    end;

                    if not WOD.GetSerialNo_(Database::"Sales Line", "Sales Line", PurchLine, WO_Serial_No) then
                        WO_Serial_No := ' ';
                end;
            }
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
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
                column(Note_Capt; NoteCapt)
                {
                }

                trigger OnPreDataItem()
                begin
                    NoteCapt := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    NoteCapt += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF "Sales Header"."Bill-to Address 2" = '' THEN BEGIN
                    BillToAd2 := ("Bill-to City") + (', ') + ("Bill-to County") + ('  ') + ("Bill-to Post Code");
                    BillTo := '';
                END ELSE BEGIN
                    BillToAd2 := "Sales Header"."Bill-to Address 2";
                    BillTo := ("Bill-to City") + (', ') + ("Bill-to County") + ('  ') + ("Bill-to Post Code");
                END;

                IF "Sales Header"."Ship-to Address 2" = '' THEN BEGIN
                    ShipToAd2 := ("Ship-to City") + (', ') + ("Ship-to County") + ('  ') + ("Ship-to Post Code");
                    ShipTo := '';
                END ELSE BEGIN
                    ShipToAd2 := "Sales Header"."Ship-to Address 2";
                    ShipTo := ("Ship-to City") + (', ') + ("Ship-to County") + ('  ') + ("Ship-to Post Code");
                END;

                IF ("Sales Header"."Payment Terms Code" = 'CC') THEN
                    CC := 'Contact Accounting for Credit Card Approval Before Shipping!'
                ELSE
                    IF ("Sales Header"."Payment Terms Code" = 'COD') THEN
                        CC := 'Contact Accounting to Calculate COD Charges, and enter COD Approval Before Shipping!'
                    ELSE
                        CC := '';
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
        NoteCapt: Integer;
        WO_Serial_No: Code[50];
        BillTo: Text[50];
        ShipTo: Text[50];
        BillToAd2: Text[50];
        ShipToAd2: Text[50];
        CC: Text[80];
        Item: Record Item;
        ITEMNO: Code[30];
        QtyAvailable: Decimal;
        S_O____CaptionLbl: Label 'S/O # :';
        Terms_CaptionLbl: Label 'Terms:';
        Rep_CaptionLbl: Label 'Rep:';
        Carrier_CaptionLbl: Label 'Carrier:';
        ADVACOCaptionLbl: Label 'ADVACO';
        Inside_Sales_CaptionLbl: Label 'Inside Sales:';
        Due_Date_CaptionLbl: Label 'Due Date:';
        Attention_CaptionLbl: Label 'Attention:';
        Ship_To_CaptionLbl: Label 'Ship To:';
        Bill_To_CaptionLbl: Label 'Bill To:';
        S_A_L_E_S___O_R_D_E_RCaptionLbl: Label 'S A L E S   O R D E R';
        Date_CaptionLbl: Label 'Date:';
        Account_No__CaptionLbl: Label 'Account No.:';
        Instructions_CaptionLbl: Label 'Instructions:';
        Charge_CaptionLbl: Label 'Charge:';
        Method_CaptionLbl: Label 'Method:';
        PostingCaptionLbl: Label 'Posting';
        QtyCaptionLbl: Label 'Qty';
        Item_No_CaptionLbl: Label 'Item No.';
        VendorCaptionLbl: Label 'Vendor';
        Avail_CaptionLbl: Label 'Avail.';
        Notes_CaptionLbl: Label 'Notes:';
        Serial_No_CaptionLbl: Label 'Serial No.';
}

