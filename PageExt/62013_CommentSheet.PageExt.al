pageextension 62013 CommentSheetExt extends "Comment Sheet"
{
    layout
    {
        // Add changes to page layout here
        Addafter(Comment)
        {
            field("User ID"; "User ID")
            {
                ApplicationArea = all;
            }
        }

    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}