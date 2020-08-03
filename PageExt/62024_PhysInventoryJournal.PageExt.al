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
    }

    var

        Item: Record item;
}