table 50019 "Open File"
{
    DataClassification = ToBeClassified;
    //TableType = Temporary;

    fields
    {
        field(10; "Key"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "File Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}