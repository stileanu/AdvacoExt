codeunit 50022 DeleteWO
{

    trigger OnRun();
    begin
        IF CONFIRM('Do you want to delete WOs? (Y/N)') THEN BEGIN
            REPEAT
                ///--!
                //Window.OPEN('Enter the Work Order No. #1#########', WODNo);
                //Window.INPUT();
                //Window.CLOSE;
                GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
                if GetWODNo.RunModal() = Action::OK then
                    GetWODNo.GetWorkOrderNo_(WODNo);
                WOM.RESET;
                IF WOD.GET(WODNo) THEN
                    DeleteWODData(WOD)
                ELSE
                    IF (WODNo <> '0') THEN
                        MESSAGE('Cannot find WO %1', WODNo);
            UNTIL WODNo = '0';
        END;
    end;

    var
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        //Window: Dialog;
        WODNo: Code[10];
        WOD: Record WorkOrderDetail;
        WOM: Record WorkOrderMaster;

    procedure DeleteWODData(WODet: Record WorkOrderDetail);
    var
        lWOD: Record WorkOrderDetail;
        nWOD: Integer;
        WOParts: Record Parts;
        WOSteps: Record Status;
        iRec: Integer;
    begin
        lWOD.SETCURRENTKEY("Work Order Master No.");
        lWOD.SETRANGE("Work Order Master No.", WOD."Work Order Master No.");
        lWOD.FINDSET;
        nWOD := lWOD.COUNT;
        WOM.GET(WOD."Work Order Master No.");

        // Delete Parts if any
        WOParts.RESET;
        WOParts.SETRANGE("Work Order No.", WODNo);
        IF WOParts.FINDFIRST THEN BEGIN
            iRec := WOParts.COUNT;
            WOParts.DELETEALL(FALSE);
            iRec := WOParts.COUNT;
        END;

        // Delete steps
        WOSteps.RESET;
        WOSteps.SETRANGE("Order No.", WODNo);
        IF WOSteps.FINDFIRST THEN BEGIN
            iRec := WOSteps.COUNT;
            WOSteps.DELETEALL(FALSE);
            iRec := WOSteps.COUNT;
        END;

        // Delete WOD
        WOD.DELETE(FALSE);

        IF nWOD = 1 THEN BEGIN
            // Delete WOM too
            WOM.DELETE(FALSE);
        END;

        // Commit changes
        COMMIT;
    end;
}

