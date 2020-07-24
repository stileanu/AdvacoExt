codeunit 50016 CMShipping
{

    trigger OnRun();
    begin
        ///--!
        //Window.OPEN('Enter the Credit Memo No. #1#########', CM);
        //Window.INPUT();
        //Window.CLOSE;
        GetWODNo.SetDialogValueType(SetType::WorkOrder, false);
        if GetWODNo.RunModal() = Action::OK then
            GetWODNo.GetWorkOrderNo_(CM);
        if CM <> '' then begin
            CreditHeader.SetCurrentKey("Document Type", "No.");
            CreditHeader.SetRange("No.", CM);
            IF CreditHeader.FIND('-') then begin
                IF CreditHeader."Bill of Lading" <> 0 then begin
                    Message('This Credit Memo already been Shipped, Please Contact Purchasing');
                end else begin
                    IF CreditHeader."Credit Memo Posted" then begin
                        Message('This Credit Memo has already been Posted, Please Contact Accounting');
                    end else begin
                        CreditLine.SETRANGE("Document Type", CreditHeader."Document Type");
                        CreditLine.SETRANGE("Document No.", CreditHeader."No.");
                        IF CreditLine.FIND('-') then begin
                            IF CreditHeader."Return to Vendor" then
                                Page.RUNMODAL(50141, CreditHeader)
                            else
                                Message('This Credit Memo hasn''t been setup to Return to Vendor, Please Contact Purchasing');
                        end else begin
                            Message('This Credit Memo doesn''t have anything to Ship, Contact Purchasing to Check Order');
                        end;
                    end;
                end;
            end else begin
                Message('Credit Memo %1 not found', CM);
            end;
        end;
        OpenNextRecord;
    end;

    var
        NextRecord: Codeunit CMShipping;
        Ok: Boolean;
        //Window: Dialog;
        GetWODNo: Page GetValueDialog;
        SetType: Enum ValueType;
        CM: Code[20];
        CreditHeader: Record "Purchase Header";
        CreditLine: Record "Purchase Line";

    procedure OpenNextRecord();
    begin
        IF NOT CONFIRM('Do you want to ship another Credit Memo', FALSE) then begin
            Commit();
            exit;
        end else begin
            Commit();
            NextRecord.RUN
        end;
    end;
}

