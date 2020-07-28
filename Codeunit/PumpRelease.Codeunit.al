codeunit 50010 PumpRelease
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########',WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN);
        IF WODN <> '' THEN BEGIN
            IF WOD.GET(WODN) THEN BEGIN
                Page.RUNMODAL(50044, WOD);
            END ELSE BEGIN
                MESSAGE('Work Order Detail %1 not found', WODN);
                NextRecord.RUN;
            END;
        END;
        OpenNextRecord;
    end;

    var
        WOD: Record WorkOrderDetail;
        NextRecord: Codeunit PumpRelease;
        Ok: Boolean;
        //Window : Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WODN: Code[7];
        WOM: Record WorkOrderMaster;

    procedure OpenNextRecord();
    begin
        IF NOT CONFIRM('Do you want to update another record?', FALSE) THEN BEGIN
            COMMIT;
            EXIT;
        END ELSE BEGIN
            COMMIT;
            NextRecord.RUN
        END;
    end;
}

