report 50112 "Inv Level Item Sold Past 365D"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50112_Inv Level Item Sold Past 365D.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
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
            column(Item__Sales__Qty___; "Sales (Qty.)")
            {
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
            }
            column(Item__Reorder_Quantity_; "Reorder Quantity")
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item__Sales__Qty___Caption; FieldCaption("Sales (Qty.)"))
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
            column(Qty_on_OrderCaption; Qty_on_OrderCaptionLbl)
            {
            }
            column(Item__Reorder_Point_Caption; FieldCaption("Reorder Point"))
            {
            }
            column(Item__Reorder_Quantity_Caption; FieldCaption("Reorder Quantity"))
            {
            }
            column(Inventory_Level_for_Items_Sold_Past_365_DaysCaption; Inventory_Level_for_Items_Sold_Past_365_DaysCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SetRange("No.");
                ClearAll;

                ItemDateFilter := Format(WorkDate - 365) + '..' + Format(99991231D);
                SetFilter("Date Filter", ItemDateFilter);
                CalcFields("Purchases (Qty.)", "Sales (Qty.)", "Positive Adjmt. (Qty.)", "Negative Adjmt. (Qty.)",
                 "Purchases (LCY)", "Sales (LCY)", "COGS (LCY)", "Transferred (Qty.)", "Transferred (LCY)", Inventory,
                 "Qty. on Purch. Order");

                if "Sales (Qty.)" > 0 then begin
                    ItemAvailableSupply := ((Inventory + "Qty. on Purch. Order") / ("Sales (Qty.)" / 12));
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
        ItemDateFilter: Text[30];
        ItemAvailableSupply: Decimal;
        Item_Supply__Months_CaptionLbl: Label 'Item Supply (Months)';
        Qty_on_HandCaptionLbl: Label 'Qty on Hand';
        Qty_on_OrderCaptionLbl: Label 'Qty on Order';
        Inventory_Level_for_Items_Sold_Past_365_DaysCaptionLbl: Label 'Inventory Level for Items Sold Past 365 Days';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

