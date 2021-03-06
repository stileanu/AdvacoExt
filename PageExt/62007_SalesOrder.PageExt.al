pageextension 62007 SalesOrderExt extends "Sales Order"
{
    layout
    {
        modify(General)
        {
            Visible = not lShipGroup;
        }
        modify("No.")
        {
            Editable = (lAccGroup or lSalesGroup);
        }
        modify("Sell-to Customer No.")
        {
            Editable = (lAccGroup or lSalesGroup);
        }
        modify("Sell-to Customer Name")
        {
            Editable = (lAccGroup or lSalesGroup);
        }
        modify("Sell-to")
        {
            Editable = (lAccGroup or lSalesGroup);
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Caption = 'Inside Sales';
        }
        modify("Invoice Details")
        {
            Visible = not lShipGroup;
        }
        modify("Foreign Trade")
        {
            Visible = not lShipGroup;
        }
        //ICE RSK 12/22/20
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify(Control1900201301)
        {
            Visible = not lShipGroup;
        }
        modify("Shipping and Billing")
        {
            Visible = not lShipGroup;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        addbefore("Salesperson Code")
        {
            field(Rep; Rec.Rep)
            {
                ApplicationArea = All;
                Caption = 'Sales Rep';
            }
        }
        addafter(General)
        {
            group(ShippingTab)
            {

                Visible = lShipGroup;
                Caption = 'Shipping';

                group(ShipToAddr)
                {
                    Editable = false;
                    Caption = 'Ship-To Address';

                    field("ShipNo."; Rec."No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                        trigger OnAssistEdit()
                        begin
                            if Rec.AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field(ShipToName; Rec."Ship-to Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Name';
                        ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                    }
                    field(ShipShipToAddr; Rec."Ship-to Address")
                    {
                        ApplicationArea = All;
                        Caption = 'Address';
                        ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                    }
                    field(ShipShipToAddr2; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = All;
                        Caption = 'Address 2';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(ShipShipToCity; Rec."Ship-to City")
                    {
                        ApplicationArea = All;
                        Caption = 'City';
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(CntyControl297)
                    {
                        ShowCaption = false;
                        field(ShipShipToCounty; Rec."Ship-to County")
                        {
                            ApplicationArea = All;
                            Caption = 'County';
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field(ShipShipToPostCode; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Post Code';
                        ToolTip = 'Specifies the postal code.';
                    }
                    field(ShipShpToCnty_RegCode; Rec."Ship-to Country/Region Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Country/Region';
                        ToolTip = 'Specifies the customer''s country/region.';

                        trigger OnValidate()
                        var
                            FormatAddress: Codeunit "Format Address";
                        begin
                            FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
                        end;
                    }
                    field(ShipShpToUPSZone; Rec."Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                        Caption = 'UPS Zone';
                        ToolTip = 'Specifies a UPS Zone code for this document if UPS is used for shipments.';
                    }
                    field(ShipToContact; Rec."Ship-to Contact")
                    {
                        ApplicationArea = All;
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone No.';
                        ToolTip = 'Specifies the phone no. of the contact person at the address that products on the sales document will be shipped to.';
                    }
                    field("Customer Order No."; Rec."Customer Order No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Customer P.O. Number';
                        ToolTip = 'Specifies the customer P.O. number for this sales order.';
                    }
                }

                group(AdvacoShipData)
                {
                    Caption = 'ADVACO';

                    field(Shipper; Shipper)
                    {
                        ApplicationArea = All;
                        Caption = 'Shippers Initals';
                        TableRelation = Resource."No." WHERE(Type = CONST(Person));
                        ToolTip = 'Specifies the initials of employee shipping order.';
                    }
                    field(ShippingTime; ShippingTime)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Time';
                        ToolTip = 'Specifies the duration of shipping process.';
                    }
                    field(ShippingWeight; ShippingWeight)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment Weight';
                        ToolTip = 'Specifies the hipping weight.';
                    }
                    field(ContainerQuantity; ContainerQuantity)
                    {
                        ApplicationArea = All;
                        Caption = 'Total Containers';
                        ToolTip = 'Specifies the total number of containers for this shipment.';
                    }
                    field(ContainerType; ContainerType)
                    {
                        ApplicationArea = All;
                        Caption = 'Container Type';
                        ToolTip = 'Specifies the container type for this shipment.';
                    }
                    field(LabelsToPrint; LabelsToPrint)
                    {
                        ApplicationArea = All;
                        Caption = 'Label Quantity';
                        ToolTip = 'Specifies how many labels will be printed.';
                    }
                }

                group(ShipmentMethod)
                {
                    Caption = 'Shipment Method';
                    field(ShipmentMethodCode; Rec."Shipment Method Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Code';
                        ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                    }
                    field(ShippingAgentCode; Rec."Shipping Agent Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Agent';
                        ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    }
                    field(ShippingAgentServiceCode; Rec."Shipping Agent Service Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Agent Service';
                        ToolTip = 'Specifies the code that represents the default shipping agent service you are using for this sales order.';
                    }
                    field(ShippingAccount; Rec."Shipping Account")
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Account';
                    }
                    field(ShippingCharge; Rec."Shipping Charge")
                    {
                        Caption = 'Shipping Charge';
                        ApplicationArea = All;
                        ToolTip = 'Specifies type of shipping charge.';

                    }
                    field(PackageTrackingNo; Rec."Package Tracking No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Package Tracking No.';
                        ToolTip = 'Specifies the shipping agent''s package number.';
                    }
                    field("Bill of Lading"; Rec."Bill of Lading")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(ShipStatus; Rec.Status)
                    {
                        ApplicationArea = Suite;
                        Importance = Additional;
                        QuickEntry = false;
                        ToolTip = 'Specifies whether the document is open, waiting to be approved, has been invoiced for prepayment, or has been released to the next stage of processing.';
                    }
                }

            }
        }
        addafter("Tax Area Code")
        {
            field("Tax Exemption No."; Rec."Tax Exemption No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Tax Exemption Certificat No.';
            }
            field("Exempt Organization"; Rec."Exempt Organization")
            {
                Caption = 'Exempt Organization No.';
                ApplicationArea = All;
                ToolTip = 'Specifies exempt orgnization no.';
            }
        }
        addbefore("Package Tracking No.")
        {
            field("Shipping Charge"; Rec."Shipping Charge")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies type of shipping charge.';
            }
            field("Shipping Account"; Rec."Shipping Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies shipping account for current shipping.';
            }
        }
        addafter("Package Tracking No.")
        {
            field("Work Order No."; Rec."Work Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies which Work Order is linked to this Sales Order.';
            }
            field(BillOfLading; Rec."Bill of Lading")
            {
                ApplicationArea = All;
                ToolTip = 'Bill of Lading No. for current shipment.';
                Editable = false;
            }
        }
        addbefore("Shipment Date")
        {
            field("Shipment Request Date"; Rec."Shipment Request Date")
            {
                Caption = 'Date Required';
                ApplicationArea = All;
                ToolTip = 'Specifies the date when shipment is requested.';
            }
            field(YourReference; Rec."Your Reference")
            {
                Caption = 'Customer P.O. Number';
                ApplicationArea = All;
                ToolTip = 'Specifies the customer''s reference. The content will be printed on sales documents.';
            }
            field(CustomerOrderNo; Rec."Customer Order No.")
            {
                Caption = 'Customer Order No.';
                ApplicationArea = All;
                ToolTip = 'Specifies customer order (Advaco).';
            }

        }
        Addafter("Shipment Date")
        {
            field("Advaco Shipping Advice"; Rec."Advaco Shipping Advice")
            {
                Caption = 'Advaco Shipping Advice';
                ApplicationArea = All;
                ToolTip = 'Specifies partial or complete (Advaco).';

            }
        }
        addbefore("Shipping and Billing")
        {
            group(Payment)
            {
                Visible = lSalesGroup or lAccGroup;

                group(CreditCardData)
                {
                    ShowCaption = false;

                    field(PaymentTermsCode; Rec."Payment Terms Code")
                    {
                        Caption = 'Payment Terms Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Payment Terms Code.';
                        Importance = Promoted;

                        trigger OnValidate()
                        var
                            GLSetup: Record "General Ledger Setup";
                        begin
                            if Rec."Payment Terms Code" = 'CC' then begin
                                GLSetup.Get;
                                if lAccGroup then
                                    if GLSetup."Credit Card Payment Code" = Rec."Payment Terms Code" then begin
                                        if not CCFeeCode.IsCCFee(Rec) then
                                            CCFeeInsertVisible := true;
                                    end;
                            end else
                                CCFeeInsertVisible := false;
                        end;
                    }
                    field("Card Type"; Rec."Card Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies type of Credit Card: AMEX,MC,Discover,VISA.';
                    }
                    field("Credit Card No."; Rec."Credit Card No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Credit Card Acct. No.';
                    }
                    field("Credit Card Exp."; Rec."Credit Card Exp.")
                    {
                        Caption = 'Credit Card Exp. Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Card expiration date.';
                    }
                    field("Credit Card SC"; Rec."Credit Card SC")
                    {
                        Caption = 'Credit Card Security Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Credit Card security code.';
                    }
                    field("Approval Code"; Rec."Approval Code")
                    {
                        Caption = 'Approval Code';
                        Visible = lAccGroup;
                        ApplicationArea = all;
                        Tooltip = 'Specified approval code';
                    }
                }
                group(CreditCardAddress)
                {
                    ShowCaption = false;

                    field("Name on Card"; Rec."Name on Card")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Name on card.';
                    }
                    field(BillToAddress1; Rec."Bill-to Address")
                    {
                        ApplicationArea = All;
                        Caption = 'Bill-to Address';
                        ToolTip = 'Specifies address on Card account.';
                    }
                    field(BillToAddress2; Rec."Bill-to Address_2")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                    field(BillToAddress3; Rec."Bill-to Address_3")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                    field(BillToAddress4; Rec."Bill-to Address_4")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                }
                group(CreditCardComments)
                {
                    ShowCaption = false;

                    field("CC Comments 1"; Rec."CC Comments 1")
                    {
                        Caption = 'Credit Card Comments';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Credit Card comments.';
                    }
                    field("CC Comments 2"; Rec."CC Comments 2")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                    field("CC Comments 3"; Rec."CC Comments 3")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                }
            }
        }
        addafter(Control1900201301)
        {
            group(ThirdParty)
            {
                Caption = 'Third Party';
                Visible = lSalesGroup;

                field("Third Party Name"; Rec."Third Party Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies Third Party Name';
                }
                field("Third Party Address"; Rec."Third Party Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party Street Address';
                }
                field("Third Party City"; Rec."Third Party City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party City';
                }
                field("Third Party State"; Rec."Third Party State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party State';
                }
                field("Third Party Zip"; Rec."Third Party Zip")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party Postal Code.';
                }
            }
        }
    }

    actions
    {
        modify("O&rder")
        {
            Visible = not lShipGroup;
        }
        modify(ActionGroupCRM)
        {
            Visible = not lShipGroup;
        }
        modify(Documents)
        {
            Visible = not lShipGroup;
        }
        modify(Warehouse)
        {
            Visible = not lShipGroup;
        }
        modify(Prepayment)
        {
            Visible = not lShipGroup;
        }
        modify(History)
        {
            Visible = not lShipGroup;
        }
        modify(Approval)
        {
            Visible = not lShipGroup;
        }
        modify("F&unctions")
        {
            Visible = not lShipGroup;
        }
        modify(Plan)
        {
            Visible = not lShipGroup;
        }
        modify("Request Approval")
        {
            Visible = not lShipGroup;
        }
        modify("P&osting")
        {
            Visible = not lShipGroup;
        }
        modify("&Print")
        {
            Visible = not lShipGroup;
        }
        modify("&Order Confirmation")
        {
            Visible = not lShipGroup;
        }
        modify("Drop Shipment Status")
        {
            Visible = not lShipGroup;
        }
        modify("Report Picking List by Order")
        {
            Visible = not lShipGroup;
        }
        modify("Work Order")
        {
            Visible = false;
        }
        modify("Pick Instruction")
        {
            Visible = false;
        }
        addbefore(Dimensions)
        {
            action("Credit Card Fee Insert")
            {
                ApplicationArea = All;
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
                        /// part function call
                        CurrPage.SalesLines.Page.DeltaUpdateTotals();
                        CurrPage.SalesLines.Page.Update();
                        CurrPage.Update();
                    end;
                    // 05/02/13 End
                end;
            }
        }
        addbefore("Work Order")
        {
            action(PrintEnvelope)
            {
                Caption = 'Envelope';
                Image = PrintDocument;
                ApplicationArea = All;
                ToolTip = 'Print Sales Order Envelope.';

                trigger OnAction()
                begin
                    SO := Rec;
                    SO.SETFILTER("No.", Rec."No.");
                    SO.SETRECFILTER;
                    REPORT.RUNMODAL(50001, TRUE, FALSE, SO);
                end;
            }
            action(PrintSalesOrderConfirmation)
            {
                Caption = 'Confirmation';
                Image = PrintDocument;
                ApplicationArea = All;
                ToolTip = 'Print Sales Order Confirmation.';

                trigger OnAction()
                begin
                    SO := Rec;
                    SO.SETFILTER("No.", Rec."No.");
                    SO.SETRECFILTER;
                    REPORT.RUNMODAL(50022, TRUE, FALSE, SO);
                end;
            }
            action(PrintPickList)
            {
                Caption = 'Pick List';
                Image = PrintDocument;
                ApplicationArea = All;
                ToolTip = 'Print Sales Order Pick Ticket.';

                trigger OnAction()
                begin
                    SO := Rec;
                    SO.SETFILTER("No.", Rec."No.");
                    SO.SETRECFILTER;
                    REPORT.RUNMODAL(50020, TRUE, FALSE, SO);
                end;
            }
        }
        addafter(Action21)
        {
            group(Shipping)
            {
                Visible = lShipGroup;

                action(PrintBOL_Labels)
                {
                    ApplicationArea = All;
                    Caption = 'Print &BOL and Labels';
                    Image = PrintAttachment;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+B';
                    ToolTip = 'Print Bill of Lading and Address Labels.';

                    trigger OnAction()
                    var
                        Ship: Codeunit Shipping;

                    begin
                        if Rec."Your Reference" = '' then
                            Error('Customer PO Number must be Entered');

                        if Shipper = '' then
                            Error('Shippers Initials must be Entered');

                        if ShippingTime = 0 then
                            Error('Shipping Time must be Entered');

                        if ShippingWeight = 0 then
                            Error('Shipment Weight must be Entered');

                        if ContainerQuantity = 0 then
                            Error('Total Containers must be Entered');

                        if ContainerType = ContainerType::" " then
                            Error('Container Type must be Entered');

                        if Rec."Shipping Agent Code" = '' then
                            Error('Shipping Agent Code must be Entered');

                        if Rec."Shipment Method Code" = '' then
                            Error('Shipment Method Code must be Entered');

                        if Rec."Shipping Charge" = Rec."Shipping Charge"::" " then
                            Error('Shipping Charge must be Entered');

                        QtyOil := 0;
                        SalesSetup2.Get;

                        //99999
                        // Check for Serial No for Pumps
                        SalesLine2.SetRange("Document Type", Rec."Document Type");
                        SalesLine2.SetRange("Document No.", Rec."No.");
                        SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                        /*99999
                        IF SalesLine2.FIND('-') THEN BEGIN
                          REPEAT
                            Main := 0;
                            IF Item2.GET(SalesLine2."No.") THEN BEGIN
                              IF Item2."Costing Method" = Item."Costing Method" :: Specific THEN BEGIN
                                IF SalesLine2."Serial No." = '' THEN
                                  ERROR('Item %1 Serial No. is blank, so the Item can not be shipped',SalesLine2."No.");
                                IF SalesLine2."Serial No." <> '' THEN BEGIN
                                  ItemLedgerSerial.SETCURRENTKEY("Item No.",Open,"Serial No.","Location Code");
                                  ItemLedgerSerial.SETRANGE("Item No.",Item2."No.");
                                  ItemLedgerSerial.SETRANGE(ItemLedgerSerial.Open,TRUE);
                                  ItemLedgerSerial.SETRANGE("Serial No.",SalesLine2."Serial No.");
                                  ItemLedgerSerial.SETRANGE("Location Code",'MAIN');
                                  IF ItemLedgerSerial.FIND('-') THEN BEGIN
                                    OK := TRUE;
                                  END ELSE BEGIN
                                    ERROR('Item %1 Serial No. %2 hasn''t been received, Contact Purchasing',Item2."No.",SalesLine2."Serial No.");
                                  END;
                                END;
                              END ELSE BEGIN
                                { -- ADV 11/30/15
                                MainInventoryQty.SETCURRENTKEY("Item No.","Location Code", "Variant Code","Document No.");
                                MainInventoryQty.SETRANGE("Item No.",Item2."No.");
                                MainInventoryQty.SETRANGE("Location Code",'Main');
                                IF MainInventoryQty.FIND('-') THEN BEGIN
                                  REPEAT
                                    Main := Main + MainInventoryQty.Quantity;
                                  UNTIL MainInventoryQty.NEXT = 0;
                                END;
                                }
                                Item2."Location Filter" := 'Main';
                                Item2.CALCFIELDS("Quantity on Hand");

                                //IF SalesLine2."Qty. to Ship" > Main THEN
                                IF SalesLine2."Qty. to Ship" > Item2."Quantity on Hand" THEN
                                  ERROR('Item %1 only has %2 in Inventory, Contact Purchasing',Item2."No.",Main);
                              END;
                            END;
                          UNTIL SalesLine2.NEXT = 0;
                        END;

                        SalesLine2.RESET;

                        // Checks Serial No for Work Orders Sold on Sales Orders
                        IF "Work Order No." <> '' THEN BEGIN
                          SalesLine2.SETRANGE("Document Type","Document Type");
                          SalesLine2.SETRANGE("Document No.","No.");
                          IF SalesLine2.FIND('-') THEN BEGIN
                            IF SalesLine2."Serial No." = '' THEN
                              ERROR('Item %1 Serial No. is blank, so the Item can not be shipped',SalesLine2."Cross Reference Item");
                          END;
                        END;
                        99999*/

                        // Check Qty to Ship against Order Quantiy and Shipped Qty
                        SalesLine2.Reset;
                        SalesLine2.SetRange("Document Type", Rec."Document Type");
                        SalesLine2.SetRange("Document No.", Rec."No.");
                        SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                        if SalesLine2.Find('-') then begin
                            repeat
                                if Item2.Get(SalesLine2."No.") then begin
                                    if SalesLine2."Qty. to Ship" + SalesLine2."Shipped Qty." > SalesLine2.Quantity then begin
                                        QtyOver := 0;
                                        QtyOver := SalesLine2."Shipped Qty." + SalesLine2."Qty. to Ship" - SalesLine2.Quantity;
                                        Error('Item %1 Current Qty. to Ship and Shipped Qty. exceeds the Order Quantity by %2, Contact Sales or reduce Shipment Qty'
                                             , Item2."No.", QtyOver);
                                    end;

                                end;
                            until SalesLine2.Next = 0;
                        end;

                        // Check for UPS Shipping Surcharge Items
                        if Rec."Shipping Agent Code" = 'UPS' then begin
                            //Removed "Pre-Paid" 11/1/04 per Darleen
                            if (Rec."Shipping Charge" = Rec."Shipping Charge"::"Pre-Paid & Add") then begin
                                SalesLine2.Reset;
                                SalesLine2.SetRange("Document Type", Rec."Document Type");
                                SalesLine2.SetRange("Document No.", Rec."No.");
                                SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                                if SalesLine2.Find('-') then begin
                                    repeat
                                        if Item2.Get(SalesLine2."No.") then begin
                                            if Item2."UPS Shipping Surcharge" = true then begin
                                                QtyOil := QtyOil + SalesLine2."Qty. to Ship"
                                            end;
                                        end;
                                    until SalesLine2.Next = 0;
                                end;
                            end;
                        end;

                        // Update Shipped Qty
                        SalesLine2.Reset;
                        SalesLine2.SetRange("Document Type", Rec."Document Type");
                        SalesLine2.SetRange("Document No.", Rec."No.");
                        SalesLine2.SetFilter("Qty. to Ship", '<>%1', 0);
                        if SalesLine2.Find('-') then begin
                            repeat
                                if Item2.Get(SalesLine2."No.") then begin
                                    SalesLine2."Shipped Qty." := SalesLine2."Qty. to Ship" + SalesLine2."Shipped Qty.";
                                    SalesLine2.Modify;
                                end;
                            until SalesLine2.Next = 0;
                        end;

                        // Find the last Sales Line
                        SalesLine3.SetRange("Document Type", Rec."Document Type");
                        SalesLine3.SetRange("Document No.", Rec."No.");
                        if SalesLine3.Find('+') then
                            SalesLineNo := SalesLine3."Line No.";

                        //UPS HANDLING
                        if Rec."Shipping Agent Code" = 'UPS' then begin
                            //Removed "Pre-Paid" 11/1/04 per Darleen
                            if (Rec."Shipping Charge" = Rec."Shipping Charge"::"Pre-Paid & Add") then begin
                                LineLoop;
                                SalesLine3.Type := SalesLine3.Type::"G/L Account";
                                SalesLine3.Validate("No.", '311');   //Sales Account
                                SalesLine3.Validate(Quantity, 1);
                                SalesLine3.Description := 'Handling Charge';
                                SalesLine3.Validate("Unit Price", SalesSetup2."UPS Handling Charge");
                                SalesLine3."Commission Calculated" := false;
                                SalesLine3.Insert;
                            end;
                        end;

                        //UPS SHIPPING
                        if Rec."Shipping Agent Code" = 'UPS' then begin
                            if (Rec."Shipping Charge" = Rec."Shipping Charge"::"Pre-Paid & Add") then begin
                                LineLoop;
                                SalesLine3.Type := SalesLine3.Type::"G/L Account";
                                SalesLine3.Validate("No.", '312');   //Sales Account
                                SalesLine3.Validate(Quantity, 1);
                                SalesLine3.Description := 'UPS Shipping Charge';
                                SalesLine3."Commission Calculated" := false;
                                SalesLine3.Insert;
                            end;
                        end;

                        //UPS Oil SHIPPING
                        if QtyOil > 0 then begin
                            LineLoop;
                            SalesLine3.Type := SalesLine3.Type::"G/L Account";
                            SalesLine3.Validate("No.", '312');   //Sales Account
                            SalesLine3.Validate(SalesLine3."Unit Price", SalesSetup2."UPS Shipping Surcharge");
                            SalesLine3.Validate(Quantity, QtyOil);
                            SalesLine3.Description := 'UPS Container Surcharge';
                            SalesLine3."Commission Calculated" := false;
                            SalesLine3.Insert;
                        end;

                        //>> Credit Card Approval Code
                        if Rec."Approval Code" <> '' then begin
                            LineLoop;
                            SalesLine3.Type := SalesLine3.Type::" ";
                            SalesLine3.Validate("No.", '');
                            SalesLine3.Description := 'Approval Code No.' + ' ' + Rec."Approval Code";
                            SalesLine3."Commission Calculated" := false;
                            SalesLine3.Insert;
                        end;

                        if BOL.Find('+') then
                            BLInteger := BOL."Bill of Lading" + 1
                        else
                            BLInteger := 100000;

                        WOD.SetCurrentKey(WOD."Work Order No.");
                        WOD.SetRange("Work Order No.", Rec."Work Order No.");
                        if WOD.Find('-') then begin
                            if WOD."Work Order No." <> '' then begin
                                Rec."Shortcut Dimension 2 Code" := 'WO';
                                Rec.Modify;
                                CreateLines;
                                CreateShippingLine;
                                Reservation;  // Commit
                                UpdateWOD;
                                UpdateWOS;
                                UpdateParts;
                            end;
                        end;


                        BOL2.Init;
                        BOL2."Bill of Lading" := BLInteger;
                        BOL2."Order No." := Rec."No.";
                        BOL2."PO No." := Rec."Your Reference";
                        BOL2.Customer := Rec."Sell-to Customer No.";
                        BOL2."Ship To Name" := Rec."Ship-to Name";
                        BOL2."Ship To Address" := Rec."Ship-to Address";
                        BOL2."Ship To Address2" := Rec."Ship-to Address 2";
                        BOL2."Ship To City" := Rec."Ship-to City";
                        BOL2."Ship To State" := Rec."Ship-to County";
                        BOL2."Ship To Zip Code" := Rec."Ship-to Post Code";
                        BOL2.Attention := Rec."Ship-to Contact";
                        BOL2."Phone No." := Rec."Phone No.";
                        BOL2."Shipping Weight" := ShippingWeight;
                        BOL2."Container Quantity" := ContainerQuantity;
                        BOL2."Container Type" := Ship.ContainerToBOLContainer(ContainerType);
                        BOL2.Employee := Shipper;
                        BOL2."Shipment Date" := Today;
                        BOL2.Carrier := Rec."Shipping Agent Code";
                        BOL2."Shipping Method" := Rec."Shipment Method Code";
                        BOL2."Shipping Charge" := Ship.ShipChrgToBOLShipChrg(Rec."Shipping Charge");
                        BOL2."Shipping Account" := Rec."Shipping Account";
                        BOL2."Label Quantity" := LabelsToPrint;
                        BOL2.Insert;

                        Rec."Bill of Lading" := BOL2."Bill of Lading";
                        Rec.Modify;
                        Commit;

                        if not Confirm('Is Bill of Lading and Labels loaded in Printers?', false) then begin
                            if not Confirm('Last Chance, Is Bill of Lading and Labels loaded in Printers?', false) then begin
                                OK := true;
                            end else begin
                                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                                REPORT.RunModal(50017, false, false, BOL2);               // BOL Document
                                BOL2."BOL Printed" := true;
                                BOL2.Modify;
                                LabelCount := LabelsToPrint;
                                repeat
                                begin
                                    LabelCount := LabelCount - 1;
                                    REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                                end;
                                until LabelCount = 0;
                                BOL2."Label Printed" := true;
                                BOL2.Modify;
                                ConfirmLabels;
                            end;
                        end else begin
                            BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                            REPORT.RunModal(50017, false, false, BOL2);               // BOL Document
                            BOL2."BOL Printed" := true;
                            BOL2.Modify;
                            LabelCount := LabelsToPrint;
                            if LabelCount > 0 then begin
                                repeat
                                begin
                                    LabelCount := LabelCount - 1;
                                    REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                                end;
                                until LabelCount = 0;
                                BOL2."Label Printed" := true;
                            end else begin
                                BOL2."Label Printed" := false;
                            end;
                            BOL2.Modify;
                            ConfirmLabels;
                        end;
                        //99999

                        CurrPage.Close;

                    end;

                }
                action("Print_Shipping")
                {
                    ApplicationArea = All;
                    Caption = '&Print';

                    trigger OnAction()
                    begin
                        DocPrintShp.PrintSalesHeader(Rec);
                    end;
                }
            }
        }

    }

    var
        GPS: Record "General Posting Setup";
        LabelCount: Integer;
        OK: Boolean;
        BOL: Record BillofLading;
        BOL2: Record BillofLading;
        lAccGroup: Boolean;
        lSalesGroup: Boolean;
        lShipGroup: Boolean;
        Shipper: Code[3];
        SerialNo: Code[20];
        ShippingTime: Decimal;
        ShippingWeight: Decimal;
        ContainerQuantity: Integer;
        ContainerType: Enum Container;
        LabelsToPrint: Integer;
        SalesLine2: Record "Sales Line";
        SalesLine3: Record "Sales Line";
        SalesLineNo: Integer;
        Item: Record Item;
        Item2: Record Item;
        QtyOil: Integer;
        SalesSetup2: Record "Sales & Receivables Setup";
        QtyOver: Decimal;
        BLInteger: Integer;
        WOD: Record WorkOrderDetail;
        WOP: Record Parts;
        WOS: Record Status;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        ReturnInventoryQty: Decimal;
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        PartsComplete: Record Parts;
        DocPrintShp: Codeunit "Document-Print";
        SysFunctions: Codeunit systemFunctionalLibrary;
        Member: Record "User Group Member";
        txtAnswer: Text[120];
        AcctCode: Label 'ADVACO ACCOUNTING';
        SalesCode: Label 'ADVACO SALES';
        ShipCode: Label 'ADVACO SHIPPING';
        Permiss: Label 'SUPER';
        ItemLedgEntryType: Enum "Item Ledger Entry Type";
        SO: Record "Sales Header";
        CCFeeInsertVisible: Boolean;
        CCFeeCode: Codeunit CreditCardFeeFunctions;

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
        GLSetup: Record "General Ledger Setup";

    begin
        // initialize group flag
        lAccGroup := false;
        lSalesGroup := false;
        lShipGroup := false;

        ///--! Permission level check code. 
        User.Get(UserSecurityId);
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");
        //Member.SetRange("User Security ID", User."User Security ID");

        lAccGroup := SysFunctions.getIfSingleGroupId(AcctCode, txtAnswer);
        if not lAccGroup then
            lAccGroup := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);
        if not lSalesGroup then  //ICE RSK 12/3/20 change from laccgroup to lsalesgroup 
            lSalesGroup := SysFunctions.getIfSingleGroupId(SalesCode, txtAnswer);
        if not (lAccGroup or lSalesGroup) then
            lShipGroup := SysFunctions.getIfSingleGroupId(ShipCode, txtAnswer);

        if not (lAccGroup or lSalesGroup or lShipGroup) then begin
            Error('You must be member of Accounting, Sales or Shipping to open this page.');
        end;

        //Insert Action for CC Fee
        // 05/02/13 Start
        GLSetup.Get;
        // Make control visible if CC pay and no fee line
        CCFeeInsertVisible := false;
        if lAccGroup then
            if GLSetup."Credit Card Payment Code" = Rec."Payment Terms Code" then begin
                if not CCFeeCode.IsCCFee(Rec) then
                    CCFeeInsertVisible := true;
            end;

        // 05/02/13 End
        //See if user is SUPER
        //user.setrange(user."User Name", userid);   
        ///--! 
        // Add the role for Accounting! 
        /*IF User.FindFirst() THEN begin 

            AccessControl.setrange("User Security ID",  User."User Security ID");
            IF AccessControl.find('-') THEN begin
                repeat
                    ///--! To add what role is for accounting?? 
                    //if (AccessControl."Role ID" = 'SUPER') or (AccessControl."Role ID" = 'ADV-ACCT') THEN                
                    if AccessControl."Role ID" = 'SUPER' THEN
                        OK := FALSE;
                until AccessControl.next = 0;

            end;
        END;
        */

        //if Ok then
        //    ERROR('This Customer Card is for Accounting Only')
        //else
        //   lAccGroup := true;
        //lAccGroup := false;
        //lSalesGroup := true;
        //lShipGroup := true;
    end;

    procedure UpdateAllowed() Response: Boolean
    begin
        if CurrPage.Editable = false then begin
            Message('Unable to execute this function while in view only mode.');
            exit(false);
        end else
            exit(true);
    end;

    procedure ConfirmLabels()
    begin
        if not Confirm('Did Bill of Lading & labels print correctly?', false) then begin
            BOL2."BOL Printed" := false;
            BOL2."Label Printed" := false;
            BOL2.Modify;
            if not Confirm('Do you want to reprint?', false) then begin
                OK := true;
            end else begin
                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                REPORT.RunModal(50017, false, false, BOL2);               // BOL Document
                BOL2."BOL Printed" := true;
                BOL2.Modify;
                LabelCount := LabelsToPrint;
                if LabelCount > 0 then begin
                    repeat
                    begin
                        LabelCount := LabelCount - 1;
                        REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                    end;
                    until LabelCount = 0;
                    BOL2."Label Printed" := true;
                end else begin
                    BOL2."Label Printed" := false;
                end;
                BOL2.Modify;
                ConfirmLabels;
            end;
        end;
    end;

    procedure CreateLines()
    begin
        //>>Create Resources Line
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Resource);
        if WOP.Find('-') then begin
            repeat
                LineLoop;
                SalesLine3.Type := SalesLine3.Type::Resource;
                SalesLine3.Validate("No.", WOP."Part No.");
                SalesLine3.Validate(Quantity, WOP."Quoted Quantity");
                SalesLine3.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine3.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                SalesLine3."Commission Calculated" := true;
                SalesLine3.Insert;
            until WOP.Next = 0;
        end;

        //>>Create Parts Lines
        WOP.Reset;
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", WOD."Work Order No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
        WOP.SetFilter(WOP."Pulled Quantity", '>0');
        if WOP.Find('-') then begin
            repeat
                if Item.Get(WOP."Part No.") then begin
                    WOP.CalcFields(WOP."In-Process Quantity");
                    ///--! SN
                    // Serial No. must be adapted to new method
                    if Item."Costing Method" = Item."Costing Method"::Specific then begin
                        SerialNo := WOP."Serial No."
                    end else begin
                        SerialNo := ''
                    end;
                end;

                ReturnInventory;
                LineLoop;
                SalesLine3.Type := SalesLine3.Type::Item;
                SalesLine3.Validate("No.", WOP."Part No.");

                ///--! Set Reservation Entry for SerialNo in Sales Line
                //IF Item."Costing Method" = Item."Costing Method"::Specific THEN BEGIN
                //    SalesLine3."Serial No." := SerialNo
                //END;

                SalesLine3.Validate(Reserve, SalesLine3.Reserve::Always);
                SalesLine3.Validate(Quantity, WOP."Pulled Quantity");
                SalesLine3.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine3.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                if SalesLine3."VAT Prod. Posting Group" = '' then
                    SalesLine3."VAT Prod. Posting Group" := 'DEFAULT';
                SalesLine3."Commission Calculated" := true;
                SalesLine3.Insert;
                WOP."In-Process Quantity" := 0;
                WOP.Modify;
            until WOP.Next = 0;
        end;
    end;

    procedure LineLoop()
    begin
        Clear(SalesLine3);
        SalesLineNo := SalesLineNo + 10000;
        SalesLine3.Init;
        SalesLine3."Document Type" := SalesLine3."Document Type"::Order;
        SalesLine3."Line No." := SalesLineNo;
        SalesLine3.Validate(SalesLine3."Document No.", Rec."No.");
    end;

    procedure GPSLoopNoGLEntry()
    begin
        // ,SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO
        if (WOD."Income Code".AsInteger() = 1) then begin
            GPS.Get('', 'REPAIR');
        end;
        if (WOD."Income Code".AsInteger() = 2) then begin
            GPS.Get('', 'PP SALES');
        end;
        if (WOD."Income Code".AsInteger() = 3) then begin
            GPS.Get('', 'TURBO');
        end;
        if (WOD."Income Code".AsInteger() = 4) then begin
            GPS.Get('', 'ELECTRONIC');
        end;
        if (WOD."Income Code".AsInteger() = 5) then begin
            GPS.Get('', 'DRY PUMP');
        end;
        if (WOD."Income Code".AsInteger() = 6) then begin
            GPS.Get('', 'CRYO');
        end;
    end;

    procedure ReturnInventory()
    begin
        ReturnInventoryQty := WOP."Pulled Quantity";
        if ReturnInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
                ItemJournalLine."Document No." := Rec."Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := Rec."Work Order No." + ' ' + 'SHIP RETURN PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := ReturnInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'MAIN';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                ///--! SN
                // Serial No. must be adapted to new method
                /*
                if SerialNo <> '' then begin
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;

                end;
                */
                IF SerialNo <> '' THEN BEGIN
                    WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                END;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure UpdateWOD()
    begin
        WOD.Carrier := Rec."Shipping Agent Code";
        WOD."Shipping Method" := Rec."Shipment Method Code";
        WOD."Shipping Charge" := Rec."Shipping Charge";
        WOD."Shipping Account" := Rec."Shipping Account";
        WOD."Ship Date" := WorkDate;
        WOD.Complete := true;
        WOD."Bill of Lading" := BLInteger;
        WOD.Modify;
    end;

    procedure UpdateWOS()
    begin
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", WOD."Work Order No.");
        if WOS.Find('+') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS."Regular Hours" := ShippingTime;
            WOS.Employee := Shipper;
            WOS.Modify;
        end;
    end;

    procedure UpdateParts()
    begin
        PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
        PartsComplete.SetRange(PartsComplete."Work Order No.", WOD."Work Order No.");
        if PartsComplete.Find('-') then begin
            repeat
                PartsComplete.Complete := true;
                PartsComplete.Modify;
            until PartsComplete.Next = 0;
        end;
    end;

    procedure CreateShippingLine()
    begin
        //>> Shippment Information
        LineLoop;
        SalesLine3.Type := SalesLine3.Type::" ";
        SalesLine3.Description := 'Total Shipment Weight is ' + Format(ShippingWeight) + ' lbs';
        SalesLine3.Insert;
    end;

    procedure Reservation()
    begin
        // Reservation Entry
        Commit;
        SalesLine3.Reset;
        SalesLine3.SetRange("Document Type", Rec."Document Type");
        SalesLine3.SetRange("Document No.", Rec."No.");
        if SalesLine3.Find('-') then begin
            repeat
                if (SalesLine3.Reserve = SalesLine3.Reserve::Always) and (SalesLine3."Outstanding Qty. (Base)" <> 0) then
                    SalesLine3.AutoReserve();
            until
              SalesLine3.Next = 0;
        end;
    end;
}