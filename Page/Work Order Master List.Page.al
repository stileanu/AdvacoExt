page 50105 "Work Order Master List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Work Order Master";
    SourceTable = WorkOrderMaster;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Work Order Master No."; "Work Order Master No.")
                {
                    ApplicationArea = All;
                }
                field(Customer; Customer)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Date Ordered"; "Date Ordered")
                {
                    ApplicationArea = All;
                }
                field("Ship To Code"; "Ship To Code")
                {
                    ApplicationArea = All;
                }
                field("Ship To Name"; "Ship To Name")
                {
                    ApplicationArea = All;
                }
                field("Date Required"; "Date Required")
                {
                    ApplicationArea = All;
                }
                field("Inside Sales"; "Inside Sales")
                {
                    ApplicationArea = All;
                }
                field(Rep; Rep)
                {
                    ApplicationArea = All;
                }
                field(Details; Details)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    /*
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    */
}