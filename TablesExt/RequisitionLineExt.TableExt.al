tableextension 50132 RequisitionLineExt extends "Requisition Line"
{
    /*
        04/26/16 ADV
        Added field <Orig. Expected Receipt Date> for Vendor Responsiveness report
    */

    fields
    {
        field(50000; "Work Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Work Order No.';
        }
    }
}