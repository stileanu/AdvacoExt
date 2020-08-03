page 50044 "Pump Release"
{
    // 2018_03_12
    //   Added control for boolean <Overwrite Cr. Limit> to allow overwrite credit check for vendor without increasing Credit Limit.

    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                group(Control1000000011)
                {
                    ShowCaption = false;
                    field("Work Order No.";"Work Order No.")
                    {
                        Editable = false;
                    }
                    field("Model No.";"Model No.")
                    {
                        Editable = false;
                    }
                    field(Description;Description)
                    {
                        Editable = false;
                    }
                    field("Serial No.";"Serial No.")
                    {
                        Editable = false;
                    }
                    field("Approval Code";"Approval Code")
                    {
                    }
                    field(Unblocked;Unblocked)
                    {
                        Caption = 'Pump Released';
                    }
                    field("Unblocked SHP";"Unblocked SHP")
                    {
                        Caption = 'Shipping Release';
                    }
                }
                group(Control1000000012)
                {
                    ShowCaption = false;
                    field("Customer ID";"Customer ID")
                    {
                        Editable = false;
                    }
                    field("Overwrite Cr. Limit";"Overwrite Cr. Limit")
                    {
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

