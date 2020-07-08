page 50005 PartsList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Parts;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Quoted Price"; "Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Part Cost"; "Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Qty."; "Quoted Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Quoted Qty.';
                }
                field("Pulled Qty."; "Pulled Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Pulled Qty.';
                }
                field("Comm. Qty."; "Committed Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Comm. Qty.';

                }
                field("In-Pro. Qty."; "In-Process Quantity")
                {
                    ApplicationArea = All;
                }
                field("BO Qty."; "Quantity Backorder")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; "Purchase Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

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
}