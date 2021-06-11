#pragma implicitwith disable
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
                field("Part Type"; Rec."Part Type")
                {
                    ApplicationArea = All;
                }
                field("Part No."; Rec."Part No.")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        ItemRec: Record Item;
                        ItemCard: Page "Item Card";

                    begin
                        if ItemRec.Get(Rec."Part No.") then begin
                            Clear(ItemCard);
                            ItemCard.SetRecord(ItemRec);
                            ItemCard.RunModal()
                        end;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; Rec."Quoted Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'QOT Qty';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectItemEntry(Rec.FIELDNO("Serial No."));
                    end;
                }
                field("Part Cost"; Rec."Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Price"; Rec."Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Committed Quantity"; Rec."Committed Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'COM Qty';
                    Editable = false;
                }
                field("Quantity Backorder"; Rec."Quantity Backorder")
                {
                    ApplicationArea = All;
                    Caption = 'BO Qty';
                    Editable = false;
                }
                field("Pre-Release PO"; Rec."Pre-Release PO")
                {
                    ApplicationArea = All;
                    Caption = 'Pre Order';
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
        Rec.TESTFIELD("Part Type", Rec."Part Type"::Item);
        ILE.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ILE.SETRANGE("Item No.", Rec."Part No.");
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

#pragma implicitwith restore

