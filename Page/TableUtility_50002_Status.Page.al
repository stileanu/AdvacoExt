#pragma implicitwith disable
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
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
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
                field("Regular Hours"; Rec."Regular Hours")
                {
                    ApplicationArea = All;
                }
                field("Overtime Hours"; Rec."Overtime Hours")
                {
                    ApplicationArea = All;
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Passed; Rec.Passed)
                {
                    ApplicationArea = All;
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                }
                field("File Exists"; Rec."File Exists")
                {
                    ApplicationArea = All;
                }
                field("Skip Step"; Rec."Skip Step")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
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
#pragma implicitwith restore
