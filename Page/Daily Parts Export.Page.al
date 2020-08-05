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
                field("Item No."; "Item No.")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Entry Type"; "Entry Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("Source No."; "Source No.")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Entry No."; "Entry No.")
                {
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
        SetCurrentKey("Document No.", "Posting Date");
        SetFilter("Document No.", 'DAILYPARTS*');
        SetFilter("Posting Date", DateFilter);
    end;

    var
        vDF: Variant;
        InValDialog: Page InputValueDialog;
        InValType: Enum InValueType;
        ItemRegister: Record "Item Register";
        Window: Dialog;
        DateFilter: Text[30];
}

