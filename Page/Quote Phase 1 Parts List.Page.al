page 50014 "Quote Phase 1 Parts List"
{
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Parts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part No.";"Part No.")
                {
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Quoted Quantity";"Quoted Quantity")
                {
                }
                field("Pre-Release PO";"Pre-Release PO")
                {
                    Caption = 'Pre Order';
                }
                field("BOM Quantity";"BOM Quantity")
                {
                    Editable = false;
                }
                field("Committed Quantity";"Committed Quantity")
                {
                    Caption = 'COM Quantity';
                    Editable = false;
                }
                field("Quantity Backorder";"Quantity Backorder")
                {
                    Caption = 'BO Quantity';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

