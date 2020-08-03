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
                field("Work Order No.";"Work Order No.")
                {
                }
                field("Model No.";"Model No.")
                {
                    DrillDownPageID = "Model List";
                    LookupPageID = "Model List";
                }
                field("Failure Code";"Failure Code")
                {
                }
                field(Descripton;Descripton)
                {
                }
            }
        }
    }

    actions
    {
    }
}

