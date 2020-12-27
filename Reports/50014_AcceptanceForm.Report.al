report 50014 "Acceptance Form"
{
    // 03/28/11 ADV
    //   Added Payment Terms from Work Order. Used a text variable PayTerms to build the string.
    // 05/06/14 ADV
    //   Updated the report to Rev 04 of the Document (#FM0043)
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50014_AcceptanceForm.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(WorkOrderDetail; WorkOrderDetail)
        {
            RequestFilterFields = "Work Order No.";
            column(ACCEPTANCE_FORM_; 'ACCEPTANCE FORM')
            {
            }
            column(Rebuild______Description______Model______Model_No________; 'Rebuild  ' + Description + ', Model  ' + "Model No." + ',')
            {
            }
            column(AgentName__________Method; AgentName + ' / ' + Method)
            {
            }
            column(Work_Order_Detail__Work_Order_No__; "Work Order No.")
            {
            }
            column(Intro01; Intro01)
            {
            }
            column(Intro02; Intro02)
            {
            }
            column(ADVACO_is_hereby_authorized_to_proceed_with_the_repair_of_the_referenced_item_at_the_price_quoted_above__; 'ADVACO is hereby authorized to proceed with the repair of the referenced item at the price quoted above.')
            {
            }
            column(This_price_is_valid_for_30_days_from_the_date_quoted__Approval_after_30_days_may_result_in_a_price_increase__; 'This price is valid for 30 days from the date quoted. Approval after 30 days may result in a price increase.')
            {
            }
            column(Past_due_invoices_will_be_subject_to_a_finance_charge_of_1_5__per_month__periodic_rate___Annual_percentage_; 'Past due invoices will be subject to a finance charge of 1.5% per month, periodic rate.  Annual percentage')
            {
            }
            column(rate_of_18___; 'rate of 18%.')
            {
            }
            column(TODAY; Today)
            {
            }
            column(EmptyString; '________________')
            {
            }
            column(PLEASE_VERIFY_TAX_STATUS_INFORMATION_; 'PLEASE VERIFY TAX STATUS INFORMATION')
            {
            }
            column(Check_one_of_the_following_for_the_repaired_property__; 'Check one of the following for the repaired property:')
            {
            }
            column(Taxable__; '____Taxable.')
            {
            }
            column(Tax_exempt___Resale_as_tangible_personal_property__; '____Tax exempt - Resale as tangible personal property.')
            {
            }
            column(Tax_exempt___Being_used_by_a_manufacturing__; '____Tax exempt - Being used by a manufacturing')
            {
            }
            column(corporation_in_the_production_of_personal_tangible__; '         corporation in the production of personal tangible')
            {
            }
            column(Tax_exempt___State_Federal_Local_Government_; '____Tax exempt - State/Federal/Local Government')
            {
            }
            column(property___; '         property.')
            {
            }
            column(If_tax_exempt__please_supply_Sales___Use_Tax__; '         If tax exempt, please supply Sales & Use Tax')
            {
            }
            column(Exempt___here___; '         Exempt # here:')
            {
            }
            column(and__a_copy_of_your_certificate_for_our_files__; '         and  a copy of your certificate for our files')
            {
            }
            column(Serial_Number______Serial_No____________Oil_Type_____Prep_; 'Serial Number  ' + "Serial No." + ', ' + "Oil Type" + ' Prep')
            {
            }
            column(to_ADVACO__S_internal_test_specifications___; 'to ADVACO''S internal test specifications. ')
            {
            }
            column(Remanufactured_parts_are_utilized_when_; 'Remanufactured parts are utilized when')
            {
            }
            column(possible_to_maximize_cost_savings__; 'possible to maximize cost savings.')
            {
            }
            column(Work_Order_Detail_Attention; Attention)
            {
            }
            column(Work_Order_Detail__Ship_To_Name_; "Ship To Name")
            {
            }
            column(RebuildPrice; RebuildPrice)
            {
            }
            column(Work_Order_Detail__Ship_To_Address_1_; "Ship To Address 1")
            {
            }
            column(ShipToAd2; ShipToAd2)
            {
            }
            column(ShipTo; ShipTo)
            {
            }
            column(Work_Order_Detail__Shipping_Charge_; "Shipping Charge")
            {
            }
            column(PO; PO)
            {
            }
            column(TAXEXEMPT; TAXEXEMPT)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(V1215_BUSINESS_PARKWAY_NORTH___WESTMINSTER___MARYLAND__21157____410__876_8200______800__272_2525______; '1215 BUSINESS PARKWAY NORTH,  WESTMINSTER,  MARYLAND  21157   (410) 876-8200     (800) 272-2525')
            {
            }
            column(Our_Customer_Is_Our_MOST_Important_Asset___; ' "...Our Customer Is Our MOST Important Asset".')
            {
            }
            column(AdditionalText; AdditionalText)
            {
            }
            column(Name_____________________________________________; 'Name: __________________________________________')
            {
            }
            column(PayTerms; PayTerms)
            {
            }
            column(CUSTOMER_Caption; CUSTOMER_CaptionLbl)
            {
            }
            column(CUSTOMER_PURCHASE_ORDER_Caption; CUSTOMER_PURCHASE_ORDER_CaptionLbl)
            {
            }
            column(SERVICE_TO_BE_PERFORMED_Caption; SERVICE_TO_BE_PERFORMED_CaptionLbl)
            {
            }
            column(TAX_STATUS_Caption; TAX_STATUS_CaptionLbl)
            {
            }
            column(ADVACO_REFERENCE_NUMBER_Caption; ADVACO_REFERENCE_NUMBER_CaptionLbl)
            {
            }
            column(REBUILD_PRICE_Caption; REBUILD_PRICE_CaptionLbl)
            {
            }
            column(DATE_QUOTED_Caption; DATE_QUOTED_CaptionLbl)
            {
            }
            column(ACCEPTANCE_DATE_Caption; ACCEPTANCE_DATE_CaptionLbl)
            {
            }
            column(PREFERRED_COMMON_CARRIER_Caption; PREFERRED_COMMON_CARRIER_CaptionLbl)
            {
            }
            column(DataItem34; CUSTOMER_SIGNATURE_CaptionLbl)
            {
            }
            column(DataItem42; PRINT_NAME_CaLbl)
            {
            }
            column(If_credit_card__print_name_exactly_as_it_appears_on_cardCaption; If_credit_card__print_name_exactly_as_it_appears_on_cardCaptionLbl)
            {
            }
            column(DataItem1100780001; Document_Control_CenterCapLbl)
            {
            }
            column(All_Quotations_and_Orders_subject_to_ADVACO_s_standard_Terms_and_Conditions_as_listed_on_www_advaco_comCaption; All_Quotations_and_Orders_subject_to_ADVACO_s_standard_Terms_and_Conditions_as_listed_on_www_advaco_comCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields("Parts Quoted", "Labor Quoted");

                //if WorkOrderDetail"."Order Type" = "Order Type" :: Warranty then
                if WorkOrderDetail."Order Type" = workorderdetail."Order Type"::Warranty then
                    RebuildPrice := 0
                else
                    RebuildPrice := "Parts Quoted" + "Labor Quoted" + "Order Adj.";


                if "Ship To Address 2" = '' then begin
                    ShipToAd2 := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                    ShipTo := '';
                end else begin
                    ShipToAd2 := "Ship To Address 2";
                    ShipTo := ("Ship To City") + (', ') + ("Ship To State") + ('  ') + ("Ship To Zip Code");
                end;

                if "Shipping Method" = '' then
                    Clear(ShipmentMethod)
                else
                    ShipmentMethod.Get("Shipping Method");
                Method := ShipmentMethod.Description;

                if Carrier = '' then
                    Clear(Agent)
                else
                    Agent.Get(Carrier);
                AgentName := Agent.Name;

                if WorkOrderDetail."Customer PO No." <> '' then
                    PO := "Customer PO No."
                else
                    PO := '_______________';

                if WOM.Get("Work Order Master No.") then begin
                    if WOM."Tax Exemption No." <> '' then
                        TAXEXEMPT := WOM."Tax Exemption No."
                    else
                        TAXEXEMPT := WOM."Exempt Organization";
                end else begin
                    TAXEXEMPT := '_______________';
                end;

                case info of
                    0:
                        AdditionalText := '';
                    1:
                        AdditionalText := 'Deemed Non Warranty';
                    2:
                        AdditionalText := 'No Charge, Non Warranty';
                    3:
                        AdditionalText := 'No Charge Repair';
                    5:
                        AdditionalText := 'Unrepairable. Scrap (No Charge) or Return (Small Fee), Please Advise_______________________';
                    4:
                        AdditionalText := 'No Charge, Warranty';
                    6:
                        AdditionalText := AdditionalText1;

                end;

                if WOM."Customer Payment Terms" <> '' then begin
                    if CustPayTerms.Get(WOM."Customer Payment Terms") then;
                    PayTerms := 'ADVACO Payment Terms are ' + CustPayTerms.Description + '.';
                end else
                    PayTerms := 'ADVACO Payment Terms are _________ .';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(info; info)
                    {
                        ApplicationArea = all;
                        Caption = 'Additional Text Options';
                        OptionCaption = ' ,Deemed Non Warranty, No Charge Non Warranty,No Charge Warranty,No Charge Repair,Unrepairable. Scrap No Charge or Return Small Fee  Please Advise_______________,Custom Text';
                    }
                    field(AdditionalText1; AdditionalText1)
                    {
                        ApplicationArea = all;
                        Caption = 'Additional Text';
                    }
                }
            }
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
        CompanyInformation.CalcFields(Picture);
    end;

    var
        ShipToAd2: Text[50];
        ShipTo: Text[50];
        ShipmentMethod: Record "Shipment Method";
        Agent: Record "Shipping Agent";
        AgentName: Text[30];
        Method: Text[30];
        Collect: Code[1];
        WOM: Record WorkOrderMaster;
        ok: Boolean;
        TAXEXEMPT: Code[30];
        CompanyInformation: Record "Company Information";
        info: Option " ","Deemed Non Warranty","No Charge Non Warranty","No Charge Warranty","No Charge Repair","Unrepairable. Scrap No Charge or Return Small Fee  Please Advise_______________","Custom Text";
        AdditionalText: Text[250];
        AdditionalText1: Text[250];
        PO: Code[30];
        RebuildPrice: Decimal;
        PayTerms: Text[50];
        CustPayTerms: Record "Payment Terms";
        Intro01: Label 'Please return via fax or e-mail as soon as possible.  Our fax number is 410 876-5820.  If extra parts are';
        Intro02: Label 'required, no work will begin until this acceptance form is received by ADVACO.';
        CUSTOMER_CaptionLbl: Label 'CUSTOMER:';
        CUSTOMER_PURCHASE_ORDER_CaptionLbl: Label 'CUSTOMER PURCHASE ORDER:';
        SERVICE_TO_BE_PERFORMED_CaptionLbl: Label 'SERVICE TO BE PERFORMED:';
        TAX_STATUS_CaptionLbl: Label 'TAX STATUS:';
        ADVACO_REFERENCE_NUMBER_CaptionLbl: Label 'ADVACO REFERENCE NUMBER:';
        REBUILD_PRICE_CaptionLbl: Label 'REBUILD PRICE:';
        DATE_QUOTED_CaptionLbl: Label 'DATE QUOTED:';
        ACCEPTANCE_DATE_CaptionLbl: Label 'ACCEPTANCE DATE:';
        PREFERRED_COMMON_CARRIER_CaptionLbl: Label 'PREFERRED COMMON CARRIER:';
        CUSTOMER_SIGNATURE_CaptionLbl: Label 'CUSTOMER SIGNATURE:__________________________________________________________________________________________________';
        PRINT_NAME_CaLbl: Label 'PRINT NAME:________________________________________________________________________________________________________________';
        If_credit_card__print_name_exactly_as_it_appears_on_cardCaptionLbl: Label 'If credit card, print name exactly as it appears on card';
        Document_Control_CenterCapLbl: Label 'Document # FM0043, Revision 04, Effective 4/30/14, Minimum Retention: 36 Months, Storage Location: Document Control Center';
        All_Quotations_and_Orders_subject_to_ADVACO_s_standard_Terms_and_Conditions_as_listed_on_www_advaco_comCaptionLbl: Label 'All Quotations and Orders subject to ADVACO''s standard Terms and Conditions as listed on www.advaco.com';
}

