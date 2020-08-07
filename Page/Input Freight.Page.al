page 50046 "Input Freight"
{
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer ID"; "Customer ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Freightin; Freightin)
                {
                    ApplicationArea = All;
                }
                field("Freightin Bill Customer"; "Freightin Bill Customer")
                {
                    ApplicationArea = All;
                }
                field(Freightout; Freightout)
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
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

