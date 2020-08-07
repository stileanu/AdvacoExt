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
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pulled Quantity"; "Pulled Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("In-Process Quantity"; "In-Process Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
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

