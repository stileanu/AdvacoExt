page 50100 GetWONoDialog
{
    Caption = 'Get Work Order No.';
    PageType = StandardDialog;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    //SourceTable = TableName;

    layout
    {
        area(Content)
        {
            group(OrderNo_)
            {
                Caption = 'Work Order No.';
                field(WONo_; WONo_)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    /*
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    */

    trigger OnOpenPage()
    begin
        WONo_ := ' ';

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
            if not ValidateWONo_ then
                Message(AdvacoErr001, WONo_);
            if WODRec.Complete then
                Message(AdvacoErr002, WONo_);
        end else begin
            exit(true);
        end;
    end;

    var
        WONo_: Code[20];
        AdvacoErr001: Label 'Work Order No. %1 does not exist.';
        AdvacoErr002: Label 'Work Order No. %1 is completed';
        WODRec: Record WorkOrderDetail;

    local procedure ValidateWONo_(): Boolean
    begin
        if WODRec.Get(WONo_) then
            exit(true);
        exit(false);
    end;

    procedure GetWorkOrderNo_(var WorkOrderNo_: Code[20])
    begin
        WorkOrderNo_ := WONo_;
    end;
}