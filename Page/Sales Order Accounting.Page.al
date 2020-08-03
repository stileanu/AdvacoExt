page 50064 "Sales Order Accounting"
{
    // 2/27/01 HEF
    // ADDED REOPEN & RELEASE BUTTON
    // 
    // Coded Added to Post & Print to prevent Invoicing before Bill of lading Printed
    // 
    // 05/02/13 ADV
    //   Added control and logic to insert Credit Card Fee line for Credit Card payments.
    // 
    // ADV 04/17/16
    //   Modify code to check Cust Credit Limit when Invoice is created
    // 
    // 07/21/20
    //   Code in OnOpenPage and OnAfterGetRecord triggers is removed because it's based on obsolete AD functionality

    PageType = Card;
    SourceTable = "Sales Header";
    SourceTableView = SORTING("Document Type","Location Code","No.")
                      ORDER(Ascending)
                      WHERE("Document Type"=FILTER(Order));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060035)
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
                    field("Sell-to Post Code";"Sell-to Post Code")
                    {
                        Editable = false;
                    }
                    field("Sell-to County";"Sell-to County")
                    {
                        Editable = false;
                    }
                    field("Sell-to Contact";"Sell-to Contact")
                    {
                        Editable = false;
                    }
                }
                group(Control1220060059)
                {
                    ShowCaption = false;
                    field("Posting Date";"Posting Date")
                    {
                    }
                    field("Order Date";"Order Date")
                    {
                    }
                    field("Document Date";"Document Date")
                    {
                    }
                    field("Shipment Date";"Shipment Date")
                    {
                    }
                    field(Status;Status)
                    {
                    }
                    field("Salesperson Code";"Salesperson Code")
                    {
                        Caption = 'Inside Sales';
                    }
                    field(Rep;Rep)
                    {
                    }
                    field("Work Order No.";"Work Order No.")
                    {
                        Editable = false;
                    }
                    field("Bill of Lading";"Bill of Lading")
                    {
                    }
                }
            }
            part(SalesLines;"Sales Order Accounting Subform")
            {
                SubPageLink = "Document No."=FIELD("No.");
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                group(Control1220060038)
                {
                    ShowCaption = false;
                    field("Bill-to Customer No.";"Bill-to Customer No.")
                    {
                    }
                    field("Bill-to Name";"Bill-to Name")
                    {
                    }
                    field("Bill-to Address";"Bill-to Address")
                    {
                    }
                    field("Bill-to Address 2";"Bill-to Address 2")
                    {
                    }
                    field("Bill-to City";"Bill-to City")
                    {
                    }
                    field("Bill-to County";"Bill-to County")
                    {
                    }
                    field("Bill-to Post Code";"Bill-to Post Code")
                    {
                    }
                    field("Bill-to Contact";"Bill-to Contact")
                    {
                    }
                }
                group(Control1220060028)
                {
                    ShowCaption = false;
                    field("Your Reference";"Your Reference")
                    {
                        Caption = 'Customer P.O Number';
                    }
                    field("Shortcut Dimension 2 Code";"Shortcut Dimension 2 Code")
                    {
                        Caption = 'Project Code';
                    }
                }
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
                field("Approval Code";"Approval Code")
                {
                }
                field("Due Date";"Due Date")
                {
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                group(Control1220060022)
                {
                    ShowCaption = false;
                    field("Ship-to Code";"Ship-to Code")
                    {
                    }
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
                    field("Ship-to UPS Zone";"Ship-to UPS Zone")
                    {
                    }
                    field("Tax Liable";"Tax Liable")
                    {
                    }
                    field("Tax Area Code";"Tax Area Code")
                    {
                    }
                }
                group(Control1220060010)
                {
                    ShowCaption = false;
                    field("Shipping Agent Code";"Shipping Agent Code")
                    {
                    }
                    field("Shipment Method Code";"Shipment Method Code")
                    {
                    }
                    field("Shipping Account";"Shipping Account")
                    {
                    }
                    field("Shipping Charge";"Shipping Charge")
                    {
                    }
                    field("Shipping Advice";"Shipping Advice")
                    {
                    }
                    field("<ShipmentDate>";"Shipment Date")
                    {
                        Caption = 'Exp. Shipment Date';
                    }
                    field("Package Tracking No.";"Package Tracking No.")
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
            group(Functions)
            {
                Caption = 'Functions';
                action("Calculate &Invoice Discount")
                {
                    AccessByPermission = TableData "Cust. Invoice Disc."=R;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                          exit;
                        // << Distribution - end

                        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
                    end;
                }
                action(CopyDocument)
                {
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
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    ShortCutKey = 'F11';

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                          exit;

                        // ADV 04/17/16: Start
                        //CustCheckCreditLimit.SalesHeaderCheck(Rec);
                        // ADV 04/17/16: End

                        //HEF INSERT
                        if ("Shortcut Dimension 2 Code" = '') or ("Shortcut Dimension 2 Code" = 'SO') then begin
                        //  IF "Bill of Lading" <> 0 THEN
                        //    CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print",Rec)
                        //  ELSE
                        //    MESSAGE('The Sales Order hasn''t Shipped Yet, Please Contact Shipping!');
                        //END ELSE BEGIN
                          CODEUNIT.Run(CODEUNIT::"Sales-Post + Print",Rec);
                        end;


                        if (GetFilter("No.") <> '') then
                          if not SalesHeader.Get("Document Type","No.") then begin
                            Message('Document %1 posted.',"No.");
                            CurrPage.Close;
                          end;
                        // << Distribution - end
                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    ShortCutKey = 'Shift+F11';

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                          exit;

                        // ADV 04/17/16: Start
                        //CustCheckCreditLimit.SalesHeaderCheck(Rec);
                        // ADV 04/17/16: End

                        //HEF INSERT
                        if ("Shortcut Dimension 2 Code" = '') or ("Shortcut Dimension 2 Code" = 'SO') then begin
                        //  IF "Bill of Lading" <> 0 THEN
                        //    CODEUNIT.RUN(CODEUNIT::"Sales-Post + Print",Rec)
                        //  ELSE
                        //    MESSAGE('The Sales Order hasn''t Shipped Yet, Please Contact Shipping!');
                        //END ELSE BEGIN
                          CODEUNIT.Run(CODEUNIT::"Sales-Post + Print",Rec);
                        end;

                        if (GetFilter("No.") <> '') then
                          if not SalesHeader.Get("Document Type","No.") then begin
                            Message('Document %1 posted.',"No.");
                            CurrPage.Close;
                          end;
                        // << Distribution - end
                    end;
                }
                action("Post and &Email")
                {
                    Caption = 'Post and &Email';

                    trigger OnAction()
                    begin
                        Cust.Get("Bill-to Customer No.");
                        //IF NOT Cust."Email Invoice" THEN
                        //  ERROR('Customer %1 not set to receive Invoices by E-Mail.',"Bill-to Customer No.");
                        //Cust.VALIDATE(Cust."Invoicing Email");
                        //IF Cust."Path to PDF" = '' THEN
                        //  ERROR('Path to PDF files not set for Customer %1',Cust.Name);

                        // ADV 04/17/16: Start
                        //CustCheckCreditLimit.SalesHeaderCheck(Rec);
                        // ADV 04/17/16: End

                        //CODEUNIT.Run(CODEUNIT::"Sales-Post + Print Email",Rec);
                        Codeunit.run(Codeunit::"Sales-Post + Email");  //ICE-MPC BC Upgrade
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';

                    trigger OnAction()
                    begin
                        // >> Distribution - start
                        if not UpdateAllowed then
                          exit;
                        // << Distribution - end

                        // ADV 04/17/16: Start
                        //CustCheckCreditLimit.SalesHeaderCheck(Rec);
                        // ADV 04/17/16: End

                        REPORT.RunModal(REPORT::"Batch Post Sales Orders",true,true,Rec);
                        CurrPage.Update(false);
                    end;
                }
            }
            action("Credit Card Fee Insert")
            {
                Caption = 'Credit Card Fee Insert';
                Image = CreditCard;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = CCFeeInsertVisible;

                trigger OnAction()
                begin
                    // 05/02/13 Start
                    // Make control invisible
                    CCFeeInsertVisible := false;
                    // Insert line
                    if not CCFeeCode.IsCCFee(Rec) then begin
                      CCFeeCode.InsertCreditCardFeeLine(Rec);
                    end;
                    // 05/02/13 End
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

        // 05/02/13 Start
        GLSetup.Get;
        // Make control visible if CC pay and no fee line
        CCFeeInsertVisible := false;
        if (UserId <> 'SCOTT') and (UserId <> 'SCOTTS') then begin
          if GLSetup."Credit Card Payment Code" = "Payment Terms Code" then begin
            if not CCFeeCode.IsCCFee(Rec) then
              CCFeeInsertVisible := true;
          end;
        end;
        // 05/02/13 End
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

        // 05/02/13 Start
        GLSetup.Get;
        // Make control visible if CC pay and no fee line
        CCFeeInsertVisible := false;
        if (UserId <> 'SCOTT') and (UserId <> 'SCOTTS') then begin
          if GLSetup."Credit Card Payment Code" = "Payment Terms Code" then begin
            if not CCFeeCode.IsCCFee(Rec) then
              CCFeeInsertVisible := true;
          end;
        end;
        // 05/02/13 End
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
        [InDataSet]
        ReopenVisible: Boolean;
        [InDataSet]
        ReleaseVisible: Boolean;
        ReleaseSalesDoc: Codeunit "Release Sales Document";
        [InDataSet]
        CCFeeInsertVisible: Boolean;

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
          Message('Unable to execute this function while in view only mode.');
          exit(false);
        end else
          exit(true);
    end;
}

