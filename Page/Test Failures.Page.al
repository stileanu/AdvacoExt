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
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                }
                field("Model No."; "Model No.")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Model List";
                    LookupPageID = "Model List";
                }
                field("Failure Code"; "Failure Code")
                {
                    ApplicationArea = All;
                }
                field(Descripton; Descripton)
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

