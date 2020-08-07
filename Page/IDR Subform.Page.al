page 50145 "IDR Subform"
{
    PageType = ListPart;
    SourceTable = IDRLine;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Part Type"; "Part Type")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Qty.';
                }
                field(Department; Department)
                {
                    ApplicationArea = All;
                    Caption = 'Depart.';
                }
                field("Failure Item"; "Failure Item")
                {
                    ApplicationArea = All;
                    Caption = 'Failure';
                }
                field("Code"; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Item Code';
                }
                field("Defect code"; "Defect code")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                    Editable = false;
                }
                field("NonConformance Description"; "NonConformance Description")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

