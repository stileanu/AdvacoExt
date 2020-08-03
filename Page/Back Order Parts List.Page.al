page 50022 "Back Order Parts List"
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
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Pulled Quantity"; "Pulled Quantity")
                {
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    Editable = false;
                }
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    Editable = false;
                }
                field("In-Process Quantity"; "In-Process Quantity")
                {
                    Editable = false;
                }
                field("Purchase Order No."; "Purchase Order No.")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

    procedure PartsAllocation2()
    begin
        Rec.PartsAllocation;
    end;

    procedure ReplacePart2()
    begin
        if "Pulled Quantity" > 0 then begin
            Error('There is already a Quantity Pulled for this Item.');
        end else begin
            Rec.ReplacePart;
        end;
    end;

    procedure DeletePart2()
    begin
        Rec.DeletePart;
    end;
}

