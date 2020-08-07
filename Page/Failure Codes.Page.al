page 50037 "Failure Codes"
{
    PageType = List;
    SourceTable = "Failure Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Failure Code"; "Failure Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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

