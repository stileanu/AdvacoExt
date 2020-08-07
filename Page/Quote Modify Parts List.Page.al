page 50020 "Quote Modify Parts List"
/*
IcE-MPC BC Upgrade
  Replaced assignment of parts cost to getunitcost function from Item Ledger.  Unit cost field no longer exists.
*/
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
                    ApplicationArea = All;
                }
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("After Quote Quantity"; "After Quote Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Adj. Qty';
                    Editable = false;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Total Qty';
                }
                field(Reason; Reason)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectItemEntry(FIELDNO("Serial No."));
                    end;
                }
                field("Pre-Release PO"; "Pre-Release PO")
                {
                    ApplicationArea = All;
                    Caption = 'Pre Order';
                }
                field("Quoted Price"; "Quoted Price")
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
        TESTFIELD("Part Type", "Part Type"::Item);
        ILE.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ILE.SETRANGE("Item No.", "Part No.");
        ILE.SETRANGE(Open, TRUE);
        ILE.SETRANGE(Positive, TRUE);
        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ILE) = ACTION::LookupOK THEN BEGIN
            Parts2 := Rec;
            WITH Parts2 DO BEGIN
                "Serial No." := ILE."Serial No.";
                //"Part Cost" := ILE."Unit Cost";
                "Part Cost" := ILE.GetUnitCostLCY(); //ICE-MPC BC UPGRADE
            END;
            Rec := Parts2;
        END;
    end;

    procedure PartsAllocation2()
    begin
        Rec.PartsAllocation;
    end;

    procedure DeletePart2()
    begin
        IF "Quoted Quantity" > 0 THEN
            ERROR('Quoted Quantity Must Be Zero to Delete');

        Rec.DeletePart;
    end;
}

