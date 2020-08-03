pageextension 62027 InventorySetupExt extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter(Numbering)
        {
            group(Advaco)
            {
                field("EOQ Inventory Range"; "EOQ Inventory Range")
                {
                    ApplicationArea = all;
                }
                field(Threshold; Threshold)
                {
                    ApplicationArea = all;
                }
                field("Sales Qty"; "Sales Qty")
                {
                    ApplicationArea = all;
                }
                field("Inventory Holding Level"; "Inventory Holding Level")
                {
                    ApplicationArea = all;
                }
                field("Holding Cost"; "Holding Cost")
                {
                    ApplicationArea = all;
                }
                field("Cost of Ordering"; "Cost of Ordering")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Posted Phys. Invt. Order Nos.")
        {
            field("Work Order Nos."; "Work Order Nos.")
            {
                ApplicationArea = all;
            }
            field("IDR Nos."; "IDR Nos.")
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