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
            Editable = lAccGroup;
        }
        modify("Sell-to Customer No.")
        {
            Editable = lAccGroup;
        }
        modify("Sell-to Customer Name")
        {
            Editable = lAccGroup;
        }
        modify("Sell-to")
        {
            Editable = lAccGroup;
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
            field(Rep; Rep)
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

                    field("ShipNo."; "No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field(ShipToName; "Ship-to Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Name';
                        ToolTip = 'Specifies the name that products on the sales document will be shipped to.';
                    }
                    field(ShipShipToAddr; "Ship-to Address")
                    {
                        ApplicationArea = All;
                        Caption = 'Address';
                        ToolTip = 'Specifies the address that products on the sales document will be shipped to.';
                    }
                    field(ShipShipToAddr2; "Ship-to Address 2")
                    {
                        ApplicationArea = All;
                        Caption = 'Address 2';
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(ShipShipToCity; "Ship-to City")
                    {
                        ApplicationArea = All;
                        Caption = 'City';
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(CntyControl297)
                    {
                        ShowCaption = false;
                        field(ShipShipToCounty; "Ship-to County")
                        {
                            ApplicationArea = All;
                            Caption = 'County';
                            ToolTip = 'Specifies the state, province or county of the address.';
                        }
                    }
                    field(ShipShipToPostCode; "Ship-to Post Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Post Code';
                        ToolTip = 'Specifies the postal code.';
                    }
                    field(ShipShpToCnty_RegCode; "Ship-to Country/Region Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Country/Region';
                        ToolTip = 'Specifies the customer''s country/region.';

                        trigger OnValidate()
                        var
                            FormatAddress: Codeunit "Format Address";
                        begin
                            FormatAddress.UseCounty("Ship-to Country/Region Code");
                        end;
                    }
                    field(ShipShpToUPSZone; "Ship-to UPS Zone")
                    {
                        ApplicationArea = All;
                        Caption = 'UPS Zone';
                        ToolTip = 'Specifies a UPS Zone code for this document if UPS is used for shipments.';
                    }
                    field(ShipToContact; "Ship-to Contact")
                    {
                        ApplicationArea = All;
                        Caption = 'Contact';
                        ToolTip = 'Specifies the name of the contact person at the address that products on the sales document will be shipped to.';
                    }
                    field("Phone No."; "Phone No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Phone No.';
                        ToolTip = 'Specifies the phone no. of the contact person at the address that products on the sales document will be shipped to.';
                    }
                    field("Customer Order No."; "Customer Order No.")
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
                    field(ShipmentMethodCode; "Shipment Method Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Code';
                        ToolTip = 'Specifies how items on the sales document are shipped to the customer.';
                    }
                    field(ShippingAgentCode; "Shipping Agent Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Agent';
                        ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    }
                    field(ShippingAgentServiceCode; "Shipping Agent Service Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Agent Service';
                        ToolTip = 'Specifies the code that represents the default shipping agent service you are using for this sales order.';
                    }
                    field(ShippingAccount; "Shipping Account")
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Account';
                    }
                    field(ShippingCharge; "Shipping Charge")
                    {
                        Caption = 'Shipping Charge';
                        ApplicationArea = All;
                        ToolTip = 'Specifies type of shipping charge.';

                    }
                    field(PackageTrackingNo; "Package Tracking No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Package Tracking No.';
                        ToolTip = 'Specifies the shipping agent''s package number.';
                    }
                    field("Bill of Lading"; "Bill of Lading")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(ShipStatus; Status)
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
            field("Tax Exemption No."; "Tax Exemption No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Tax Exemption Certificat No.';
            }
            field("Exempt Organization"; "Exempt Organization")
            {
                Caption = 'Exempt Organization No.';
                ApplicationArea = All;
                ToolTip = 'Specifies exempt orgnization no.';
            }
        }
        addbefore("Package Tracking No.")
        {
            field("Shipping Charge"; "Shipping Charge")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies type of shipping charge.';
            }
            field("Shipping Account"; "Shipping Account")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies shipping account for current shipping.';
            }
        }
        addafter("Package Tracking No.")
        {
            field("Work Order No."; "Work Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies which Work Order is linked to this Sales Order.';
            }
            field(BillOfLading; "Bill of Lading")
            {
                ApplicationArea = All;
                ToolTip = 'Bill of Lading No. for current shipment.';
                Editable = false;
            }
        }
        addbefore("Shipment Date")
        {
            field("Shipment Request Date"; "Shipment Request Date")
            {
                Caption = 'Date Required';
                ApplicationArea = All;
                ToolTip = 'Specifies the date when shipment is requested.';
            }
            field(YourReference; "Your Reference")
            {
                Caption = 'Customer P.O. Number';
                ApplicationArea = All;
                ToolTip = 'Specifies the customer''s reference. The content will be printed on sales documents.';
            }
            field(CustomerOrderNo; "Customer Order No.")
            {
                Caption = 'Customer Order No.';
                ApplicationArea = All;
                ToolTip = 'Specifies customer order (Advaco).';
            }

        }
        addbefore("Shipping and Billing")
        {
            group(Payment)
            {
                Visible = lSalesGroup;

                group(CreditCardData)
                {
                    ShowCaption = false;

                    field(PaymentTermsCode; "Payment Terms Code")
                    {
                        Caption = 'Payment Terms Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Payment Terms Code.';
                        Importance = Promoted;
                    }
                    field("Card Type"; "Card Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies type of Credit Card: AMEX,MC,Discover,VISA.';
                    }
                    field("Credit Card No."; "Credit Card No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Credit Card Acct. No.';
                    }
                    field("Credit Card Exp."; "Credit Card Exp.")
                    {
                        Caption = 'Credit Card Exp. Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Card expiration date.';
                    }
                    field("Credit Card SC"; "Credit Card SC")
                    {
                        Caption = 'Credit Card Security Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Credit Card security code.';
                    }
                }
                group(CreditCardAddress)
                {
                    ShowCaption = false;

                    field("Name on Card"; "Name on Card")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies Name on card.';
                    }
                    field(BillToAddress1; "Bill-to Address")
                    {
                        ApplicationArea = All;
                        Caption = 'Bill-to Address';
                        ToolTip = 'Specifies address on Card account.';
                    }
                    field(BillToAddress2; "Bill-to Address_2")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                    field(BillToAddress3; "Bill-to Address_3")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                    field(BillToAddress4; "Bill-to Address_4")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                }
                group(CreditCardComments)
                {
                    ShowCaption = false;

                    field("CC Comments 1"; "CC Comments 1")
                    {
                        Caption = 'Credit Card Comments';
                        ApplicationArea = All;
                        ToolTip = 'Specifies Credit Card comments.';
                    }
                    field("CC Comments 2"; "CC Comments 2")
                    {
                        Caption = '                                                 ';
                        ApplicationArea = All;
                    }
                    field("CC Comments 3"; "CC Comments 3")
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

                field("Third Party Name"; "Third Party Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies Third Party Name';
                }
                field("Third Party Address"; "Third Party Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party Street Address';
                }
                field("Third Party City"; "Third Party City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party City';
                }
                field("Third Party State"; "Third Party State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Third Party State';
                }
                field("Third Party Zip"; "Third Party Zip")
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
                        if "Your Reference" = '' then
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

                        if "Shipping Agent Code" = '' then
                            Error('Shipping Agent Code must be Entered');

                        if "Shipment Method Code" = '' then
                            Error('Shipment Method Code must be Entered');

                        if "Shipping Charge" = "Shipping Charge"::" " then
                            Error('Shipping Charge must be Entered');

                        QtyOil := 0;
                        SalesSetup2.Get;

                        //99999
                        // Check for Serial No for Pumps
                        SalesLine2.SetRange("Document Type", "Document Type");
                        SalesLine2.SetRange("Document No.", "No.");
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
                        SalesLine2.SetRange("Document Type", "Document Type");
                        SalesLine2.SetRange("Document No.", "No.");
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
                        if "Shipping Agent Code" = 'UPS' then begin
                            //Removed "Pre-Paid" 11/1/04 per Darleen
                            if ("Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
                                SalesLine2.Reset;
                                SalesLine2.SetRange("Document Type", "Document Type");
                                SalesLine2.SetRange("Document No.", "No.");
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
                        SalesLine2.SetRange("Document Type", "Document Type");
                        SalesLine2.SetRange("Document No.", "No.");
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
                        SalesLine3.SetRange("Document Type", "Document Type");
                        SalesLine3.SetRange("Document No.", "No.");
                        if SalesLine3.Find('+') then
                            SalesLineNo := SalesLine3."Line No.";

                        //UPS HANDLING
                        if "Shipping Agent Code" = 'UPS' then begin
                            //Removed "Pre-Paid" 11/1/04 per Darleen
                            if ("Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
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
                        if "Shipping Agent Code" = 'UPS' then begin
                            if ("Shipping Charge" = "Shipping Charge"::"Pre-Paid & Add") then begin
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
                        if "Approval Code" <> '' then begin
                            LineLoop;
                            SalesLine3.Type := SalesLine3.Type::" ";
                            SalesLine3.Validate("No.", '');
                            SalesLine3.Description := 'Approval Code No.' + ' ' + "Approval Code";
                            SalesLine3."Commission Calculated" := false;
                            SalesLine3.Insert;
                        end;

                        if BOL.Find('+') then
                            BLInteger := BOL."Bill of Lading" + 1
                        else
                            BLInteger := 100000;

                        WOD.SetCurrentKey(WOD."Work Order No.");
                        WOD.SetRange("Work Order No.", "Work Order No.");
                        if WOD.Find('-') then begin
                            if WOD."Work Order No." <> '' then begin
                                "Shortcut Dimension 2 Code" := 'WO';
                                Modify;
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
                        BOL2."Order No." := "No.";
                        BOL2."PO No." := "Your Reference";
                        BOL2.Customer := "Sell-to Customer No.";
                        BOL2."Ship To Name" := "Ship-to Name";
                        BOL2."Ship To Address" := "Ship-to Address";
                        BOL2."Ship To Address2" := "Ship-to Address 2";
                        BOL2."Ship To City" := "Ship-to City";
                        BOL2."Ship To State" := "Ship-to County";
                        BOL2."Ship To Zip Code" := "Ship-to Post Code";
                        BOL2.Attention := "Ship-to Contact";
                        BOL2."Phone No." := "Phone No.";
                        BOL2."Shipping Weight" := ShippingWeight;
                        BOL2."Container Quantity" := ContainerQuantity;
                        BOL2."Container Type" := Ship.ContainerToBOLContainer(ContainerType);
                        BOL2.Employee := Shipper;
                        BOL2."Shipment Date" := Today;
                        BOL2.Carrier := "Shipping Agent Code";
                        BOL2."Shipping Method" := "Shipment Method Code";
                        BOL2."Shipping Charge" := Ship.ShipChrgToBOLShipChrg("Shipping Charge");
                        BOL2."Shipping Account" := "Shipping Account";
                        BOL2."Label Quantity" := LabelsToPrint;
                        BOL2.Insert;

                        "Bill of Lading" := BOL2."Bill of Lading";
                        Modify;
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
        Permis: Label 'SUPER';

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
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
            lAccGroup := SysFunctions.getIfSingleRoleId(Permis, txtAnswer);
        if not lAccGroup then
            lSalesGroup := SysFunctions.getIfSingleGroupId(SalesCode, txtAnswer);
        if not (lAccGroup or lSalesGroup) then
            lShipGroup := SysFunctions.getIfSingleGroupId(ShipCode, txtAnswer);

        if not (lAccGroup or lSalesGroup or lShipGroup) then begin
            Error('You must be member of Accounting, Sales or Shipping to open this page.');
        end;


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
                    /*
                    if Item."Costing Method" = Item."Costing Method"::Specific then begin
                        SerialNo := WOP."Serial No."
                    end else begin
                        SerialNo := ''
                    end
                    */
                end;

                ReturnInventory;
                LineLoop;
                SalesLine3.Type := SalesLine3.Type::Item;
                SalesLine3.Validate("No.", WOP."Part No.");

                //    IF Item."Costing Method" = Item."Costing Method" :: Specific THEN BEGIN
                //      SalesLine3."Serial No." := SerialNo
                //    END;

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
        SalesLine3.Validate(SalesLine3."Document No.", "No.");
    end;

    procedure GPSLoopNoGLEntry()
    begin
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
                ItemJournalLine."Entry Type" := 4; //Transfer
                ItemJournalLine."Document No." := "Work Order No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := "Work Order No." + ' ' + 'SHIP RETURN PARTS';
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
        WOD.Carrier := "Shipping Agent Code";
        WOD."Shipping Method" := "Shipment Method Code";
        WOD."Shipping Charge" := "Shipping Charge";
        WOD."Shipping Account" := "Shipping Account";
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
        SalesLine3.SetRange("Document Type", "Document Type");
        SalesLine3.SetRange("Document No.", "No.");
        if SalesLine3.Find('-') then begin
            repeat
                if (SalesLine3.Reserve = SalesLine3.Reserve::Always) and (SalesLine3."Outstanding Qty. (Base)" <> 0) then
                    SalesLine3.AutoReserve();
            until
              SalesLine3.Next = 0;
        end;
    end;
}