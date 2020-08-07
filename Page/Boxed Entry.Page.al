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
                    field("Customer ID"; "Customer ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Work Order No."; "Work Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Sales Order No."; "Sales Order No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Model No."; "Model No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Serial No."; "Serial No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Boxed; Boxed)
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
            action("&Close")
            {
                ApplicationArea = All;
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

