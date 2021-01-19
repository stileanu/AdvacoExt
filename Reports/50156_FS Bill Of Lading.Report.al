report 50156 "FS Bill Of Lading"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50156_FS Bill Of Lading.Rp.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(BillofLading; BillofLading)
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
            dataitem("Field Service Parts Shipment"; "Field Service Parts Shipment")
            {
                DataItemLink = "Bill of Lading" = FIELD("Bill of Lading");
                DataItemTableView = SORTING("Bill of Lading", "Work Order No.", "Part No.") ORDER(Ascending);
                column(FS_______Work_Order_No__; 'FS# ' + "Work Order No.")
                {
                }
                column(PO______PO; 'PO# ' + PO)
                {
                }
                column(Qty__; 'Qty.')
                {
                }
                column(Field_Service_Parts_Shipment__Qty__Shipped_; "Qty. Shipped")
                {
                }
                column(Field_Service_Parts_Shipment__Part_No__; "Part No.")
                {
                }
                column(Field_Service_Parts_Shipment_Description; Description)
                {
                }
                column(Field_Service_Parts_Shipment__Serial_No__; "Serial No.")
                {
                }
                column(Field_Service_Parts_Shipment_Bill_of_Lading; "Bill of Lading")
                {
                }
                column(Field_Service_Parts_Shipment_Work_Order_No_; "Work Order No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Field Service Parts Shipment"."Qty. Shipped" = 0 then begin
                        CurrReport.Skip;
                    end else begin
                        if "Field Service Parts Shipment"."Serial No." = '' then
                            Serial := ''
                        else
                            Serial := 'SN#  ' + "Serial No.";
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

                if Carrier = '' then
                    Clear(Agent)
                else
                    Agent.Get(Carrier);
                AgentName := Agent.Name;

                if "Shipping Charge" = "Shipping Charge"::Collect then
                    Collect := 'X'
                else
                    Collect := '';

                PO := "PO No.";
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
        Serial: Code[30];
        PO: Code[30];
}

