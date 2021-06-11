#pragma implicitwith disable
page 50045 "Order Type"
{
    // 2010/10/14 ADV
    //   Allowed "Role ID" = ADV-SALESADVANCED to modify the type (for Trisha)
    // 2011/04/13 ADV
    //   Set form editable for shipped orders for Sales Manager(Kaye)

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
                    field("Order Type"; Rec."Order Type")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if xRec."Order Type" <> Rec."Order Type" then begin
                                if not Confirm('Are you sure you wish to change the Order Type?') then begin
                                    Error('Order Type has not been changed');
                                end else begin
                                    if Rec."Order Type" <> Rec."Order Type"::Warranty then begin
                                        Rec."Warranty Type" := Rec."Warranty Type"::" ";
                                        Rec."Warranty Reason" := '';
                                        Message('Order Type Reason must also be entered');
                                    end else begin
                                        Message('Order Type Reason, Warranty Type, & Warranty Reason must also be entered');
                                    end;
                                end;
                            end;

                            Rec.Validate("Order Type");
                        end;
                    }
                    field("Order Type Reason"; Rec."Order Type Reason")
                    {
                        ApplicationArea = All;
                    }
                    field("Warranty Type"; Rec."Warranty Type")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if Rec."Warranty Type" <> xRec."Warranty Type" then begin
                                if Rec."Order Type" <> Rec."Order Type"::Warranty then begin
                                    Message('Order Type must be Warranty to Enter Warranty Type');
                                    Rec."Warranty Type" := Rec."Warranty Type"::" ";
                                    Rec.Modify;
                                end;
                            end;
                        end;
                    }
                    field("Warranty Reason"; Rec."Warranty Reason")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if Rec."Warranty Reason" <> xRec."Warranty Reason" then begin
                                if Rec."Order Type" <> Rec."Order Type"::Warranty then begin
                                    Message('Order Type must be Warranty to Enter Warranty Reason');
                                    Rec."Warranty Reason" := '';
                                    Rec.Modify;
                                end;
                            end;
                        end;
                    }
                }
                group(Control1000000012)
                {
                    ShowCaption = false;
                    field("Customer ID"; Rec."Customer ID")
                    {
                        ApplicationArea = All;
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
        WOS.SetRange(WOS."Order No.", Rec."Work Order No.");
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
                if (Rec."Order Type" = Rec."Order Type"::Warranty) and Rec.Complete then
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

#pragma implicitwith restore

