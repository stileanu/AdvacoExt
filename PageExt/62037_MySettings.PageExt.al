pageextension 62037 MySettingsExtension extends "My Settings"
{
    layout
    {
        // Add changes to page layout here
        modify(UserRoleCenter)
        {

            Visible = SuperUser;
        }
    }


    actions
    {
        // Add changes to page actions here
    }


    trigger OnOpenPage()


    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
        Permiss: Label 'SUPER';
        SysFunctions: Codeunit systemFunctionalLibrary;
        txtanswer: text;


    begin


        ///--! Permission level check code. 
        User.Get(UserSecurityId);
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");

        SuperUser := SysFunctions.getIfSingleRoleId(Permiss, txtAnswer);


    end;



    var

        SuperUser: Boolean;
}