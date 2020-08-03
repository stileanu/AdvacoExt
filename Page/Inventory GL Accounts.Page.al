page 50054 "Inventory GL Accounts"
{
    PageType = List;
    SourceTable = "G/L Account";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("No."=FILTER('120'..'132'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(Name;Name)
                {
                }
                field("Net Change";"Net Change")
                {
                }
                field("Balance at Date";"Balance at Date")
                {
                    Visible = false;
                }
                field(Balance;Balance)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewGLAcc(xRec,BelowxRec);
    end;
}

