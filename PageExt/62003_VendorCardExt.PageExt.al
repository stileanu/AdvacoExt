pageextension 62003 VendorCardExt extends "Vendor Card"
{
    layout
    {
        addafter("Disable Search by Name")
        {
            field("Receiving Inspection"; Rec."Receiving Inspection")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Items from this Vendor must be inspected.';
            }

            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Vendor Type';
            }
        }
        addafter("E-Mail")
        {
            field("Email Invoice"; Rec."Email Invoice")
            {
                Caption = 'E-Mail Invoice';
                ApplicationArea = All;
                ToolTip = 'Specifies Invoice document to be sent by E-Mail.';
            }
            field("Invoicing Email"; Rec."Invoicing Email")
            {
                Caption = 'Order E-Mail';
                ApplicationArea = All;
                ToolTip = 'Specifies the E-Mail address where the Invoice should be sent.';
            }
        }
    }

    actions
    {
        addafter("Open Vendor Entries")
        {
            action(Aging)
            {
                ApplicationArea = All;
                Caption = 'Aging Report';
                Visible = NOT OK;
                Image = Aging;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    vendor := rec;
                    vendor.SetRecFilter();
                    report.runmodal(10085, true, false, vendor);
                end;
            }
        }
    }

    var

        Vendor: Record vendor;
        OK: Boolean;

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";

        User: Record User;
    begin
        OK := TRUE;
        //See  if user is SUPER
        user.setrange(user."User Name", userid);
        IF User.FindFirst() THEN begin


            AccessControl.setrange("User Security ID", user."User Security ID");
            IF AccessControl.find('-') THEN begin
                repeat
                    if AccessControl."Role ID" = 'SUPER' THEN
                        OK := FALSE;
                until AccessControl.next = 0;

            end;
        END;

    end;
}