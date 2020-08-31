page 50011 "Mechanics Parts Phase 1"
{
    //Tested
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = QuoteMechanicsParts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field("Part Quantity"; "Part Quantity")
                {
                    ApplicationArea = All;
                }
                field("Part Description"; "Part Description")
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

