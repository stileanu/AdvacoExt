tableextension 50135 InventorySetupExt extends "Inventory Setup"
{
    fields
    {
        field(50000; "Work Order Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Order Nos.';
            TableRelation = "No. Series";
        }
        field(50001; "IDR Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'IDR Nos.';
            TableRelation = "No. Series";
        }
        field(50002; "Threshold"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Threshold';
        }
        field(50003; "Inventory Holding Level"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Inventory Holding Level';
        }
        field(50004; "Holding Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Holding Cost';
        }
        field(50005; "Cost of Ordering"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cost of Ordering';
        }
        field(50006; "Sales Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "EOQ Inventory Range"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'EOQ Inventory Range';
        }
    }

    var
        myInt: Integer;
}
