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
                field("Part Type";"Part Type")
                {
                }
                field("Part No.";"Part No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Quoted Quantity";"Quoted Quantity")
                {
                }
                field("Part Cost";"Part Cost")
                {
                }
                field("Quoted Price";"Quoted Price")
                {
                }
                field("BOM Quantity";"BOM Quantity")
                {
                    Editable = false;
                }
                field("Committed Quantity";"Committed Quantity")
                {
                    Editable = false;
                }
                field("Quantity Backorder";"Quantity Backorder")
                {
                    Caption = 'Backorder Quantity';
                    Editable = false;
                }
                field("In-Process Quantity";"In-Process Quantity")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

