report 50067 "Vendor List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50067_VendorList.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    caption = 'Vendor List';
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            //DataItemTableView = SORTING("No.") WHERE("No."=FILTER('??????'));
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Vendor Type";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(Vendor_Name; Name)
            {
            }
            column(Address__________City___________State__________ZIP_Code_; Address + '  ' + City + ',  ' + County + ' ' + "Post Code")
            {
            }
            column(Vendor__Phone_No__; "Phone No.")
            {
            }
            column(Vendor__Vendor_Type_; "Vendor Type")
            {
            }
            column(Vendor_ListCaption; Vendor_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CodeCaption; CodeCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(PhoneCaption; PhoneCaptionLbl)
            {
            }
            column(TypeCaption; TypeCaptionLbl)
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
        Vendor_ListCaptionLbl: Label 'Vendor List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CodeCaptionLbl: Label 'Code';
        NameCaptionLbl: Label 'Name';
        AddressCaptionLbl: Label 'Address';
        PhoneCaptionLbl: Label 'Phone';
        TypeCaptionLbl: Label 'Type';
}

