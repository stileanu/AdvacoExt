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
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quoted Price"; "Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Part Cost"; "Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Pulled Quantity"; "Pulled Quantity")
                {
                    ApplicationArea = All;
                }
                field("Committed Quantity"; "Committed Quantity")
                {
                    ApplicationArea = All;
                }
                field("BOM Quantity"; "BOM Quantity")
                {
                    ApplicationArea = All;
                }
                //ICE RSK 12/29/20
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    ApplicationArea = all;
                }
                field("Purchase Order No."; "Purchase Order No.")
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

