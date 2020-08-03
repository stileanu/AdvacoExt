page 50008 "Job Status List"
{
    // 2016_02_27 ADV
    //   Repaired broken action for Show Status button on Special Inquiry form.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Status;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No.";"Order No.")
                {
                }
                field(Step;Step)
                {
                }
                field("Date In";"Date In")
                {
                }
                field("Date Out";"Date Out")
                {
                }
                field(Status;Status)
                {
                }
                field(Employee;Employee)
                {
                }
                field("Regular Hours";"Regular Hours")
                {
                }
                field("Overtime Hours";"Overtime Hours")
                {
                }
            }
        }
    }

    actions
    {
    }
}

