#pragma implicitwith disable
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
                field("Work Order Master No."; Rec."Work Order Master No.")
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Date Ordered"; Rec."Date Ordered")
                {
                    ApplicationArea = All;
                }
                field("Ship To Code"; Rec."Ship To Code")
                {
                    ApplicationArea = All;
                }
                field("Ship To Name"; Rec."Ship To Name")
                {
                    ApplicationArea = All;
                }
                field("Date Required"; Rec."Date Required")
                {
                    ApplicationArea = All;
                }
                field("Inside Sales"; Rec."Inside Sales")
                {
                    ApplicationArea = All;
                }
                field(Rep; Rec.Rep)
                {
                    ApplicationArea = All;
                }
                field(Details; Rec.Details)
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
#pragma implicitwith restore
