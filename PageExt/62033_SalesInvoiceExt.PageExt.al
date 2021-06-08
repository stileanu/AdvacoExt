pageextension 62033 SalesInvoiceExt extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
        {
            field(Rep; Rec.Rep)
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the name of the Representative who is assigned to the customer.';
            }
            field("Bill of Lading"; Rec."Bill of Lading")
            {
                ApplicationArea = All;
                Importance = Additional;
                ToolTip = 'Specifies the Bill of Lading for the shipping of this order.';
            }
        }
        modify("CFDI Purpose")
        {
            Visible = false;
        }
        modify("CFDI Relation")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = False;
        }

        addafter("Payment Method Code")
        {
            group(CCard)
            {
                ShowCaption = false;
                Visible = (Rec."Payment Method Code" = 'CC');

                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = All;

                }
                field("Credit Card No."; Rec."Credit Card No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Card Exp."; Rec."Credit Card Exp.")
                {
                    ApplicationArea = All;
                }
            }
        }
        modify("EU 3-Party Trade")
        {
            Visible = False;
        }
        modify("Your Reference")
        {
            Caption = 'Customer P.O. Number';
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(YourReference1; Rec."Your Reference")
            {
                Caption = 'Customer P.O. Number';
                ApplicationArea = All;

            }
        }
    }

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;

    begin
        // initialize group flag
        lAccGroup := false;
        lFMgrGroup := false;

        ///--! Permission level check code. 
        User.Get(UserSecurityId);
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");
        //Member.SetRange("User Security ID", User."User Security ID");

        lAccGroup := SysFunctions.getIfSingleGroupId(AcctCode, txtAnswer);
        if not lAccGroup then
            lAccGroup := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);
        if not lAccGroup then
            lFMgrGroup := SysFunctions.getIfSingleGroupId(FMgrCode, txtAnswer);

        if not (lAccGroup or lFMgrGroup) then begin
            Error('You must be member of Accounting to open this page.');
        end;
    end;

    var
        SysFunctions: Codeunit systemFunctionalLibrary;
        lAccGroup: Boolean;
        lFMgrGroup: Boolean;
        lShipGroup: Boolean;
        Member: Record "User Group Member";
        txtAnswer: Text[120];
        AcctCode: Label 'ADVACO ACCOUNTING';
        FMgrCode: Label 'ADVACO FINANCE MGR';
        Permiss: Label 'SUPER';
}