page 50024 "Build Ahead Parts List"
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
                }
                field("Pulled Quantity";"Pulled Quantity")
                {
                }
                field("Serial No.";"Serial No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        SelectItemEntry(FIELDNO("Serial No."));
                    end;
                }
                field("Quantity Backorder";"Quantity Backorder")
                {
                    Caption = 'Back Order Quantity';
                    Editable = false;
                }
                field("In-Process Quantity";"In-Process Quantity")
                {
                    Editable = false;
                }
                field("Committed Quantity";"Committed Quantity")
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

