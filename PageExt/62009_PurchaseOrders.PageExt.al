pageextension 62009 PurchaseOrdersExt extends "Purchase Orders"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor No.")
        {
            field("Order No."; "Order No.")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}