page 50197 "Billing List 50035"
{
    PageType = List;
    SourceTable = WorkOrderDetail;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Caption = 'BILLING LIST';
                field("Billing List"; "Billing List")
                {
                }
                field("Work Order No."; "Work Order No.")
                {
                }
                field("Model No."; "Model No.")
                {
                }
                field("Detail Step"; "Detail Step")
                {
                }
                field(Complete; Complete)
                {
                }
                field("Income Code"; "Income Code")
                {
                }
            }
            group(Control1220060010)
            {
                ShowCaption = false;
                field(TotalServiceAmt; TotalServiceAmt)
                {
                    Caption = 'Total Service';
                }
                field(TotalSalesAmt; TotalSalesAmt)
                {
                    Caption = 'Total Sales';
                }
                field(TotalTurboAmt; TotalTurboAmt)
                {
                    Caption = 'Total Turbo';
                }
                field(TotalElectronicAmt; TotalElectronicAmt)
                {
                    Caption = 'Total Electronic';
                }
                field(TotalDryAmt; TotalDryAmt)
                {
                    Caption = 'Total Dry';
                }
                field(TotalCryoAmt; TotalCryoAmt)
                {
                    Caption = 'Total Cryo';
                }
                field(ServiceAmt; ServiceAmt)
                {
                    Caption = 'Shipped Service';
                }
                field("<TotalSalesAmt2>"; TotalSalesAmt)
                {
                    Caption = 'Shipped Sales';
                }
                field("<TotalTurboAmt2>"; TotalTurboAmt)
                {
                    Caption = 'Shipped Turbo';
                }
                field("<TotalElectronicAmt2>"; TotalElectronicAmt)
                {
                    Caption = 'Shipped Electronic';
                }
                field("<TotalDryAmt2>"; TotalDryAmt)
                {
                    Caption = 'Shipped Dry';
                }
                field("<TotalCryoAmt2>"; TotalCryoAmt)
                {
                    Caption = 'Shipped Cryo';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(RESET)
            {
                Caption = 'RESET';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ResetVisible;

                trigger OnAction()
                begin
                    IF CONFIRM('Are you sure you want to reset all marked records?', FALSE) THEN BEGIN
                        IF CONFIRM('There is no way to undo this procedure.  Are you sure you wish to continue?', FALSE) THEN BEGIN
                            MESSAGE('You must close and reopen the screen in order to refresh the records');
                            IF WOD.FIND('-') THEN
                                WOD."Billing List" := FALSE;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ServiceAmt := 0;
        SalesAmt := 0;
        TurboAmt := 0;
        ElectronicAmt := 0;
        DryAmt := 0;
        CryoAmt := 0;

        CASE "Income Code" OF
            "Income Code"::Service:
                Service;
            "Income Code"::Sales:
                Sales;
            "Income Code"::Turbo:
                Turbo;
            "Income Code"::Electronic:
                Electronic;
            "Income Code"::Dry:
                Dry;
            "Income Code"::Cryo:
                Cryo;

        END;
    end;

    trigger OnInit()
    begin
        UserName := USERID;
        GroupsBelongedTo.CALCFIELDS("User Name");

        Permitted := FALSE;
        GroupsBelongedTo.SETFILTER("User Name", UserName);
        IF GroupsBelongedTo.FIND('-') THEN
            REPEAT
                IF GroupsBelongedTo."Role ID" = 'ADV-SALESMNGR' THEN
                    Permitted := TRUE;
            UNTIL GroupsBelongedTo.NEXT = 0;
    end;

    trigger OnOpenPage()
    begin
        IF Permitted = FALSE THEN BEGIN
            ResetVisible := FALSE;
        END ELSE
            ResetVisible := TRUE;
    end;

    var
        ServiceAmt: Decimal;
        ServiceAmtShipped: Decimal;
        TotalServiceAmt: Decimal;
        SalesAmt: Decimal;
        SalesAmtShipped: Decimal;
        TotalSalesAmt: Decimal;
        TurboAmt: Decimal;
        TurboAmtShipped: Decimal;
        TotalTurboAmt: Decimal;
        ElectronicAmt: Decimal;
        ElectronicAmtShipped: Decimal;
        TotalElectronicAmt: Decimal;
        DryAmt: Decimal;
        DryAmtShipped: Decimal;
        TotalDryAmt: Decimal;
        CryoAmt: Decimal;
        CryoAmtShipped: Decimal;
        TotalCryoAmt: Decimal;
        WOD: Record WorkOrderDetail;
        UserName: Code[10];
        Permitted: Boolean;
        GroupsBelongedTo: Record "Access Control";
        [InDataSet]
        ResetVisible: Boolean;

    procedure Service()
    begin
        ServiceAmt := "Quote Price";
        IF Complete THEN
            ServiceAmtShipped := ServiceAmtShipped + "Quote Price";
        TotalServiceAmt := TotalServiceAmt + ServiceAmt;
    end;

    procedure Sales()
    begin
        SalesAmt := "Quote Price";
        IF Complete THEN
            SalesAmtShipped := SalesAmtShipped + "Quote Price";
        TotalSalesAmt := TotalSalesAmt + SalesAmt;
    end;

    procedure Turbo()
    begin
        TurboAmt := "Quote Price";
        IF Complete THEN
            TurboAmtShipped := TurboAmtShipped + "Quote Price";
        TotalTurboAmt := TotalTurboAmt + TurboAmt;
    end;

    procedure Electronic()
    begin
        ElectronicAmt := "Quote Price";
        IF Complete THEN
            ElectronicAmtShipped := ElectronicAmtShipped + "Quote Price";
        TotalElectronicAmt := TotalElectronicAmt + ElectronicAmt;
    end;

    procedure Dry()
    begin
        DryAmt := "Quote Price";
        IF Complete THEN
            DryAmtShipped := DryAmtShipped + "Quote Price";
        TotalDryAmt := TotalDryAmt + DryAmt;
    end;

    procedure Cryo()
    begin
        CryoAmt := "Quote Price";
        IF Complete THEN
            CryoAmtShipped := CryoAmtShipped + "Quote Price";
        TotalCryoAmt := TotalCryoAmt + CryoAmt;
    end;
}

