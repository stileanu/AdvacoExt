page 50045 "Order Type"
{
    // 2010/10/14 ADV
    //   Allowed "Role ID" = ADV-SALESADVANCED to modify the type (for Trisha)
    // 2011/04/13 ADV
    //   Set form editable for shipped orders for Sales Manager (Kaye)

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
                        Editable = false;
                    }
                    field("Model No."; "Model No.")
                    {
                        Editable = false;
                    }
                    field(Description; Description)
                    {
                        Editable = false;
                    }
                    field("Serial No."; "Serial No.")
                    {
                        Editable = false;
                    }
                    field("Order Type"; "Order Type")
                    {

                        trigger OnValidate()
                        begin
                            if xRec."Order Type" <> "Order Type" then begin
                                if not Confirm('Are you sure you wish to change the Order Type?') then begin
                                    Error('Order Type has not been changed');
                                end else begin
                                    if "Order Type" <> "Order Type"::Warranty then begin
                                        "Warranty Type" := "Warranty Type"::" ";
                                        "Warranty Reason" := '';
                                        Message('Order Type Reason must also be entered');
                                    end else begin
                                        Message('Order Type Reason, Warranty Type, & Warranty Reason must also be entered');
                                    end;
                                end;
                            end;

                            Validate("Order Type");
                        end;
                    }
                    field("Order Type Reason"; "Order Type Reason")
                    {
                    }
                    field("Warranty Type"; "Warranty Type")
                    {

                        trigger OnValidate()
                        begin
                            if "Warranty Type" <> xRec."Warranty Type" then begin
                                if "Order Type" <> "Order Type"::Warranty then begin
                                    Message('Order Type must be Warranty to Enter Warranty Type');
                                    "Warranty Type" := "Warranty Type"::" ";
                                    Modify;
                                end;
                            end;
                        end;
                    }
                    field("Warranty Reason"; "Warranty Reason")
                    {

                        trigger OnValidate()
                        begin
                            if "Warranty Reason" <> xRec."Warranty Reason" then begin
                                if "Order Type" <> "Order Type"::Warranty then begin
                                    Message('Order Type must be Warranty to Enter Warranty Reason');
                                    "Warranty Reason" := '';
                                    Modify;
                                end;
                            end;
                        end;
                    }
                }
                group(Control1000000012)
                {
                    ShowCaption = false;
                    field("Customer ID"; "Customer ID")
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

    trigger OnOpenPage()
    begin
        ok := false;
        WOS.SetRange(WOS."Order No.", "Work Order No.");
        WOS.SetRange(WOS.Step, WOS.Step::QOT);
        WOS.SetRange(WOS.Status, WOS.Status::Waiting);
        if WOS.Find('-') then begin
            Member.CalcFields("User Name");
            Member.SetRange(Member."User Name", UserId);
            if Member.Find('-') then begin
                repeat
                    // 2010/10/14 Start
                    //IF (Member."Role ID" = 'ADV-SHOPMNGR') OR  (Member."Role ID" = 'SUPER') THEN
                    if (Member."Role ID" = 'ADV-SHOPMNGR') or (Member."Role ID" = 'SUPER') or
                       (Member."Role ID" = 'ADV-SALESADVANCED') then
                        // 2010/10/14 End
                        ok := true;
                until Member.Next = 0;
            end;

            if ok then
                CurrPage.Editable(true)
            else
                CurrPage.Editable(false);
        end else begin
            CurrPage.Editable(false);

            // 2011/04/13 Start
            if (UserId = 'KAYE') or (UserId = 'ADMIN') then begin
                if ("Order Type" = "Order Type"::Warranty) and Complete then
                    CurrPage.Editable(true);
            end;
            // 2011/04/13 End

        end;
    end;

    var
        WOS: Record Status;
        Member: Record "Access Control";
        ok: Boolean;
        User: Code[20];
}

