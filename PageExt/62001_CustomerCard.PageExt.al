pageextension 62001 CustomerCardExt2 extends "Customer Card"
{
    // need more fields. and hide some more
    layout
    {
        // Add changes to page layout here
        //ICE RSK 12/15/20
        Modify("Credit Limit (LCY)")
        {
            Editable = lAccGroup;
        }
        addafter("Name")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
            }
        }
        addafter("Salesperson Code")
        {
            field(Rep; Rec.Rep)
            {
                ApplicationArea = All;
                Editable = lAccGroup;
                ToolTip = 'Specifies the External Rep for this Customer.';
            }
            field("Payment Terms Code_1"; Rec."Payment Terms Code")
            {
                ApplicationArea = All;
                Caption = 'Payment Terms Code';
                Editable = lAccGroup;
                ToolTip = 'Specifies the Payment Terms set for this Customer.';
            }
            field("Payment Method Code_1"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Payment Method Code';
                Editable = lAccGroup;
                ToolTip = 'Specifies the Payment Method set for this Customer.';
            }
        }
        modify(Blocked)
        {
            Editable = lAccGroup;
        }

        modify(Payments)
        {
            Visible = lAccGroup;
        }
        addbefore("Last Date Modified")
        {
            field("Customer Since"; Rec."Customer Since")
            {
                ApplicationArea = All;
                Visible = lAccGroup;
                ToolTip = 'Specifies the date of first Order.';
            }
        }
        addafter("Last Date Modified")
        {
            field("CC Fee Waived"; Rec."CC Fee Waived")
            {
                ApplicationArea = All;
                Editable = lAccGroup;
                ToolTip = 'Specifies if Credit Card Fee is waived.';
            }
        }
        addbefore(Blocked)
        {
            field("Credit Issues"; Rec."Credit Issues")
            {
                ApplicationArea = All;
                Editable = lAccGroup;
                ToolTip = 'Specifies if Customer has problems with Credit.';
            }
        }
        addafter("E-Mail")
        {
            field("Email Invoice"; Rec."Email Invoice")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies if Invoices will be be sent by Email only.';
                Visible = lAccGroup;
            }
        }
        addafter("Email Invoice")
        {
            field("Invoicing Email"; Rec."Invoicing Email")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the Email address where to send Invoice.';
                Visible = lAccGroup;
            }
        }
        addafter("Bill-to Customer No.")
        {
            field("Internet Invoicing"; Rec."Internet Invoicing")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if Invoices sent over Internet only';
            }
        }
        addafter("Internet Invoicing")
        {
            field("No Internet/Paper Invoice"; Rec."No Internet/Paper Invoice")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if Invoice sent by Email only';
                Visible = lAccGroup;
            }
        }
        addafter("Shipping Advice")
        {
            field("Ship on Sales Order"; Rec."Ship on Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specify if Work Orders should use Sales Order document for shipping.';
            }
        }

    }

    actions
    {
        modify(NewSalesInvoice)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewSalesCreditMemo)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewSalesOrderAddin)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewSalesQuoteAddin)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewSalesInvoiceAddin)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewSalesCreditMemoAddin)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewServiceQuote)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewServiceInvoice)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewServiceOrder)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewSalesReturnOrder)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewServiceCreditMemo)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewReminder)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(NewFinanceChargeMemo)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Direct Debit Mandates")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(Action76)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("S&ales")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Entry Statistics")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Statistics by C&urrencies")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Item &Tracking Entries")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(Prices)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(Invoices)
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Return Orders")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify("Issued Documents")
        {
            //ApplicationArea = All; 
            Visible = lAccGroup;
        }
        modify("Sales Journal")
        {
            Visible = lAccGroup;
        }
        modify("Post Cash Receipts")
        {
            Visible = lAccGroup;
        }
        modify(PaymentRegistration)
        {
            Visible = lAccGroup;
        }
        modify("Bank Accounts")
        {
            Visible = lAccGroup;
        }
        modify("&Jobs")
        {
            ApplicationArea = All;
            Visible = lAccGroup;
        }
        modify(Service)
        {
            //ApplicationArea = All;
            Visible = false;
        }
        modify(NewBlanketSalesOrder)
        {
            Promoted = true;
            PromotedCategory = Category4;
        }
        modify("Aged Accounts Receivable")
        {
            Visible = lAccGroup;
        }
        modify("Account Detail")
        {
            Visible = lAccGroup;
        }
        modify("Cash Applied")
        {
            Visible = lAccGroup;
            ApplicationArea = All;
        }
        modify("Customer Jobs (Price)")
        {
            Visible = lAccGroup;
        }
        modify("Customer/Item Statistics")
        {
            Visible = lAccGroup;
        }
        modify("Customer Jobs (Cost)")
        {
            Visible = lAccGroup;
        }
        modify("Report Statement")
        {
            Visible = lAccGroup;
        }
        modify(BackgroundStatement)
        {
            Visible = lAccGroup;
        }
        // Add changes to page actions here
        addafter("Entry Statistics")
        {
            action(Services)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //DistIntegration.IMShowCustServList(Rec);  //RSK Missing Page
                end;
            }
        }
    }

    var
        myInt: Integer;
        DistIntegration: Codeunit "Dist. Integration";
        txtAnswer: Text[120];
        AcctCode: Label 'ADVACO ACCOUNTING';
        SalesCode: Label 'ADVACO SALES';
        SysFunctions: Codeunit systemFunctionalLibrary;
        Permiss: Label 'SUPER';
        lAccGroup: Boolean;
        lSalesGroup: Boolean;

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
    begin
        /*
            ///--! Permission level check code.
            User.Get(UserSecurityId);
            //User.CalcFields("User Name");
            Ok := true;
            User.SetRange("User Security ID", User."User Security ID");

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

            //lAccGroup := false;
        end;
    */

        // initialize group flag
        lAccGroup := false;
        //lSalesGroup := false;
        //lShipGroup := false;

        ///--! Permission level check code. 
        User.Get(UserSecurityId);
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");
        //Member.SetRange("User Security ID", User."User Security ID");

        lAccGroup := SysFunctions.getIfSingleGroupId(AcctCode, txtAnswer);
        if not lAccGroup then
            lAccGroup := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);
        if not lsalesGroup then
            lSalesGroup := SysFunctions.getIfSingleGroupId(SalesCode, txtAnswer);
        //if not (lAccGroup or lSalesGroup) then
        //   lShipGroup := SysFunctions.getIfSingleGroupId(ShipCode, txtAnswer);

        if not (lAccGroup or lSalesGroup) then begin
            Error('You must be member of Accounting or Sales group to open this page.');
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
        
        if Ok then
            ERROR('This Customer Card is for Accounting Only')
        else
           lAccGroup := true;
        */
    end;

    var

}