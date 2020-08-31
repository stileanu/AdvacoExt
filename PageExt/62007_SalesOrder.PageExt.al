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

        // Add changes to page actions here
    }

    var

        lAccGroup: Boolean;
        lSalesGroup: Boolean;
        lShipGroup: Boolean;
        Shipper: Code[3];
        ShippingTime: Decimal;
        ShippingWeight: Decimal;
        ContainerQuantity: Integer;
        ContainerType: Enum Container;
        LabelsToPrint: Integer;

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
    begin
        ///--! Permission level check code.
        User.Get(UserSecurityId);
        //User.CalcFields("User Name");
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");

        lAccGroup := false;
        lSalesGroup := false;
        lShipGroup := false;

        //See if user is SUPER
        //user.setrange(user."User Name", userid);
        ///--!
        // Add the role for Accounting!
        IF User.FindFirst() THEN begin

            AccessControl.setrange("User Security ID", User."User Security ID");
            IF AccessControl.find('-') THEN begin
                repeat
                    ///--! To add what role is for accounting?? 
                    //if (AccessControl."Role ID" = 'SUPER') or (AccessControl."Role ID" = 'ADV-ACCT') THEN                
                    if AccessControl."Role ID" = 'SUPER' THEN
                        OK := FALSE;
                until AccessControl.next = 0;

            end;
        END;
        IF Ok THEN
            ERROR('This Customer Card is for Accounting Only')
        else
            lAccGroup := true;
        lAccGroup := false;
        //lSalesGroup := true;
        //lShipGroup := true;
    end;

}