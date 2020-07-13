tableextension 50115 Ship_ToAddressExt extends "Ship-to Address"
{
    fields
    {
        field(50000; "Inside Sales"; Code[3])
        {
            Caption = 'Inside Sales';
        }
        field(50001; Rep; Code[3])
        {
            Caption = 'Rep';
        }
        field(50004; "Shipment Approved"; Boolean)
        {
            Caption = 'Shipment Approved';
        }
        field(50005; "Freight include in Price"; Boolean)
        {
            Caption = 'Freight include in Price';
        }
    }

    trigger OnAfterInsert()
    var
        Cust: Record Customer;

    begin
        Cust.GET("Customer No.");

        //>> HEF 01/18/01  02/01/01
        "Location Code" := 'MAIN';
        Rep := Cust.Rep;
        "Inside Sales" := Cust."Salesperson Code";
        "Tax Area Code" := 'MD';
        "Tax Liable" := Cust."Tax Liable";
        "Shipment Method Code" := Cust."Shipment Method Code";
        "Shipping Agent Code" := Cust."Shipping Agent Code";
    end;
}