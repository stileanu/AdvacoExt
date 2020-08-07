page 50018 "Quote Phase 3 Parts List"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = Parts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part Type"; "Part Type")
                {
                    ApplicationArea = All;
                }
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Part Cost"; "Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Price"; "Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("BOM Quantity"; "BOM Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Committed Quantity"; "Committed Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    ApplicationArea = All;
                    Caption = 'Backorder Quantity';
                    Editable = false;
                }
                field("In-Process Quantity"; "In-Process Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

