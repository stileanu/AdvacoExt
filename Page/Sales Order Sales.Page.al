page 50062 "Sales Order Sales"
{
    // HTCS RJK 10/24/00
    // Added Field for Outside Sales Rep to General TAB
    // 1/9/01 HTCS RCA
    // Changed caption for "Shipment Date" to "Exp. Shipment Date"
    // 
    // 2/27/01 HEF
    // ADDED REOPEN & RELEASE BUTTON
    // 
    // 04/28/2011 ADV
    //   Added Name on Card, Bill-to Address and CC Comments fields to a new tab <Payments>
    //   Moved all fields related to Payment processing to the new tab.

    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type","Location Code","No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=FILTER(Order));

    layout
    {
        area(content)
        {
            group(Control1220060076)
            {
                ShowCaption = false;
                grid(Control1220060077)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060078)
                    {
                        ShowCaption = false;
                        field("No.";"No.")
                        {
                            Editable = false;

                            trigger OnAssistEdit()
                            begin
                                if AssistEdit(xRec) then
                                  CurrPage.Update;
                            end;
                        }
                        field("Sell-to Customer No.";"Sell-to Customer No.")
                        {
                        }
                        field("Ship-to Code";"Ship-to Code")
                        {
                        }
                        field("Order Date";"Order Date")
                        {
                        }
                    }
                }
            }
            group(General)
            {
                group(Control1220060035)
                {
                    ShowCaption = false;
                    field("Sell-to Customer Name";"Sell-to Customer Name")
                    {
                        Editable = false;
                    }
                    field("Sell-to Address";"Sell-to Address")
                    {
                        Editable = false;
                    }
                    field("Sell-to Address 2";"Sell-to Address 2")
                    {
                        Editable = false;
                    }
                    field("Sell-to City";"Sell-to City")
                    {
                        Editable = false;
                    }
                    field("Sell-to County";"Sell-to County")
                    {
                        Editable = false;
                    }
                    field("Sell-to Post Code";"Sell-to Post Code")
                    {
                        Editable = false;
                    }
                    field("Sell-to Contact";"Sell-to Contact")
                    {
                        Editable = false;
                    }
                    field("Tax Exemption No.";"Tax Exemption No.")
                    {
                    }
                    field("Exempt Organization";"Exempt Organization")
                    {
                    }
                    field("Tax Liable";"Tax Liable")
                    {
                    }
                }
                group(Control1220060036)
                {
                    ShowCaption = false;
                    field("Ship-to Name";"Ship-to Name")
                    {
                    }
                    field("Ship-to Address";"Ship-to Address")
                    {
                    }
                    field("Ship-to Address 2";"Ship-to Address 2")
                    {
                    }
                    field("Ship-to City";"Ship-to City")
                    {
                    }
                    field("Ship-to County";"Ship-to County")
                    {
                    }
                    field("Ship-to Post Code";"Ship-to Post Code")
                    {
                    }
                    field("Ship-to Contact";"Ship-to Contact")
                    {
                    }
                    field("Phone No.";"Phone No.")
                    {
                    }
                    field(Rep;Rep)
                    {
                    }
                    field("Salesperson Code";"Salesperson Code")
                    {
                        Caption = 'Inside Sales';
                    }
                    field(Status;Status)
                    {
                    }
                }
            }
            part(SalesLines;"Sales Order Sales Subform")
            {
                SubPageLink = "Document No."=FIELD("No.");
            }
            group(Other)
            {
                Caption = 'Other';
                group(Control1220060056)
                {
                    ShowCaption = false;
                    field("Shipping Agent Code";"Shipping Agent Code")
                    {
                    }
                    field("Shipment Method Code";"Shipment Method Code")
                    {
                    }
                    field("Shipping Charge";"Shipping Charge")
                    {
                    }
                    field("Shipping Account";"Shipping Account")
                    {
                    }
                    field("Shipping Advice";"Shipping Advice")
                    {
                    }
                    field("Package Tracking No.";"Package Tracking No.")
                    {
                    }
                    field("Work Order No.";"Work Order No.")
                    {
                    }
                    field("Bill of Lading";"Bill of Lading")
                    {
                        Editable = false;
                    }
                }
                group(Control1220060057)
                {
                    ShowCaption = false;
                    field("Your Reference";"Your Reference")
                    {
                        Caption = 'Customer P.O Number';
                    }
                    field("Customer Order No.";"Customer Order No.")
                    {
                    }
                }
            }
            group(Payment)
            {
                Caption = 'Payment';
                field("Payment Terms Code";"Payment Terms Code")
                {
                }
                field("Card Type";"Card Type")
                {
                }
                field("Credit Card No.";"Credit Card No.")
                {
                }
                field("Credit Card Exp.";"Credit Card Exp.")
                {
                }
                field("Credit Card SC";"Credit Card SC")
                {
                }
                group(Control1220060060)
                {
                    ShowCaption = false;
                    field("Name on Card";"Name on Card")
                    {
                    }
                    group("<Control1220060065>")
                    {
                        Caption = 'Bill-to Address';
                        field("Bill-to Address";"Bill-to Address")
                        {
                            ShowCaption = false;
                        }
                        field("Bill-to Address 2";"Bill-to Address 2")
                        {
                            ShowCaption = false;
                        }
                        field("Bill-to Address 3";"Bill-to Address_3")
                        {
                            ShowCaption = false;
                        }
                        field("Bill-to Address 4";"Bill-to Address_4")
                        {
                            ShowCaption = false;
                        }
                    }
                }
            }
            group("Credit Card Comments")
            {
                Caption = 'Credit Card Comments';
                group(Control1220060051)
                {
                    ShowCaption = false;
                    field("CC Comments 1";"CC Comments 1")
                    {
                        ShowCaption = false;
                    }
                    field("CC Comments 2";"CC Comments 2")
                    {
                        ShowCaption = false;
                    }
                    field("CC Comments 3";"CC Comments 3")
                    {
                        ShowCaption = false;
                    }
                }
            }
            group("Third Party")
            {
                Caption = 'Third Party';
                group(Control1220060064)
                {
                    ShowCaption = false;
                    field("Third Party Name";"Third Party Name")
                    {
                    }
                    field("Third Party Address";"Third Party Address")
                    {
                    }
                    field("Third Party City";"Third Party City")
                    {
                    }
                    field("Third Party State";"Third Party State")
                    {
                    }
                    field("Third Party Zip";"Third Party Zip")
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
            action("Add Item")
            {
                Caption = 'Add Item';

                trigger OnAction()
                begin
                    PAGE.Run(50057);
                end;
            }
            group(Print)
            {
                Caption = 'Print';
                action(Envelope)
                {
                    Caption = 'Envelope';

                    trigger OnAction()
                    begin
                        SO := Rec;
                        SO.SetFilter("No.","No.");
                        SO.SetRecFilter;
                        REPORT.RunModal(50001,true,false,SO);
                    end;
                }
                action("Order")
                {
                    Caption = 'Order';

                    trigger OnAction()
                    begin
                        OIL := false;
                        OILSL.SetRange(OILSL."Document No.","No.");
                        if OILSL.Find('-') then begin
                          repeat
                          if OILSL."Gen. Prod. Posting Group" = 'OIL SALES' then
                            OIL := true;
                          until OILSL.Next = 0;
                        end;

                        if OIL then
                          Message('Remember to Print Oil Labels and MSDS to go with the Order');

                        SO := Rec;
                        SO.SetFilter("No.","No.");
                        SO.SetRecFilter;
                        REPORT.RunModal(50022,true,false,SO);
                    end;
                }
                action("Pick Ticket")
                {
                    Caption = 'Pick Ticket';

                    trigger OnAction()
                    begin
                        SO := Rec;
                        SO.SetFilter("No.","No.");
                        SO.SetRecFilter;
                        REPORT.RunModal(50020,true,false,SO);
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    RunObject = Page "Sales Order Statistics";
                    RunPageLink = "Document Type"=FIELD("Document Type"),
                                  "No."=FIELD("No.");
                    ShortCutKey = 'F9';
                }
                action(Card)
                {
                    Caption = 'Card';
                    RunObject = Page "Customer Card Sales";
                    RunPageLink = "No."=FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type"=FIELD("Document Type"),
                                  "No."=FIELD("No.");
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No."=FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No."=FIELD("No.");
                    RunPageView = SORTING("Order No.");
                }
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReleaseVisible;

                trigger OnAction()
                begin
                    // >> Distribution - start
                    if not UpdateAllowed then
                      exit;
                    // << Distribution - end

                    //>>  Whse. Management - start
                    ReleaseSalesDoc.PerformManualRelease(Rec);
                    //<<  Whse. Management - end

                    if Status = Status::Released then begin
                      ReopenVisible := true;
                      ReleaseVisible := false;
                    end else begin
                      ReopenVisible := false;
                      ReleaseVisible := true;
                    end;
                    CurrPage.Update;
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReopenVisible;

                trigger OnAction()
                begin
                    // >> Distribution - start
                    if not UpdateAllowed then
                      exit;
                    // << Distribution - end

                    //>>  Warehouse Management - start
                    //Released := FALSE;
                    //"Order Status" := "Order Status"::Open;
                    ReleaseSalesDoc.PerformManualReopen(Rec);
                    //<<  Warehouse Management - end

                    if Status = Status::Open then begin
                      ReopenVisible := false;
                      ReleaseVisible := true;
                    end else begin
                      ReopenVisible := true;
                      ReleaseVisible := false;
                    end;
                    CurrPage.Update;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //>> HEF 2/27/01
        if Status = Status::Open then begin
          ReopenVisible := false;
          ReleaseVisible := true;
        end else begin
          ReopenVisible := true;
          ReleaseVisible := false;
        end;
        //<< HEF 2/27/01
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(ConfirmDeletion);
    end;

    trigger OnOpenPage()
    begin
        //>> HEF
        if Status = Status::Open then begin
          ReopenVisible := false;
          ReleaseVisible := true;
        end else begin
          ReopenVisible := true;
          ReleaseVisible := false;
        end;
        //<< END INSERT
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if "No." <> '' then begin
          if "Your Reference" = '' then
          Error('Customer P.O Number Must be Entered');
        end;
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        UserSetup: Record "User Setup";
        ReqLine: Record "Requisition Line";
        ReqName: Record "Requisition Wksh. Name";
        GetSalesOrder: Report "Get Sales Orders";
        SalesLine: Record "Sales Line";
        ReservationEntry: Record "Reservation Entry";
        SalesHeader: Record "Sales Header";
        Location: Record Location;
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        CopySalesDoc: Report "Copy Sales Document";
        ChangeExchangeRate: Page "Change Exchange Rate";
        ReserveComplete: Boolean;
        NotPicked: Boolean;
        PickComplete: Boolean;
        PartialPick: Boolean;
        QuantityReserved: Decimal;
        OK: Boolean;
        PrintPick: Integer;
        SO: Record "Sales Header";
        OILSL: Record "Sales Line";
        OIL: Boolean;
        [InDataSet]
        ReopenVisible: Boolean;
        [InDataSet]
        ReleaseVisible: Boolean;
        ReleaseSalesDoc: Codeunit "Release Sales Document";

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
          Message('Unable to execute this function while in view only mode.');
          exit(false);
        end else
          exit(true);
    end;
}

