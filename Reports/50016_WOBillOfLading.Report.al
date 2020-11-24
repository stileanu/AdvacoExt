report 50016 "WO Bill Of Lading"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50016_WOBillOfLading.rdl';
    UseSystemPrinter = false;

    dataset
    {
        dataitem("Bill of Lading"; BillOfLading)
        {
            RequestFilterFields = "Bill of Lading", "Order No.", Type;
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
            column(Att; Att)
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
            dataitem("Work Order Detail Customer"; WorkOrderDetail)
            {
                DataItemLink = "Bill of Lading" = FIELD("Bill of Lading");
                DataItemTableView = SORTING("Bill of Lading") ORDER(Ascending);
                column(line3; line3)
                {
                }
                column(line2; line2)
                {
                }
                column(line1; line1)
                {
                }
                column(Work_Order_Detail_Customer__Model_No__; "Model No.")
                {
                }
                column(SN________Serial_No__; 'SN#  ' + "Serial No.")
                {
                }
                column(Work_Order_Detail_Customer__Work_Order_No__; "Work Order No.")
                {
                }
                column(Work_Order_Detail_Customer__Third_Party_Name_; "Third Party Name")
                {
                }
                column(Work_Order_Detail_Customer__Third_Party_Address_; "Third Party Address")
                {
                }
                column(ThirdPartyAddress; ThirdPartyAddress)
                {
                }
                column(THIRD_PARTY_BILLING______________; '*********** THIRD PARTY BILLING  ***********')
                {
                }
                column(EmptyString; '*****************************************************')
                {
                }
                column(Work_Order_Detail_Customer_Bill_of_Lading; "Bill of Lading")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Work Order Detail Customer"."Customer Part No." = '' then begin
                        line1 := Description;
                        line2 := 'PO# ' + "Customer PO No.";
                        line3 := '';
                    end else begin
                        line1 := 'Part# ' + "Customer Part No.";
                        line2 := Description;
                        line3 := 'PO# ' + "Customer PO No.";
                    end;

                    if ("Third Party City" <> '') or ("Third Party State" <> '') or ("Third Party Zip" <> '') then
                        ThirdPartyAddress := ("Third Party City") + (', ') + ("Third Party State") + ('  ') + ("Third Party Zip");
                end;
            }
            dataitem("Work Order Detail Vendor"; WorkOrderDetail)
            {
                DataItemLink = "Vendor Bill of Lading" = FIELD("Bill of Lading");
                DataItemTableView = SORTING("Bill of Lading") ORDER(Ascending);
                column(Work_Order_Detail_Vendor__Model_No__; "Model No.")
                {
                }
                column(Work_Order_Detail_Vendor__RMA_PO_No__; "RMA PO No.")
                {
                }
                column(Work_Order_Detail_Vendor__Work_Order_No__; "Work Order No.")
                {
                }
                column(Work_Order_Detail_Vendor_Description; Description)
                {
                }
                column(SN________Serial_No___Control33; 'SN#  ' + "Serial No.")
                {
                }
                column(Work_Order_Detail_Vendor_Vendor_Bill_of_Lading; "Vendor Bill of Lading")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if ("RMA No." <> '') and (Type = Type::Vendor) then
                    Att := 'RMA: ' + "RMA No."
                else
                    Att := 'ATTN: ' + Attention;

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
        AgentName: Text[50];
        Method: Text[50];
        Collect: Code[1];
        line1: Code[50];
        line2: Code[50];
        line3: Code[50];
        Att: Code[50];
        ThirdPartyAddress: Code[70];
}

