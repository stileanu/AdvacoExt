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
                field("Part Type";"Part Type")
                {
                }
                field("Item No.";"Item No.")
                {
                }
                field(Quantity;Quantity)
                {
                    Caption = 'Qty.';
                }
                field(Department;Department)
                {
                    Caption = 'Depart.';
                }
                field("Failure Item";"Failure Item")
                {
                    Caption = 'Failure';
                }
                field("Code";Code)
                {
                    Caption = 'Item Code';
                }
                field("Defect code";"Defect code")
                {
                    Caption = 'Code';
                    Editable = false;
                }
                field("NonConformance Description";"NonConformance Description")
                {
                }
                field("Serial No.";"Serial No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

