codeunit 50030 systemFunctionalLibrary
{
    /*
    Procedures Library for System Functionality
    A) Determine if a user is part of a group or has a certain roll
    Procedures:
        1.  procedure setRollArray(aRoll: Code[20]; bRoll: Code[20]; cRoll: Code[20]; dRoll: Code[20]): Text
            upload an array with up to four user rolls to be tested against. aRoll..dRoll are code[20]
            OBSOLETE - Cancelled

        2.  procedure setGroupArray(aGroup: Code[20]; bGroup: Code[20]; cGroup: Code[20]; dGroup: Code[20]): Text
            upload an array with up to four user user groups to be tested against. aGroup..dGroup are code[20]

        3.  procedure getIfRoleId(orAnd: Boolean): Text
            orAnd is set as fasle for or-ed operation, and true for and-ed multiple rols setup in textRoll array.

    */

    trigger OnRun()
    begin
    end;

    local procedure getAccessControl(userSecurityId: Guid): Text;
    begin
        // Clear pointer
        Member.Reset();

        if not User.Get(userSecurityId) then begin
            exit(notSuchUser);
        end;


        Member.SetRange("User Security ID", User."User Security ID");
        if Member.Find('-') then
            exit(yesSuccess)
        else
            exit(notAccesCtrlRec);

    end;

    /*
    procedure setRollArray(aRoll: Code[20]; bRoll: Code[20]; cRoll: Code[20]; dRoll: Code[20]): Text
    var
        index: Integer;
    begin
        if (aRoll = '') and (bRoll = '') and (cRoll = '') and (dRoll = '') then
            exit(noElementsArray);
        index := 1;
        repeat
            case index of
                1:
                    textRoll[index] := aRoll;
                2:
                    textRoll[index] := bRoll;
                3:
                    textRoll[index] := cRoll;
                4:
                    textRoll[index] := dRoll;
            end;
            index += 1;
        until index > 4;

        CompressArray(textRoll);
        if ArrayLen(textRoll) = 0 then
            exit(noElementsArray);
    end;
    */

    procedure setGroupRollArray(aGroup: Code[20]; bGroup: Code[20]; cGroup: Code[20]; dGroup: Code[20]): Text
    var
        index: Integer;
    begin
        if (aGroup = '') and (bGroup = '') and (cGroup = '') and (dGroup = '') then
            exit(noElementsArray);
        index := 1;
        repeat
            case index of
                1:
                    textGroup[index] := aGroup;
                2:
                    textGroup[index] := bGroup;
                3:
                    textGroup[index] := cGroup;
                4:
                    textGroup[index] := dGroup;
            end;
            index += 1;
        until index > 4;

        CompressArray(textGroup);
        if ArrayLen(textGroup) = 0 then
            exit(noElementsArray);

        exit(yesSuccess);
    end;

    procedure getIfRoleId(orAnd: Boolean): Text
    // orAnd is set as fasle for or-ed operation, 
    // and true for and-ed multiple rols setup in textRoll array. 
    var
        locIndex: Integer;
        locResult: Boolean;
        locContFlag: Boolean;

    begin
        if orAnd then
            locResult := true
        else
            locResult := false;
        locIndex := ArrayLen(textGroup);
        if locIndex = 0 then
            exit(noElementsArray);

        locIndex := 1;
        User.Get(UserSecurityId);
        Role.SetRange("User Security ID", User."User Security ID");
        if not Role.FindFirst() then
            exit(noRoleFound);

        repeat
            Role.FindFirst();
            case orAnd of
                true:
                    begin
                        if locResult then
                            repeat
                                if textGroup[locIndex] = Role."Role ID" then begin
                                    locContFlag := false;
                                    locResult := true;
                                end;
                                if Role.Next() = 0 then begin
                                    locResult := false;
                                    locContFlag := false;
                                end;
                            until not locContFlag;
                    end;
                false:
                    begin
                        if not locResult then
                            repeat
                            until locContFlag;
                    end;
            end;
            locIndex += 1;
        //review 
        until locIndex = 0;
        /*
        User.Get(UserSecurityId);  
        //Member.CalcFields("User Name"); 
        Ok2 := true;
        Member.SetRange("User Security ID", User."User Security ID");
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALES') or (Member."Role ID" = 'SUPER') then
                    Ok2 := false;
            until Member.Next = 0;
        end;
        */
    end;

    var
        Member: Record "User Group Member";
        Role: Record "Access Control";
        User: Record User;
        //textRoll: array[4] of Code[20];
        textGroup: array[4] of Code[20];
        notSuchUser: Label 'No such user (%1).';
        notAccesCtrlRec: Label 'User access not setup (%1).';
        noElementsArray: Label 'Group/Rolls Array empty.';
        noRoleFound: Label 'User does not have the role(s).';
        yesSuccess: Label 'OK';
}