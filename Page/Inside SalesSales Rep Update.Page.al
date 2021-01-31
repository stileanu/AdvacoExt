page 50052 "Inside Sales/Sales Rep Update"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "G/L Entry" = m,
                  TableData "Cust. Ledger Entry" = m,
                  TableData "Item Ledger Entry" = m,
                  TableData "Sales Invoice Header" = m,
                  TableData "Sales Cr.Memo Header" = m;
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = SORTING("Document Type", "Document No.", "Customer No.")
                      WHERE("Document Type" = FILTER(Invoice | "Credit Memo"),
                            Amount = FILTER(<> 0));
    UsageCategory = Tasks;
    ApplicationArea = all;
    Caption = 'Inside/Rep Correction';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //TableRelation = customer."No." where("no." = field("Customer No."));
                    trigger OnDrillDown()
                    begin
                        IF cust.get("Customer No.") then
                            page.RunModal(page::"Customer Card", Cust);
                    end;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        IF shiptoaddress.get("Customer No.", "Ship-To Code") then
                            page.RunModal(page::"Ship-to Address", shiptoaddress);

                    end;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if xRec."Salesperson Code" = "Salesperson Code" then
                            exit;

                        if not Confirm('Are you sure you want to change the salesperson code for this %1?', true, "Document Type") then
                            Error('Press Escape to return to the original value.');

                        GLEntry.Reset;
                        GLEntry.SetCurrentKey("Document No.", "Posting Date");
                        GLEntry.SetRange("Document No.", "Document No.");
                        GLEntry.SetRange("Posting Date", "Posting Date");
                        if GLEntry.Find('-') then
                            repeat
                                GLEntry."Salesperson Code" := "Salesperson Code";
                                GLEntry.Modify;
                            until GLEntry.Next = 0;


                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Document No.", "Posting Date");
                        ItemLedgerEntry.SETRANGE("Document No.", "Document No.");
                        ItemLedgerEntry.SETRANGE("Posting Date", "Posting Date");

                        ///--! How Sales Pres Code is managed??                        
                        IF ItemLedgerEntry.FIND('-') THEN
                            repeat
                                ItemLedgerEntry."Salespers./Purch. Code" := "Salesperson Code";
                                ItemLedgerEntry.MODIFY;
                            until ItemLedgerEntry.NEXT = 0;

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
                field(Rep; Rep)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if xRec.Rep = Rep then
                            exit;

                        if not Confirm('Are you sure you want to change the rep for this %1?', true, "Document Type") then
                            Error('Press Escape to return to the original value.');

                        GLEntry.Reset;
                        GLEntry.SetCurrentKey("Document No.", "Posting Date");
                        GLEntry.SetRange("Document No.", "Document No.");
                        GLEntry.SetRange("Posting Date", "Posting Date");
                        if GLEntry.Find('-') then
                            repeat
                                GLEntry.Rep := Rep;
                                GLEntry.Modify;
                            until GLEntry.Next = 0;

                        ItemLedgerEntry.Reset;
                        ItemLedgerEntry.SetCurrentKey("Document No.", "Posting Date");
                        ItemLedgerEntry.SetRange("Document No.", "Document No.");
                        ItemLedgerEntry.SetRange("Posting Date", "Posting Date");
                        if ItemLedgerEntry.Find('-') then
                            repeat
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
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Open; Open)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Control1000000011)
            {
                ShowCaption = false;
                //field("Customer Name2";"Customer Name2") ICE-MPC BC Upgrade
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("&Application")
            {
                Caption = '&Application';
                action("Applied E&ntries")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.Run;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //lSuperUser := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);
        //if lSuperUser then
        if not SysFunctions.getIfSingleRoleId(Permiss, txtAnswer) then begin
            Error('You don''t have permission to run this page.');
            CurrPage.Close();
        end;
    end;

    var
        txtAnswer: Text[120];
        Permiss: Label 'SUPER';
        SysFunctions: Codeunit systemFunctionalLibrary;
        GLEntry: Record "G/L Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        Navigate: Page Navigate;
        Cust: record customer;
        shiptoaddress: Record "Ship-to Address";
}

