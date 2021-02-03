pageextension 62024 PhysInventoryJournalExt extends "Phys. Inventory Journal"
{


    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addafter("Bin Contents")
        {
            action("Return Committed")
            {
                ApplicationArea = All;
                image = Return;
                Promoted = true;
                PromotedCategory = Process;
                RunPageOnRec = true;

                trigger OnAction()
                begin
                    IF item.get("Item No.") then
                        page.RunModal(50055, item);
                end;
            }
        }
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action(PrintAdv)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    ItemJournalBatch2: Record "Item Journal Batch";
                begin
                    ItemJournalBatch2.SetRange("Journal Template Name", "Journal Template Name");
                    ItemJournalBatch2.SetRange(Name, "Journal Batch Name");
                    REPORT.RunModal(10151, true, false, ItemJournalBatch2);
                end;
            }

        }
        modify(CalculateInventory)
        {
            Visible = false;
        }
        addafter(CalculateInventory)
        {
            action(CalculateInventoryAdv)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calculate &Inventory';
                Ellipsis = true;
                Image = CalculateInventory;
                Promoted = true;
                PromotedCategory = Category5;
                Scope = Repeater;
                ToolTip = 'Start the process of counting inventory by filling the journal with known quantities.';

                trigger OnAction()
                var
                    CalcQtyOnHand2: Report "Calculate Inventory New";
                begin
                    CalcQtyOnHand2.SetItemJnlLine(Rec);
                    CalcQtyOnHand2.RunModal;
                    Clear(CalcQtyOnHand2);
                end;
            }
        }
    }

    var

        Item: Record item;
}