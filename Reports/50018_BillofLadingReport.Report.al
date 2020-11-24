report 50018 "Bill of Lading Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50018_BillofLadingReport.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(BillofLading; BillofLading)
        {
            DataItemTableView = SORTING("Bill of Lading") ORDER(Ascending);
            RequestFilterFields = "Shipment Date", Customer, "Bill of Lading", Type, Carrier;
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Bill_of_Lading_Report_; 'Bill of Lading Report')
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
            column(Bill_of_Lading__Bill_of_Lading_; "Bill of Lading")
            {
            }
            column(Bill_of_Lading__Order_No__; "Order No.")
            {
            }
            column(Bill_of_Lading_Customer; Customer)
            {
            }
            column(Bill_of_Lading__Ship_To_Name_; "Ship To Name")
            {
            }
            column(Bill_of_Lading__Shipping_Weight_; "Shipping Weight")
            {
            }
            column(Bill_of_Lading__Container_Quantity_; "Container Quantity")
            {
            }
            column(Bill_of_Lading__Container_Type_; "Container Type")
            {
            }
            column(Bill_of_Lading_Carrier; Carrier)
            {
            }
            column(Bill_of_Lading__Shipping_Method_; "Shipping Method")
            {
            }
            column(Bill_of_Lading__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(Bill_of_Lading__Shipment_Date_; "Shipment Date")
            {
            }
            column(Model; Model)
            {
            }
            column(Bill_of_Lading_Type; Type)
            {
            }
            column(BOLCaption; BOLCaptionLbl)
            {
            }
            column(Bill_of_Lading__Order_No__Caption; FieldCaption("Order No."))
            {
            }
            column(Bill_of_Lading_CustomerCaption; FieldCaption(Customer))
            {
            }
            column(Bill_of_Lading__Ship_To_Name_Caption; FieldCaption("Ship To Name"))
            {
            }
            column(WeightCaption; WeightCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(ContainerCaption; ContainerCaptionLbl)
            {
            }
            column(Bill_of_Lading_CarrierCaption; FieldCaption(Carrier))
            {
            }
            column(MethodCaption; MethodCaptionLbl)
            {
            }
            column(ChargeCaption; ChargeCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ModelCaption; ModelCaptionLbl)
            {
            }
            column(ToCaption; ToCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if StrLen("Order No.") <= 7 then begin
                    if WOD.Get("Order No.") then
                        Model := WOD."Model No."
                    else
                        Model := '';
                end else begin
                    Model := '';
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

    trigger OnInitReport()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        WOD: Record WorkOrderDetail;
        Ok: Boolean;
        Model: Code[30];
        BOLCaptionLbl: Label 'BOL';
        WeightCaptionLbl: Label 'Weight';
        QtyCaptionLbl: Label 'Qty';
        ContainerCaptionLbl: Label 'Container';
        MethodCaptionLbl: Label 'Method';
        ChargeCaptionLbl: Label 'Charge';
        DateCaptionLbl: Label 'Date';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        ModelCaptionLbl: Label 'Model';
        ToCaptionLbl: Label 'To';
}

