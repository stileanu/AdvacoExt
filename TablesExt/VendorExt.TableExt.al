TableExtension 50103 VendorExt Extends Vendor
{
    fields
    {
        field(50000; "Vendor Type"; Enum VendorType)
        {
            Caption = 'Vendor Type';
            //OptionCaption = ' ,A1,A2,A3,C1,C2,C3,D1,D2,D3';
            //OptionMembers = " ",A1,A2,A3,C1,C2,C3,D1,D2,D3;
        }
        field(50001; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
        }
        field(50002; Notes; Code[60])
        {
            Caption = 'Notes';
        }
        field(50003; Notes2; Code[60])
        {
            Caption = 'Notes 2';
        }
        field(50004; "Receiving Inspection"; Boolean)
        {
            Caption = 'Receiving Inspecition';
        }
        field(50005; "User Id"; Code[50])
        {
            Caption = 'User Id';
        }
        field(50009; "Email Invoice"; Boolean)
        {
            Caption = 'Email Invoice';
            trigger OnValidate()
            begin
                if "Email Invoice" then begin
                    if "Invoicing Email" = '' then begin
                        if "E-Mail" = '' then
                            Error(NO_EMAIL_ADDRESS)
                        else begin
                            "Invoicing Email" := "E-Mail";
                            Modify();
                        end;
                    end;
                    if not ValidateEmail("Invoicing Email") then begin
                        Error(NO_VALID_EMAIL);
                    end;
                end;
            end;
        }
        field(50010; "Path to PDF"; Text[150])
        {
            Caption = 'Path to PDF';
        }
        field(50011; "Invoicing Email"; Text[100])
        {
            Caption = 'Invoicing Email';
            trigger OnValidate()
            begin
                if "Invoicing Email" <> '' then begin
                    if not ValidateEmail("Invoicing Email") then begin
                        error(NO_VALID_EMAIL);
                    end;
                end else begin
                    if "Email Invoice" then
                        "Email Invoice" := false;
                end;
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                //HEF INSERT
                "Code Length" := StrLen("No.");
                AP := CopyStr("No.", ("Code Length" - 1), "Code Length");
                if AP = 'AP' then begin
                    "Vendor Posting Group" := 'VPG';
                    "VAT Bus. Posting Group" := 'DEFAULT';

                end;
                //END
            end;
        }
        modify("E-Mail")
        {
            trigger OnAfterValidate()
            begin
                //ICE MPC
                if not ValidateEmail("E-Mail") then
                    Error(NO_VALID_EMAIL);
            end;
        }

    }

    trigger OnModify()
    begin
        //>> HEF Add User Who Modified File
        "USER ID" := USERID;
        //>> End Insert  
    end;

    var
        NO_EMAIL_ADDRESS: Label 'NO Invoicing Email address set for current customer';
        NO_VALID_EMAIL: Label 'Email address %1 is not Valid';
        "Code Length": Integer;
        AP: Code[2];

    procedure ValidateEmail(Email: Text[80]): Boolean
    begin
        if StrPos(Email, '@') = 0 then
            exit(false);
        IF STRPOS(COPYSTR(Email, STRPOS(Email, '@') + 1), '.') = 0 THEN
            EXIT(FALSE);
        IF STRPOS(COPYSTR(Email, STRPOS(Email, '@') + 1), '.') = STRLEN(Email) THEN
            EXIT(FALSE);
        EXIT(TRUE);
    end;
}
