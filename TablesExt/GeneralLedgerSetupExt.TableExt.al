tableextension 50122 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    fields
    {
        /*   
            05/02/13 ADV
            Added three new fields to store Credit Card Fee information: <Credit Card Payment Code>, <Credit Card Fee Account>
            and <Credit Card Fee %>.
        */
        field(50000; "Credit Card Payment Code"; Code[10])
        {
            Caption = 'Credit Card Payment Code';
            TableRelation = "Payment Terms";
        }
        field(50001; "Credit Card Fee Account"; Code[20])
        {
            Caption = 'Credit Card Fee Account';
            TableRelation = "G/L Account";
        }
        field(50002; "Credit Card Fee %"; Decimal)
        {
            Caption = 'Credit Card Fee %';
        }
    }
}