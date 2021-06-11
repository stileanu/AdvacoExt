#pragma implicitwith disable
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
                }
                field("Rep Address 1"; Rec."Rep Address 1")
                {
                    ApplicationArea = All;
                }
                field("Rep City"; Rec."Rep City")
                {
                    ApplicationArea = All;
                }
                field("Rep State"; Rec."Rep State")
                {
                    ApplicationArea = All;
                }
                field("Rep Zip"; Rec."Rep Zip")
                {
                    ApplicationArea = All;
                }
                field("Commission %"; Rec."Commission %")
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

