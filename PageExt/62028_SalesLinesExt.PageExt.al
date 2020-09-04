pageextension 62028 SalesLinesExt extends "Sales Lines"
{
    layout
    {
        /*
            modify("Document Type")
            {
                Visible = not lShipGroup;
            }
            modify("Qty. to Ship")
            {
                Visible = lShipGroup;
            }
            addafter("Qty. to Ship")
            {
                field("Quantity Shipped"; "Quantity Shipped")
                {
                    Visible = lShipGroup;
                    Editable = false;
                }
            }
        */
    }

    actions
    {
        // Add  changes to page actions here
    }

    var
        lShipGroup: Boolean;
        lSalesgroup: Boolean;
        lAccGroup: Boolean;

}