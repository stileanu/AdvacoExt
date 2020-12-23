report 50125 "Shop Employee Hours"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50125_ShopEmployeeHours.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Resource; Resource)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE(Type = CONST(Person));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(USERID; UserId)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Shop_Employee_Hours_; 'Shop Employee Hours')
            {
            }
            column(Resource__No__; "No.")
            {
            }
            column(Resource_Name; Name)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Resource_NameCaption; FieldCaption(Name))
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            dataitem(Status; Status)
            {
                DataItemLink = Employee = FIELD("No.");
                PrintOnlyIfDetail = false;
                RequestFilterFields = Step, Type, "Date Out", "Regular Hours", "Overtime Hours";
                column(Status__Order_No__; "Order No.")
                {
                }
                column(Status__Date_In_; "Date In")
                {
                }
                column(Status__Date_Out_; "Date Out")
                {
                }
                column(Status__Regular_Hours_; "Regular Hours")
                {
                }
                column(Status__Overtime_Hours_; "Overtime Hours")
                {
                }
                column(RStep; RStep)
                {
                }
                column(WOD__Model_No__; WOD."Model No.")
                {
                }
                column(TotalRegularHours; TotalRegularHours)
                {
                }
                column(TotalOvertimeHours; TotalOvertimeHours)
                {
                }
                column(Status__Order_No__Caption; FieldCaption("Order No."))
                {
                }
                column(Status__Date_In_Caption; FieldCaption("Date In"))
                {
                }
                column(Status__Date_Out_Caption; FieldCaption("Date Out"))
                {
                }
                column(Status__Regular_Hours_Caption; FieldCaption("Regular Hours"))
                {
                }
                column(Status__Overtime_Hours_Caption; FieldCaption("Overtime Hours"))
                {
                }
                column(StepCaption; StepCaptionLbl)
                {
                }
                column(Model_No_Caption; Model_No_CaptionLbl)
                {
                }
                column(Total_Hours_Caption; Total_Hours_CaptionLbl)
                {
                }
                column(Status_Line_No_; "Line No.")
                {
                }
                column(Status_Employee; Employee)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //StatusStep := Step;  ICE-MPC 08/14/20
                    StatusStep := Step.AsInteger();
                    ReceiveOrder;

                    TotalHours := "Regular Hours" + "Overtime Hours" + TotalHours;
                    TotalRegularHours := "Regular Hours" + TotalRegularHours;
                    TotalOvertimeHours := "Overtime Hours" + TotalOvertimeHours;

                    if WOD.Get("Order No.") then
                        OK := true;

                end;

                trigger OnPreDataItem()
                begin
                    TotalHours := 0;
                    TotalRegularHours := 0;
                    TotalOvertimeHours := 0;
                    REChours := 0;
                    DIShours := 0;
                    QOThours := 0;
                    BOhours := 0;
                    CLNhours := 0;
                    ASMhours := 0;
                    TSThours := 0;
                    MSPhours := 0;
                    PNThours := 0;
                    QChours := 0;
                    SHPhours := 0;
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
        StatusStep: Option;
        WOD: Record WorkOrderDetail;
        WOS: Record Status;
        FromDate: Date;
        ToDate: Date;
        TotalHours: Decimal;
        TotalOvertimeHours: Decimal;
        TotalRegularHours: Decimal;
        REChours: Decimal;
        DIShours: Decimal;
        QOThours: Decimal;
        BOhours: Decimal;
        CLNhours: Decimal;
        ASMhours: Decimal;
        TSThours: Decimal;
        REPhours: Decimal;
        MSPhours: Decimal;
        PNThours: Decimal;
        QChours: Decimal;
        SHPhours: Decimal;
        RStep: Code[10];
        OK: Boolean;
        CompanyInformation: Record "Company Information";
        Employee_No_CaptionLbl: Label 'Employee No.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        StepCaptionLbl: Label 'Step';
        Model_No_CaptionLbl: Label 'Model No.';
        Total_Hours_CaptionLbl: Label 'Total Hours:';

    procedure ReceiveOrder()
    begin
        case StatusStep of
            0:
                begin
                    RStep := 'REC';
                    REChours := REChours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            1:
                begin
                    RStep := 'DIS';
                    DIShours := DIShours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            2:
                begin
                    RStep := 'QOT';
                    QOThours := QOThours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            3:
                begin
                    RStep := 'B-O';
                    BOhours := BOhours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            4:
                begin
                    RStep := 'CLN';
                    CLNhours := CLNhours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            5:
                begin
                    RStep := 'ASM';
                    ASMhours := ASMhours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            6:
                begin
                    RStep := 'TST';
                    TSThours := TSThours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            7:
                begin
                    RStep := 'REP';
                    REPhours := REPhours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            8:
                begin
                    RStep := 'TST';
                    TSThours := TSThours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            9:
                begin
                    RStep := 'MSP';
                    MSPhours := MSPhours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            10:
                begin
                    RStep := 'PNT';
                    PNThours := PNThours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            11:
                begin
                    RStep := 'QC';
                    QChours := QChours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            12:
                begin
                    RStep := 'SHP';
                    SHPhours := SHPhours + Status."Regular Hours" + Status."Overtime Hours";
                end;
            100:
                RStep := '';
        end;
    end;
}

