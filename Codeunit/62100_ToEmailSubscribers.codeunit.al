codeunit 62100 ToEmailSubscriber
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnAfterGetEmailBodyCustomer', '', true, true)]
    local procedure OnAfterGetEmailBodyCustomer(var CustomerEmailAddress: Text[250]; ServerEmailBodyFilePath: Text[250]; RecordVariant: Variant; var Result: Boolean; var IsHandled: Boolean)
    var
        cust: Record customer;
        recordref: recordref;
        fieldref: fieldref;
        custno: code[20];
        DatatypeManagement: Codeunit "Data Type Management";
    begin



        RecordRef.GetTable(RecordVariant);
        if not RecordRef.IsEmpty then
            if DataTypeManagement.FindFieldByName(RecordRef, FieldRef, 'Sell-to Customer No.') then begin
                CustNo := FieldRef.Value;

                IF cust.get(custno) THEN begin
                    IF cust."Invoicing Email" <> '' then begin
                        CustomerEmailAddress := cust."Invoicing Email";

                    end;

                end;
            end;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnAfterGetEmailBodyVendor', '', true, true)]
    local procedure OnAfterGetEmailBodyVendor(var VendorEmailAddress: Text[250]; ServerEmailBodyFilePath: Text[250]; RecordVariant: Variant; var Result: Boolean; var IsHandled: Boolean)
    var
        vend: Record vendor;
        recordref: recordref;
        fieldref: fieldref;
        vendno: code[20];
        DatatypeManagement: Codeunit "Data Type Management";
    begin



        RecordRef.GetTable(RecordVariant);
        if not RecordRef.IsEmpty then
            if DataTypeManagement.FindFieldByName(RecordRef, FieldRef, 'Buy-from Vendor No.') then begin
                VendNo := FieldRef.Value;

                IF vend.get(vendno) THEN begin
                    IF vend."Invoicing Email" <> '' then begin
                        VendorEmailAddress := vend."Invoicing Email";

                    end;

                end;
            end;

    end;
}