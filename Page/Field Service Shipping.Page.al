page 50156 "Field Service Shipping"
{
    // 05/2/18
    //   ContainerType control set to field options in table 50001.

    PageType = Card;
    SourceTable = FieldService;

    layout
    {
        area(content)
        {
            group(Shipping)
            {
                group(Control1220060024)
                {
                    ShowCaption = false;
                    field("Field Service No."; Rec."Field Service No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(Customer; Rec.Customer)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To Code"; Rec."Ship To Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To Name"; Rec."Ship To Name")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To Address 1"; Rec."Ship To Address 1")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To Address 2"; Rec."Ship To Address 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To City"; Rec."Ship To City")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To State"; Rec."Ship To State")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Ship To Zip Code"; Rec."Ship To Zip Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Control1220060025)
                {
                    ShowCaption = false;
                    field(Shipper; Shipper)
                    {
                        ApplicationArea = All;
                        Caption = 'Shippers Initals';
                        TableRelation = Resource."No." WHERE(Type = CONST(Person));
                    }
                    field(ShippingTime; ShippingTime)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Time';
                    }
                    field(ShipmentWeight; ShipmentWeight)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipment Weight';
                    }
                    field(ContainerQty; ContainerQty)
                    {
                        ApplicationArea = All;
                        Caption = 'Total Containers';
                    }
                    field(ContainerType; ContainerType)
                    {
                        ApplicationArea = All;
                        Caption = 'Container Type';
                    }
                    field(LabelCount; LabelCount)
                    {
                        ApplicationArea = All;
                        Caption = 'Label Quantity';
                    }
                    field(Carrier; Rec.Carrier)
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Method"; Rec."Shipping Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Account"; Rec."Shipping Account")
                    {
                        ApplicationArea = All;
                    }
                    field("Shipping Charge"; Rec."Shipping Charge")
                    {
                        ApplicationArea = All;
                    }
                    field(PackageTrackingNo; PackageTrackingNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Package Tracking No.';
                    }
                }
            }
            part(FieldServiceParts; "Field Service Shipping Sub")
            {
                ApplicationArea = All;
                SubPageLink = "Work Order No." = FIELD("Field Service No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Print &BOL and Labels")
            {
                ApplicationArea = All;
                Caption = 'Print &BOL and Labels';
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Shipper = '' then
                        Error('Shippers Initials must be Entered');

                    if ShippingTime = 0 then
                        Error('Shipping Time must be Entered');

                    if ShipmentWeight = 0 then
                        Error('Shipment Weight must be Entered');

                    if ContainerQty = 0 then
                        Error('Total Containers must be Entered');

                    if ContainerType.AsInteger() = 0 then
                        Error('Container Type must be Entered');

                    if Rec.Carrier = '' then
                        Error('Shipping Agent Code must be Entered');

                    if Rec."Shipping Method" = '' then
                        Error('Shipment Method Code must be Entered');

                    if Rec."Shipping Charge" = Rec."Shipping Charge"::" " then
                        Error('Shipping Charge must be Entered');

                    Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                    Parts.SetRange(Parts."Work Order No.", Rec."Field Service No.");
                    Parts.SetFilter(Parts."Qty. to Ship", '<>%1', 0);
                    if Parts.Find('-') then
                        ok := true
                    else
                        Error('Qty to Ship for atleast one must be entered for atleast one part');


                    if BOL.Find('+') then
                        BLInteger := BOL."Bill of Lading" + 1
                    else
                        BLInteger := 100000;

                    // Create Parts Shipment Record to Print BOL and for Future Reference
                    Parts.Reset;
                    Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                    Parts.SetRange(Parts."Work Order No.", Rec."Field Service No.");
                    if Parts.Find('-') then begin
                        repeat
                            if Parts."Qty. to Ship" > 0 then begin
                                FSParts.Init;
                                FSParts."Bill of Lading" := BLInteger;
                                FSParts."Work Order No." := Parts."Work Order No.";
                                FSParts."Part Type" := Parts."Part Type";
                                FSParts."Part No." := Parts."Part No.";
                                FSParts.Description := Parts.Description;
                                FSParts."Serial No." := Parts."Serial No.";
                                FSParts."Qty. Shipped" := Parts."Qty. to Ship";
                                FSParts.Insert;
                            end;
                        until Parts.Next = 0;
                    end;

                    // Update Parts table Qty to Ship to Qty Shipped & zero out Qty to Ship
                    Parts.Reset;
                    Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                    Parts.SetRange(Parts."Work Order No.", Rec."Field Service No.");
                    Parts.SetFilter(Parts."Qty. to Ship", '<>%1', 0);
                    if Parts.Find('-') then begin
                        repeat
                            Parts2.Reset;
                            Parts2.SetCurrentKey(Parts2."Work Order No.", Parts2."Part No.");
                            Parts2.SetRange(Parts2."Work Order No.", Rec."Field Service No.");
                            Parts2.SetRange(Parts2."Part No.", Parts."Part No.");
                            if Parts2.Find('-') then begin
                                Parts2."Qty. Shipped" := Parts2."Qty. Shipped" + Parts2."Qty. to Ship";
                                Parts2."Qty. to Ship" := 0;
                                Parts2.Modify;
                            end;
                        until Parts.Next = 0;
                    end;

                    // Insert Shipping Step
                    WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
                    WOS.SetRange(WOS."Order No.", Rec."Field Service No.");
                    if WOS.Find('+') then begin
                        WOS2.Init;
                        WOS2."Order No." := WOS."Order No.";
                        WOS2.Type := WOS2.Type::FieldService;
                        WOS2."Line No." := WOS."Line No." + 10000;
                        WOS2.Step := WOS2.Step::SHP;
                        WOS2."Date In" := WorkDate;
                        WOS2."Date Out" := WorkDate;
                        WOS2.Employee := Shipper;
                        WOS2."Regular Hours" := ShippingTime;
                        WOS2.Status := WOS2.Status::Complete;
                        WOS2.Insert;
                    end;

                    // Create Bill of Lading Record
                    BOL2.Init;
                    BOL2."Bill of Lading" := BLInteger;
                    BOL2."Order No." := Rec."Field Service No.";
                    BOL2.Customer := Rec.Customer;
                    BOL2."Ship To Name" := Rec."Ship To Name";
                    BOL2."Ship To Address" := Rec."Ship To Address 1";
                    BOL2."Ship To Address2" := Rec."Ship To Address 2";
                    BOL2."Ship To City" := Rec."Ship To City";
                    BOL2."Ship To State" := Rec."Ship To State";
                    BOL2."Ship To Zip Code" := Rec."Ship To Zip Code";
                    BOL2.Attention := Rec.Attention;
                    BOL2."Phone No." := Rec."Phone No.";
                    BOL2."Shipping Weight" := ShipmentWeight;
                    BOL2."Container Quantity" := ContainerQty;
                    BOL2."Container Type" := ContainerType;
                    BOL2.Employee := Shipper;
                    BOL2."Shipment Date" := Today;
                    BOL2.Carrier := Rec.Carrier;
                    BOL2."Shipping Method" := Rec."Shipping Method";
                    BOL2."Shipping Charge" := Rec."Shipping Charge";
                    BOL2."Shipping Account" := Rec."Shipping Account";
                    BOL2."Label Quantity" := LabelsToPrint;
                    BOL2.Insert;

                    Rec.Modify;
                    Commit;

                    if not Confirm('Is Bill of Lading and Labels loaded in Printers?', false) then begin
                        if not Confirm('Last Chance, Is Bill of Lading and Labels loaded in Printers?', false) then begin
                            ok := true;
                        end else begin
                            BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                            REPORT.RunModal(50156, false, false, BOL2);               // BOL Document
                            BOL2."BOL Printed" := true;
                            BOL2.Modify;
                            LabelCount := LabelsToPrint;
                            repeat
                            begin
                                LabelCount := LabelCount - 1;
                                REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                            end;
                            until LabelCount = 0;
                            BOL2."Label Printed" := true;
                            BOL2.Modify;
                            ConfirmLabels;
                        end;
                    end else begin
                        BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                        REPORT.RunModal(50156, false, false, BOL2);               // BOL Document
                        BOL2."BOL Printed" := true;
                        BOL2.Modify;
                        LabelCount := LabelsToPrint;
                        if LabelCount > 0 then begin
                            repeat
                            begin
                                LabelCount := LabelCount - 1;
                                REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                            end;
                            until LabelCount = 0;
                            BOL2."Label Printed" := true;
                        end else begin
                            BOL2."Label Printed" := false;
                        end;
                        BOL2.Modify;
                        ConfirmLabels;
                    end;

                    CurrPage.Close;
                end;
            }
        }
    }

    var
        Shipper: Code[3];
        ShippingTime: Decimal;
        ShipmentWeight: Decimal;
        ContainerQty: Integer;
        ContainerType: Enum BOLContainer;
        LabelCount: Integer;
        LabelsToPrint: Integer;
        PackageTrackingNo: Text[30];
        BOL: Record BillofLading;
        BOL2: Record BillofLading;
        BLInteger: Integer;
        ok: Boolean;
        Parts: Record Parts;
        Parts2: Record Parts;
        FSParts: Record "Field Service Parts Shipment";
        WOS: Record Status;
        WOS2: Record Status;

    procedure ConfirmLabels()
    begin
        if not Confirm('Did Bill of Lading & labels print correctly?', false) then begin
            BOL2."BOL Printed" := false;
            BOL2."Label Printed" := false;
            BOL2.Modify;
            if not Confirm('Do you want to reprint?', false) then begin
                ok := true;
            end else begin
                BOL2.SetRange(BOL2."Bill of Lading", BOL2."Bill of Lading");
                REPORT.RunModal(50156, false, false, BOL2);               // BOL Document
                BOL2."BOL Printed" := true;
                BOL2.Modify;
                LabelCount := LabelsToPrint;
                if LabelCount > 0 then begin
                    repeat
                    begin
                        LabelCount := LabelCount - 1;
                        REPORT.RunModal(50015, false, false, BOL2);               // Shipping Label
                    end;
                    until LabelCount = 0;
                    BOL2."Label Printed" := true;
                end else begin
                    BOL2."Label Printed" := false;
                end;
                BOL2.Modify;
                ConfirmLabels;
            end;
        end;
    end;
}

