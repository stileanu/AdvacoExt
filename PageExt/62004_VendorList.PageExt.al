pageextension 62004 VendorListExt extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Post Code2"; Rec."Post Code")
            {
                ApplicationArea = all;
                Caption = 'Post Code';
            }
            field("Country/Region Code2"; Rec."Country/Region Code")
            {
                ApplicationArea = all;
                Caption = 'Country/Region Code';

            }
            field("Phone No.2"; Rec."Phone No.")
            {
                ApplicationArea = all;
                Caption = 'Phone No.';
            }
            field("Fax No.2"; Rec."Fax No.")
            {
                ApplicationArea = all;
                Caption = 'Fax No.';

            }
            field("Payment Terms Code2"; Rec."Payment Terms Code")
            {
                ApplicationArea = all;
                Caption = 'Payment Terms Code';
            }
        }
    }


}