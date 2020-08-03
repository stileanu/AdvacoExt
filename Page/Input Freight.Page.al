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
                field("Work Order No.";"Work Order No.")
                {
                    Editable = false;
                }
                field("Customer ID";"Customer ID")
                {
                    Editable = false;
                }
                field(Freightin;Freightin)
                {
                }
                field("Freightin Bill Customer";"Freightin Bill Customer")
                {
                }
                field(Freightout;Freightout)
                {
                }
                field("Package Tracking No.";"Package Tracking No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

