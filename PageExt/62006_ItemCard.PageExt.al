pageextension 62006 ItemCardExt extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Blocked)
        {
            field("UPS Shipping Surcharge"; "UPS Shipping Surcharge")
            {
                ApplicationArea = all;
            }
        }
    }


}