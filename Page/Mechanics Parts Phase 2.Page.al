#pragma implicitwith disable
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
                field(Entered; Rec.Entered)
                {
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;
                }
                field("Part Description"; Rec."Part Description")
                {
                    ApplicationArea = All;
                }
                field("Part Quantity"; Rec."Part Quantity")
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

