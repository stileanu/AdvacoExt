pageextension 62016 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Salesperson Code")
        {
            field(Rep; Rec.Rep)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}