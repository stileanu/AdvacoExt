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

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Ship-to Code', true, true)]
    local procedure OnBeforeValidateShiptoCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        shiptoaddress: Record "Ship-to Address";
    begin
        if rec."Tax Area Code" = '' then begin
            if rec."Ship-to Code" <> '' then begin
                if shiptoaddress.get(rec."Sell-to Customer No.", rec."Ship-to Code") then begin
                    if shiptoaddress."Tax Area Code" <> '' then
                        shiptoaddress."Tax Area Code" := '';
                    shiptoaddress.modify;

                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Code', true, true)]
    local procedure OnAfterValidateShiptoCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        shiptoaddress: Record "Ship-to Address";
    begin
        // new function ICE 2/2/20121 
        if rec."Ship-to Code" <> '' then begin
            if shiptoaddress.get(rec."Sell-to Customer No.", rec."Ship-to Code") then begin
                Rec."Salesperson Code" := shiptoaddress."Inside Sales";
                Rec.Rep := shiptoaddress.Rep;
                Rec."Freight include in Price" := shiptoaddress."Freight include in Price";
            end;
        end;

    end;
}