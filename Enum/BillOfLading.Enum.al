enum 50026 BillType
{
    Extensible = true;

    value(0; Customer) { }
    value(1; Vendor) { }
    value(2; "Credit Memo") { }
}
enum 50027 BOLContainer
{
    Extensible = true;

    value(0; " ") { }
    value(1; Crate) { }
    value(2; Box) { }
    value(3; Skid) { }
    value(4; "Case") { }
    value(5; Drum) { }
    value(6; "Skid Box") { }
    value(7; Loose) { }
}
enum 50028 BOLShipCharge
{
    Extensible = true;

    value(0; " ") { }
    value(1; Collect) { }
    value(2; "Pre-Paid") { }
    value(3; "Pre-Paid & Add") { }
    value(4; "3rd Party") { }
    value(5; Consignee) { }
}
/*
    value(0; " ") { }
    value(1; Collect) { }
    value(2; "Pre-Paid") { }
    value(3; "Pre-Paid & Add") { }
    value(4; "3rd Party") { }
    value(5; Consignee) { }
*/
