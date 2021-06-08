pageextension 62019 ApplyCustomerEntriesExt extends "Apply Customer Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = all;
            }
            field("Order No"; OrderNo)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        OrderNo: Integer;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        //HEF INSERT
        Rec.CALCFIELDS("Work Order No.", "Sales Order No.");

        IF Rec."Work Order No." <> '' THEN BEGIN
            IF NOT EVALUATE(OrderNo, Rec."Work Order No.") THEN
                OrderNo := 0;
        END ELSE BEGIN
            IF NOT EVALUATE(OrderNo, Rec."Sales Order No.") THEN
                OrderNo := 0;
        END;

        //END INSERT
    end;
}