TableExtension 50109 CommentLineExt extends "Comment Line"
{
    fields
    {
        field(50000; "User ID"; Code[50])
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