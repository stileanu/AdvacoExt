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
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Freightin; Rec.Freightin)
                {
                    ApplicationArea = All;
                }
                field("Freightin Bill Customer"; Rec."Freightin Bill Customer")
                {
                    ApplicationArea = All;
                }
                field(Freightout; Rec.Freightout)
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; Rec."Package Tracking No.")
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

