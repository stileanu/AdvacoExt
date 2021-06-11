#pragma implicitwith disable
page 50047 "Warranty Analysis"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = WorkOrderDetail;
    SourceTableView = SORTING("Work Order Master No.", "Ship Date", "Customer ID", "Model No.")
                      WHERE("Warranty Type" = FILTER(<> " "),
                            Complete = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ship Date"; Rec."Ship Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Work Order Master No."; Rec."Work Order Master No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        WOD: Record WorkOrderDetail;
                    begin
                        WOD.Reset;
                        WOD.SetRange("Work Order No.", Rec."Work Order No.");
                        PAGE.RunModal(50002, WOD);
                    end;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Model No."; Rec."Model No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Warranty Type"; Rec."Warranty Type")
                {
                    ApplicationArea = All;
                }
                field("Warranty Reason"; Rec."Warranty Reason")
                {
                    ApplicationArea = All;
                }
                field("Parts Cost"; Rec."Parts Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Run Report")
            {
                ApplicationArea = All;
                Caption = 'Run Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WOD: Record WorkOrderDetail;
                    DateFilter: Text[120];
                    ModelFilter: Text[120];
                    CustomerFilter: Text[120];
                begin
                    DateFilter := Rec.GetFilter("Ship Date");
                    ModelFilter := Rec.GetFilter("Model No.");
                    CustomerFilter := Rec.GetFilter("Customer ID");
                    if DateFilter <> '' then
                        if CopyStr(DateFilter, StrLen(DateFilter) - 1, 2) = '..' then
                            DateFilter := DateFilter + Format(Today);
                    if DateFilter <> '' then
                        WOD.SetFilter("Ship Date", DateFilter);
                    if ModelFilter <> '' then
                        WOD.SetFilter("Model No.", ModelFilter);
                    if CustomerFilter <> '' then
                        WOD.SetFilter("Customer ID", CustomerFilter);
                    REPORT.RunModal(50035, true, false, WOD);
                end;
            }
        }
    }
}

#pragma implicitwith restore

