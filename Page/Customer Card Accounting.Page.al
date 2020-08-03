page 50070 "Customer Card Accounting"
{
    // 05/02/13 ADV
    //   Added new control on Communication tab to set invoice sent by Email method of Invoice delivery.
    // 02/07/16 ADV
    //    Reorganize Communication tab per Kaye request. Took out <Home Page> and <Name 2> controls.
    //    Took out email Invoice field.
    // 06/09/19
    //    Added control for field 50012 CC Fee Waived to indicate Credit Card fee is waived. It is read only here.

    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060030)
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
                    field("Shipping Advice";"Shipping Advice")
                    {
                    }
                    field("Ship on Sales Order";"Ship on Sales Order")
                    {
                    }
                }
                group(Control1220060031)
                {
                    ShowCaption = false;
                    field("Search Name";"Search Name")
                    {
                    }
                    field("Balance (LCY)";"Balance (LCY)")
                    {
                        Editable = false;
                    }
                    field("Credit Limit (LCY)";"Credit Limit (LCY)")
                    {
                        Editable = false;
                    }
                    field("Salesperson Code";"Salesperson Code")
                    {
                        Editable = false;
                    }
                    field(Rep;Rep)
                    {
                    }
                    field(Blocked;Blocked)
                    {
                    }
                    field("Credit Issues";"Credit Issues")
                    {
                    }
                    field("Customer Since";"Customer Since")
                    {
                    }
                    field("Last Date Modified";"Last Date Modified")
                    {
                    }
                    field("CC Fee Waived";"CC Fee Waived")
                    {
                    }
                }
            }
            group(Communication)
            {
                field("<PhoneNo.>";"Phone No.")
                {
                }
                field("Fax No.";"Fax No.")
                {
                }
                field("E-Mail";"E-Mail")
                {
                    Caption = 'Contact E-Mail';
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
            group(Invoicing)
            {
                group(Control1220060058)
                {
                    ShowCaption = false;
                    field("Shipment Method Code";"Shipment Method Code")
                    {
                    }
                    field("Shipping Agent Code";"Shipping Agent Code")
                    {
                    }
                    field("Shipping Account";"Shipping Account")
                    {
                    }
                    field("Combine Shipments";"Combine Shipments")
                    {
                    }
                    field("Internet Invoicing";"Internet Invoicing")
                    {
                    }
                    field("No Internet/Paper Invoice";"No Internet/Paper Invoice")
                    {
                    }
                    field("Invoice Copies";"Invoice Copies")
                    {
                    }
                    field("Tax Liable";"Tax Liable")
                    {
                    }
                    field("Tax Area Code";"Tax Area Code")
                    {
                    }
                    field("Tax Exemption No.";"Tax Exemption No.")
                    {
                    }
                    field("Exempt Organization";"Exempt Organization")
                    {
                    }
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                group(Control1220060047)
                {
                    ShowCaption = false;
                    field("Payment Terms Code";"Payment Terms Code")
                    {
                        Editable = false;
                    }
                    field("Payment Method Code";"Payment Method Code")
                    {
                    }
                    field("Reminder Terms Code";"Reminder Terms Code")
                    {
                    }
                    field("Fin. Charge Terms Code";"Fin. Charge Terms Code")
                    {
                    }
                }
                group(Control1220060048)
                {
                    ShowCaption = false;
                    field("Print Statements";"Print Statements")
                    {
                    }
                    field("Last Statement No.";"Last Statement No.")
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
            group("&Customer")
            {
                Caption = '&Customer';
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Page "Customer Ledger Entries";
                    RunPageLink = "Customer No."=FIELD("No.");
                    RunPageView = SORTING("Customer No.","Posting Date");
                    ShortCutKey = 'Ctrl+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name"=CONST(Customer),
                                  "No."=FIELD("No.");
                }
                action("Bank Accounts")
                {
                    Caption = 'Bank Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No."=FIELD("No.");
                }
                action("Ship-&to Addresses")
                {
                    Caption = 'Ship-&to Addresses';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Ship-to Address";
                    RunPageLink = "Customer No."=FIELD("No.");
                }
                separator(Separator1220060053)
                {
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    RunObject = Page "Customer Statistics";
                    RunPageLink = "No."=FIELD("No."),
                                  "Date Filter"=FIELD("Date Filter");
                    ShortCutKey = 'F9';
                }
                action("Entry Statistics")
                {
                    Caption = 'Entry Statistics';
                    RunObject = Page "Customer Entry Statistics";
                    RunPageLink = "No."=FIELD("No."),
                                  "Date Filter"=FIELD("Date Filter");
                }
                action("S&ales")
                {
                    Caption = 'S&ales';
                    RunObject = Page "Customer Sales";
                    RunPageLink = "No."=FIELD("No.");
                }
            }
            group(ActionGroup1220060040)
            {
                Caption = 'S&ales';
                action("Invoice &Discounts")
                {
                    Caption = 'Invoice &Discounts';
                    Promoted = true;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code=FIELD("Invoice Disc. Code");
                }
                action(Quotes)
                {
                    Caption = 'Quotes';
                    Promoted = true;
                    RunObject = Page "Sales Quote";
                    RunPageLink = "Sell-to Customer No."=FIELD("No.");
                    RunPageView = SORTING("Document Type","Sell-to Customer No.","No.");
                }
                action("Blanket Orders")
                {
                    Caption = 'Blanket Orders';
                    Promoted = true;
                    RunObject = Page "Blanket Sales Order";
                    RunPageLink = "Sell-to Customer No."=FIELD("No.");
                    RunPageView = SORTING("Document Type","Sell-to Customer No.","No.");
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Promoted = true;
                    RunObject = Page "Sales Order Sales";
                    RunPageLink = "Sell-to Customer No."=FIELD("No.");
                    RunPageView = SORTING("Document Type","Sell-to Customer No.","No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("No.");
    end;

    var
        Mail: Codeunit Mail;
}

