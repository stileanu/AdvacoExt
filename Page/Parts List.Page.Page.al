page 50005 "Parts List"
{
    // 2014_09_08 ADV
    //   Added Serial No. field to the columns, initially hidden.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
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
                }
                field("Serial No.";"Serial No.")
                {
                    Visible = false;
                }
                field("Quoted Price";"Quoted Price")
                {
                }
                field("Part Cost";"Part Cost")
                {
                }
                field("Quoted Quantity";"Quoted Quantity")
                {
                }
                field("Pulled Quantity";"Pulled Quantity")
                {
                }
                field("Committed Quantity";"Committed Quantity")
                {
                }
                field("BOM Quantity";"BOM Quantity")
                {
                }
                field("Purchase Order No.";"Purchase Order No.")
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

