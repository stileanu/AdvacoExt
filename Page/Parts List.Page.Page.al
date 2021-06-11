#pragma implicitwith disable
page 50005 "Parts List"
{
    // 2014_09_08 ADV
    //   Added Serial No. field to the columns, initially hidden.

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
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
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quoted Price"; Rec."Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Part Cost"; Rec."Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; Rec."Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Pulled Quantity"; Rec."Pulled Quantity")
                {
                    ApplicationArea = All;
                }
                field("Committed Quantity"; Rec."Committed Quantity")
                {
                    ApplicationArea = All;
                }
                field("BOM Quantity"; Rec."BOM Quantity")
                {
                    ApplicationArea = All;
                }
                //ICE RSK 12/29/20
                field("Quantity Backorder"; Rec."Quantity Backorder")
                {
                    ApplicationArea = all;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        PurchLine: Record "Purchase Line";
                        PurchLines: Page "Purchase Lines";

                    begin
                        PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
                        PurchLine.SetRange("Document No.", Rec."Purchase Order No.");
                        PurchLine.SetRange("No.", Rec."Part No.");
                        PurchLine.SetFilter(Type, '>0');
                        if PurchLine.FindFirst() then begin
                            //if PurchLine.Get(PurchLine."Document Type"::Order, Rec."Purchase Order No.") then begin
                            Clear(PurchLines);
                            PurchLines.SetTableView(PurchLine);
                            PurchLines.RunModal()
                        end;
                    end;

                }
            }
        }
    }

    actions
    {
    }
}

#pragma implicitwith restore

