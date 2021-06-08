page 50071 "Customer Card Sales"
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
                    field("Shipping Advice"; Rec."Shipping Advice")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship on Sales Order"; Rec."Ship on Sales Order")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060031)
                {
                    ShowCaption = false;
                    field("Search Name"; Rec."Search Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Balance (LCY)"; Rec."Balance (LCY)")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Salesperson Code"; Rec."Salesperson Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Rep; Rec.Rep)
                    {
                        ApplicationArea = All;
                    }
                    field("Credit Issues"; Rec."Credit Issues")
                    {
                        ApplicationArea = All;
                    }
                    field(Blocked; Rec.Blocked)
                    {
                        ApplicationArea = All;
                    }
                    field("Last Date Modified"; Rec."Last Date Modified")
                    {
                        ApplicationArea = All;
                    }
                    field("CC Fee Waived"; Rec."CC Fee Waived")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Communication)
            {
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
            }
            group(Invoicing)
            {
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Account"; Rec."Shipping Account")
                {
                    ApplicationArea = All;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = All;
                }
                field("Internet Invoicing"; Rec."Internet Invoicing")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Exemption No."; Rec."Tax Exemption No.")
                {
                    ApplicationArea = All;
                }
                field("Exempt Organization"; Rec."Exempt Organization")
                {
                    ApplicationArea = All;
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
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Customer),
                                  "No." = FIELD("No.");
                }
                action("Bank Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
                action("Ship-&to Addresses")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-&to Addresses';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Ship-to Address";
                    RunPageLink = "Customer No." = FIELD("No.");
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                action("Invoice &Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Invoice &Discounts';
                    Promoted = true;
                    RunObject = Page "Cust. Invoice Discounts";
                    RunPageLink = Code = FIELD("Invoice Disc. Code");
                }
                action(Quotes)
                {
                    ApplicationArea = All;
                    Caption = 'Quotes';
                    Promoted = true;
                    RunObject = Page "Sales Quote";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.", "No.");
                }
                action("Blanket Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Blanket Orders';
                    Promoted = true;
                    RunObject = Page "Blanket Sales Order";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.", "No.");
                }
                action(Orders)
                {
                    ApplicationArea = All;
                    Caption = 'Orders';
                    Promoted = true;
                    RunObject = Page "Sales Order Sales";
                    RunPageLink = "Sell-to Customer No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", "Sell-to Customer No.", "No.");
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.");
    end;

    var
        Mail: Codeunit Mail;
}

