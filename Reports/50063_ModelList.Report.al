report 50063 "Model List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50063_ModelList.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Search Description", "Assembly BOM", "Inventory Posting Group", "Shelf No.", "Location Filter";
            column(Inventory_Report_; 'Inventory Report')
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
            column(Item__Unit_Price_; "Unit Price")
            {
                DecimalPlaces = 0 : 2;
            }
            column(Item__Last_Direct_Cost_; "Last Direct Cost")
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
            column(PriceCaption; PriceCaptionLbl)
            {
            }
            column(CostCaption; CostCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Item.Class = 'MODEL' then begin
                    CalcFields(Inventory, Comment, "Assembly BOM");

                end else begin
                    CurrReport.Skip;
                end;

            end;

            trigger OnPreDataItem()
            begin

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
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        PriceCaptionLbl: Label 'Price';
        CostCaptionLbl: Label 'Cost';
}

