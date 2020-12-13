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
                    field("Work Order No."; "Work Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Model No."; "Model No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Serial No."; "Serial No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Approval Code"; "Approval Code")
                    {
                        ApplicationArea = All;
                    }
                    field(Unblocked; Unblocked)
                    {
                        ApplicationArea = All;
                        Caption = 'Pump Released';
                    }
                    field("Unblocked SHP"; "Unblocked SHP")
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Release';
                    }
                    //field(Complete; Complete)
                    //{
                    //    ApplicationArea = All;
                    //}
                }
                group(Control1000000012)
                {
                    ShowCaption = false;
                    field("Customer ID"; "Customer ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Overwrite Cr. Limit"; "Overwrite Cr. Limit")
                    {
                        ApplicationArea = All;
                        //Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
    }
}

