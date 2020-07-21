tableextension 50110 SalesShipmentHeaderExt extends "Sales Shipment Header"
{
    /*
     //>> Add User Who Created file
    */
    fields
    {
        field(50000; Rep; code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";
        }
        field(50001; "Shipping Account"; Code[20])
        {
            Caption = 'Shipping Account';
        }
        field(50002; "Shipping Charge"; Enum ShippingCharge)
        {
            Caption = 'Shipping Charge';
            //OptionMembers = " ",Collect,"Pre-paid","Pre-Paid & Add","3rd Party",Consignee;
            //OptionCaption = ' ,Collect,Pre-Paid,Pre-Paid & Add,3rd Party,Consignee';

        }
        field(50003; "Exempt Organization"; Text[30])
        {
            Caption = 'Exempt Organization';
        }
        field(50004; User; Code[15])
        {
            Caption = 'User';

        }
        field(50005; "Card Type"; Enum CreditCardType)
        {
            Caption = 'Card Type';
            //OptionMembers = " ",AM,DI,MC,VI;
            //OptionCaption = ' ,AM,DI,MC,VI';
        }
        field(5006; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
            AutoFormatExpression = "Credit Card No.";
        }
        field(50007; "Credit Card Exp."; Code[6])
        {
            Caption = 'Credit Card Exp.';
            AutoFormatExpression = "Credit Card Exp.";

        }
        field(50008; "Bill of Lading"; Integer)
        {
            Caption = 'Bill of Lading';
        }
        field(50009; "Approval Code"; Code[20])
        {
            Caption = 'Approval Code';
        }
        field(50010; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            AutoFormatExpression = "Phone No.";
        }
        field(50011; "Work Order No."; Code[20])
        {
            Caption = 'Work Order No.';
        }
        field(50012; "Customer Order No."; Code[30])
        {
            Caption = 'Customer Order No.';
        }
        field(50013; "Freight Include in Price"; Boolean)
        {
            Caption = 'Freight Include in Price';
        }

    }
    trigger OnInsert()
    begin
        //>> HEF Add User who Created File
        User := USERID;
        //>> End Insert  
    end;
}