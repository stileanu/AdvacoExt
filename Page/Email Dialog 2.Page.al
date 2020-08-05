page 50048 "Email Dialog 2"
{

    ///--! File Mgmt issue
    // 08/05/20 ICE SII
    // No CommDialog Mgmt codeunit. 


    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                group(Control1000000007)
                {
                    ShowCaption = false;
                    field(ToAddress; ToAddress)
                    {
                        Caption = 'To:';
                    }
                    field(CCAddress; CCAddress)
                    {
                        Caption = 'CC:';
                    }
                    field(SubjectLine; SubjectLine)
                    {
                        Caption = 'Subject:';
                    }
                    field(Attached; Attached)
                    {
                        Caption = 'Attached:';
                        Editable = false;

                        trigger OnDrillDown()
                        begin
                            ///--! File Mgmt issue
                            // 08/05/20 ICE SII
                            //Attached := CommDlgMgmt.OpenFile('Select Attachement', Attached, DefFileType::" ", '', FileAction::Save);
                            //CurrPage.UPDATE;
                        end;
                    }
                    field(eMailBody; eMailBody)
                    {
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group("Email Signature")
                {
                    Caption = 'Email Signature';
                    field("UserSignature[1]"; UserSignature[1])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[2]"; UserSignature[2])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[3]"; UserSignature[3])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[4]"; UserSignature[4])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[5]"; UserSignature[5])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[6]"; UserSignature[6])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[7]"; UserSignature[7])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                    field("UserSignature[8]"; UserSignature[8])
                    {
                        Editable = false;
                        ShowCaption = false;
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        /*99999
        //AttFileName := GetFileNameOnly(Attached);
        // Get User's Email Signature
        UserSetup.GET(USERID);
        i := UserSetup.GetSignature(UserSignature);
        IF i=0 THEN
          UserSignature[1] := NO_SIGNATURE_MSSG;
        99999*/

    end;

    var
        UserSetup: Record "User Setup";
        UserSignature: array[8] of Text[120];
        ToAddress: Text[100];
        CCAddress: Text[100];
        SubjectLine: Text[100];
        eMailBody: Text[500];
        AttFileName: Text[250];
        Attached: Text[250];
        ///--! File Mgmt issue
        // 08/05/20 ICE SII
        //CommDlgMgmt: Codeunit "ComDialog Management";
        FileAction: Option Open,Save;
        DefFileType: Option " ",Text,Excel,Word,Custom;
        bCancel: Boolean;
        i: Integer;
        NO_SIGNATURE_MSSG: Label 'No Signature on File for current user.';

    procedure SetEmailValues(var ToAddressFill: Text[100]; var CcAddressFill: Text[100]; var SubjectFill: Text[100]; var AttachedFill: Text[250]; var BodyFill: Text[500])
    begin
        ToAddress := ToAddressFill;
        CCAddress := CcAddressFill;
        SubjectLine := SubjectFill;
        Attached := AttachedFill;
        eMailBody := BodyFill;
    end;

    procedure GetEmailValues(var bCancelVal: Boolean; var ToAddressFill: Text[100]; var CcAddressFill: Text[100]; var SubjectFill: Text[100]; var AttachedFill: Text[250]; var BodyFill: Text[500]; var UserSign: array[8] of Text[120])
    begin
        bCancelVal := bCancel;
        ToAddressFill := ToAddress;
        CcAddressFill := CCAddress;
        SubjectFill := SubjectLine;
        AttachedFill := Attached;
        BodyFill := eMailBody;
        CopyArray(UserSign, UserSignature, 1);
    end;

    procedure GetFileNameOnly(var FileName: Text[250])
    begin
        //FileName := COPYSTR(FileName,1,STRPOS(FileName,
        /*
        SplitFilename(Filename : Text[250];VAR Path : Text[250];VAR Name : Text[250])
        
        Path := '';
        Name := '';
        Filename := DELCHR(Filename,'<>');
        IF (Filename = '') THEN
          EXIT;
        
        Pos := STRLEN(Filename);
        REPEAT
          Found := (COPYSTR(Filename,Pos,1) = '\');
          IF NOT Found THEN
            Pos := Pos - 1;
        UNTIL (Pos = 0) OR Found;
        
        IF Found THEN BEGIN
          Path := COPYSTR(Filename,1,Pos);
          Name := COPYSTR(Filename,Pos+1);
        END ELSE BEGIN
          Path := '';
          Name := Filename;
        END;
        */

    end;
}

