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
                field("Part Type"; Rec."Part Type")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Qty.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Caption = 'Depart.';
                }
                field("Failure Item"; Rec."Failure Item")
                {
                    ApplicationArea = All;
                    Caption = 'Failure';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Item Code';
                }
                field("Defect code"; Rec."Defect code")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                    Editable = false;
                }
                field("NonConformance Description"; Rec."NonConformance Description")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
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

