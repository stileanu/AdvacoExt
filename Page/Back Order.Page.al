page 50021 "Back Order"
{
    SourceTable = Status;
    SourceTableView = SORTING("Order No.", Step)
                      ORDER(Ascending)
                      WHERE(Step = CONST("B-O"),
                            Type = CONST(WorkOrder));

    layout
    {
        area(content)
        {
            group(Control1000000010)
            {
                ShowCaption = false;
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WOD.""Model No."""; WOD."Model No.")
                {
                    ApplicationArea = All;
                    Caption = 'Model No.';

                    trigger OnValidate()
                    begin
                        if WOD."Model No." <> OLDWOD."Model No." then begin
                            WOD.Validate(WOD."Model No.");
                            WOD.Modify;
                        end;
                    end;
                }
                field("WOD.""Serial No."""; WOD."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Serial No.';

                    trigger OnValidate()
                    begin
                        if WOD."Serial No." <> OLDWOD."Serial No." then
                            WOD.Modify;
                    end;
                }
                field("WOM.Customer"; WOM.Customer)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                    Editable = false;
                }
                field("Date In"; "Date In")
                {
                    ApplicationArea = All;
                }
                field("Date Out"; "Date Out")
                {
                    ApplicationArea = All;
                }
                field(Employee; Employee)
                {
                    ApplicationArea = All;
                }
                field("Regular Hours"; "Regular Hours")
                {
                    ApplicationArea = All;
                }
                field("Overtime Hours"; "Overtime Hours")
                {
                    ApplicationArea = All;
                }
            }
            part(PartsLines; "Back Order Parts List")
            {
                ApplicationArea = All;
                SubPageLink = "Work Order No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Swap Part")
            {
                ApplicationArea = All;
                Caption = 'Swap Part';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to replace this part?') then begin
                        CurrPage.PartsLines.PAGE.ReplacePart2;
                        CurrPage.Update;
                    end;
                end;
            }
            action("Allocate Parts")
            {
                ApplicationArea = All;
                Caption = 'Allocate Parts';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // CurrForm.PartsLines.FORM.PartsAllocation

                    Parts.SetRange(Parts."Work Order No.", "Order No.");
                    PAGE.RunModal(PAGE::"Parts Allocation", Parts);
                end;
            }
            action("Picking Ticket")
            {
                ApplicationArea = All;
                Caption = 'Picking Ticket';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    WOD.Reset;
                    WOD.Get("Order No.");
                    WOD.SetFilter(WOD."Work Order No.", "Order No.");
                    REPORT.Run(50019, true, false, WOD);
                    WOD.Reset;
                end;
            }
            action("Pull Parts")
            {
                ApplicationArea = All;
                Caption = 'Pull Parts';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Parts.SetCurrentKey("Work Order No.", "Part Type", "Part No.");
                    Parts.SetRange(Parts."Work Order No.", "Order No.");
                    if Parts.Find('-') then begin
                        repeat
                            Parts.CalcFields(Parts."In-Process Quantity");
                            if Parts."In-Process Quantity" > 0 then begin
                                Parts."Pulled Quantity" := Parts."In-Process Quantity";
                                Parts.Modify;
                            end;
                        until Parts.Next = 0;
                    end;
                end;
            }
        }
    }

    var
        WOD: Record WorkOrderDetail;
        OLDWOD: Record WorkOrderDetail;
        WOI: Record WorkInstructions;
        WOM: Record WorkOrderMaster;
        Instructions: Text[250];
        MasterNo: Code[7];
        OK: Boolean;
        Parts: Record Parts;
}

