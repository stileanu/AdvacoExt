TableExtension 50105 ItemLedgerEntryExt Extends "Item Ledger Entry"
{
    fields
    {
        field(50000; Rep; Code[3])
        {
            Caption = 'Rep';
            TableRelation = "Outside Sales Reps"."Rep Code";
        }
        field(50001; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salesperson/Purchaser';
            TableRelation = "Salesperson/Purchaser";
        }
    }
}