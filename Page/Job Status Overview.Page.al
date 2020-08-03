page 50007 "Job Status Overview"
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
                field("Order Type";"Order Type")
                {
                    Editable = false;
                }
                field("Model No.";"Model No.")
                {
                    Editable = false;
                }
                field("Serial No.";"Serial No.")
                {
                    Editable = false;
                }
                field("Customer ID";"Customer ID")
                {
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
            }
            part(Control1000000008;"Job Status List")
            {
                SubPageLink = "Order No."=FIELD("Work Order No.");
            }
            group(Control1000000009)
            {
                ShowCaption = false;
                field(BO;BO)
                {
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

