pageextension 50023 VendorCardExtPage extends "Vendor Card"
{
    layout
    {
        addafter(Receiving)
        {
            group(Advaco)
            {
                Caption = 'Advanced Vacuum';

                field("Vendor Type"; "Vendor Type")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Type';
                }
                field("Approval Date"; "Approval Date")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Date';
                }
                field(Notes2; Notes2)
                {
                    ApplicationArea = All;
                    Caption = 'Notes 2';
                }
                field(Notes; Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                }
                field("Receiving Inspection"; "Receiving Inspection")
                {
                    ApplicationArea = All;
                    Caption = 'Receiving Inspection';
                }
                field("User Id"; "User Id")
                {
                    ApplicationArea = All;
                    Caption = 'User Id';
                }
                field("Invoicing Email"; "Invoicing Email")
                {
                    ApplicationArea = All;
                    Caption = 'Invoicing Email';
                }
                field("Email Invoice"; "Email Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Email Invoice';
                }
                field("Path to PDF"; "Path to PDF")
                {
                    ApplicationArea = All;
                    Caption = 'Path to PDF';
                }

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}