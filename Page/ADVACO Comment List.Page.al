page 50041 "ADVACO Comment List"
{
    Caption = 'Comment List';
    DataCaptionFields = "No.";
    Editable = false;
    PageType = List;
    SourceTable = "ADVACO Comment Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(Date;Date)
                {
                }
                field(Comment;Comment)
                {
                }
            }
        }
    }

    actions
    {
    }
}

