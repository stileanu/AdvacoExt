pageextension 62020 SalesJournalExt extends "Sales Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Shortcut Dimension 2 Code")
        {
            field(Rep; Rep)
            {
                ApplicationArea = all;
            }

        }
        modify("External Document No.")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}