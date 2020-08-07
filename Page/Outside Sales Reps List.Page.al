page 50051 "Outside Sales Reps List"
{
    // 01212011 - ADV
    // New form

    PageType = List;
    SourceTable = "Outside Sales Reps";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Rep Code"; "Rep Code")
                {
                    ApplicationArea = All;
                }
                field("Rep Name"; "Rep Name")
                {
                    ApplicationArea = All;
                }
                field("Rep Company"; "Rep Company")
                {
                    ApplicationArea = All;
                }
                field("Rep Address 1"; "Rep Address 1")
                {
                    ApplicationArea = All;
                }
                field("Rep City"; "Rep City")
                {
                    ApplicationArea = All;
                }
                field("Rep State"; "Rep State")
                {
                    ApplicationArea = All;
                }
                field("Rep Zip"; "Rep Zip")
                {
                    ApplicationArea = All;
                }
                field("Commission %"; "Commission %")
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

