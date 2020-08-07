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
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Buy-from City"; "Buy-from City")
                {
                    ApplicationArea = All;
                }
                field("Buy-from County"; "Buy-from County")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Return Reason"; "Return Reason")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Credit Memo Posted"; "Credit Memo Posted")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; "Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; "Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Authorized By"; "Authorized By")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Credit Memo Action"; "Credit Memo Action")
                {
                    ApplicationArea = All;
                }
                field("Return to Vendor"; "Return to Vendor")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Credit Memo Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Shipping)
            {
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; "Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Ship-to UPS Zone"; "Ship-to UPS Zone")
                {
                    ApplicationArea = All;
                }
                field("RMA No."; "RMA No.")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent"; "Shipping Agent")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Charge"; "Shipping Charge")
                {
                    ApplicationArea = All;
                }
                field("Shipping Account"; "Shipping Account")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Bill of Lading"; "Bill of Lading")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Card';
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                ApplicationArea = All;
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

