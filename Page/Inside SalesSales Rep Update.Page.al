page 50052 "Inside Sales/Sales Rep Update"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "G/L Entry"=m,
                  TableData "Cust. Ledger Entry"=m,
                  TableData "Item Ledger Entry"=m,
                  TableData "Sales Invoice Header"=m,
                  TableData "Sales Cr.Memo Header"=m;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = SORTING("Document Type","Document No.","Customer No.")
                      WHERE("Document Type"=FILTER(Invoice|"Credit Memo"),
                            Amount=FILTER(<>0));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type";"Document Type")
                {
                    Editable = false;
                }
                field("Document No.";"Document No.")
                {
                    Editable = false;
                }
                field("Posting Date";"Posting Date")
                {
                    Editable = false;
                }
                field("Customer No.";"Customer No.")
                {
                    Editable = false;
                }
                field("Ship-to Code";"Ship-to Code")
                {
                    Editable = false;
                }
                field("Salesperson Code";"Salesperson Code")
                {

                    trigger OnValidate()
                    begin
                        if xRec."Salesperson Code" = "Salesperson Code" then
                          exit;
                        
                        if not Confirm('Are you sure you want to change the salesperson code for this %1?',true,"Document Type") then
                          Error('Press Escape to return to the original value.');
                        
                        GLEntry.Reset;
                        GLEntry.SetCurrentKey("Document No.","Posting Date");
                        GLEntry.SetRange("Document No.","Document No.");
                        GLEntry.SetRange("Posting Date","Posting Date");
                        if GLEntry.Find('-') then repeat
                          GLEntry."Sales Person Code" := "Salesperson Code";
                          GLEntry.Modify;
                        until GLEntry.Next = 0;
                        
                        /*99999
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Document No.","Posting Date");
                        ItemLedgerEntry.SETRANGE("Document No.","Document No.");
                        ItemLedgerEntry.SETRANGE("Posting Date","Posting Date");
                        IF ItemLedgerEntry.FIND('-') THEN REPEAT
                          ItemLedgerEntry."Salespers./Purch. Code" := "Salesperson Code";
                          ItemLedgerEntry.MODIFY;
                        UNTIL ItemLedgerEntry.NEXT = 0;
                        99999*/
                        
                        if "Document Type" = "Document Type"::Invoice then begin
                          if SalesInvoiceHeader.Get("Document No.") then begin
                            SalesInvoiceHeader."Salesperson Code" := "Salesperson Code";
                            SalesInvoiceHeader.Modify;
                          end;
                        end else begin
                          if SalesCrMemoHeader.Get("Document No.") then begin
                            SalesCrMemoHeader."Salesperson Code" := "Salesperson Code";
                            SalesCrMemoHeader.Modify;
                          end;
                        end;

                    end;
                }
                field(Rep;Rep)
                {

                    trigger OnValidate()
                    begin
                        if xRec.Rep = Rep then
                          exit;

                        if not Confirm('Are you sure you want to change the rep for this %1?',true,"Document Type") then
                          Error('Press Escape to return to the original value.');

                        GLEntry.Reset;
                        GLEntry.SetCurrentKey("Document No.","Posting Date");
                        GLEntry.SetRange("Document No.","Document No.");
                        GLEntry.SetRange("Posting Date","Posting Date");
                        if GLEntry.Find('-') then repeat
                          GLEntry.Rep := Rep;
                          GLEntry.Modify;
                        until GLEntry.Next = 0;

                        ItemLedgerEntry.Reset;
                        ItemLedgerEntry.SetCurrentKey("Document No.","Posting Date");
                        ItemLedgerEntry.SetRange("Document No.","Document No.");
                        ItemLedgerEntry.SetRange("Posting Date","Posting Date");
                        if ItemLedgerEntry.Find('-') then repeat
                          ItemLedgerEntry.Rep := Rep;
                          ItemLedgerEntry.Modify;
                        until ItemLedgerEntry.Next = 0;

                        if "Document Type" = "Document Type"::Invoice then begin
                          if SalesInvoiceHeader.Get("Document No.") then begin
                            SalesInvoiceHeader.Rep := Rep;
                            SalesInvoiceHeader.Modify;
                          end;
                        end else begin
                          if SalesCrMemoHeader.Get("Document No.") then begin
                            SalesCrMemoHeader.Rep := Rep;
                            SalesCrMemoHeader.Modify;
                          end;
                        end;
                    end;
                }
                field(Amount;Amount)
                {
                    Editable = false;
                }
                field(Open;Open)
                {
                    Editable = false;
                }
            }
            group(Control1000000011)
            {
                ShowCaption = false;
                //field("Customer Name2";"Customer Name2") ICE-MPC BC Upgrade
                field("Customer Name";"Customer Name")
                {
                    Editable = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("&Application")
            {
                Caption = '&Application';
                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Applied Customer Entries";
                }
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date","Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    var
        GLEntry: Record "G/L Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Navigate: Page Navigate;
}

