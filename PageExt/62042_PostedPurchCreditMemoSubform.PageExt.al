pageextension 62042 MyExtension extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Vendor P/#';
            }
        }
    }

}