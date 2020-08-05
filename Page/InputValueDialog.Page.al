page 50131 InputValueDialog
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
                Caption = 'Get Value';
                field(tValCaption; tValCaption)
                {
                    Editable = false;
                    Enabled = false;
                }
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

    /*
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //if CloseAction in [ACTION::OK, ACTION::LookupOK] then
        exit(true);
    end;
    */

    var
        tValCaption: Text[60];
        ValueNo_: Text[120];
        lValueType: Enum InValueType;
        tVal: Text[120];
        cVal: Code[50];
        dtVal: Date;
        dVal: Decimal;
        iVal: Integer;
        dfVal: Text[30];


    procedure SetValueType(ReqValueType: Enum InValueType; CaptionVal: Text[60])
    begin
        tValCaption := CaptionVal;
        lValueType := ReqValueType;
    end;

    procedure GetEnteredValue(var RetValue: Variant)
    begin
        case lValueType of
            lValueType::TextType:
                RetValue := ValueNo_;
            lValueType::CodeType:
                RetValue := UpperCase(ValueNo_);
            else
                if not Evaluate(RetValue, ValueNo_) then
                    Error('Not a valid value.');
        end;
        /*
        if (lValueType = lValueType::InstallText) or (lValueType = lValueType::DateFilter) then
            WorkOrderNo_ := Format(ValueNo_)
        else
            WorkOrderNo_ := ValueNo_;
        */
    end;
}