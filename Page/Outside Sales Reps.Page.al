page 50050 "Outside Sales Reps"
{
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
                    Visible = false;
                }
                field("Rep Address 1"; "Rep Address 1")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep City"; "Rep City")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep State"; "Rep State")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep Zip"; "Rep Zip")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Commission %"; "Commission %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

