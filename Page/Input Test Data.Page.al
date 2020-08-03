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
                field("Ultimate Test";"Ultimate Test")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if "Ultimate Test" = '' then
          Error('You must enter Ultimate Test Information!');
    end;
}

