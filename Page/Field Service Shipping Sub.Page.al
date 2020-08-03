page 50157 "Field Service Shipping Sub"
{
    DeleteAllowed = false;
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
                    Editable = false;
                }
                field(Description;Description)
                {
                    Editable = false;
                }
                field("Quoted Quantity";"Quoted Quantity")
                {
                    Editable = false;
                }
                field("Pulled Quantity";"Pulled Quantity")
                {
                    Editable = false;
                }
                field("Qty. to Ship";"Qty. to Ship")
                {
                }
                field("Qty. Shipped";"Qty. Shipped")
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

