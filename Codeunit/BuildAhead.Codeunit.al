codeunit 50007 "Build Ahead"
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Number #1#########',WODN);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(WODN)
        else
            exit;

        if WODN <> '' then begin
            WOD.SetCurrentKey(WOD."Work Order No.");
            if WOD.GET(WODN) then begin
                WOM.GET(WOD."Work Order Master No.");
                BlockCheck;
                if Continue = TRUE then begin
                    if WOD.Complete then begin
                        if WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::" " then begin
                            Message('The Work Order was shipped');
                            OpenNextRecord;
                        end;
                        if WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Un-Assembled" then begin
                            Message('The Work Order was shipped Un-Assembled');
                            OpenNextRecord;
                        end;
                        if WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Return Assembled" then begin
                            Message('The Work Order was shipped Assembled');
                            OpenNextRecord;
                        end;
                        if WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::"Save Parts & Scrap" then begin
                            Message('The Pump was Scrapped & Parts Saved');
                            OpenNextRecord;
                        end;
                        if WOD."Unrepairable Handling" = WOD."Unrepairable Handling"::Scrap then begin
                            Message('The Pump was Scrapped');
                            OpenNextRecord;
                        end;
                    end ELSE begin
                        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
                        WOS.SetRange(WOS."Order No.", WOD."Work Order No.");
                        WOS.SetRange(WOS.Step, WOS.Step::QOT);
                        WOS.SetRange(WOS.Status, WOS.Status::Waiting);
                        if WOS.FIND('+') then begin
                            Found;
                        end ELSE begin
                            WOSTEP.SetCurrentKey(WOSTEP."Order No.", WOSTEP."Line No.");
                            WOSTEP.SetRange(WOSTEP."Order No.", WOD."Work Order No.");
                            WOSTEP.SetRange(WOSTEP.Status, WOSTEP.Status::Waiting);
                            if WOSTEP.FIND('+') then begin
                                CurrentStep := WOSTEP.Step;
                                Message('Work Order Detail is in %1', CurrentStep);
                                OpenNextRecord;
                            end ELSE begin
                                Message('Pump has not been Received');
                                OpenNextRecord;
                            end;
                        end;
                    end;
                end ELSE
                    OpenNextRecord;
            end ELSE begin
                Message('Work Order Detail %1 not found', WODN);
                NextRecord.RUN;
            end;
        end ELSE begin
            Message('You must enter a number.');
            NextRecord.RUN;
        end;
    end;

    var
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        WOS2: Record Status;
        //Window : Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        WODN: Code[50];
        NextRecord: Codeunit "Build Ahead";
        Ok: Boolean;
        Parts: Record Parts;
        CurrentStep: Enum DetailStep;
        //REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        NewStep: Enum DetailStep;
        //REC,DIS,QOT,"B-O",CLN,ASM,TST,REP,RET,MSP,PNT,QC,SHP;
        Mechanics: Record "Pump Failures";
        Customer: Record Customer;
        Continue: Boolean;
        WOSTEP: Record Status;
        CodeDateIn: Date;
        CodeDateOut: Date;
        CodePerson: Code[10];
        CodeRegular: Decimal;
        CodeOvertime: Decimal;
        WOD2: Record WorkOrderDetail;
        Open: Boolean;
        WOD2Backorder: Record WorkOrderDetail;

    procedure Found();
    begin
        if WOD."Quote Phase".AsInteger() < 2 then begin
            if WOD."Pump Module" then begin
                Message('Work Order %1 is Quoted for a Pump Module and Need to be processed by the Parts Department', WOD."Work Order No.");
            end ELSE begin
                Message('Work Order %1 hasn''t Completed Quote Phase 1', WODN);
                OpenNextRecord;
            end;
        end ELSE
            if WOD."Quote Phase".AsInteger() = 2 then begin
                Phase2;
            end ELSE begin
                if WOD."Build Ahead" = TRUE then begin
                    Message('Work Order %1 has been Pre-Released, and all parts changes need to be made through Parts Adjustment', WODN);
                    OpenNextRecord;
                end ELSE begin
                    Message('Work Order %1 is in Quote Phase 3, and can''t be Quoted as a Build Ahead', WODN);
                    OpenNextRecord;
                end;
            end;
    end;

    procedure Phase2();
    begin
        ///--!
        PAGE.RUNMODAL(50023, WOS);

        WOD.RESET;
        WOD.SetCurrentKey(WOD."Work Order No.");
        if WOD.GET(WODN) then begin
        end;

        // Runs only if Build Ahead Buttton Pressed on Screen
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", WOD."Work Order No.");
        WOS.SetRange(WOS.Step, WOS.Step::"B-O");
        WOS.SetRange(WOS.Status, WOS.Status::Waiting);
        if WOS.FIND('+') then begin
            Parts.SetRange(Parts."Work Order No.", WOS."Order No.");
            if Parts.FIND('-') then begin
                REPEAT
                    // Checks to see if In-Process Parts are Pulled
                    Parts.CALCFIELDS(Parts."In-Process Quantity");
                    if (Parts."Quantity Backorder" > 0) OR (Parts."Pulled Quantity" < Parts."In-Process Quantity") then
                        Open := TRUE;
                UNTIL Parts.NEXT = 0;
            end;

            WOD."Quote Phase" := WOD."Quote Phase"::"Phase 3";
            if Open then
                WOD.BackorderText := 'BACK ORDER';
            WOD.MODifY;
            WOS.Status := WOS.Status::Complete;
            WOS.MODifY;
            COMMIT;

            WOS2.INIT;
            WOS2."Order No." := WOS."Order No.";
            WOS2."Line No." := WOS."Line No." + 10000;
            WOS2.Step := WOS2.Step::CLN;
            WOS2."Date In" := WORKDATE;
            WOS2.INSERT;

            if Open then begin
                Message('This Order is NOT COMPLETE');
                OpenNextRecord;
            end ELSE begin
                Message('This Order is Complete');
                OpenNextRecord;
            end;

        end ELSE begin
            Message('Work Order %1 is still in Quote Phase 2, and Not Released as a Build Ahead', WODN);
            OpenNextRecord;
        end;
    end;

    procedure TestComplete();
    begin
    end;

    procedure BlockCheck();
    begin
        Continue := TRUE;
        if Customer.GET(WOM.Customer) then begin
            if Customer.Blocked <> Customer.Blocked::" " then begin
                if WOD.Unblocked = FALSE then begin
                    Message('This Work Order Detail is currently Blocked.  Please see Accounting');
                    Continue := FALSE;
                end;
            end;
        end;
    end;

    procedure OpenNextRecord();
    begin
        if NOT CONFIRM('Do you want to update another record?', FALSE) then begin
            COMMIT;
            EXIT;
        end ELSE begin
            COMMIT;
            NextRecord.RUN
        end;
    end;
}

