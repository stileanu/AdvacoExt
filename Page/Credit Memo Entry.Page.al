page 50140 "Credit Memo Entry"
{
    // // Added Filter to Form to only show unposted and Issue Full Credit Memos

    PageType = Card;
    SourceTable = "Purchase Header";
    ///--!
    //SourceTableView = SORTING("Document Type","Order Date")
    SourceTableView = SORTING("Document Type")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
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
                field("Location Code"; "Location Code")
                {
                }
                field("Return Reason"; "Return Reason")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                    Enabled = false;
                }
                field("Credit Memo Posted"; "Credit Memo Posted")
                {
                }
                field("Your Reference"; "Your Reference")
                {
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                }
                field("Vendor Cr. Memo No."; "Vendor Cr. Memo No.")
                {
                    Editable = false;
                }
                field("Authorized By"; "Authorized By")
                {
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                }
                field("Credit Memo Action"; "Credit Memo Action")
                {
                }
                field("Return to Vendor"; "Return to Vendor")
                {
                }
            }
            part(PurchLines; "Credit Memo Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Shipping)
            {
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
                field("RMA No."; "RMA No.")
                {
                }
                field("Shipping Agent"; "Shipping Agent")
                {
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                }
                field("Shipping Charge"; "Shipping Charge")
                {
                }
                field("Shipping Account"; "Shipping Account")
                {
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                }
                field("Bill of Lading"; "Bill of Lading")
                {
                    Editable = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Close Credit Memo")
            {
                Caption = 'Close Credit Memo';

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Close this Credit Memo', false) then begin
                        Message('Close Credit Memo has been Aborted');
                    end else begin
                        if "Credit Memo Action" = "Credit Memo Action"::"Issue Full Credit" then begin
                            Message('This Credit Memo is setup up as "Issue Full Credit" and must be processed by Accounting');
                        end else begin
                            if "Return to Vendor" then begin
                                if "Bill of Lading" = 0 then begin
                                    Message('This Credit Memo can''t be closed because it is setup as a Return to Vendor and it hasn''t been shipped yet');
                                end else begin
                                    "Credit Memo Posted" := true;
                                    "Completion Date" := Today;
                                    "Completion USERID" := UserId;
                                    Modify;
                                end;
                            end else begin
                                "Credit Memo Posted" := true;
                                "Completion Date" := Today;
                                "Completion USERID" := UserId;
                                Modify;
                            end;
                        end;
                    end;
                end;
            }
            group("&Cr. Memo")
            {
                Caption = '&Cr. Memo';
                action(Card)
                {
                    Caption = 'Card';
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Copy Document")
                {
                    Caption = 'Copy Document';

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Promoted = true;

                trigger OnAction()
                begin
                    CM.SetRange(CM."Document Type", "Document Type"::"Credit Memo");
                    CM.SetRange(CM."No.", "No.");
                    REPORT.RunModal(50141, true, false, CM);
                    REPORT.RunModal(50142, false, false, CM);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if "Credit Memo Posted" then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchaseLine: Record "Purchase Line";
        ReservationEntry: Record "Reservation Entry";
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        ReportPrint: Codeunit "Test Report-Print";
        QuantityReserved: Decimal;
        OrderComplete: Boolean;
        OrderReserved: Boolean;
        Location: Record Location;
        PrintPick: Integer;
        PickComplete: Boolean;
        NothingPicked: Boolean;
        "Credit Memo Header": Record "Purchase Header";
        CM: Record "Purchase Header";
}

