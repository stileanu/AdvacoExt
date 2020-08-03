page 50034 "Boxed Entry"
{
    PageType = Card;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            group(Control1000000001)
            {
                ShowCaption = false;
                group(Control1000000008)
                {
                    ShowCaption = false;
                    field("Customer ID";"Customer ID")
                    {
                        Editable = false;
                    }
                    field("Work Order No.";"Work Order No.")
                    {
                        Editable = false;
                    }
                    field("Sales Order No.";"Sales Order No.")
                    {
                        Editable = false;
                    }
                    field("Model No.";"Model No.")
                    {
                        Editable = false;
                    }
                    field("Serial No.";"Serial No.")
                    {
                        Editable = false;
                    }
                    field(Boxed;Boxed)
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
            action("&Close")
            {
                Caption = '&Close';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.Close;
                end;
            }
        }
    }
}

