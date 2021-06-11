#pragma implicitwith disable
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
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Step; Rec.Step)
                {
                    ApplicationArea = All;
                }
                field("Date In"; Rec."Date In")
                {
                    ApplicationArea = All;
                }
                field("Date Out"; Rec."Date Out")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                }
                field("Regular Hours"; Rec."Regular Hours")
                {
                    ApplicationArea = All;
                }
                field("Overtime Hours"; Rec."Overtime Hours")
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

