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
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pulled Quantity"; Rec."Pulled Quantity")
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; Rec."Quoted Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Backorder"; Rec."Quantity Backorder")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("In-Process Quantity"; Rec."In-Process Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
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
        if Rec."Pulled Quantity" > 0 then begin
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

