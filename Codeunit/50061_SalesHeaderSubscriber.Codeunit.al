codeunit 50061 SalesHeaderSubscriber
{
    trigger OnRun()
    begin

    end;

    //OnAfterRecreateSalesLine(SalesLine, TempSalesLine);
    [EventSubscriber(ObjectType::Table, 36, 'OnAfterRecreateSalesLine', '', false, false)]
    procedure SalesHeader_Onafter(var SalesLine: Record "Sales Line"; var TEmpSalesLine: Record "Sales Line")
    begin

        SalesLine.validate("Unit Price", TEmpSalesLine."Unit Price");

    end;


}