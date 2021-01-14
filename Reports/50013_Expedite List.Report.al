report 50013 "Expedite List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Expedite List.rdl';

    dataset
    {
        dataitem("Work Order Detail";"WorkOrderDetail")
        {
            DataItemTableView = WHERE(Expedite=CONST(true),Complete=CONST(false));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Customer ID","Model No.";
            column(Expedite_List_;'Expedite List')
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(USERID;UserId)
            {
            }
            column(TIME;Time)
            {
            }
            column(Work_Order_Detail__Work_Order_No__;"Work Order No.")
            {
            }
            column(Work_Order_Detail__Model_No__;"Model No.")
            {
            }
            column(Work_Order_Detail__Detail_Step_;"Detail Step")
            {
            }
            column(Work_Order_Detail__Customer_ID_;"Customer ID")
            {
            }
            column(Work_Order_Detail__Expedite_Notes_;"Expedite Notes")
            {
            }
            column(Work_Order_Detail__Income_Code_;"Income Code")
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Current_StepCaption;Current_StepCaptionLbl)
            {
            }
            column(Work_Order_Detail__Model_No__Caption;FieldCaption("Model No."))
            {
            }
            column(Work_OrderCaption;Work_OrderCaptionLbl)
            {
            }
            column(CustomerCaption;CustomerCaptionLbl)
            {
            }
            column(Work_Order_Detail__Expedite_Notes_Caption;FieldCaption("Expedite Notes"))
            {
            }
            column(Work_Order_Detail__Income_Code_Caption;FieldCaption("Income Code"))
            {
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

    var
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Current_StepCaptionLbl: Label 'Current Step';
        Work_OrderCaptionLbl: Label 'Work Order';
        CustomerCaptionLbl: Label 'Customer';
}

