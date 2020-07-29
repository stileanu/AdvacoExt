codeunit 50002 "Work Order Detail Insert"
{
    // 03/31/18
    //   Added code to test for limit for maximum 99 details.

    TableNo = 50000;

    trigger OnRun();
    var
        localDetailsNo: Integer;
    begin

        WorkOrderDetail3.SETCURRENTKEY(WorkOrderDetail3."Work Order No.");
        WorkOrderDetail3.SETRANGE(WorkOrderDetail3."Work Order Master No.", "Work Order Master No.");
        IF WorkOrderDetail3.FIND('+') THEN BEGIN
            WorkOrderDetail3.CALCFIELDS(WorkOrderDetail3."Detail Step");
            // 03/31/18 Start
            EVALUATE(localDetailsNo, WorkOrderDetail3."Detail No.");
            IF localDetailsNo >= 99 THEN
                ERROR('You have reach the maximum 99 details for this Work Order. You cannot add another Detail, create a new Order.');
            // 03/31/18 End
            NextWONo := INCSTR(WorkOrderDetail3."Detail No.");
        END;

        WorkOrderDetail.SETCURRENTKEY(WorkOrderDetail."Work Order No.");
        WorkOrderDetail.SETRANGE(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
        IF WorkOrderDetail.FIND('-') THEN BEGIN
            REPEAT
                WorkOrderDetail.CALCFIELDS(WorkOrderDetail."Detail Step");
                IF WorkOrderDetail."Detail Step" <> WorkOrderDetail."Detail Step"::SHP THEN BEGIN
                    RecordCount := RecordCount + 1;
                END ELSE
                    Ok := FALSE;
            UNTIL WorkOrderDetail.NEXT = 0;

            IF RecordCount > 0 THEN Ok := TRUE;

            IF Ok = FALSE THEN
                ERROR('All Details are already in Shipping for this Work Order.  You must create a new Work Order.')
            ELSE BEGIN
                WorkOrderDetail2.INIT;
                WorkOrderDetail2."Work Order Master No." := "Work Order Master No.";
                WorkOrderDetail2."Detail No." := NextWONo;
                WorkOrderDetail2."Work Order No." := COPYSTR("Work Order Master No.", 1, 5) + WorkOrderDetail2."Detail No.";
                WorkOrderDetail2."Customer ID" := Customer;
                WorkOrderDetail2."Payment Method" := "Payment Method";
                WorkOrderDetail2."Card Type" := "Card Type";
                WorkOrderDetail2."Credit Card No." := "Credit Card No.";
                WorkOrderDetail2."Credit Card Exp." := "Credit Card Exp.";
                WorkOrderDetail2."Tax Liable" := "Tax Liable";
                WorkOrderDetail2."Payment Terms" := "Customer Payment Terms";
                WorkOrderDetail2."Ship To Name" := "Ship To Name";
                WorkOrderDetail2."Ship To Address 1" := "Ship To Address 1";
                WorkOrderDetail2."Ship To Address 2" := "Ship To Address 2";
                WorkOrderDetail2."Ship To City" := "Ship To City";
                WorkOrderDetail2."Ship To State" := "Ship To State";
                WorkOrderDetail2."Ship To Zip Code" := "Ship To Zip Code";
                WorkOrderDetail2.Attention := Attention;
                WorkOrderDetail2."Phone No." := "Phone No.";
                WorkOrderDetail2."Container Quantity" := 1;
                WorkOrderDetail2."Work Order Date" := "Date Ordered";
                WorkOrderDetail2."Date Required" := "Date Required";

                CUST.GET(Customer);
                WorkOrderDetail2."Ship on Sales Order" := CUST."Ship on Sales Order";

                WorkOrderDetail2.INSERT;

            END;

        END ELSE BEGIN
            WorkOrderDetail2.INIT;
            WorkOrderDetail2."Work Order Master No." := "Work Order Master No.";
            WorkOrderDetail2."Detail No." := '01';
            WorkOrderDetail2."Work Order No." := COPYSTR("Work Order Master No.", 1, 5) + WorkOrderDetail2."Detail No.";
            WorkOrderDetail2."Customer ID" := Customer;
            WorkOrderDetail2."Payment Method" := "Payment Method";
            WorkOrderDetail2."Card Type" := "Card Type";
            WorkOrderDetail2."Credit Card No." := "Credit Card No.";
            WorkOrderDetail2."Credit Card Exp." := "Credit Card Exp.";
            WorkOrderDetail2."Tax Liable" := "Tax Liable";
            WorkOrderDetail2."Payment Terms" := "Customer Payment Terms";
            WorkOrderDetail2."Ship To Name" := "Ship To Name";
            WorkOrderDetail2."Ship To Address 1" := "Ship To Address 1";
            WorkOrderDetail2."Ship To Address 2" := "Ship To Address 2";
            WorkOrderDetail2."Ship To City" := "Ship To City";
            WorkOrderDetail2."Ship To State" := "Ship To State";
            WorkOrderDetail2."Ship To Zip Code" := "Ship To Zip Code";
            WorkOrderDetail2.Attention := Attention;
            WorkOrderDetail2."Phone No." := "Phone No.";
            WorkOrderDetail2."Container Quantity" := 1;
            WorkOrderDetail2."Work Order Date" := "Date Ordered";
            WorkOrderDetail2."Date Required" := "Date Required";

            CUST.GET(Customer);
            WorkOrderDetail2."Ship on Sales Order" := CUST."Ship on Sales Order";

            WorkOrderDetail2.INSERT;

        END;

        COMMIT;

        WorkOrderDetail2.SETRANGE(WorkOrderDetail2."Work Order No.", WorkOrderDetail2."Work Order No.");
        PAGE.RUNMODAL(50002, WorkOrderDetail2);

        IF NOT CONFIRM('Add more Records', FALSE) THEN
            EXIT
        ELSE
            AddRecords.RUN(Rec);
    end;

    var
        WorkOrderDetail2: Record WorkOrderDetail;
        WorkOrderDetail3: Record WorkOrderDetail;
        WorkOrderDetail4: Record WorkOrderDetail;
        WorkOrderDetail: Record WorkOrderDetail;
        NextWONo: Code[10];
        RecordCount: Integer;
        Ok: Boolean;
        AddRecords: Codeunit "Work Order Detail Insert";
        CUST: Record Customer;
}

