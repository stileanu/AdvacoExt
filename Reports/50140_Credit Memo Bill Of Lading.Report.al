report 50140 "Credit Memo Bill Of Lading"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50140_Credit Memo Bill Of Lading.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(BillofLading; BillofLading)
        {
            DataItemTableView = SORTING("Bill of Lading") ORDER(Ascending) WHERE(Type = FILTER("Credit Memo"));
            RequestFilterFields = "Bill of Lading", "Order No.";
            column(AgentName__________Method_; AgentName + '  ' + Method)
            {
            }
            column(Bill_of_Lading__Ship_To_Name_; "Ship To Name")
            {
            }
            column(Bill_of_Lading__Ship_To_Address_; "Ship To Address")
            {
            }
            column(Bill_of_Lading__Shipment_Date_; "Shipment Date")
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Bill_of_Lading_Attention; Attention)
            {
            }
            column(Bill_of_Lading__Bill_of_Lading_; "Bill of Lading")
            {
            }
            column(ShipToAd2; ShipToAd2)
            {
            }
            column(Bill_of_Lading__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(ATTN__; 'ATTN:')
            {
            }
            column(Bill_of_Lading__Shipping_Account_; "Shipping Account")
            {
            }
            column(Bill_of_Lading___Phone_No__; "Phone No.")
            {
            }
            column(Bill_of_Lading__Container_Quantity_; "Container Quantity")
            {
            }
            column(Bill_of_Lading__Container_Type_; "Container Type")
            {
            }
            column(POWER_VACUUM_PUMPS_PARTS_OIL_; 'POWER VACUUM PUMPS/PARTS/OIL')
            {
            }
            column(FORMAT__Shipping_Weight____________Lbs__; Format("Shipping Weight") + ' ' + 'Lbs.')
            {
            }
            column(V085_; '085')
            {
            }
            column(Collect; Collect)
            {
            }
            column(Bill_of_Lading_Order_No_; "Order No.")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("Order No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = FILTER("Credit Memo"));
                column(CM_______Document_No__; 'CM# ' + "Document No.")
                {
                }
                column(RMA______PurchaseHeader__RMA_No__; 'RMA# ' + PurchaseHeader."RMA No.")
                {
                }
                column(Serial; Serial)
                {
                }
                column(Purchase_Line_Description; Description)
                {
                }
                column(Qty__; 'Qty.')
                {
                }
                column(Purchase_Line_Quantity; Quantity)
                {
                }
                column(ItemNo; ItemNo)
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
                    PurchaseHeader.SetRange("Document Type", "Document Type");
                    PurchaseHeader.SetRange("No.", "Document No.");
                    if PurchaseHeader.Find('-') then begin
                        if ("Purchase Line"."No." = '408') or ("Purchase Line"."No." = '404') then
                            CurrReport.Skip;

                        //if "Purchase Line".Type <> 1 then ICE-MPC 08/21/20
                        if "Purchase Line".Type.AsInteger() <> 1 then
                            //    ItemNo := "Purchase Line"."Cross Reference Item"
                            //  ELSE
                            ItemNo := "Purchase Line"."No.";

                        //  IF "Purchase Line"."Serial No." = '' THEN
                        //    Serial := ''
                        //  ELSE
                        //    Serial := 'SN#  ' + "Serial No.";
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if "Ship To Address2" = '' then begin
                    ShipToAd2 := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                    ShipTo := '';
                end else begin
                    ShipToAd2 := "Ship To Address2";
                    ShipTo := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                end;

                if "Shipping Method" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipping Method");
                Method := ShipmentMethod.Description;

                if Carrier = '' then begin
                    Clear(Agent);
                end else begin
                    if Agent.Get(Carrier) then
                        AgentName := Agent.Name
                    else
                        AgentName := Carrier;
                end;

                if "Shipping Charge" = "Shipping Charge"::Collect then
                    Collect := 'X'
                else
                    Collect := '';
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
        ShipToAddress: Record "Ship-to Address";
        ShipToAd2: Text[50];
        ShipTo: Text[50];
        ShipmentMethod: Record "Shipment Method";
        Agent: Record "Shipping Agent";
        AgentName: Text[30];
        Method: Text[30];
        Collect: Code[1];
        ItemNo: Code[30];
        Serial: Code[30];
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
}

