report 50137 "1st TimeTest Failures"
{
    DefaultLayout = RDLC;
    RDLCLayout = './50137_1st TimeTest Failures.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Order Defects";"Order Defects")
        {
            DataItemTableView = SORTING("Order No.",Occurrence) ORDER(Ascending) WHERE(Department=FILTER("Production Assembly"|Test));
            RequestFilterFields = "Date Filter",Technician,"Model No.";
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;CompanyName)
            {
            }
            column(USERID;UserId)
            {
            }
            column(PeriodText;PeriodText)
            {
            }
            column(Order_Defects__Order_No__;"Order No.")
            {
            }
            column(Order_Defects_Department;Department)
            {
            }
            column(Order_Defects__Model_No__;"Model No.")
            {
            }
            column(Order_Defects__Defect_Code_;"Defect Code")
            {
            }
            column(Order_Defects_Technician;Technician)
            {
            }
            column(Order_Defects_Date;Date)
            {
            }
            column(Order_Defects__Failure_Item_;"Failure Item")
            {
            }
            column(Order_Defects_Code;Code)
            {
            }
            column(EmptyString;'%')
            {
            }
            column(TestingYield;TestingYield)
            {
            }
            column(TotalOrdersTested;TotalOrdersTested)
            {
            }
            column(Failure_One_;"Failure One")
            {
            }
            column(V1st_Time_Test_FailuresCaption;V1st_Time_Test_FailuresCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Order_Defects__Order_No__Caption;FieldCaption("Order No."))
            {
            }
            column(Order_Defects_DepartmentCaption;FieldCaption(Department))
            {
            }
            column(Order_Defects__Model_No__Caption;FieldCaption("Model No."))
            {
            }
            column(CodeCaption;CodeCaptionLbl)
            {
            }
            column(Order_Defects_TechnicianCaption;FieldCaption(Technician))
            {
            }
            column(Order_Defects_DateCaption;FieldCaption(Date))
            {
            }
            column(Order_Defects_CodeCaption;FieldCaption(Code))
            {
            }
            column(Order_Defects__Failure_Item_Caption;FieldCaption("Failure Item"))
            {
            }
            column(First_Time_Test_Yield_Caption;First_Time_Test_Yield_CaptionLbl)
            {
            }
            column(Total_Systems_Tested_Caption;Total_Systems_Tested_CaptionLbl)
            {
            }
            column(Total_Test_Failures_Caption;Total_Test_Failures_CaptionLbl)
            {
            }
            column(Order_Defects_Occurrence;Occurrence)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Report only Failures that are within the Date Range
                if (ToDate > Date) and (FromDate < Date) then begin
                  if Occurrence = 10 then begin
                    CreateReport := true;
                    //Count Number of Failures
                    "Failure One" := "Failure One" + 1;
                  end else begin
                    if CreateReport = false then begin
                       CreateReport := true;
                       "Order Defects"."Order No." := '';
                       "Order Defects"."Model No." := '';
                       "Order Defects"."Defect Code" := '';
                       //"Order Defects".Department := 0;  ICE-MPC 08/20/20
                       Clear("Order Defects".Department);
                       //"Order Defects"."Failure Item" := 0;  ICE-MPC 08/20/20
                       Clear("Order Defects"."Failure Item");
                       //"Order Defects".Code := 0;  ICE-MPC 08/20/20
                       Clear("Order Defects".Code);
                       "Order Defects".Technician := '';
                       "Order Defects".Date := 0D;
                    end else begin
                      CurrReport.Skip;
                    end;
                  end;
                end else begin
                  CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CreateReport := false;

                LastFieldNo := FieldNo("Order No.");

                Clear(TotalOrdersTested);

                DateFilter := GetFilter("Date Filter");
                if DateFilter <> '' then begin
                  FromDate := GetRangeMin("Date Filter");
                  ToDate := GetRangeMax("Date Filter");
                end else begin
                  FromDate := 0D;
                  ToDate := WorkDate;
                  SetRange("Date Filter",FromDate,ToDate);
                end;

                PeriodText := 'Period from ' + Format(FromDate,0,4) + ' to ' + Format(ToDate,0,4);

                //Determine Total System that were Tested within the Date Range
                OrdersTestedStatus.SetRange(OrdersTestedStatus.Step, OrdersTestedStatus.Step :: TST);
                OrdersTestedStatus.SetRange(OrdersTestedStatus.Status,OrdersTestedStatus.Status :: Complete);
                OrdersTestedStatus.SetRange(OrdersTestedStatus."Date Out",FromDate,ToDate);
                if OrdersTestedStatus.Find ('-') then begin
                  repeat
                    //Count Total Units Tested
                    TotalOrdersTested := TotalOrdersTested + 1;
                  until OrdersTestedStatus.Next = 0;
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

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInformation: Record "Company Information";
        OrdersTestedStatus: Record Status;
        FromDate: Date;
        ToDate: Date;
        DateFilter: Text[30];
        PeriodText: Text[200];
        TotalFailures: Integer;
        TotalOrdersTested: Integer;
        TotalOrdersPassed: Integer;
        TestingYield: Decimal;
        OrdersCounted: Boolean;
        "Failure One": Integer;
        "Failure Two": Integer;
        "Failure Three": Integer;
        "Failure Four": Integer;
        "Failure Five": Integer;
        CreateReport: Boolean;
        V1st_Time_Test_FailuresCaptionLbl: Label '1st Time Test Failures';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        First_Time_Test_Yield_CaptionLbl: Label 'First Time Test Yield:';
        Total_Systems_Tested_CaptionLbl: Label 'Total Systems Tested:';
        Total_Test_Failures_CaptionLbl: Label 'Total Test Failures:';
}

