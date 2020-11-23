codeunit 50031 SalesPost_RepFields
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromSalesHeader', '', false, false)]
    procedure ItemJnlLine_CopyFromSalHeader(var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header")
    begin

        ItemJnlLine.Rep := SalesHeader.Rep;
        //ItemJnlLine."Salespers./Purch. Code" := SalesHeader."Salesperson Code";

    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterCopyGenJnlLineFromSalesHeader', '', false, false)]
    procedure GenJnlLine_CopyGenJnlLineFromSalHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin

        GenJournalLine.Rep := SalesHeader.Rep;
        GenJournalLine."Salespers./Purch. Code" := SalesHeader."Salesperson Code";
        GenJournalLine."Ship-to Code" := SalesHeader."Ship-to Code";

    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', false, false)]
    procedure ItemJnlPostLine_InitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin

        NewItemLedgEntry.Rep := ItemJournalLine.Rep;

    end;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', false, false)]
    procedure CustLedgEntry_CopyCustLedgEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin

        CustLedgerEntry.Rep := GenJournalLine.Rep;
        CustLedgerEntry."Ship-to Code" := GenJournalLine."Ship-to Code";

    end;

    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', false, false)]
    procedure GLEntry_CopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    var
        GLAcc: Record "G/L Account";

    begin
        GLAcc.Get(GenJournalLine."Account No.");

        GLEntry.Rep := GenJournalLine.Rep;
        GLEntry."Include for Commissions" := GLAcc."Include for Commissions";
        GLEntry."Commission Dept. Code" := GLAcc."Global Dimension 1 Code";
        GLEntry."Salesperson Code" := GenJournalLine."Salespers./Purch. Code";

    end;

}