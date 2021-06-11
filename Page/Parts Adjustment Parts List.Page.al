#pragma implicitwith disable
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
                field("Part Type"; Rec."Part Type")
                {
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("After Quote Quantity"; Rec."After Quote Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Adj. Qty';
                    Editable = false;
                }
                field("Quoted Quantity"; Rec."Quoted Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Total Qty';
                }
                field("Pulled Quantity"; Rec."Pulled Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Pulled Qty';
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectItemEntry(Rec.FieldNo("Serial No."));
                    end;
                }
                field("Quantity Backorder"; Rec."Quantity Backorder")
                {
                    ApplicationArea = All;
                    Caption = 'BO Qty';
                    Editable = false;
                }
                field("In-Process Quantity"; Rec."In-Process Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'I/P Qty';
                    Editable = false;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
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
        Rec.TestField("Part Type", Rec."Part Type"::Item);
        ILE.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ILE.SetRange("Item No.", Rec."Part No.");
        ILE.SetRange(Open, true);
        ILE.SetRange(Positive, true);
        if PAGE.RunModal(PAGE::"Item Ledger Entries", ILE) = ACTION::LookupOK then begin
            Parts2 := Rec;
            ///with Parts2 do begin
            Parts2."Serial No." := ILE."Serial No.";
            //    "Part Cost" := ILE."Unit Cost";
            ///end;
            Rec := Parts2;
        end;
    end;

    procedure PartsAllocation2()
    begin
        Rec.PartsAllocation;
    end;

    procedure DeletePart2()
    begin
        if Rec."Quoted Quantity" > 0 then
            Error('Quoted Quantity Must Be Zero to Delete');

        Rec.DeletePart;
    end;
}

#pragma implicitwith restore

