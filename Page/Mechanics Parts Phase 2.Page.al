page 50012 "Mechanics Parts Phase 2"
{
    //Tested
    PageType = ListPart;
    SourceTable = QuoteMechanicsParts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Entered; Entered)
                {
                    ApplicationArea = All;
                }
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field("Part Description"; "Part Description")
                {
                    ApplicationArea = All;
                }
                field("Part Quantity"; "Part Quantity")
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

