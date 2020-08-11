Tableextension 50108 UserSetupExt Extends "User Setup"
{

    fields
    {
        field(50000; "Adobe Software"; Text[250])
        {
            Caption = 'Adobe Software';

        }
        field(50001; "Allow WI Blocking"; Boolean)
        {
            Caption = 'Allow WI Blocking';
        }
        field(50002; "Allow WI Deletion"; Boolean)
        {
            Caption = 'Allow WI Deletion';

        }
        field(50003; Signature1; Text[120])
        {
            Caption = 'Signature 1';

        }
        field(50004; Signature2; Text[120])
        {
            Caption = 'Signature 2';

        }
        field(50005; Signature3; Text[120])
        {
            Caption = 'Signature 3';

        }
        field(50006; Signature4; Text[120])
        {
            Caption = 'Signature 4';

        }
        field(50007; Signature5; Text[120])
        {
            Caption = 'Signature 5';

        }
        field(50008; Signature6; Text[120])
        {
            Caption = 'Signature 6';

        }
        field(50009; Signature7; Text[120])
        {
            Caption = 'Signature 7';

        }
        field(50010; Signature8; Text[120])
        {
            Caption = 'Signature 8';

        }
        field(50011; "PDF Path to Documents"; Text[100])
        {
            Caption = 'PDF Path to Documents';
        }
        field(99001915; "Sales Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Location';
        }
        field(99001916; "Purch. Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purch. Location';
        }
        field(99001917; "Return Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Return Location';
        }
        field(99002580; "Inventory Management Location"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Inventory Management Location';
        }
    }
    procedure GetParamStatus(var UserID: Code[20]; ParamID: Integer): Boolean

    var
        ADV001: Label 'Msg for Programmers: Incorrect Function ID.';
        ADV002: Label 'Msg for Programmers: Incorrect User ID.';

    begin

        //  04/01/13 - new function
        //  Parameter List is:
        //  1 - Register Time
        //  2 - Allow WI Blocking
        //  3 - Allow WI Deletion
        //  Return current value of field.

        IF NOT GET(UserID) THEN
            ERROR(ADV002);
        CASE ParamID OF
            1:
                EXIT("Register Time");
            2:
                EXIT("Allow WI Blocking");
            3:
                EXIT("Allow WI Deletion");
            ELSE
                ERROR(ADV001);
        END;
    end;

    procedure SetParamStatus(var UserID: Code[2]; var ParamID: Integer; var setvalue: Boolean): Boolean
    var
        UserRec: Record "User Setup";
        PrevValue: Boolean;
        ADV001: Label 'Msg for Programmers: Incorrect Function ID.';
        ADV002: Label 'Msg for Programmers: Incorrec User ID';
    begin

        //  04/01/13 - new function
        //  Parameter List is:
        //  1 - Register Time
        //  2 - Allow WI Blocking
        //  3 - Allow WI Deletion
        //  setValue is the value to be set by function
        //  Return previous value of field.

        IF NOT GET(UserID) THEN
            ERROR(ADV002);
        CASE ParamID OF
            1:
                BEGIN
                    prevValue := "Register Time";
                    "Register Time" := setValue;
                    MODIFY(FALSE);
                END;
            2:
                BEGIN
                    prevValue := "Allow WI Blocking";
                    "Allow WI Blocking" := setValue;
                    MODIFY(FALSE);
                END;

            3:
                BEGIN
                    prevValue := "Allow WI Deletion";
                    "Allow WI Deletion" := setValue;
                    MODIFY(FALSE);
                END;

            ELSE
                ERROR(ADV001);
        END;

        EXIT(prevValue);
    end;

    procedure GetSignature(var UserEmailSignature: array[8] of Text[120]): Integer
    begin

        UserEmailSignature[1] := Signature1;
        UserEmailSignature[2] := Signature2;
        UserEmailSignature[3] := Signature3;
        UserEmailSignature[4] := Signature4;
        UserEmailSignature[5] := Signature5;
        UserEmailSignature[6] := Signature6;
        UserEmailSignature[7] := Signature7;
        UserEmailSignature[8] := Signature8;

        // Compress array
        EXIT(COMPRESSARRAY(UserEmailSignature));
    end;

}