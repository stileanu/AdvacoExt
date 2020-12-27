codeunit 50097 PurchaseHeaderSubscriber
{
    trigger OnRun()
    begin

    end;

    //ICE RSK 12/23/20 for creating orders from blanket orders

    [EventSubscriber(ObjectType::Codeunit, 97, 'OnBeforePurchOrderHeaderModify', '', false, false)]
    local procedure OnBeforePurchaseOrderHeaderModify(var PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."Order Date" := WORKDATE;
        PurchORderHeader."Document Date" := WORKDATE;
        PurchOrderHeader."Due Date" := 0D;

        BlanketOrderPurchHeader."Order Date" := WORKDATE;
        BlanketOrderPurchHeader."Document Date" := WORKDATE;
        BlanketOrderPurchHeader."Due Date" := 0D;
        //BlanketOrderPurchHeader.Modify();



    end;

    var
        myInt: Integer;
}