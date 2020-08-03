page 50049 "Shop Employees"
{
    PageType = Card;
    SourceTable = Resource;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Type=CONST(Person));

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1000000009)
                {
                    ShowCaption = false;
                    field("No.";"No.")
                    {

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit(xRec) then
                              CurrPage.Update;
                        end;
                    }
                    field(Name;Name)
                    {
                    }
                    field("Search Name";"Search Name")
                    {
                    }
                    field(Type;Type)
                    {
                    }
                    field("Resource Group No.";"Resource Group No.")
                    {
                    }
                    field(Blocked;Blocked)
                    {
                    }
                    field("Last Date Modified";"Last Date Modified")
                    {
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
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Comment Sheet";
                RunPageLink = "Table Name"=CONST(Resource),
                              "No."=FIELD("No.");
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

