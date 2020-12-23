report 50039 "Quote Pick Ticket"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Quote Pick Ticket.rdlc';

    dataset
    {
        dataitem("Work Order Detail";"Work Order Detail")
        {
            DataItemTableView = SORTING("Work Order No.");
            RequestFilterFields = "Work Order No.";
            column(CompanyInformation_Name;CompanyInformation.Name)
            {
            }
            column(Pick_Ticket_;'Pick Ticket')
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(TIME;Time)
            {
            }
            column(Resource_Name;Resource.Name)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(Work_Order_Detail__Work_Order_No__;"Work Order No.")
            {
            }
            column(Work_Order_Detail__Work_Order_Date_;"Work Order Date")
            {
            }
            column(Work_Order_Detail__Model_No__;"Model No.")
            {
            }
            column(Work_Order_Detail__Serial_No__;"Serial No.")
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MechanicCaption;MechanicCaptionLbl)
            {
            }
            column(Work_Order_Detail__Work_Order_No__Caption;FieldCaption("Work Order No."))
            {
            }
            column(W_O_DateCaption;W_O_DateCaptionLbl)
            {
            }
            column(Work_Order_Detail__Model_No__Caption;FieldCaption("Model No."))
            {
            }
            column(Work_Order_Detail__Serial_No__Caption;FieldCaption("Serial No."))
            {
            }
            dataitem(Parts;Parts)
            {
                DataItemLink = "Work Order No."=FIELD("Work Order No.");
                DataItemTableView = SORTING("Work Order No.","Part Type","Part No.") ORDER(Ascending) WHERE("Part Type"=CONST(Item));
                column(Parts__Part_No__;"Part No.")
                {
                }
                column(Parts_Description;Description)
                {
                }
                column(Parts__Quoted_Quantity_;"Quoted Quantity")
                {
                }
                column(EmptyString;'______________________________')
                {
                }
                column(Bin;Bin)
                {
                }
                column(Parts__Part_No__Caption;FieldCaption("Part No."))
                {
                }
                column(Parts_DescriptionCaption;FieldCaption(Description))
                {
                }
                column(Parts__Quoted_Quantity_Caption;FieldCaption("Quoted Quantity"))
                {
                }
                column(Quantity_PulledCaption;Quantity_PulledCaptionLbl)
                {
                }
                column(BinCaption;BinCaptionLbl)
                {
                }
                column(Parts_Work_Order_No_;"Work Order No.")
                {
                }
                column(Parts_Part_Type;"Part Type")
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
            dataitem("Quote Mechanics Parts";"Quote Mechanics Parts")
            {
                DataItemLink = "Work Order No."=FIELD("Work Order No.");
                DataItemTableView = SORTING("Work Order No.","Part No.") ORDER(Ascending);
                column(Quote_Mechanics_Parts__Part_No__;"Part No.")
                {
                }
                column(Quote_Mechanics_Parts__Part_Description_;"Part Description")
                {
                }
                column(Quote_Mechanics_Parts__Part_Quantity_;"Part Quantity")
                {
                }
                column(EmptyString_Control36;'______________________________')
                {
                }
                column(Mechanic_Parts_ListCaption;Mechanic_Parts_ListCaptionLbl)
                {
                }
                column(Quote_Mechanics_Parts_Work_Order_No_;"Work Order No.")
                {
                }
                column(Quote_Mechanics_Parts_Sequence;Sequence)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                  WOS.SetCurrentKey(WOS."Order No.");
                  WOS.SetRange(WOS."Order No.","Work Order No.");
                  WOS.SetRange(WOS.Step,WOS.Step :: QOT);
                  if WOS.Find('+') then begin
                    Mechanic := WOS.Employee;
                  end;

                if Mechanic <> '' then
                  Resource.Get(Mechanic);
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
        WOS: Record Status;
        Mechanic: Code[20];
        Resource: Record Resource;
        item: Record Item;
        Bin: Code[10];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MechanicCaptionLbl: Label 'Mechanic';
        W_O_DateCaptionLbl: Label 'W/O Date';
        Quantity_PulledCaptionLbl: Label 'Quantity Pulled';
        BinCaptionLbl: Label 'Bin';
        Mechanic_Parts_ListCaptionLbl: Label 'Mechanic Parts List';
}

