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
                    field("No.";"No.")
                    {

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                              CurrPage.Update;
                        end;
                    }
                    field(Name;Name)
                    {
                    }
                    field(Address;Address)
                    {
                    }
                    field("Address 2";"Address 2")
                    {
                    }
                    field(City;City)
                    {
                    }
                    field(County;County)
                    {
                    }
                    field("Post Code";"Post Code")
                    {
                    }
                    field("Phone No.";"Phone No.")
                    {
                    }
                    field(Contact;Contact)
                    {
                    }
                }
                group(Control1220060043)
                {
                    ShowCaption = false;
                    field("Search Name";"Search Name")
                    {
                    }
                    field("Balance (LCY)";"Balance (LCY)")
                    {
                    }
                    field("Purchaser Code";"Purchaser Code")
                    {
                    }
                    field(Blocked;Blocked)
                    {
                    }
                    field("Receiving Inspection";"Receiving Inspection")
                    {
                    }
                    field("Vendor Type";"Vendor Type")
                    {
                    }
                    field("Last Date Modified";"Last Date Modified")
                    {
                    }
                }
            }
            group(Communication)
            {
                group(Control1220060041)
                {
                    ShowCaption = false;
                    field("<PhoneNo.>";"Phone No.")
                    {
                    }
                    field("Fax No.";"Fax No.")
                    {
                    }
                    field("E-Mail";"E-Mail")
                    {
                    }
                    field("Email Invoice";"Email Invoice")
                    {
                    }
                    field("Invoicing Email";"Invoicing Email")
                    {
                    }
                    field("Path to PDF";"Path to PDF")
                    {
                    }
                }
            }
            group(Invoicing)
            {
                group(Control1220060044)
                {
                    ShowCaption = false;
                    field("Shipment Method Code";"Shipment Method Code")
                    {
                    }
                    field("Pay-to Vendor No.";"Pay-to Vendor No.")
                    {
                    }
                }
                group(Control1220060045)
                {
                    ShowCaption = false;
                    field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                    {
                    }
                    field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                    {
                    }
                    field("Vendor Posting Group";"Vendor Posting Group")
                    {
                    }
                    field("Global Dimension 1 Code";"Global Dimension 1 Code")
                    {
                    }
                    field("Global Dimension 2 Code";"Global Dimension 2 Code")
                    {
                    }
                    field("Invoice Disc. Code";"Invoice Disc. Code")
                    {
                    }
                }
            }
            group(Payments)
            {
                group(Control1220060046)
                {
                    ShowCaption = false;
                    field("Payment Terms Code";"Payment Terms Code")
                    {
                    }
                    field("Payment Method Code";"Payment Method Code")
                    {
                    }
                    field("IRS 1099 Code";"IRS 1099 Code")
                    {
                    }
                    field("Federal ID No.";"Federal ID No.")
                    {
                    }
                }
                group(Control1220060047)
                {
                    ShowCaption = false;
                    field("Our Account No.";"Our Account No.")
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
            action("Aging Report")
            {
                Caption = 'Aging Report';
                Enabled = AgingEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    Vendor := Rec;
                    //Vendor.SETFILTER(Vendor."No.","No.");
                    Vendor.SetRecFilter;
                    REPORT.RunModal(10085,true,false,Vendor);

                end;
            }
            group("Ven&dor")
            {
                Caption = 'Ven&dor';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Promoted = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name"=CONST(Vendor),
                                  "No."=FIELD("No.");
                }
                separator(Separator1220060053)
                {
                }
                action(Purchases)
                {
                    Caption = 'Purchases';
                    Promoted = true;
                    RunObject = Page "Vendor Purchases";
                    RunPageLink = "No."=FIELD("No."),
                                  "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter");
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action(Items)
                {
                    Caption = 'Items';
                    Promoted = true;
                    RunObject = Page "Vendor Item Catalog";
                    RunPageLink = "Vendor No."=FIELD("No.");
                    RunPageView = SORTING("Vendor No.");
                }
                action(Quotes)
                {
                    Caption = 'Quotes';
                    Promoted = true;
                    RunObject = Page "Purchase Quote";
                    RunPageLink = "Buy-from Vendor No."=FIELD("No.");
                    RunPageView = SORTING("Document Type","Buy-from Vendor No.","No.");
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Promoted = true;
                    RunObject = Page "Blanket Purchase Order";
                    RunPageLink = "Buy-from Vendor No."=FIELD("No.");
                    RunPageView = SORTING("Document Type","Buy-from Vendor No.","No.");
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Promoted = true;
                    RunObject = Page "Purchase Order";
                    RunPageLink = "Buy-from Vendor No."=FIELD("No.");
                    RunPageView = SORTING("Document Type","Buy-from Vendor No.","No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("No.");
    end;

    trigger OnOpenPage()
    begin
        // HEF INSERT USER ID CHECK
        Member.CalcFields(Member."User Name");
        ok := true;
        Member.SetRange(Member."User Name",UserId);
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

