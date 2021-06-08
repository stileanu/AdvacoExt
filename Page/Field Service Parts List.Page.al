page 50153 "Field Service Parts List"
{
    //  Used For:
    //    Parts Adjustment
    //    Field Service Parts
    /*
    IcE-MPC BC Upgrade
      Replaced assignment of parts cost to getunitcost function from Item Ledger.  Unit cost field no longer exists.
    */
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
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SelectItemEntry(Rec.FIELDNO("Serial No."));
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
        Rec.TESTFIELD("Part Type", Rec."Part Type"::Item);
        ILE.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ILE.SETRANGE("Item No.", Rec."Part No.");
        ILE.SETRANGE(Open, TRUE);
        ILE.SETRANGE(Positive, TRUE);
        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries", ILE) = ACTION::LookupOK THEN BEGIN
            Parts2 := Rec;
            ///WITH Parts2 DO BEGIN
            Parts2."Serial No." := ILE."Serial No.";
            //"Part Cost" := ILE."Unit Cost"; ICE-MPC BC Upgrade
            Parts2."Part Cost" := ILE.GetUnitCostLCY();
            ///END;
            Rec := Parts2;
        END;
    end;

    procedure PartsAllocation2()
    begin
        Rec.PartsAllocation;
    end;

    procedure DeletePart2()
    begin
        IF Rec."Quoted Quantity" > 0 THEN
            ERROR('Quoted Quantity Must Be Zero to Delete');

        Rec.DeletePart;
    end;
}

