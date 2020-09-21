page 50008 "Job Status List"
{
    // 2016_02_27 ADV
    //   Repaired broken action for Show Status button on Special Inquiry form.

    DeleteAllowed = false;
    //Editable = false;
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
                field(Status; Status)
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

