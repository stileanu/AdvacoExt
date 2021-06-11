#pragma implicitwith disable
page 50054 "Inventory GL Accounts"
{
    //Tested
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = All;
                }
                field("Balance at Date"; Rec."Balance at Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Balance; Rec.Balance)
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
        Rec.SetupNewGLAcc(xRec, BelowxRec);
    end;
}

#pragma implicitwith restore

