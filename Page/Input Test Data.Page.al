page 50043 "Input Test Data"
{
    PageType = Card;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group("Ultimate Test Information")
            {
                field("Ultimate Test"; Rec."Ultimate Test")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Rec."Ultimate Test" = '' then
            Error('You must enter Ultimate Test Information!');
    end;
}

