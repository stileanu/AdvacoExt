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
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pulled Quantity"; "Pulled Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped"; "Qty. Shipped")
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

