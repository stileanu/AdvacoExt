page 50011 "Mechanics Parts Phase 1"
{
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = QuoteMechanicsParts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part No.";"Part No.")
                {
                }
                field("Part Quantity";"Part Quantity")
                {
                }
                field("Part Description";"Part Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

