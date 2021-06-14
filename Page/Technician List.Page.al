#pragma implicitwith disable
page 50110 "Technician List"
{
    Editable = false;
    PageType = List;
    SourceTable = Resource;

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
                field(Name; Rec.Name)
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

#pragma implicitwith restore

