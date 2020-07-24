codeunit 50012 OrderType
{
    // version ADV

    // 04/13/2011 - ADV
    //   Solved an infinite loop if form 50045 non editable and info not in table.
    //   Added CONFIRM to cancel the form.


    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########', WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN);
        IF WODN <> '' THEN BEGIN
            IF WOD.GET(WODN) THEN BEGIN
                OLDWOD.GET(WODN);
                Page.RUNMODAL(50045, WOD);
                TestComplete;
            END ELSE BEGIN
                MESSAGE('Work Order Detail %1 not found', WODN);
                NextRecord.RUN;
            END;
        END;

        OpenNextRecord;
    end;

    var
        WOD: Record WorkOrderDetail;
        OLDWOD: Record WorkOrderDetail;
        WOD2: Record WorkOrderDetail;
        NextRecord: Codeunit OrderType;
        //Window : Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;

        WODN: Code[7];

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

    procedure TestComplete();
    begin
        WOD2.GET(WODN);
        IF OLDWOD."Order Type" <> WOD2."Order Type" THEN BEGIN
            IF WOD2."Order Type Reason" = '' THEN BEGIN
                MESSAGE('You must enter an Order Type Reason');

                // 04/13/2011 ADV : Start
                IF CONFIRM('Do you want to stop editing current order?', FALSE) THEN
                    EXIT;
                // 04/13/2011 ADV : End

                Page.RUNMODAL(50045, WOD2);
                COMMIT;
                TestComplete;
            END;
        END;

        IF WOD2."Order Type" = WOD2."Order Type"::Warranty THEN BEGIN
            IF (WOD2."Warranty Type" = WOD2."Warranty Type"::" ") OR (WOD2."Warranty Reason" = '') THEN BEGIN
                MESSAGE('Warranty Type and Warranty Reason must be entered');

                // 04/13/2011 ADV : Start
                IF CONFIRM('Do you want to stop editing current order?', FALSE) THEN
                    EXIT;
                // 04/13/2011 ADV : End

                Page.RUNMODAL(50045, WOD2);
                COMMIT;
                TestComplete;
            END;
        END;
    end;
}

