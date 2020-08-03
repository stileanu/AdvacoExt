page 50076 "Blanket Purchase Order Purch"
{
    PageType = Card;
    SourceTable = "Purchase Header";
    SourceTableView = SORTING("Document Type", "Location Code", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060052)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                    }
                    field("Buy-from Vendor No."; "Buy-from Vendor No.")
                    {
                    }
                    field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                    {
                    }
                    field("Buy-from Address"; "Buy-from Address")
                    {
                    }
                    field("Buy-from Address 2"; "Buy-from Address 2")
                    {
                    }
                    field("Buy-from City"; "Buy-from City")
                    {
                    }
                    field("Buy-from County"; "Buy-from County")
                    {
                    }
                    field("Buy-from Post Code"; "Buy-from Post Code")
                    {
                    }
                    field("Buy-from Contact"; "Buy-from Contact")
                    {
                    }
                    field("Payment Terms Code"; "Payment Terms Code")
                    {
                    }
                    field(Notes; Notes)
                    {
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    field("Order Date"; "Order Date")
                    {
                    }
                    field("Document Date"; "Document Date")
                    {
                    }
                    field("Vendor Order No."; "Vendor Order No.")
                    {
                    }
                    field("Vendor Shipment No."; "Vendor Shipment No.")
                    {
                    }
                    field("Order Address Code"; "Order Address Code")
                    {
                    }
                    field("Purchaser Code"; "Purchaser Code")
                    {
                    }
                    field("Placed By"; "Placed By")
                    {
                    }
                    field("Quality Clause"; "Quality Clause")
                    {
                    }
                    field("Due Date"; "Due Date")
                    {
                    }
                }
            }
            part(PurchLines; "Blanket Purch Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                group(Control1220060054)
                {
                    ShowCaption = false;
                    field("Pay-to Vendor No."; "Pay-to Vendor No.")
                    {
                    }
                    field("Pay-to Name"; "Pay-to Name")
                    {
                    }
                    field("Pay-to Address"; "Pay-to Address")
                    {
                    }
                    field("Pay-to Address 2"; "Pay-to Address 2")
                    {
                    }
                    field("Pay-to City"; "Pay-to City")
                    {
                    }
                    field("Pay-to County"; "Pay-to County")
                    {
                    }
                    field("Pay-to Post Code"; "Pay-to Post Code")
                    {
                    }
                    field("Pay-to Contact"; "Pay-to Contact")
                    {
                    }
                    field("On Hold"; "On Hold")
                    {
                    }
                }
                group(Control1220060055)
                {
                    ShowCaption = false;
                    field("Tax Liable"; "Tax Liable")
                    {
                    }
                    field("Tax Area Code"; "Tax Area Code")
                    {
                    }
                }
            }
            group(Shipping)
            {
                group(Control1220060056)
                {
                    ShowCaption = false;
                    field("Ship-to Name"; "Ship-to Name")
                    {
                    }
                    field("Ship-to Address"; "Ship-to Address")
                    {
                    }
                    field("Ship-to Address 2"; "Ship-to Address 2")
                    {
                    }
                    field("Ship-to City"; "Ship-to City")
                    {
                    }
                    field("Ship-to County"; "Ship-to County")
                    {
                    }
                    field("Ship-to Post Code"; "Ship-to Post Code")
                    {
                    }
                    field("Ship-to Contact"; "Ship-to Contact")
                    {
                    }
                    field("Ship-to UPS Zone"; "Ship-to UPS Zone")
                    {
                    }
                }
                group(Control1220060057)
                {
                    ShowCaption = false;
                    field("Location Code"; "Location Code")
                    {
                    }
                    field("Shipment Method Code"; "Shipment Method Code")
                    {
                    }
                    field("Shipping Agent"; "Shipping Agent")
                    {
                    }
                    field("Expected Receipt Date"; "Expected Receipt Date")
                    {
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    RunObject = Page "Purchase Order Statistics";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'F9';
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = Calculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("Insert &Ext. Text")
                {
                    Caption = 'Insert &Ext. Text';
                    Image = Insert;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.InsertExtendedText(true);
                    end;
                }
                action(Reserve)
                {
                    Caption = 'Reserve';
                    Image = Reserve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        CurrPage.PurchLines.PAGE.ShowReservation2;
                    end;
                }
            }
            action("Make &Order")
            {
                Caption = 'Make &Order';
                RunObject = Codeunit "Blnkt Purch Ord. to Ord. (Y/N)";
            }
            action("&Print")
            {
                Caption = '&Print';
                Image = Print;

                trigger OnAction()
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    var
        CurrentPurchLine: Record "Purchase Line";
        PurchLine: Record "Purchase Line";
        PurchReceiptLine: Record "Purch. Rcpt. Line";
        PurchInvoiceLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        CopyPurchDoc: Report "Copy Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page "Change Exchange Rate";
}

