pageextension 62008 SalesOrderSubpageExt extends "Sales Order Subform"
{
    layout
    {
        addafter("No.")
        {
            field("Cross Reference Item"; "Cross Reference Item")
            {

                ApplicationArea = All;
                Editable = false;
            }
            field("Vendor No."; "Vendor No.")
            {
                ApplicationArea = All;
                Visible = lSalesGroup;
            }
            field("Vendor Item No."; "Vendor Item No.")
            {
                ApplicationArea = All;
                Visible = lSalesGroup;
            }
            field("Purchase Order No."; "Purchase Order No.")
            {
                ApplicationArea = All;
                Visible = lSalesGroup;
            }
            field(Amount; Amount)
            {
                ApplicationArea = All;
                Visible = not lShipGroup;
            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = not lShipGroup;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = lSalesGroup;
            }

        }
        addafter("Unit Price")
        {
            field(Reserve; Reserve)
            {
                ApplicationArea = All;
                Visible = lAccGroup;
            }
            field("Commission Calculated"; "Commission Calculated")
            {
                ApplicationArea = All;
                Visible = not lShipGroup;
            }
        }
        modify(Type)
        {
            Visible = not lShipGroup;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = All;
            Visible = not lShipGroup;
        }
        modify("Qty. to Invoice")
        {
            ApplicationArea = ALl;
            Visible = not lShipGroup;
        }
        modify("Unit Price")
        {
            ApplicationArea = All;
            Visible = not lShipGroup;
        }
        modify("Amount Including VAT")
        {
            ApplicationArea = All;
            Visible = not lShipGroup;
        }

        modify("Qty. to Ship")
        {
            ApplicationArea = All;
            Visible = lShipGroup;
        }
        modify("Shipment Date")
        {
            ApplicationArea = All;
            Visible = lShipGroup;
        }
        modify("Quantity Shipped")
        {
            ApplicationArea = All;
            Editable = false;
            Visible = not lSalesGroup;
        }
        modify("Line Discount %")
        {
            ApplicationArea = All;
            Visible = not lShipGroup;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = All;
            Visible = not lShipGroup;
        }
        modify("Reserved Quantity")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Package Tracking No.")
        {
            ApplicationArea = All;
            Visible = lShipGroup;
        }
        modify("Tax Liable")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Tax Group Code")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        lShipGroup: Boolean;
        lSalesGroup: Boolean;
        lAccGroup: Boolean;
}