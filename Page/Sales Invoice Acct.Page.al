page 50066 "Sales Invoice Acct"
{
    // 07/21/20
    //   Code in OnOpenPage trigger is removed because it's based on obsolete AD functionality

    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type", "Location Code", "No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = FILTER(Invoice));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060035)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                        ApplicationArea = All;
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field("Sell-to Customer No."; "Sell-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Sell-to Customer Name"; "Sell-to Customer Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to Address"; "Sell-to Address")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to Address 2"; "Sell-to Address 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to City"; "Sell-to City")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to Post Code"; "Sell-to Post Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to County"; "Sell-to County")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sell-to Contact"; "Sell-to Contact")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Control1220060059)
                {
                    ShowCaption = false;
                    field("Posting Date"; "Posting Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Document Date"; "Document Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Salesperson Code"; "Salesperson Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Inside Sales';
                    }
                    field(Rep; Rep)
                    {
                        ApplicationArea = All;
                    }
                    field("Bill of Lading"; "Bill of Lading")
                    {
                        ApplicationArea = All;
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(SalesLines; "Sales Invoice Acct Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                group(Control1220060038)
                {
                    ShowCaption = false;
                    field("Bill-to Customer No."; "Bill-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Name"; "Bill-to Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Address"; "Bill-to Address")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Address 2"; "Bill-to Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to City"; "Bill-to City")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to County"; "Bill-to County")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Post Code"; "Bill-to Post Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Contact"; "Bill-to Contact")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1220060028)
                {
                    ShowCaption = false;
                    field("Your Reference"; "Your Reference")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer P.O Number';
                    }
                    field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Project Code';
                    }
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Card Type"; "Card Type")
                {
                    ApplicationArea = All;
                }
                field("Credit Card No."; "Credit Card No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Card Exp."; "Credit Card Exp.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                group(Control1220060022)
                {
                    ShowCaption = false;
                    field("Ship-to Code"; "Ship-to Code")
                    {
                        ApplicationArea = All;
                    }
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
                }
                group(Control1220060010)
                {
                    ShowCaption = false;
                    field("Shipping Agent Code"; "Shipping Agent Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipment Method Code"; "Shipment Method Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Package Tracking No."; "Package Tracking No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Liable"; "Tax Liable")
                    {
                        ApplicationArea = All;
                    }
                    field("Tax Area Code"; "Tax Area Code")
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
            group("&Invoice")
            {
                Caption = '&Invoice';
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    RunObject = Page "Sales Statistics";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'F9';
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No.");
                }
            }
            group(Functions)
            {
                Caption = 'Functions';
                action(CopyDocument)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RunModal;
                        Clear(CopySalesDoc);
                    end;
                }
                action("Insert &Ext. Text")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Cust. Invoice Disc." = R;
                    Caption = 'Insert &Ext. Text';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.InsertExtendedText(true);
                    end;
                }
                action("&Reserve")
                {
                    ApplicationArea = All;
                    Caption = '&Reserve';

                    trigger OnAction()
                    begin
                        CurrPage.SalesLines.PAGE.ShowReservation2;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    RunObject = Codeunit "Sales-Post (Yes/No)";
                    ShortCutKey = 'F11';
                }
                action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    RunObject = Codeunit "Sales-Post + Print";
                    ShortCutKey = 'Shift+F11';
                }
                action("Post and &Email")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Email';

                    trigger OnAction()
                    begin
                        Cust.Get("Bill-to Customer No.");
                        //IF NOT Cust."Email Invoice" THEN
                        //  ERROR('Customer %1 not set to receive Invoices by E-Mail.',"Bill-to Customer No.");
                        //Cust.VALIDATE(Cust."Invoicing Email");
                        //IF Cust."Path to PDF" = '' THEN
                        //  ERROR('Path to PDF files not set for Customer %1',Cust.Name);

                        //CODEUNIT.Run(CODEUNIT::"Sales-Post + Print Email",Rec);
                        CODEUNIT.Run(CODEUNIT::"Sales-Post + Email"); //ICE-MPC BC Upgrade
                    end;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        ReqLine: Record "Requisition Line";
        ReqName: Record "Requisition Wksh. Name";
        GetSalesOrder: Report "Get Sales Orders";
        SalesLine: Record "Sales Line";
        ReservSalesLine: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
        ReservEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        Cust: Record Customer;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ReservMgt: Codeunit "Reservation Management";
        CopySalesDoc: Report "Copy Sales Document";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ReserveComplete: Boolean;
        NotPicked: Boolean;
        PickComplete: Boolean;
        PartialPick: Boolean;
        QuantityReserved: Decimal;
        OK: Boolean;
        PrintPick: Integer;
        WhseDocExists: Boolean;
        CCFeeCode: Codeunit CreditCardFeeFunctions;
        GLSetup: Record "General Ledger Setup";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
            Message('Unable to execute this function while in view only mode.');
            exit(false);
        end else
            exit(true);
    end;
}

