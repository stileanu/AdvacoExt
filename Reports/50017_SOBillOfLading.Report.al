report 50017 "SO Bill Of Lading"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50017_SOBillOfLading.rdl';
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Bill of Lading"; BillOfLading)
        {
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
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("Order No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Order));
                column(SO_______Document_No__; 'SO# ' + "Document No.")
                {
                }
                column(PO_______Bill_of_Lading___PO_No__; 'PO# ' + "Bill of Lading"."PO No.")
                {
                }
                column(Qty__; 'Qty.')
                {
                }
                column(Sales_Line__Qty__to_Ship_; "Qty. to Ship")
                {
                }
                column(ItemNo; ItemNo)
                {
                }
                column(Sales_Line_Description; Description)
                {
                }
                column(Serial; Serial)
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
                var
                    WorkOrder: Record WorkOrderDetail;
                    PurchLine: Record "Purchase Line";
                    SerialNo: Code[20];

                begin
                    SalesHeader.SetRange("Document Type", "Document Type");
                    SalesHeader.SetRange("No.", "Document No.");
                    if SalesHeader.Find('-') then begin
                        if SalesHeader."Work Order No." <> '' then begin
                            if "Sales Line"."Line No." = 10000 then begin
                                if "Sales Line".Type = "Sales Line Type".FromInteger(1) then
                                    ItemNo := "Sales Line"."Cross Reference Item"
                                else
                                    ItemNo := "Sales Line"."No.";

                                if not WorkOrder.GetSerialNo_(Database::"Sales Line", "Sales Line", PurchLine, SerialNo) then
                                    Serial := ''
                                else
                                    Serial := 'SN#  ' + SerialNo;
                            end else begin
                                CurrReport.Skip;
                            end;
                        end else begin
                            if "Sales Line"."Qty. to Ship" = 0 then
                                CurrReport.Skip;

                            if ("Sales Line"."No." = '311') or ("Sales Line"."No." = '312') then
                                CurrReport.Skip;

                            if "Sales Line".Type = "Sales Line Type".FromInteger(1) then
                                ItemNo := "Sales Line"."Cross Reference Item"
                            else
                                ItemNo := "Sales Line"."No.";

                            if not WorkOrder.GetSerialNo_(Database::"Sales Line", "Sales Line", PurchLine, SerialNo) then
                                Serial := ''
                            else
                                Serial := 'SN#  ' + SerialNo;
                            //    IF "Sales Line"."Serial No." = '' THEN
                            //      Serial := ''
                            //    ELSE
                            //      Serial := 'SN#  ' + "Serial No.";
                        end;
                    end;
                end;
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "No." = FIELD("Order No.");
                DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Order));
                column(THIRD_PARTY_BILLING______________; '*********** THIRD PARTY BILLING  ***********')
                {
                }
                column(Sales_Header__Third_Party_Name_; "Third Party Name")
                {
                }
                column(Sales_Header__Third_Party_Address_; "Third Party Address")
                {
                }
                column(ThirdPartyAddress; ThirdPartyAddress)
                {
                }
                column(EmptyString; '*****************************************************')
                {
                }
                column(Sales_Header_Document_Type; "Document Type")
                {
                }
                column(Sales_Header_No_; "No.")
                {
                }
                column(Third_Party_Charge; ThirdPartyCharge)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("Third Party City" <> '') or ("Third Party State" <> '') or ("Third Party Zip" <> '') then
                        ThirdPartyAddress := ("Third Party City") + (', ') + ("Third Party State") + ('  ') + ("Third Party Zip");

                    ThirdPartyCharge := "Sales Header"."Shipping Charge" <> "Sales Header"."Shipping Charge"::"3rd Party";
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

                if Carrier = '' then
                    Clear(Agent)
                else
                    Agent.Get(Carrier);
                AgentName := Agent.Name;

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
        ThirdPartyCharge: Boolean;
        Serial: Code[30];
        SalesHeader: Record "Sales Header";
        ThirdPartyAddress: Code[70];
}

