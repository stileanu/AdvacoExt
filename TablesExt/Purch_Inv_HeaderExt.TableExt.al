tableextension 50128 Purch_Inv_HeaderExt extends "Purch. Inv. Header"
{
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
        field(50007; "Vendor Fax"; Text[30])
        {
            Caption = 'Vendor Fax';
        }
        field(50008; "Vendor E-mail"; Text[80])
        {
            Caption = 'Vendor E-mail';
        }
        field(50009; "Vendor Repair"; Boolean)
        {
            Caption = 'Vendor Repair';
        }
        field(50100; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
    }
}