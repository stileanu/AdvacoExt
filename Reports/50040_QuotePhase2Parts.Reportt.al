report 50040 "Quote Phase 2 Parts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50040_QuotePhase2Parts.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            DataItemTableView = SORTING("Work Order No.");
            RequestFilterFields = "Work Order No.";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Quote_Parts_List_; 'Quote Parts List')
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
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail__Work_Order_Date_; "Work Order Date")
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail__Serial_No__; "Serial No.")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Work_Order_Detail__Work_Order_No__Caption; FieldCaption("Work Order No."))
            {
            }
            column(W_O_DateCaption; W_O_DateCaptionLbl)
            {
            }
            column(Work_Order_Detail__Model_No__Caption; FieldCaption("Model No."))
            {
            }
            column(Work_Order_Detail__Serial_No__Caption; FieldCaption("Serial No."))
            {
            }
            dataitem(Parts; Parts)
            {
                DataItemLink = "Work Order No." = FIELD("Work Order No.");
                DataItemTableView = SORTING("Work Order No.", "Part Type", "Part No.") ORDER(Ascending);
                column(Parts__Part_No__; "Part No.")
                {
                }
                column(Parts_Description; Description)
                {
                }
                column(Parts__Quoted_Quantity_; "Quoted Quantity")
                {
                }
                column(EmptyString; '______________________________')
                {
                }
                column(Parts__Part_No__Caption; FieldCaption("Part No."))
                {
                }
                column(Parts_DescriptionCaption; FieldCaption(Description))
                {
                }
                column(Parts__Quoted_Quantity_Caption; FieldCaption("Quoted Quantity"))
                {
                }
                column(ADVACOCaption; ADVACOCaptionLbl)
                {
                }
                column(Parts_Work_Order_No_; "Work Order No.")
                {
                }
                column(Parts_Part_Type; "Part Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Parts."Quoted Quantity" = 0 then
                        CurrReport.Skip;
                end;
            }
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
    end;

    var
        CompanyInformation: Record "Company Information";
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        W_O_DateCaptionLbl: Label 'W/O Date';
        ADVACOCaptionLbl: Label 'ADVACO';
}

