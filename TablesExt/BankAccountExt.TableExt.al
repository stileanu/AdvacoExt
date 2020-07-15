tableextension 50123 BankAccountExt extends "Bank Account"
{
    fields
    {
        field(50000; "MICR Layout Picture"; Text[50])
        {
            Caption = 'MICR Layout Picture';
        }
        field(50001; "Leading Zeros"; Boolean)
        {
            Caption = 'Leading Zeros';
        }
        field(50002; "Check Number Width"; Integer)
        {
            Caption = 'Check Number Width';
        }
        field(50003; "Routing Symbol"; Text[11])
        {
            Caption = 'Routing Symbol';
            Description = 'AVF.MAC.041910';
        }
        field(50004; "Print Company Address"; Boolean)
        {
            Caption = 'Print Company Address';
            Description = 'AVF.MAC.041910';
        }
        field(50006; "Divider 1"; Code[1])
        {
            Caption = 'Divider 1';
            Description = 'AVF.MAC.041910';

            trigger OnValidate()
            begin
                //MICRFormat("Last Check No.");
            end;
        }
        field(50007; "Format 1"; Enum BankAcctFormat)
        {
            Caption = 'Format 1';
            Description = 'AVF.MAC.041910';
        }
        field(50008; "Divider 2"; Code[1])
        {
            Caption = 'Divider 2';
            Description = 'AVF.MAC.041910';

            trigger OnValidate()
            begin
                //MICRFormat("Last Check No.");
            end;
        }
        field(50009; "Format 2"; Enum BankAcctFormat)
        {
            Caption = 'Format 2';
            Description = 'AVF.MAC.041910';
        }
        field(50010; "Divider 3"; Code[1])
        {
            Caption = 'Divider 3';
            Description = 'AVF.MAC.041910';

            trigger OnValidate()
            begin
                //MICRFormat("Last Check No.");
            end;
        }
        field(50011; "Format 3"; Enum BankAcctFormat)
        {
            Caption = 'Format 3';
            Description = 'AVF.MAC.041910';
        }
        field(50012; "Divider 4"; Code[1])
        {
            Caption = 'Divider 4';
            Description = 'AVF.MAC.041910';

            trigger OnValidate()
            begin
                //MICRFormat("Last Check No.");
            end;
        }
        field(50013; "Print MICR Encoding"; Boolean)
        {
            Caption = 'Print MICR Encoding';
            Description = 'AVF.MAC.041910';

            trigger OnValidate()
            begin
                //MICRFormat("Last Check No.");
            end;
        }
        field(50014; "Divider 5"; Code[1])
        {
            Caption = 'Divider 5';
            Description = 'AVF.MAC.041910';
        }
        field(50015; "Divider 6"; Code[1])
        {
            Caption = 'Divider 6';
            Description = 'AVF.MAC.041910';
        }
        field(50016; "Check Layout"; Enum CheckLayout)
        {
            Caption = 'Check Layout';
            Description = 'AVF.MAC.041910';
        }
        field(50017; "Bank E-pay ID String"; Text[80])
        {
            Caption = 'Bank E-pay ID String';
            Description = 'AVF.MAC.041910';
        }
        field(50030; "County/City Text"; Text[10])
        {
            Caption = 'County/City Text';
        }
    }

    var
        myInt: Integer;

    procedure MICRFormat(CheckNo: Code[20]) MICRString: Text[50]
    var
        CheckInfoPrinted: Boolean;

    begin

        // New function by AVF (MAC 04/19/10)

        IF (NOT "Print MICR Encoding") OR ("Last Check No." = '') OR ("Bank Account No." = '') OR ("Transit No." = '') OR
           ("Format 1" = "Format 1"::" ") OR ("Format 2" = "Format 2"::" ") OR ("Format 3" = "Format 3"::" ") THEN
            EXIT('');

        MICRString := "Divider 1";

        CASE "Format 1" OF
            "Format 1"::"Bank Account No.":
                MICRString += "Bank Account No.";
            "Format 1"::"Transit No.":
                MICRString += "Transit No.";
            "Format 1"::"Check No.":
                MICRString += CheckNo;
        END;

        IF "Divider 2" <> '' THEN
            MICRString += "Divider 2";

        CheckInfoPrinted := ("Format 1" = "Format 1"::"Check No.");
        IF NOT CheckInfoPrinted THEN
            MICRString += ' '
        ELSE
            CASE STRLEN(CheckNo) OF
                3:
                    MICRString += '   ';
                4:
                    MICRString += '  ';
                5:
                    MICRString += ' ';
                6:
                    MICRString += ' ';
            END;

        IF "Divider 3" <> '' THEN
            MICRString += "Divider 3";

        CASE "Format 2" OF
            "Format 2"::"Bank Account No.":
                MICRString += "Bank Account No.";
            "Format 2"::"Transit No.":
                MICRString += "Transit No.";
            "Format 2"::"Check No.":
                MICRString += CheckNo;
        END;

        IF "Divider 4" <> '' THEN
            MICRString += "Divider 4";

        CheckInfoPrinted := ("Format 2" = "Format 2"::"Check No.");
        IF NOT CheckInfoPrinted THEN
            MICRString += ' '
        ELSE
            CASE STRLEN(CheckNo) OF
                3:
                    MICRString += '  ';
                4:
                    MICRString += ' ';
                5:
                    ;
                6:
                    MICRString += ' ';
            END;

        IF "Divider 5" <> '' THEN
            MICRString += "Divider 5";

        CASE "Format 3" OF
            "Format 3"::"Bank Account No.":
                MICRString += "Bank Account No.";
            "Format 3"::"Transit No.":
                MICRString += "Transit No.";
            "Format 3"::"Check No.":
                MICRString += CheckNo;
        END;

        MICRString += "Divider 6";
    end;
}