#pragma implicitwith disable
page 50056 "Item Work Orders"
{
    //Tested
    PageType = List;
    SourceTable = Parts;
    SourceTableView = SORTING("Work Order No.", "Part No.")
                      ORDER(Ascending)
                      WHERE(Complete = FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; Rec."Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Committed Quantity"; Rec."Committed Quantity")
                {
                    ApplicationArea = All;
                }
                field("In-Process Quantity"; Rec."In-Process Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity Backorder"; Rec."Quantity Backorder")
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

