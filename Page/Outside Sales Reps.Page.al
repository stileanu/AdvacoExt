#pragma implicitwith disable
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
                field("Rep Code"; Rec."Rep Code")
                {
                    ApplicationArea = All;
                }
                field("Rep Name"; Rec."Rep Name")
                {
                    ApplicationArea = All;
                }
                field("Rep Company"; Rec."Rep Company")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep Address 1"; Rec."Rep Address 1")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep City"; Rec."Rep City")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep State"; Rec."Rep State")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Rep Zip"; Rec."Rep Zip")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Commission %"; Rec."Commission %")
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

#pragma implicitwith restore

