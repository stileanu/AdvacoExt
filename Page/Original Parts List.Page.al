page 50006 "Original Parts List"
{
    //Tested
    Editable = false;
    PageType = List;
    SourceTable = OriginalQuotedParts;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Work Order No."; "Work Order No.")
                {
                    ApplicationArea = All;
                }
                field("Part Type"; "Part Type")
                {
                    ApplicationArea = All;
                }
                field("Part No."; "Part No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Quoted Quantity"; "Quoted Quantity")
                {
                    ApplicationArea = All;
                }
                field("Part Cost"; "Part Cost")
                {
                    ApplicationArea = All;
                }
                field("Quoted Price"; "Quoted Price")
                {
                    ApplicationArea = All;
                }
                field("Total Quote Price"; "Total Quote Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

