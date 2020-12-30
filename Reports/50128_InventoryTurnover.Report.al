report 50128 "Inventory Turnover"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50128_InventoryTurnover.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "Date Filter";
            column(Title; Title)
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
            column(Item__Quantity_on_Hand_; Inventory)
            {
            }
            column(Item__Last_Direct_Cost_; "Last Direct Cost")
            {
            }
            column(ItemValue; ItemValue)
            {
            }
            column(InventoryValue; InventoryValue)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption("No."))
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Total_ValueCaption; Total_ValueCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }
            column(Report_TotalCaption; Report_TotalCaptionLbl)
            {
            }
            column(Item_Inventory_Posting_Group; "Inventory Posting Group")
            {
            }
            column(Item_Vendor_No_; "Vendor No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ItemValue := 0;
                CountItem := false;
                NoShow := false;

                CalcFields("Sales (Qty.)", "Sales (LCY)", "Assembly BOM", Inventory);

                if ("Sales (Qty.)" > 0) then
                    CurrReport.Skip;

                if Item.Inventory > 0 then begin
                    CountItem := true;
                end else begin
                    CurrReport.Skip;
                end;

                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::"Negative Adjmt.");
                CopyFilter("Date Filter", ItemLedgerEntry."Posting Date");
                if ItemLedgerEntry.Find('-') then begin
                    CountItem := false;
                end;

                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::"Positive Adjmt.");
                CopyFilter("Date Filter", ItemLedgerEntry."Posting Date");
                if ItemLedgerEntry.Find('-') then begin
                    CountItem := false;
                end;

                ItemLedgerEntry.SetRange("Item No.", "No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                CopyFilter("Date Filter", ItemLedgerEntry."Posting Date");
                if ItemLedgerEntry.Find('-') then begin
                    CountItem := false;
                end;



                if CountItem then begin
                    ItemValue := Item.Inventory * Item."Last Direct Cost";
                    InventoryValue := InventoryValue + ItemValue;
                end else begin
                    CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals("Sales (Qty.)","Sales (LCY)");
                ItemLedgerEntry.SetCurrentKey("Entry Type", "Item No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                CopyFilter("Date Filter", ItemLedgerEntry."Posting Date");
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

    trigger OnPreReport()
    begin
        Title := 'Inventory Turn Over Report';

        CompanyInformation.Get;
        ItemFilter := Item.GetFilters;
    end;

    var
        CompanyInformation: Record "Company Information";
        ItemPostingGr: Record "Inventory Posting Group";
        Vendor: Record Vendor;
        ItemLedgerEntry: Record "Item Ledger Entry";
        IncludeItemDescriptions: Boolean;
        NoShow: Boolean;
        ItemFilter: Text[250];
        Title: Text[80];
        Profit: Decimal;
        ItemValue: Decimal;
        InventoryValue: Decimal;
        CountItem: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        QuantityCaptionLbl: Label 'Quantity';
        Total_ValueCaptionLbl: Label 'Total Value';
        CostCaptionLbl: Label 'Cost';
        Report_TotalCaptionLbl: Label 'Report Total';

    procedure AnyVariants(): Boolean
    var
        ItemVariant: Record "Item Variant";
    begin
    end;
}

