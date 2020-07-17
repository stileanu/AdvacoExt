table 50012 BillOfLading
{
    // 05/2/18
    //   Container Type field set to field options in table 50001.


    fields
    {
        field(10; "Bill of Lading"; Integer)
        {
        }
        field(15; Type; Enum BillType)
        {
            //OptionMembers = Customer,Vendor,"Credit Memo";
        }
        field(20; "Order No."; Code[20])
        {
        }
        field(30; Customer; Code[20])
        {
        }
        field(40; "PO No."; Code[30])
        {
        }
        field(41; "Ship To Name"; Text[30])
        {
        }
        field(42; "Ship To Address"; Text[30])
        {
        }
        field(43; "Ship To Address2"; Text[30])
        {
        }
        field(44; "Ship To City"; Text[30])
        {
        }
        field(45; "Ship To State"; Code[15])
        {
        }
        field(46; "Ship To Zip Code"; Code[15])
        {
        }
        field(47; Attention; Text[40])
        {
        }
        field(48; "Phone No."; Text[30])
        {
        }
        field(50; "Shipping Weight"; Decimal)
        {
        }
        field(60; "Container Quantity"; Integer)
        {
        }
        field(75; "Container Type"; Enum BOLContainer)
        {
            //OptionCaption = '" ,Crate,Box,Skid,Case,Drum,Skid Box,Loose"';
            //OptionMembers = " ",Crate,Box,Skid,"Case",Drum,"Skid Box",Loose;
        }
        field(80; Employee; Code[3])
        {
        }
        field(110; "Shipment Date"; Date)
        {
        }
        field(120; Carrier; Code[20])
        {
        }
        field(122; "Shipping Method"; Code[10])
        {
        }
        field(124; "Shipping Charge"; Enum BOLShipCharge)
        {
            //OptionMembers = " ",Collect,"Pre-Paid","Pre-Paid & Add","3rd Party",Consignee;
        }
        field(126; "Shipping Account"; Code[30])
        {
        }
        field(130; "Package Tracking No."; Text[30])
        {
        }
        field(200; "BOL Printed"; Boolean)
        {
        }
        field(210; "Label Printed"; Boolean)
        {
        }
        field(220; "Label Quantity"; Integer)
        {
        }
        field(230; "Quantity Printed"; Integer)
        {
        }
        field(240; "RMA No."; Code[30])
        {
        }
    }

    keys
    {
        key(Key1; "Bill of Lading")
        {
        }
        key(Key2; Type, "Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

