page 50049 "Shop Employees"
{
    PageType = Card;
    SourceTable = Resource;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Type = CONST(Person));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1000000009)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field(Name; Name)
                    {
                        ApplicationArea = All;
                    }
                    field("Search Name"; "Search Name")
                    {
                        ApplicationArea = All;
                    }
                    field(Type; Type)
                    {
                        ApplicationArea = All;
                    }
                    field("Resource Group No."; "Resource Group No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Blocked; Blocked)
                    {
                        ApplicationArea = All;
                    }
                    field("Last Date Modified"; "Last Date Modified")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Comment)
            {
                ApplicationArea = All;
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name" = CONST(Resource),
                              "No." = FIELD("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("No.");
    end;

    var
        ContractType: Option Sales,Purchase;
}

