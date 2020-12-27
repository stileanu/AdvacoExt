report 50053 "WO Back Orders Sorted by WO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50053_WOBackOrdersSortedbyWO.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'WO Back Orders Soted by WO';

    dataset
    {
        dataitem(Parts; Parts)
        {
            CalcFields = "Committed Quantity", "In-Process Quantity";
            DataItemTableView = SORTING("Work Order No.", "Part No.") ORDER(Ascending) WHERE("Part Type" = CONST(Item));
            RequestFilterFields = "Work Order No.", "Quantity Backorder", "Committed Quantity", "In-Process Quantity", "Pulled Quantity";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Work_Orders_with_Back_Orders_; 'Work Orders with Back Orders')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(Parts__Work_Order_No__; "Work Order No.")
            {
            }
            column(Parts__Part_No__; "Part No.")
            {
            }
            column(Parts_Description; Description)
            {
            }
            column(QtyCommitted; QtyCommitted)
            {
            }
            column(Item__Qty__on_Purch__Order_; Item."Qty. on Purch. Order")
            {
            }
            column(Parts__Quantity_Backorder_; "Quantity Backorder")
            {
            }
            column(Qty; Qty)
            {
            }
            column(Parts__Purchase_Order_No__; "Purchase Order No.")
            {
            }
            column(Vendor; Vendor)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Work_OrderCaption; Work_OrderCaptionLbl)
            {
            }
            column(Parts__Part_No__Caption; FieldCaption("Part No."))
            {
            }
            column(Parts_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Total_QuantityCaption; Total_QuantityCaptionLbl)
            {
            }
            column(PO_QtyCaption; PO_QtyCaptionLbl)
            {
            }
            column(Parts__Quantity_Backorder_Caption; FieldCaption("Quantity Backorder"))
            {
            }
            column(Main_QuantityCaption; Main_QuantityCaptionLbl)
            {
            }
            column(Parts__Purchase_Order_No__Caption; FieldCaption("Purchase Order No."))
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(Parts_Part_Type; "Part Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Ok := false;
                QtyAvailable := 0;
                Qty := 0;
                QtyAvailableCommitted := 0;
                QtyCommitted := 0;
                Vendor := '';


                WOD.SetRange(WOD."Work Order No.", Parts."Work Order No.");
                if WOD.Find('-') then begin
                    WOD.CalcFields(WOD."Detail Step");
                    //if WOD."Detail Step" >= 3 then begin ICE-MPC 08/14/20
                    if WOD."Detail Step".AsInteger() >= 3 then begin
                        if WOD.Complete then begin
                            Ok := false;
                        end else begin
                            if Parts."Quantity Backorder" > 0 then begin
                                //if (WOD."Build Ahead") and ((WOD.Quote = 0) or (WOD.Quote = WOD.Quote :: "Not Repairable")) then begin ICE-MPC 08/14/20
                                if (WOD."Build Ahead") and ((WOD.Quote.AsInteger() = 0) or (WOD.Quote = WOD.Quote::"Not Repairable")) then begin
                                    Ok := false;
                                end else begin
                                    if Item.Get(Parts."Part No.") then begin
                                        Item.SetFilter(Item."Location Filter", 'COMMITTED');
                                        Item.CalcFields(Item.Inventory, Item."Qty. on Purch. Order", Item."Qty. on Sales Order");
                                        QtyAvailableCommitted := Item.Inventory;
                                        QtyCommitted := Item.Inventory;

                                        Item.SetFilter(Item."Location Filter", 'MAIN');
                                        Item.CalcFields(Item.Inventory, Item."Qty. on Purch. Order", Item."Qty. on Sales Order");
                                        QtyAvailable := Item.Inventory + Item."Qty. on Purch. Order" - Item."Qty. on Sales Order";
                                        Qty := Item.Inventory - Item."Qty. on Sales Order";
                                        QtyAvailableCommitted := QtyAvailableCommitted + QtyAvailable;
                                        QtyCommitted := QtyCommitted + Qty;
                                        Vendor := Item."Vendor No.";
                                        Ok := true;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;

                if Ok = false then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        Item: Record Item;
        WOD: Record WorkOrderDetail;
        Ok: Boolean;
        QtyAvailable: Decimal;
        Qty: Decimal;
        QtyAvailableCommitted: Decimal;
        QtyCommitted: Decimal;
        Vendor: Code[20];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Work_OrderCaptionLbl: Label 'Work Order';
        Total_QuantityCaptionLbl: Label 'Total Quantity';
        PO_QtyCaptionLbl: Label 'PO Qty';
        Main_QuantityCaptionLbl: Label 'Main Quantity';
        VendorCaptionLbl: Label 'Vendor';
}

