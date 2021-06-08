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
                    field("Field Service No."; Rec."Field Service No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Service Type"; Rec."Service Type")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Control1220060008)
                {
                    ShowCaption = false;
                    field(Customer; Rec.Customer)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
            part(Control1220060010; "Job Status List")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = FIELD("Field Service No.");
            }
        }
    }

    actions
    {
    }
}

