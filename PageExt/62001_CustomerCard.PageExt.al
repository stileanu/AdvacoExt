pageextension 62001 CustomerCardExt2 extends "Customer Card"
{
    // need more fields. and hide some more
    layout
    {
        // Add changes to page layout here

        addafter("E-Mail")
        {
            field("Email Invoice"; "Email Invoice")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
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

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        OK: Boolean;
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
        IF OK THEN
            ERROR('This Customer Card is for Accounting Only');
    end;
}