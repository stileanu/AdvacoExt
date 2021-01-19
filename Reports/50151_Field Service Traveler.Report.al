report 50151 "Field Service Traveler"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50151_Field Service Traveler.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Field Service"; FieldService)
        {
            RequestFilterFields = "Field Service No.";
            column(Field_Service_Attention; Attention)
            {
            }
            column(Field_Service__Phone_No__; "Phone No.")
            {
            }
            column(BillTo; BillTo)
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Field_Service__Customer_Address_1_; "Customer Address 1")
            {
            }
            column(Field_Service__Ship_To_Address_1_; "Ship To Address 1")
            {
            }
            column(BillToAd2; BillToAd2)
            {
            }
            column(ShipToAd2; ShipToAd2)
            {
            }
            column(Field_Service__Customer_Name_; "Customer Name")
            {
            }
            column(Field_Service__Ship_To_Name_; "Ship To Name")
            {
            }
            column(Field_Service__Date_Ordered_; "Date Ordered")
            {
            }
            column(Field_Service_Customer; Customer)
            {
            }
            column(Field_Service__Field_Service_No__; "Field Service No.")
            {
            }
            column(Field_Service_Description; Description)
            {
            }
            column(Attention_Caption; Attention_CaptionLbl)
            {
            }
            column(Phone_No__Caption; Phone_No__CaptionLbl)
            {
            }
            column(Ship_To_Customer_Caption; Ship_To_Customer_CaptionLbl)
            {
            }
            column(Bill_To_Customer_Caption; Bill_To_Customer_CaptionLbl)
            {
            }
            column(Date_Ordered_Caption; Date_Ordered_CaptionLbl)
            {
            }
            column(Customer__Caption; Customer__CaptionLbl)
            {
            }
            column(F_S__Caption; F_S__CaptionLbl)
            {
            }
            column(FIELD_SERVICE_________Caption; FIELD_SERVICE_________CaptionLbl)
            {
            }
            column(Service_Description_Caption; Service_Description_CaptionLbl)
            {
            }
            column(Technician_Service_Notes_Caption; Technician_Service_Notes_CaptionLbl)
            {
            }
            column(Customer_Signature_Caption; Customer_Signature_CaptionLbl)
            {
            }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Customer_hereby_acknowledges_satisfactory_completion_of_work_as_required_Caption; Customer_hereby_acknowledges_satisfactory_completion_of_work_as_required_CaptionLbl)
            {
            }
            column(Technician_Name_Caption; Technician_Name_CaptionLbl)
            {
            }
            column(Date_Caption_Control36; Date_Caption_Control36Lbl)
            {
            }
            dataitem(Parts; Parts)
            {
                DataItemLink = "Work Order No." = FIELD("Field Service No.");
                column(Parts__Part_No__; "Part No.")
                {
                }
                column(Parts_Description; Description)
                {
                }
                column(Parts__Quoted_Quantity_; "Quoted Quantity")
                {
                }
                column(Parts__Pulled_Quantity_; "Pulled Quantity")
                {
                }
                column(EmptyString; '______________________________')
                {
                }
                column(Quantity_DeliveredCaption; Quantity_DeliveredCaptionLbl)
                {
                }
                column(Quantity_QuotedCaption; Quantity_QuotedCaptionLbl)
                {
                }
                column(DescriptionCaption; DescriptionCaptionLbl)
                {
                }
                column(Part_No_Caption; Part_No_CaptionLbl)
                {
                }
                column(Quantity_UsedCaption; Quantity_UsedCaptionLbl)
                {
                }
                column(Parts_Work_Order_No_; "Work Order No.")
                {
                }
                column(Parts_Part_Type; "Part Type")
                {
                }
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
        ShipTo: Text[50];
        BillTo: Text[50];
        ShipToAd2: Text[50];
        BillToAd2: Text[50];
        Attention_CaptionLbl: Label 'Attention:';
        Phone_No__CaptionLbl: Label 'Phone No.:';
        Ship_To_Customer_CaptionLbl: Label 'Ship To Customer:';
        Bill_To_Customer_CaptionLbl: Label 'Bill To Customer:';
        Date_Ordered_CaptionLbl: Label 'Date Ordered:';
        Customer__CaptionLbl: Label 'Customer #';
        F_S__CaptionLbl: Label 'F/S #';
        FIELD_SERVICE_________CaptionLbl: Label '*   *  * FIELD SERVICE *  *   *';
        Service_Description_CaptionLbl: Label 'Service Description:';
        Technician_Service_Notes_CaptionLbl: Label 'Technician Service Notes:';
        Customer_Signature_CaptionLbl: Label 'Customer Signature:';
        Date_CaptionLbl: Label 'Date:';
        Customer_hereby_acknowledges_satisfactory_completion_of_work_as_required_CaptionLbl: Label 'Customer hereby acknowledges satisfactory completion of work as required.';
        Technician_Name_CaptionLbl: Label 'Technician Name:';
        Date_Caption_Control36Lbl: Label 'Date:';
        Quantity_DeliveredCaptionLbl: Label 'Quantity Delivered';
        Quantity_QuotedCaptionLbl: Label 'Quantity Quoted';
        DescriptionCaptionLbl: Label 'Description';
        Part_No_CaptionLbl: Label 'Part No.';
        Quantity_UsedCaptionLbl: Label 'Quantity Used';
}

