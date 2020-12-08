report 50122 "Work Order Install Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50122_WorkOrderInstallDate.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            DataItemTableView = WHERE(Complete = CONST(true));
            RequestFilterFields = "Customer ID", "Install Date";
            column(WORK_ORDER_INSTALL_DATE_REPORT_; 'WORK ORDER INSTALL DATE REPORT')
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
            column(Work_Order_Detail__Order_Type_; "Order Type")
            {
            }
            column(Work_Order_Detail__Model_No__; "Model No.")
            {
            }
            column(Work_Order_Detail__Ship_Date_; "Ship Date")
            {
            }
            column(Work_Order_Detail__Customer_Part_No__; "Customer Part No.")
            {
            }
            column(Work_Order_Detail__Install_Date_; "Install Date")
            {
            }
            column(Work_Order_Detail__Customer_ID_; "Customer ID")
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(Cust__Phone_No__; Cust."Phone No.")
            {
            }
            column(Cust_Contact; Cust.Contact)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Model_No_Caption; Model_No_CaptionLbl)
            {
            }
            column(ShipCaption; ShipCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
            {
            }
            column(W_O_No_Caption; W_O_No_CaptionLbl)
            {
            }
            column(Cust__Part_No_Caption; Cust__Part_No_CaptionLbl)
            {
            }
            column(InstallCaption; InstallCaptionLbl)
            {
            }
            column(Cust_No_Caption; Cust_No_CaptionLbl)
            {
            }
            column(Cust_No_Caption_Control11; Cust_No_Caption_Control11Lbl)
            {
            }
            column(Phone_No_Caption; Phone_No_CaptionLbl)
            {
            }
            column(ContactCaption; ContactCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if WOM.Get(WorkOrderDetail."Work Order Master No.") then
                    Cust.Get(WOM.Customer);
            end;

            trigger OnPreDataItem()
            begin
                OrderCount := WorkOrderDetail.Count;
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
        WOM: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        Ok: Boolean;
        OrderCount: Integer;
        Cust: Record Customer;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Model_No_CaptionLbl: Label 'Model No.';
        ShipCaptionLbl: Label 'Ship';
        TypeCaptionLbl: Label 'Type';
        W_O_No_CaptionLbl: Label 'W/O No.';
        Cust__Part_No_CaptionLbl: Label 'Cust. Part No.';
        InstallCaptionLbl: Label 'Install';
        Cust_No_CaptionLbl: Label 'Cust No.';
        Cust_No_Caption_Control11Lbl: Label 'Cust No.';
        Phone_No_CaptionLbl: Label 'Phone No.';
        ContactCaptionLbl: Label 'Contact';
}

