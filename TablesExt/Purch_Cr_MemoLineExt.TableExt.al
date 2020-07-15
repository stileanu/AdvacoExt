tableextension 50131 Purch_Cr_MemoLineExt extends "Purch. Cr. Memo Line"
{
    /*   
        04/26/16 ADV
        Added field <Orig. Expected Receipt Date> for Vendor Responsiveness report
    */
    fields
    {
        field(50007; "Orig. Expected Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Orig. Expected Receipt Date';
            Description = '4/26/16 ADV';
        }
    }
}