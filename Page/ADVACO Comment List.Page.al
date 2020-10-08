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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
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

