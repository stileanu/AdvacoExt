page 50007 "Job Status Overview"
{
    SourceTable = WorkOrderDetail;
    //Editable = false;

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
                field("Order Type"; "Order Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model No."; "Model No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer ID"; "Customer ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1000000008; "Job Status List")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = FIELD("Work Order No.");
                Editable = true;
            }
            group(Control1000000009)
            {
                ShowCaption = false;
                field(BO; BO)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //MasterNo := COPYSTR("Work Order No.",1,5) + '00';
        //IF WOM.GET (MasterNo) THEN
        //   OK := TRUE;
        //IF WOD.GET (Rec."Work Order No.") THEN
        //   OK := TRUE;
        BO := BackorderText;
    end;

    var
        WOM: Record WorkOrderMaster;
        OK: Boolean;
        WOD: Record WorkOrderDetail;
        MasterNo: Code[7];
        BO: Code[40];
}

