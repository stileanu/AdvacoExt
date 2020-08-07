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
                    ApplicationArea = All;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field(Step; Step)
                {
                    ApplicationArea = All;
                }
                field("Date In"; "Date In")
                {
                    ApplicationArea = All;
                }
                field("Date Out"; "Date Out")
                {
                    ApplicationArea = All;
                }
                field(Employee; Employee)
                {
                    ApplicationArea = All;
                }
                field("Regular Hours"; "Regular Hours")
                {
                    ApplicationArea = All;
                }
                field("Overtime Hours"; "Overtime Hours")
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

