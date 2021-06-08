pageextension 62026 SalesReceivableSetupExt extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Copy Line Descr. to G/L Entry")
        {
            field("Mileage Rate"; Rec."Mileage Rate")
            {
                ApplicationArea = all;
            }
            field("Field Service Rate"; Rec."Field Service Rate")
            {
                ApplicationArea = all;
            }
            field("UPS Handling Charge"; Rec."UPS Handling Charge")
            {
                ApplicationArea = all;
            }
            field("UPS Shipping Surcharge"; Rec."UPS Shipping Surcharge")
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