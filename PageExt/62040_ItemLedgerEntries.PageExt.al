pageextension 62040 ItemLedgerEntriesExt extends "Item Ledger Entries"
{
    layout
    {
        modify("Serial No.")
        {
            ApplicationArea = All;
            Visible = true;
        }
        addafter("Lot No.")
        {
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}