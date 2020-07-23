page 50100 GetValueDialog
{
    Caption = 'Get Value';
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
                Caption = 'Value';
                field(ValueNo_; ValueNo_)
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
        ValueNo_ := ' ';

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [ACTION::OK, ACTION::LookupOK] then
            if lValidate then
                case lValueType of
                    lValueType::WorkOrder:
                        begin
                            if not ValidateWONo_ then
                                Message(AdvacoErr001, ValueNo_);
                            if WODRec.Complete then
                                Message(AdvacoErr002, ValueNo_);
                        end;
                    lValueType::Item:
                        begin
                            if not ValidateItemNo_ then
                                Message(AdvacoErr003, ValueNo_);
                        end;
                end
            else begin
                exit(true);
            end;
    end;

    var
        ValueNo_: Code[20];
        lValueType: Enum ValueType;
        lValidate: Boolean;
        AdvacoErr001: Label 'Work Order No. %1 does not exist.';
        AdvacoErr002: Label 'Work Order No. %1 is completed';
        AdvacoErr003: Label 'Item No. %1 does not exists';
        WODRec: Record WorkOrderDetail;
        ItemRec: Record Item;

    local procedure ValidateWONo_(): Boolean
    begin
        if WODRec.Get(ValueNo_) then
            exit(true);
        exit(false);
    end;

    procedure ValidateItemNo_(): Boolean
    begin
        if ItemRec.Get(ValueNo_) then
            exit(true);
        exit(false);
    end;

    procedure SetDialogValueType(ReqValueType: Enum ValueType; Validate: Boolean)
    begin
        lValueType := ReqValueType;
        lValidate := Validate;
    end;

    procedure GetWorkOrderNo_(var WorkOrderNo_: Code[20])
    begin
        WorkOrderNo_ := ValueNo_;
    end;
}