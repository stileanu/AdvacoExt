#pragma implicitwith disable
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
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;
                }
                field("Part Quantity"; Rec."Part Quantity")
                {
                    ApplicationArea = All;
                }
                field("Part Description"; Rec."Part Description")
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

