page 50056 "Item Work Orders"
{
    PageType = List;
    SourceTable = Parts;
    SourceTableView = SORTING("Work Order No.","Part No.")
                      ORDER(Ascending)
                      WHERE(Complete=FILTER(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Work Order No.";"Work Order No.")
                {
                }
                field("Part No.";"Part No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Quoted Quantity";"Quoted Quantity")
                {
                }
                field("Committed Quantity";"Committed Quantity")
                {
                }
                field("In-Process Quantity";"In-Process Quantity")
                {
                }
                field("Quantity Backorder";"Quantity Backorder")
                {
                }
            }
        }
    }

    actions
    {
    }
}

