page 50078 "Purchase Invoice Act"
{
    PageType = Card;
    SourceTable = "Purchase Header";
    SourceTableView = SORTING("Document Type","Location Code","No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=FILTER(Invoice));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No.";"No.")
                {
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                }
                field("Buy-from Address";"Buy-from Address")
                {
                }
                field("Buy-from Address 2";"Buy-from Address 2")
                {
                }
                field("Buy-from City";"Buy-from City")
                {
                }
                field("Buy-from County";"Buy-from County")
                {
                }
                field("Buy-from Post Code";"Buy-from Post Code")
                {
                }
                field("Buy-from Contact";"Buy-from Contact")
                {
                }
                field("Posting Date";"Posting Date")
                {
                }
                field("Due Date";"Due Date")
                {
                }
                field("Vendor Invoice No.";"Vendor Invoice No.")
                {
                }
                field("Pay-to Vendor No.";"Pay-to Vendor No.")
                {
                }
                field("Payment Terms Code";"Payment Terms Code")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                }
                field("Applies-to Doc. No.";"Applies-to Doc. No.")
                {
                }
            }
            part(PurchLines;"Purch. Invoice Subform Act")
            {
                SubPageLink = "Document No."=FIELD("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Invoice)
            {
                Caption = 'Invoice';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Statistics";
                    RunPageLink = "Document Type"=FIELD("Document Type"),
                                  "No."=FIELD("No.");
                    ShortCutKey = 'F9';
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No."=FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type"=FIELD("Document Type"),
                                  "No."=FIELD("No.");
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Text")
                {
                    Caption = 'Insert &Ext. Text';
                    Image = Text;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.InsertExtendedText(true);
                    end;
                }
                action("&Get Receipt")
                {
                    Caption = '&Get Receipt';
                    Image = Receipt;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.GetReceipt;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Purch.-Post (Yes/No)";
                    ShortCutKey = 'F11';
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Purch.-Post + Print";
                    ShortCutKey = 'Shift+F11';
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction()
                    begin
                        REPORT.RunModal(REPORT::"Batch Post Purchase Invoices",true,true,Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*99999
        //>>  Location Management - start
        IF CurrForm.EDITABLE THEN BEGIN
          IF MultiLocations.GetPurchLocation = '' THEN
            SETRANGE("Location Code")
          ELSE
            SETRANGE("Location Code",MultiLocations.GetPurchLocation);
        END;
        //>>  Location Management - end
        99999*/

    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
}

