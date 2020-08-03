page 50199 "Work Order Step Entry 50007"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = Status;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field("Order No."; "Order No.")
                {
                }
                field(Step; Step)
                {
                }
                field("Date In"; "Date In")
                {
                }
                field("Date Out"; "Date Out")
                {
                }
                field(Employee; Employee)
                {
                }
                field("Regular Hours"; "Regular Hours")
                {
                }
                field("Overtime Hours"; "Overtime Hours")
                {
                }
            }
        }
    }

    actions
    {
    }
}

