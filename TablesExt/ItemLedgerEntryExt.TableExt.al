TableExtension 50105 ItemLedgerEntryExt Extends "Item Ledger Entry"
{
    fields
    {
        field(50000; Rep; Code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";
        }
    }
}