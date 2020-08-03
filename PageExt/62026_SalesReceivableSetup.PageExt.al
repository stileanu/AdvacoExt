pageextension 62026 SalesReceivableSetupExt extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Copy Line Descr. to G/L Entry")
        {
            field("Mileage Rate"; "Mileage Rate")
            {
                ApplicationArea = all;
            }
            field("Field Service Rate"; "Field Service Rate")
            {
                ApplicationArea = all;
            }
            field("UPS Handling Charge"; "UPS Handling Charge")
            {
                ApplicationArea = all;
            }
            field("UPS Shipping Surcharge"; "UPS Shipping Surcharge")
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