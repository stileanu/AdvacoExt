#pragma implicitwith disable
page 50072 "Vendor Card ALL"
{
    PageType = Card;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060042)
                {
                    ShowCaption = false;
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            if Rec.AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field(Name; Rec.Name)
                    {
                        ApplicationArea = All;
                    }
                    field(Address; Rec.Address)
                    {
                        ApplicationArea = All;
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                    }
                    field(County; Rec.County)
                    {
                        ApplicationArea = All;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Contact; Rec.Contact)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060043)
                {
                    ShowCaption = false;
                    field("Search Name"; Rec."Search Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Balance (LCY)"; Rec."Balance (LCY)")
                    {
                        ApplicationArea = All;
                    }
                    field("Purchaser Code"; Rec."Purchaser Code")
                    {
                        ApplicationArea = All;
                    }
                    field(Blocked; Rec.Blocked)
                    {
                        ApplicationArea = All;
                    }
                    field("Receiving Inspection"; Rec."Receiving Inspection")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Type"; Rec."Vendor Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Last Date Modified"; Rec."Last Date Modified")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Communication)
            {
                group(Control1220060041)
                {
                    ShowCaption = false;
                    field("<PhoneNo.>"; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Fax No."; Rec."Fax No.")
                    {
                        ApplicationArea = All;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = All;
                    }
                    field("Email Invoice"; Rec."Email Invoice")
                    {
                        ApplicationArea = All;
                    }
                    field("Invoicing Email"; Rec."Invoicing Email")
                    {
                        ApplicationArea = All;
                    }
                    field("Path to PDF"; Rec."Path to PDF")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Invoicing)
            {
                group(Control1220060044)
                {
                    ShowCaption = false;
                    field("Shipment Method Code"; Rec."Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060045)
                {
                    ShowCaption = false;
                    field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                    {
                        ApplicationArea = All;
                    }
                    field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Posting Group"; Rec."Vendor Posting Group")
                    {
                        ApplicationArea = All;
                    }
                    field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Payments)
            {
                group(Control1220060046)
                {
                    ShowCaption = false;
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Payment Method Code"; Rec."Payment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("IRS 1099 Code"; Rec."IRS 1099 Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Federal ID No."; Rec."Federal ID No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060047)
                {
                    ShowCaption = false;
                    field("Our Account No."; Rec."Our Account No.")
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
            action("Aging Report")
            {
                ApplicationArea = All;
                Caption = 'Aging Report';
                Enabled = AgingEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    Vendor := Rec;
                    //Vendor.SETFILTER(Vendor."No.","No."); 
                    Vendor.SetRecFilter;
                    REPORT.RunModal(10085, true, false, Vendor);

                end;
            }
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Promoted = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Vendor),
                                  "No." = FIELD("No.");
                }
                separator(Separator1220060053)
                {
                }
                action(Purchases)
                {
                    ApplicationArea = All;
                    Caption = 'Purchases';
                    Promoted = true;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No." = FIELD("No."),
                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter");
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action(Items)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    Promoted = true;
                    RunObject = Page "Vendor Item Catalog";
                    RunPageLink = "Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                }
                action(Quotes)
                {
                    ApplicationArea = All;
                    Caption = 'Quotes';
                    Promoted = true;
                    RunObject = Page "Purchase Quote";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
                }
                action("Blanket Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Orders';
                    Promoted = true;
                    RunObject = Page "Blanket Purchase Order";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
                }
                action(Orders)
                {
                    ApplicationArea = All;
                    Caption = 'Orders';
                    Promoted = true;
                    RunObject = Page "Purchase Order";
                    RunPageLink = "Buy-from Vendor No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Buy-from Vendor No.", "No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.");
    end;

    trigger OnOpenPage()
    begin
        // HEF INSERT USER ID CHECK
        Member.CalcFields(Member."User Name");
        ok := true;
        Member.SetRange(Member."User Name", UserId);
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'SUPER') then
                    ok := false;
            until Member.Next = 0;
        end;

        if ok then
            AgingEnabled := false;
    end;

    var
        Mail: Codeunit Mail;
        Vendor: Record Vendor;
        Member: Record "Access Control";
        ok: Boolean;
        [InDataSet]
        AgingEnabled: Boolean;
}

#pragma implicitwith restore

