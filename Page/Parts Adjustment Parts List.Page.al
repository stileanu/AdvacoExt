page 50026 "Parts Adjustment Parts List"
{
    PageType = ListPart;
    SourceTable = Parts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part Type"; "Part Type")
                {
                }
                field("Part No."; "Part No.")
                {
                }
                field(Description; Description)
                {
                }
                field("After Quote Quantity"; "After Quote Quantity")
                {
                    Caption = 'Adj. Qty';
                    Editable = false;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    Caption = 'Total Qty';
                }
                field("Pulled Quantity"; "Pulled Quantity")
                {
                    Caption = 'Pulled Qty';
                }
                field(Reason; Reason)
                {
                }
                field("Serial No."; "Serial No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectItemEntry(FieldNo("Serial No."));
                    end;
                }
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    Caption = 'BO Qty';
                    Editable = false;
                }
                field("In-Process Quantity"; "In-Process Quantity")
                {
                    Caption = 'I/P Qty';
                    Editable = false;
                }
                field("Purchase Order No."; "Purchase Order No.")
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        ILE: Record "Item Ledger Entry";
        Parts2: Record Parts;

    procedure SelectItemEntry(CurrentFieldNo: Integer)
    begin
        TestField("Part Type", "Part Type"::Item);
        ILE.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ILE.SetRange("Item No.", "Part No.");
        ILE.SetRange(Open, true);
        ILE.SetRange(Positive, true);
        if PAGE.RunModal(PAGE::"Item Ledger Entries", ILE) = ACTION::LookupOK then begin
            Parts2 := Rec;
            with Parts2 do begin
                "Serial No." := ILE."Serial No.";
                //    "Part Cost" := ILE."Unit Cost";
            end;
            Rec := Parts2;
        end;
    end;

    procedure PartsAllocation2()
    begin
        Rec.PartsAllocation;
    end;

    procedure DeletePart2()
    begin
        if "Quoted Quantity" > 0 then
            Error('Quoted Quantity Must Be Zero to Delete');

        Rec.DeletePart;
    end;
}

