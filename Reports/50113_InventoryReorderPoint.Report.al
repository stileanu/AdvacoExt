report 50113 "Inventory Reorder Point"
{
    Caption = 'Inventory EOQ ReOrder Report';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50113_InventoryReorderPoint.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Inventory Posting Group" = FILTER(<> 'SALES'));
            RequestFilterFields = "No.", Inventory, "Sales (Qty.)", "Qty. on Purch. Order";
            column(COMPANYNAME; CompanyName)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }

            column(Item__No__; "No.")
            {
            }
            column(SalesQtyYear; SalesQtyYear)
            {
                DecimalPlaces = 0 : 0;
            }
            column(ItemAvailableSupply; ItemAvailableSupply)
            {
            }
            column(Item__Quantity_on_Hand_; Inventory)
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Qty__on_Purch__Order_; "Qty. on Purch. Order")
            {
            }
            column(Item__Reorder_Point_; "Reorder Point")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item__Reorder_Quantity_; "Reorder Quantity")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item__Old_ReOrder_Point_; "Old ReOrder Point")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item__Old_ReOrder_Qty_; "Old ReOrder Qty")
            {
                DecimalPlaces = 0 : 0;
            }
            column(Item__Last_Direct_Cost_; "Last Direct Cost")
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Yearly_Sales_QtyCaption; Yearly_Sales_QtyCaptionLbl)
            {
            }
            column(Item_Supply__Months_Caption; Item_Supply__Months_CaptionLbl)
            {
            }
            column(Qty_on_HandCaption; Qty_on_HandCaptionLbl)
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(Item__Qty__on_Purch__Order_Caption; FieldCaption("Qty. on Purch. Order"))
            {
            }
            column(Ord_PntCaption; Ord_PntCaptionLbl)
            {
            }
            column(EOQCaption; EOQCaptionLbl)
            {
            }
            column(Inventory_ReOrder_Point_and_EOQ_ReportCaption; Inventory_ReOrder_Point_and_EOQ_ReportCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Old_RPCaption; Old_RPCaptionLbl)
            {
            }
            column(Old_RQCaption; Old_RQCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetRange("No.");
                KitItem := false;
                SalesQtyYear := 0;
                SalesQtyMonth := 0;
                ClearAll;

                InventorySetup.Get;

                ItemDateFilter := Format(WorkDate - (InventorySetup."EOQ Inventory Range" * 30.5)) + '..' + Format(99991231D);
                SetFilter("Date Filter", ItemDateFilter);
                CalcFields("Purchases (Qty.)", "Sales (Qty.)", "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)",
                 "Purchases (LCY)", "Sales (LCY)", "COGS (LCY)", "Transferred (Qty.)", "Transferred (LCY)", Inventory,
                 "Qty. on Purch. Order");

                // "EOQ Inventory Range" must be greater than Zero because the system can't divivde by Zero
                if InventorySetup."EOQ Inventory Range" <= 0 then
                    Error('The EOQ Inv. Range(Months) must be Greater than Zero, See Inventory Setup');


                // Sales Qty must be greater than Zero because the system can't divivde by Zero
                if InventorySetup."Sales Qty" <= 0 then
                    Error('Sales Qty Threshold must be Greater than Zero, See Inventory Setup');

                //Determine if Part of a Bill of Material for a Kit
                BOM.Reset;
                //BOM.SETRANGE(Type, BOM.Type :: Item);
                BOM.SetRange("No.", Item."No.");
                if BOM.Find('-') then begin
                    repeat
                        if BOMItem.Get(BOM."Parent Item No.") then
                            ok := true;
                    //    IF BOMItem.Class = 'ITEM' THEN
                    //      KitItem := TRUE;
                    until BOM.Next = 0;
                end;

                // If KitItem use Negative Adjusments & Sales for Past Year for the Sales Quantity
                // in the Formula since they will not be sold individually
                if KitItem then
                    SalesQtyMonth := ("Sales (Qty.)" + "Negative Adjmt. (Qty.)") / InventorySetup."EOQ Inventory Range"
                else
                    SalesQtyMonth := ("Sales (Qty.)" / InventorySetup."EOQ Inventory Range");
                SalesQtyYear := SalesQtyMonth * 12;

                // Filter according to Inventory Setup Specs.
                if (SalesQtyYear > InventorySetup."Sales Qty") and ("Last Direct Cost" < InventorySetup.Threshold) and
                   ("Manual ReOrder Point" = false) then begin

                    // Exclude Sales Inventory
                    if "Inventory Posting Group" <> 'SALES' then begin

                        //Calculate Available Supply in Months for the Item
                        ItemAvailableSupply := ((Inventory + "Qty. on Purch. Order") / (SalesQtyMonth));

                        //Calculate ReOrder Point Level
                        ReOrderPoint := (SalesQtyMonth) * InventorySetup."Inventory Holding Level";
                        ReOrderPoint := Round(ReOrderPoint, 1, '=');

                        //Calculate Economic Order Quantity
                        ReOrderQty := (2 * SalesQtyYear * InventorySetup."Cost of Ordering") / (InventorySetup."Holding Cost" * Item."Last Direct Cost");
                        ReOrderQty := Power(ReOrderQty, (1 / 2));

                        // Prevent EOQ ReOrder Qty from exceeding 2 Years of Inventory
                        if (SalesQtyYear * 2) < ReOrderQty then
                            ReOrderQty := SalesQtyYear * 2;
                        ReOrderQty := Round(ReOrderQty, 1, '=');

                        //Update ReOrder Point and ReOrder Quantity
                        "Reorder Point" := ReOrderPoint;
                        "Reorder Quantity" := ReOrderQty;

                        //Mark Purchase amounts exceeding one year
                        if ReOrderQty > SalesQtyYear then
                            OverYearSupply := '*'
                        else
                            OverYearSupply := '';

                        //Update the Item Table
                        Modify;

                    end else begin
                        CurrReport.Skip;
                    end;
                end else begin
                    CurrReport.Skip;
                end;
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

    var
        InventorySetup: Record "Inventory Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
        BOM: Record "BOM Component";
        BOMItem: Record Item;
        ItemDateFilter: Text[30];
        ItemAvailableSupply: Decimal;
        ok: Boolean;
        KitItem: Boolean;
        SalesQtyYear: Decimal;
        SalesQtyMonth: Decimal;
        ReOrderPoint: Decimal;
        ReOrderQty: Decimal;
        sr: Decimal;
        OverYearSupply: Boolean;
        Yearly_Sales_QtyCaptionLbl: Label 'Yearly Sales Qty';
        Item_Supply__Months_CaptionLbl: Label 'Item Supply (Months)';
        Qty_on_HandCaptionLbl: Label 'Qty on Hand';
        Ord_PntCaptionLbl: Label 'Ord Pnt';
        EOQCaptionLbl: Label 'EOQ';
        Inventory_ReOrder_Point_and_EOQ_ReportCaptionLbl: Label 'Inventory ReOrder Point and EOQ Report';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Old_RPCaptionLbl: Label 'Old RP';
        Old_RQCaptionLbl: Label 'Old RQ';
        CostCaptionLbl: Label 'Cost';
}

