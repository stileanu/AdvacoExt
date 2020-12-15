report 50066 "Model - Bill of Materials"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50066_Model_BillOfMaterials.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") WHERE(Class = CONST('MODEL'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", Class;
            column(ADVACO_STOCK_PARTS_LIST_; 'ADVACO STOCK PARTS LIST')
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(USERID; UserId)
            {
            }
            column(TIME; Time)
            {
            }
            ///--! column(CurrReport_PAGENO;CurrReport.PageNo)
            //{
            //}
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem("BOM Component"; "BOM Component")
            {
                DataItemLink = "Parent Item No." = FIELD("No.");
                DataItemTableView = SORTING(Type, "No.") ORDER(Ascending) WHERE(Type = CONST(Item));
                column(BOM_Component__No__; "No.")
                {
                }
                column(BOM_Component__Quantity_per_; "Quantity per")
                {
                }
                column(BOM_Component_Description; Description)
                {
                }
                column(EmptyString; '________________')
                {
                }
                column(BOM_Component__No__Caption; FieldCaption("No."))
                {
                }
                column(BOM_QuantityCaption; BOM_QuantityCaptionLbl)
                {
                }
                column(BOM_Component_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(BOM_QuantityCaption_Control15; BOM_QuantityCaption_Control15Lbl)
                {
                }
                column(BOM_Component_Parent_Item_No_; "Parent Item No.")
                {
                }
                column(BOM_Component_Line_No_; "Line No.")
                {
                }


            }
            trigger OnAfterGetRecord()
            begin
                if not CalcFields("Assembly BOM") then
                    CurrReport.Skip();
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
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        BOM_QuantityCaptionLbl: Label 'BOM Quantity';
        BOM_QuantityCaption_Control15Lbl: Label 'BOM Quantity';
}

