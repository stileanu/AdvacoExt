report 50019 "Work Order Pick Ticket"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50019_WorkOrderPickTicket.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Work Order Detail"; WorkOrderDetail)
        {
            DataItemTableView = SORTING("Work Order No.");
            RequestFilterFields = "Work Order No.";
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Pick_Ticket_; 'Pick Ticket')
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
                DataItemTableView = SORTING("Work Order No.", "Part Type", "Part No.") ORDER(Ascending) WHERE("Part No." = FILTER(<> '1'));
                column(Parts__Part_No__; "Part No.")
                {
                }
                column(Parts_Description; Description)
                {
                }
                column(Parts__Quoted_Quantity_; "Quoted Quantity")
                {
                }
                column(Parts__In_Process_Quantity_; "In-Process Quantity")
                {
                }
                column(Parts__Pulled_Quantity_; "Pulled Quantity")
                {
                }
                column(EmptyString; '______________________________')
                {
                }
                column(Bin; Bin)
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
                column(Parts__In_Process_Quantity_Caption; FieldCaption("In-Process Quantity"))
                {
                }
                column(Quantity_already_PulledCaption; Quantity_already_PulledCaptionLbl)
                {
                }
                column(Quantity_PulledCaption; Quantity_PulledCaptionLbl)
                {
                }
                column(BinCaption; BinCaptionLbl)
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
                    if item.Get(Parts."Part No.") then begin
                        Bin := item."Shelf No.";
                    end else begin
                        Bin := '';
                    end;
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
        Bin: Code[10];
        item: Record Item;
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        W_O_DateCaptionLbl: Label 'W/O Date';
        Quantity_already_PulledCaptionLbl: Label 'Quantity already Pulled';
        Quantity_PulledCaptionLbl: Label 'Quantity Pulled';
        BinCaptionLbl: Label 'Bin';
}

