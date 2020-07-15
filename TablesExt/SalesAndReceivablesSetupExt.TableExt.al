tableextension 50124 SalesAndReceivablesSetupExt extends "Sales & Receivables Setup"
{
    // Added Mileage Rate Field

    fields
    {
        field(50000; "Mileage Rate"; Decimal)
        {
            Caption = 'Mileage Rate';
        }
        field(50001; "Field Service Rate"; Decimal)
        {
            Caption = 'Field Service Rate';
        }
        field(50002; "UPS Shipping Surcharge"; Decimal)
        {
            Caption = 'UPS Shipping Surcharge';
        }
        field(50003; "UPS Handling Charge"; Decimal)
        {
            Caption = 'UPS Handling Charge';
        }
    }
}