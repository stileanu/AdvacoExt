pageextension 62010 AppliedCustomerEntriesExt extends "Applied Customer Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
        }


    }
}