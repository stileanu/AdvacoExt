page 50104 "Daily Parts Export"
{
    PageType = List;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        if DateFilter = '' then begin
            ///--!
            //Window.Open('Enter the Date Filter #1#########', DateFilter);
            //Window.Input();
            //Window.Close;
            vDF := DateFilter;
            InValDialog.SetValueType(InValType::TextType, 'Enter the Date Filter:');
            if InValDialog.RunModal() = Action::OK then
                InValDialog.GetEnteredValue(vDF);
            DateFilter := StrSubstNo(vDF, 1, 30);

        end;
        // Apply filter
        Rec.SetCurrentKey("Document No.", "Posting Date");
        Rec.SetFilter("Document No.", 'DAILYPARTS*');
        Rec.SetFilter("Posting Date", DateFilter);
    end;

    var
        vDF: Variant;
        InValDialog: Page InputValueDialog;
        InValType: Enum InValueType;
        ItemRegister: Record "Item Register";
        Window: Dialog;
        DateFilter: Text[30];
}

