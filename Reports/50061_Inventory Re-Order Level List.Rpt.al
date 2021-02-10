report 50061 "Inventory Re-Order Level List"
{
    // 07/21/19
    //   Added controls for QtyAvailable, Sales Qty This Year and Sales Qty Last Year, and tagged code to implement them.
    //   Added Lead Time control and code to provide value.
    caption = 'Inventory Re-Order Level List';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50061_Inventory Re-Order Level List.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Search Description", "Assembly BOM", "Inventory Posting Group", "Shelf No.", "Location Filter";
            CalcFields = Inventory, "Qty. on Purch. Order", "Reserved Qty. on Inventory", Comment, "Assembly BOM";

            column(Inventory_Re_Order_Level_List_; 'Inventory Re-Order Level List')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }

            column(USERID; UserId)
            {
            }
            column(Item_TABLENAME__________ItemFilter; Item.TableName + ': ' + ItemFilter)
            {
            }
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Reorder_Point_; "Reorder Point")
            {
            }
            column(Item__Reorder_Quantity_; "Reorder Quantity")
            {
            }
            column(Item__Quantity_on_Hand_; Inventory)
            {
            }
            column(QtyAvailable; QtyAvailable)
            {
            }
            column(Item__Qty__on_Purch__Order_; "Qty. on Purchase Orders")
            {
            }
            column(SalesThisYear; SalesThisYear)
            {
            }
            column(SalesLastYear; SalesLastYear)
            {
            }
            column(LeadTimeCalc; LeadTimeCalc)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Description))
            {
            }
            column(ReOrder_LevelCaption; ReOrder_LevelCaptionLbl)
            {
            }
            column(Order_QtyCaption; Order_QtyCaptionLbl)
            {
            }
            column(Item__Quantity_on_Hand_Caption; FieldCaption(Inventory))
            {
            }
            column(Qty_AvailableCaption; Qty_AvailableCaptionLbl)
            {
            }
            column(Qty__on_Purch__OrderCaption; Qty__on_Purch__OrderCaptionLbl)
            {
            }
            column(Sales_Qty_This_YearCaption; Sales_Qty_This_YearCaptionLbl)
            {
            }
            column(Sales_Qty_Last_YearCaption; Sales_Qty_Last_YearCaptionLbl)
            {
            }
            column(Lead_TimeCaption; Lead_TimeCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // 07/21/19 start
                if Item.Class = 'MODEL' then
                    exit
                //IF Item.Class <> 'MODEL' THEN BEGIN
                else begin
                    // 07/21/19 end
                    CalcFields(Inventory, Comment, "Assembly BOM");
                    /* Calculate the Total Value of the Inventory on Hand */
                    //remove valuation not used on report
                    /*
                    TotalValue := 0;
                    ItemLedgerEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive,
                                                  "Location Code", "Posting Date");
                    ItemLedgerEntry.SetRange("Item No.", "No.");
                    ItemLedgerEntry.SetRange(Open, true);
                    CopyFilter("Date Filter", ItemLedgerEntry."Posting Date");
                    CopyFilter("Global Dimension 1 Filter", ItemLedgerEntry."Global Dimension 1 Code");
                    CopyFilter("Global Dimension 2 Filter", ItemLedgerEntry."Global Dimension 2 Code");
                    CopyFilter("Location Filter", ItemLedgerEntry."Location Code");
                    if ItemLedgerEntry.Find('-') then
                        repeat
                            ItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                            if ("Costing Method" = "Costing Method"::Average) and
                               (ItemLedgerEntry.Quantity > 0)
                            then
                                Cost := item."Unit Cost"
                            else
                                Cost := ItemLedgerEntry."Cost Amount (Actual)" / ItemLedgerEntry.Quantity;
                            ValueThisEntry := Cost * ItemLedgerEntry."Remaining Quantity";
                            if ((ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase) or
                               (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::"Positive Adjmt.")) and
                               ("Costing Method" = "Costing Method"::Average) and
                               (ItemLedgerEntry.Quantity <> ItemLedgerEntry."Invoiced Quantity")
                           then begin
                                /* there are some uninvoiced receipts */
                    TotalInvoicedQty := ItemLedgerEntry."Invoiced Quantity";
                    /* add in amounts invoiced since the original receipt */
                    /*     ItemLedgerEntry2.SetCurrentKey("Closed by Entry No.");
                         ItemLedgerEntry2.SetRange("Closed by Entry No.", ItemLedgerEntry."Entry No.");
                         ItemLedgerEntry2.SetFilter("Entry Type",
                                                    '%1|%2',
                                                    ItemLedgerEntry2."Entry Type"::Purchase,
                                                    ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                         if ItemLedgerEntry2.Find('-') then
                             repeat
                                 TotalInvoicedQty := TotalInvoicedQty + ItemLedgerEntry2."Invoiced Quantity";
                             until ItemLedgerEntry2.Next = 0;
                         if ItemLedgerEntry.Quantity <> TotalInvoicedQty then begin // still some uninvoiced receipts
                             ValueThisEntry := (TotalInvoicedQty * "Average Cost") +
                                                ((ItemLedgerEntry.Quantity - TotalInvoicedQty) * ItemLedgerEntry.SetItemVariantLocationFilters);
                             Cost := ValueThisEntry / ItemLedgerEntry.Quantity;
                             ValueThisEntry := ItemLedgerEntry."Remaining Quantity" * Cost;
                         end;
                     end;
                     TotalValue := TotalValue + ValueThisEntry;
                 until ItemLedgerEntry.Next = 0;
             // 07/21/19 start
             //END ELSE BEGIN
             //  CurrReport.SKIP;
             // 07/21/19 end
             */
                end;


                // 07/21/19 start
                Item.SetFilter("Date Filter", '');
                Item.SetFilter("Location Filter", '%1|%2', 'MAIN', 'COMMITTED');
                Item.CalcFields(Inventory, "Qty. on Purch. Order", "Qty. on Purchase Orders", "Reserved Qty. on Inventory");
                QtyAvailable := (Item.Inventory - Item."Reserved Qty. on Inventory");

                // Retrieve Expected Receipt Date
                if Vend.Get(Item."Vendor No.") then begin
                    if GetItemVendor("No.", Vend."No.") then
                        if FORMAT(ItemVendor."Lead Time Calculation") <> '' then
                            Evaluate(LeadTimeCalc, FORMAT(ItemVendor."Lead Time Calculation"))
                        else
                            LeadTimeCalc := FORMAT(Item."Lead Time Calculation");
                end;
                // Calculate Sales this year and last year
                // This Year
                InitialDate := CalcDate('CY-1Y+1D', Today);
                EndDate := Today;
                Item.SetRange("Date Filter", InitialDate, EndDate);
                Item.CalcFields("Sales (Qty.)", "Negative Adjmt. (Qty.)");
                SalesThisYear := Item."Sales (Qty.)" + Item."Negative Adjmt. (Qty.)";

                // Last year
                InitialDate := CalcDate('-1Y', InitialDate);
                EndDate := CalcDate('CY-1Y', EndDate);
                Item.SetRange("Date Filter", InitialDate, EndDate);
                Item.CalcFields("Sales (Qty.)", "Negative Adjmt. (Qty.)");
                SalesLastYear := Item."Sales (Qty.)" + Item."Negative Adjmt. (Qty.)";
                // 07/21/19 end

            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(TotalValue);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        ItemFilter := Item.GetFilters;
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        ItemFilter: Text[250];
        TotalInvoicedQty: Decimal;
        ValueThisEntry: Decimal;
        TotalValue: Decimal;
        Cost: Decimal;
        QtyAvailable: Decimal;
        LeadTimeCalc: Code[10];
        ItemVendor: Record "Item Vendor";
        Vend: Record Vendor;
        SalesThisYear: Decimal;
        SalesLastYear: Decimal;
        InitialDate: Date;
        EndDate: Date;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ReOrder_LevelCaptionLbl: Label 'ReOrder Level';
        Order_QtyCaptionLbl: Label 'Order Qty';
        Qty_AvailableCaptionLbl: Label 'Qty Available';
        Qty__on_Purch__OrderCaptionLbl: Label 'Qty. on Purch. Order';
        Sales_Qty_This_YearCaptionLbl: Label 'Sales Qty This Year';
        Sales_Qty_Last_YearCaptionLbl: Label 'Sales Qty Last Year';
        Lead_TimeCaptionLbl: Label 'Lead Time';

    procedure GetItemVendor(No: Code[20]; BuyFromVendorNo: Code[20]): Boolean
    var
        lReturn: Boolean;
    begin
        // 07/21/19 new function
        lReturn := false;

        itemvendor.SetRange("Item No.", No);
        itemvendor.SetRange("Vendor No.", BuyFromVendorNo);
        if itemvendor.Find('+') then
            exit(true);

        exit(false);
    end;
}

