#pragma implicitwith disable
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
                    field("No."; Rec."No.")
                    {
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            if Rec.AssistEdit(xRec) then
                                CurrPage.Update;
                        end;
                    }
                    field(Name; Rec.Name)
                    {
                        ApplicationArea = All;
                    }
                    field("Search Name"; Rec."Search Name")
                    {
                        ApplicationArea = All;
                    }
                    field(Type; Rec.Type)
                    {
                        ApplicationArea = All;
                    }
                    field("Resource Group No."; Rec."Resource Group No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Blocked; Rec.Blocked)
                    {
                        ApplicationArea = All;
                    }
                    field("Last Date Modified"; Rec."Last Date Modified")
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
        Rec.SetRange("No.");
    end;

    var
        ContractType: Option Sales,Purchase;
}

#pragma implicitwith restore

