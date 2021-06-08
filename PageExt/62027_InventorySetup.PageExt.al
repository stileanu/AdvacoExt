pageextension 62027 InventorySetupExt extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(Numbering)
        {
            group(Advaco)
            {
                field("EOQ Inventory Range"; Rec."EOQ Inventory Range")
                {
                    ApplicationArea = all;
                }
                field(Threshold; Rec.Threshold)
                {
                    ApplicationArea = all;
                }
                field("Sales Qty"; Rec."Sales Qty")
                {
                    ApplicationArea = all;
                }
                field("Inventory Holding Level"; Rec."Inventory Holding Level")
                {
                    ApplicationArea = all;
                }
                field("Holding Cost"; Rec."Holding Cost")
                {
                    ApplicationArea = all;
                }
                field("Cost of Ordering"; Rec."Cost of Ordering")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Posted Phys. Invt. Order Nos.")
        {
            field("Work Order Nos."; Rec."Work Order Nos.")
            {
                ApplicationArea = all;
            }
            field("IDR Nos."; Rec."IDR Nos.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}