tableextension 50130 Purch_Cr_Memo_HdrExt extends "Purch. Cr. Memo Hdr."
{
    /*    
        09/14/2011 ADV
        Fixed a bug.
        Extended field 50003 Notes from Chr60 to Chr75 to fit Purchase Header size.
    */
    fields
    {
        field(50000; "Blanket Order No."; Code[10])
        {
            Caption = 'Blanket Order No.';
        }
        field(50001; "Quality Clause"; Code[10])
        {
            Caption = 'Quality Clause';
        }
        field(50002; "Shipping Agent"; Code[20])
        {
            Caption = 'Shipping Agent';
        }
        field(50003; Notes; Code[75])
        {
            Caption = 'Notes';
        }
        field(50004; "Placed by"; Enum OrderPlacedBy)
        {
            Caption = 'Placed by';
        }
        field(50006; Requested; Code[3])
        {
            Caption = 'Requested';
        }

    }
}