report 50069 "Item Quantity by Location"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50069_Item Quantity by Location.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Item; Item)
        {
            CalcFields = Inventory, "Qty. on Purch. Order", "Qty. on Sales Order";
            RequestFilterFields = "No.", "Assembly BOM";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Item_Quantity_by_Location_; 'Item Quantity by Location')
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
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Item__Quantity_on_Hand_; Inventory)
            {
            }
            column(Item__Qty__on_Purch__Order_; "Qty. on Purch. Order")
            {
            }
            column(Item__Qty__on_Sales_Order_; "Qty. on Sales Order")
            {
            }
            column(InProcess; InProcess)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Committed; Committed)
            {
                DecimalPlaces = 0 : 0;
            }
            column(Main; Main)
            {
                DecimalPlaces = 0 : 0;
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
            column(Item__Quantity_on_Hand_Caption; FieldCaption(Inventory))
            {
            }
            column(Item__Qty__on_Purch__Order_Caption; FieldCaption("Qty. on Purch. Order"))
            {
            }
            column(Item__Qty__on_Sales_Order_Caption; FieldCaption("Qty. on Sales Order"))
            {
            }
            column(QTY_in_COMMITTEDCaption; QTY_in_COMMITTEDCaptionLbl)
            {
            }
            column(QTY_in_IN_PROCESSCaption; QTY_in_IN_PROCESSCaptionLbl)
            {
            }
            column(QTY_in_MAINCaption; QTY_in_MAINCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Main := 0;
                Committed := 0;
                InProcess := 0;
                Defective := 0;

                ILE1.SetCurrentKey(ILE1."Item No.", ILE1."Location Code", ILE1."Variant Code", ILE1."Document No.");
                ILE1.SetRange(ILE1."Item No.", Item."No.");
                ILE1.SetRange(ILE1."Location Code", 'Main');
                if ILE1.Find('-') then begin
                    repeat
                        Main := Main + ILE1.Quantity;
                    until ILE1.Next = 0;
                end;
                ILE2.SetCurrentKey(ILE2."Item No.", ILE2."Location Code", ILE2."Variant Code", ILE2."Document No.");
                ILE2.SetRange(ILE2."Item No.", Item."No.");
                ILE2.SetRange(ILE2."Location Code", 'Committed');
                if ILE2.Find('-') then begin
                    repeat
                        Committed := Committed + ILE2.Quantity;
                    until ILE2.Next = 0;
                end;
                ILE3.SetCurrentKey(ILE3."Item No.", ILE3."Location Code", ILE3."Variant Code", ILE3."Document No.");
                ILE3.SetRange(ILE3."Item No.", Item."No.");
                ILE3.SetRange(ILE3."Location Code", 'IN PROGRES');
                if ILE3.Find('-') then begin
                    repeat
                        InProcess := InProcess + ILE3.Quantity;
                    until ILE3.Next = 0;
                end;
                ILE4.SetCurrentKey(ILE4."Item No.", ILE4."Location Code", ILE4."Variant Code", ILE4."Document No.");
                ILE4.SetRange(ILE4."Item No.", Item."No.");
                ILE4.SetRange(ILE4."Location Code", 'Defective');
                if ILE4.Find('-') then begin
                    repeat
                        Defective := Defective + ILE4.Quantity;
                    until ILE4.Next = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin
                Main := 0;
                Committed := 0;
                InProcess := 0;
                Defective := 0;
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
        Main: Decimal;
        Committed: Decimal;
        InProcess: Decimal;
        Defective: Decimal;
        ILE1: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        ILE3: Record "Item Ledger Entry";
        ILE4: Record "Item Ledger Entry";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        QTY_in_COMMITTEDCaptionLbl: Label 'QTY in COMMITTED';
        QTY_in_IN_PROCESSCaptionLbl: Label 'QTY in IN PROCESS';
        QTY_in_MAINCaptionLbl: Label 'QTY in MAIN';
}

