page 50090 tableUtility_Status
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Status;

    layout
    {
        area(Content)
        {
            repeater(DetailStatusList)
            {
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
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
                field("Regular Hours"; "Regular Hours")
                {
                    ApplicationArea = All;
                }
                field("Overtime Hours"; "Overtime Hours")
                {
                    ApplicationArea = All;
                }
                field(Employee; Employee)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field(Passed; Passed)
                {
                    ApplicationArea = All;
                }
                field(User; User)
                {
                    ApplicationArea = All;
                }
                field("File Exists"; "File Exists")
                {
                    ApplicationArea = All;
                }
                field("Skip Step"; "Skip Step")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; "Serial No")
                {
                    ApplicationArea = All;
                }
            }

        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}