pageextension 62002 CustomerLedgerEntriesExt extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Work Order No."; "Work Order No.")
            {
                ApplicationArea = all;
            }
            field("Sales Order No."; "Sales Order No.")
            {
                ApplicationArea = all;
            }
        }
    }


}