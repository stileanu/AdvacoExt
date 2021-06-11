#pragma implicitwith disable
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
                    field("Work Order No."; Rec."Work Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Model No."; Rec."Model No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Serial No."; Rec."Serial No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Approval Code"; Rec."Approval Code")
                    {
                        ApplicationArea = All;
                    }
                    field(Unblocked; Rec.Unblocked)
                    {
                        ApplicationArea = All;
                        Caption = 'Pump Released';
                    }
                    field("Unblocked SHP"; Rec."Unblocked SHP")
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
                    field("Customer ID"; Rec."Customer ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Overwrite Cr. Limit"; Rec."Overwrite Cr. Limit")
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

#pragma implicitwith restore

