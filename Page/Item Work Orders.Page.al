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
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                }
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Committed Quantity"; "Committed Quantity")
                {
                    ApplicationArea = All;
                }
                field("In-Process Quantity"; "In-Process Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quantity Backorder"; "Quantity Backorder")
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

