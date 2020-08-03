pageextension 62021 CashReceiptJournalExt extends "Cash Receipt Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("External Document No.")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Reconcile)
        {
            action(Search)
            {
                ApplicationArea = All;
                Image = Find;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "customer ledger entries";
                RunPageView = sorting("Document No.", "Document Type", "Customer No.") where("Document Type" = const(Invoice));
                trigger OnAction()
                begin

                end;
            }
        }

    }

    var
        myInt: Integer;
}