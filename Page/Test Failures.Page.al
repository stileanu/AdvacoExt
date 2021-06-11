#pragma implicitwith disable
page 50036 "Test Failures"
{
    PageType = List;
    SourceTable = "Pump Failures";

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
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Model List";
                    LookupPageID = "Model List";
                }
                field("Failure Code"; Rec."Failure Code")
                {
                    ApplicationArea = All;
                }
                field(Descripton; Rec.Descripton)
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

