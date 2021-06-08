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
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address"; Rec."Buy-from Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Address 2"; Rec."Buy-from Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from City"; Rec."Buy-from City")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from County"; Rec."Buy-from County")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Post Code"; Rec."Buy-from Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Buy-from Contact"; Rec."Buy-from Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;
                    }
                    field(Notes; Rec.Notes)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    field("Order Date"; Rec."Order Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Document Date"; Rec."Document Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Order No."; Rec."Vendor Order No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Order Address Code"; Rec."Order Address Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Purchaser Code"; Rec."Purchaser Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Placed By"; Rec."Placed By")
                    {
                        ApplicationArea = All;
                    }
                    field("Quality Clause"; Rec."Quality Clause")
                    {
                        ApplicationArea = All;
                    }
                    field("Due Date"; Rec."Due Date")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(PurchLines; "Blanket Purch Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                group(Control1220060054)
                {
                    ShowCaption = false;
                    field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Name"; Rec."Pay-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Address"; Rec."Pay-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Address 2"; Rec."Pay-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to City"; Rec."Pay-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to County"; Rec."Pay-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Post Code"; Rec."Pay-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Contact"; Rec."Pay-to Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("On Hold"; Rec."On Hold")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060055)
                {
                    ShowCaption = false;
                    field("Tax Liable"; Rec."Tax Liable")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Area Code"; Rec."Tax Area Code")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Shipping)
            {
                group(Control1220060056)
                {
                    ShowCaption = false;
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to County"; Rec."Ship-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to UPS Zone"; Rec."Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060057)
                {
                    ShowCaption = false;
                    field("Location Code"; Rec."Location Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipment Method Code"; Rec."Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Agent"; Rec."Shipping Agent")
                    {
                        ApplicationArea = All;
                    }
                    field("Expected Receipt Date"; Rec."Expected Receipt Date")
                    {
                        ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = Card;
                    Promoted = true;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = 'Make &Order';
                RunObject = Codeunit "Blnkt Purch Ord. to Ord. (Y/N)";
            }
            action("&Print")
            {
                ApplicationArea = All;
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
        exit(Rec.ConfirmDeletion);
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

