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
                field("Part Type";"Part Type")
                {
                }
                field("Part No.";"Part No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Quoted Quantity";"Quoted Quantity")
                {
                    Caption = 'Total Qty';
                }
                field("Pulled Quantity";"Pulled Quantity")
                {
                    Caption = 'Pulled Qty';
                }
                field("Serial No.";"Serial No.")
                {

                    trigger OnValidate()
                    begin
                        SelectItemEntry(FIELDNO("Serial No."));
                    end;
                }
                field("Quantity Backorder";"Quantity Backorder")
                {
                    Caption = 'BO Qty';
                    Editable = false;
                }
                field("In-Process Quantity";"In-Process Quantity")
                {
                    Caption = 'I/P Qty';
                    Editable = false;
                }
                field("Purchase Order No.";"Purchase Order No.")
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
        TESTFIELD("Part Type","Part Type"::Item);
        ILE.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date");
        ILE.SETRANGE("Item No.","Part No.");
        ILE.SETRANGE(Open,TRUE);
        ILE.SETRANGE(Positive,TRUE);
        IF PAGE.RUNMODAL(PAGE::"Item Ledger Entries",ILE) = ACTION::LookupOK THEN BEGIN
          Parts2 := Rec;
          WITH Parts2 DO BEGIN
            "Serial No." := ILE."Serial No.";
            //"Part Cost" := ILE."Unit Cost"; ICE-MPC BC Upgrade
            "Part Cost" := ILE.GetUnitCostLCY();
          END;
          Rec := Parts2;
        END;
    end;

    procedure PartsAllocation()
    begin
        Rec.PartsAllocation;
    end;

    procedure DeletePart()
    begin
        IF "Quoted Quantity" > 0 THEN
          ERROR('Quoted Quantity Must Be Zero to Delete');

        Rec.DeletePart;
    end;
}

