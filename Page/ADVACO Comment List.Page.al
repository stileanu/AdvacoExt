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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

