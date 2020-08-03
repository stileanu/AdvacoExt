page 50047 "Warranty Analysis"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = WorkOrderDetail;
    SourceTableView = SORTING("Work Order Master No.","Ship Date","Customer ID","Model No.")
                      WHERE("Warranty Type"=FILTER(<>" "),
                            Complete=CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ship Date";"Ship Date")
                {
                    Editable = false;
                }
                field("Work Order Master No.";"Work Order Master No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Work Order No.";"Work Order No.")
                {
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        WOD: Record WorkOrderDetail;
                    begin
                        WOD.Reset;
                        WOD.SetRange("Work Order No.","Work Order No.");
                        PAGE.RunModal(50002,WOD);
                    end;
                }
                field("Customer ID";"Customer ID")
                {
                    Editable = false;
                }
                field("Model No.";"Model No.")
                {
                    Editable = false;
                }
                field("Warranty Type";"Warranty Type")
                {
                }
                field("Warranty Reason";"Warranty Reason")
                {
                }
                field("Parts Cost";"Parts Cost")
                {
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
                    DateFilter := GetFilter("Ship Date");
                    ModelFilter := GetFilter("Model No.");
                    CustomerFilter := GetFilter("Customer ID");
                    if DateFilter <> '' then
                      if CopyStr(DateFilter,StrLen(DateFilter)-1,2) = '..' then
                        DateFilter := DateFilter + Format(Today);
                    if DateFilter <> '' then
                      WOD.SetFilter("Ship Date",DateFilter);
                    if ModelFilter <> '' then
                      WOD.SetFilter("Model No.",ModelFilter);
                    if CustomerFilter <> '' then
                      WOD.SetFilter("Customer ID",CustomerFilter);
                    REPORT.RunModal(50035,true,false,WOD);
                end;
            }
        }
    }
}

