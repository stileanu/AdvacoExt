page 50016 "Quote Phase 2 Parts List"
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
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'QOT Qty';
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectItemEntry(FIELDNO("Serial No."));
                    end;
                }
                field("Part Cost"; "Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Price"; "Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Committed Quantity"; "Committed Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'COM Qty';
                    Editable = false;
                }
                field("Quantity Backorder"; "Quantity Backorder")
                {
                    ApplicationArea = All;
                    Caption = 'BO Qty';
                    Editable = false;
                }
                field("Pre-Release PO"; "Pre-Release PO")
                {
                    ApplicationArea = All;
                    Caption = 'Pre Order';
                    Editable = false;
                }
                field("Purchase Order No."; "Purchase Order No.")
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
        ILE.SETRANGE("Location Code", 'MAIN');
        ILE.SETRANGE(Positive, TRUE);
        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ILE) = ACTION::LookupOK THEN BEGIN
            Parts2 := Rec;
            ///WITH Parts2 DO BEGIN
            Parts2."Serial No." := ILE."Serial No.";
            //"Part Cost" := ILE."Unit Cost";
            Parts2."Part Cost" := ILE.GetUnitCostLCY(); //ICE MPC BC Upgrade
            ///END;
            Rec := Parts2;
        END;
    end;
}

