pageextension 62003 VendorCardExt extends "Vendor Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
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
        //See if user is SUPER
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