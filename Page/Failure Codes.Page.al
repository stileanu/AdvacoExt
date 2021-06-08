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
                field("Failure Code"; Rec."Failure Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

