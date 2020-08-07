page 50054 "Inventory GL Accounts"
{
    PageType = List;
    SourceTable = "G/L Account";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("No." = FILTER('120' .. '132'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Net Change"; "Net Change")
                {
                    ApplicationArea = All;
                }
                field("Balance at Date"; "Balance at Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetupNewGLAcc(xRec, BelowxRec);
    end;
}

