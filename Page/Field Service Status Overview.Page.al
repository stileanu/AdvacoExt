page 50154 "Field Service Status Overview"
{
    SourceTable = FieldService;

    layout
    {
        area(content)
        {
            group(Control1220060003)
            {
                ShowCaption = false;
                group(Control1220060004)
                {
                    ShowCaption = false;
                    field("Field Service No.";"Field Service No.")
                    {
                        Editable = false;
                    }
                    field("Service Type";"Service Type")
                    {
                        Editable = false;
                    }
                    field(Description;Description)
                    {
                        Editable = false;
                    }
                }
                group(Control1220060008)
                {
                    ShowCaption = false;
                    field(Customer;Customer)
                    {
                        Editable = false;
                    }
                }
            }
            part(Control1220060010;"Job Status List")
            {
                SubPageLink = "Order No."=FIELD("Field Service No.");
            }
        }
    }

    actions
    {
    }
}

