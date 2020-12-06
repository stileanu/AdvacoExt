pageextension 62034 SalesLineCommentExt extends "comment list"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addfirst(Processing)
        {

            action(EditComments)
            {
                ApplicationArea = All;
                Caption = 'Edit Comments';
                Image = EditList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Comment Sheet";
                RunPageLink = "No." = field("No."), "Table Name" = filter(Customer);

            }
        }
    }

    var
        myInt: Integer;
}