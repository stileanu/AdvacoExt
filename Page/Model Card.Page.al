#pragma implicitwith disable
page 50004 "Model Card"
{
    PageType = Card;
    SourceTable = Item;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Model Type"; Rec."Model Type")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Model)
            {
                Caption = 'Model';
                action("Bill of Materials")
                {
                    ApplicationArea = All;
                    Caption = 'Bill of Materials';
                    RunObject = Page "Assembly BOM";
                    RunPageLink = "Parent Item No." = FIELD("No.");
                }
                action("Parts List")
                {
                    ApplicationArea = All;
                    Caption = 'Parts List';

                    trigger OnAction()
                    begin
                        Item.SetRange(Item."No.", Rec."No.");
                        REPORT.Run(50066, true, false, Item);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("No.");
    end;

    var
        Location: Record Location;
        ContractType: Option Sales,Purchase;
        Ok: Boolean;
        Item: Record Item;
}

#pragma implicitwith restore

