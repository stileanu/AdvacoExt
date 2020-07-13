TableExtension 50109 CommentLineExt extends "Comment Line"
{
    fields
    {
        field(5000; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
    }
    trigger OnInsert()

    begin
        //>> HEF Add User
        "User ID" := USERID;
        //>> End Insert 
    end;

}