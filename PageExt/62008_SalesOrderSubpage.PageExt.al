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
                Editable = (lAccGroup or lSalesGroup);  //ICE RSK 12/3/20
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
    var
        lAccGroup: Boolean;
        lSalesGroup: Boolean;
        lShipGroup: Boolean;
        SysFunctions: Codeunit systemFunctionalLibrary;
        txtAnswer: Text[120];
        AcctCode: Label 'ADVACO ACCOUNTING';
        SalesCode: Label 'ADVACO SALES';
        ShipCode: Label 'ADVACO SHIPPING';
        Permiss: Label 'SUPER';

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


    end;



}