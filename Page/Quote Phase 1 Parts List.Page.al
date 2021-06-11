#pragma implicitwith disable
page 50014 "Quote Phase 1 Parts List"
{
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
                    Editable = false;
                }
                field("Quoted Quantity"; Rec."Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Pre-Release PO"; Rec."Pre-Release PO")
                {
                    ApplicationArea = All;
                    Caption = 'Pre Order';
                }
                field("BOM Quantity"; Rec."BOM Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Committed Quantity"; Rec."Committed Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'COM Quantity';
                    Editable = false;
                }
                field("Quantity Backorder"; Rec."Quantity Backorder")
                {
                    ApplicationArea = All;
                    Caption = 'BO Quantity';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

