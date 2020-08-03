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
                field("No.";"No.")
                {

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit() then
                          CurrPage.Update;
                    end;
                }
                field(Description;Description)
                {
                }
                field("Model Type";"Model Type")
                {
                }
                field("Gross Weight";"Gross Weight")
                {
                }
                field("Assembly BOM";"Assembly BOM")
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Model)
            {
                Caption = 'Model';
                action("Bill of Materials")
                {
                    Caption = 'Bill of Materials';
                    RunObject = Page "Assembly BOM";
                    RunPageLink = "Parent Item No."=FIELD("No.");
                }
                action("Parts List")
                {
                    Caption = 'Parts List';

                    trigger OnAction()
                    begin
                        Item.SetRange(Item."No.","No.");
                        REPORT.Run(50066,true,false,Item);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("No.");
    end;

    var
        Location: Record Location;
        ContractType: Option Sales,Purchase;
        Ok: Boolean;
        Item: Record Item;
}

