report 50008 "Boxed Work Order Status Rpt"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50008_BoxedWorkOrderStatus.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Work Order Detail 1"; "WorkOrderDetail")
        {
            DataItemTableView = SORTING("Work Order No.") WHERE(Boxed = FILTER(true), Complete = FILTER(false));
            RequestFilterFields = "Customer ID", "Model No.", "Customer Part No.";
            column(USERID; UserId)
            {
            }

            column(Boxed_Work_Order_Status_; 'Boxed Work Order Status')
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
            column(Work_Order_Detail_1__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail_1__Work_Order_No__; "Work Order No.")
            {
            }
            column(Work_Order_Detail_1__Serial_No__; "Serial No.")
            {
            }
            column(Work_Order_Detail_1__Customer_Part_No__; "Customer Part No.")
            {
            }
            column("OrderNo"; OrderNo)
            {
            }
            column(Work_Order_Detail_1__Customer_PO_No__; "Customer PO No.")
            {
            }
            column(Work_Order_Detail_1__Customer_ID_; "Customer ID")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Model_Caption; Model_CaptionLbl)
            {
            }
            column(Work_OrderCaption; Work_OrderCaptionLbl)
            {
            }
            column(Work_Order_Detail_1__Serial_No__Caption; FieldCaption("Serial No."))
            {
            }
            column(Work_Order_Detail_1__Customer_Part_No__Caption; FieldCaption("Customer Part No."))
            {
            }
            column(Order_No_Caption; Order_No_CaptionLbl)
            {
            }
            column(PO_No_Caption; PO_No_CaptionLbl)
            {
            }
            column(Work_Order_Detail_1__Customer_ID_Caption; FieldCaption("Customer ID"))
            {
            }

            trigger OnAfterGetRecord()
            begin

                if "Work Order Detail 1"."Sales Order No." <> '' then
                    OrderNo := "Work Order Detail 1"."Sales Order No."
                else
                    OrderNo := "Work Order Detail 1"."Sales Order No.";
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
    end;

    var
        CompanyInformation: Record "Company Information";
        WorkOrderStatus: Record Status;
        Ok: Boolean;
        "OrderNo": Code[20];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Model_CaptionLbl: Label 'Model ';
        Work_OrderCaptionLbl: Label 'Work Order';
        Order_No_CaptionLbl: Label 'Order No.';
        PO_No_CaptionLbl: Label 'PO No.';
}

