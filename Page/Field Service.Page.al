page 50150 "Field Service"
{
    PageType = Card;
    SourceTable = FieldService;

    layout
    {
        area(content)
        {
            group(FSOrder)
            {


                field("Field Service No."; Rec."Field Service No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Ship To Code"; Rec."Ship To Code")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Date Ordered"; Rec."Date Ordered")
                {
                    ApplicationArea = All;
                    Caption = 'Order Date';
                    Editable = false;
                }


            }
            group(General)
            {



                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Address 1"; Rec."Customer Address 1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Address 2"; Rec."Customer Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer City"; Rec."Customer City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer State"; Rec."Customer State")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Zip Code"; Rec."Customer Zip Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer Payment Terms"; Rec."Customer Payment Terms")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Credit Card No."; Rec."Credit Card No.")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Credit Card Exp."; Rec."Credit Card Exp.")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Tax Exemption No."; Rec."Tax Exemption No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Exempt Organization"; Rec."Exempt Organization")
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
                    Editable = ControlsEditable;
                }
                field("Ship To Address 2"; Rec."Ship To Address 2")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
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
                field(Attention; Rec.Attention)
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    Editable = ControlsEditable;
                }
                field("Inside Sales"; Rec."Inside Sales")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Rep; Rec.Rep)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Complete; Rec.Complete)
                {
                    ApplicationArea = All;
                }
            }
            group("Service Detail")
            {
                group(Control1220060059)
                {
                    ShowCaption = false;
                    field("Service Type"; Rec."Service Type")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if Rec."Service Type" = Rec."Service Type"::Unpaid then begin
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");
                                OrderAdjEditable := false;
                            end else begin
                                Rec."Order Adj." := 0;
                                OrderAdjEditable := true;
                            end;

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field("Income Code"; Rec."Income Code")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                        OptionCaption = ' ,SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO,INCOME FS';
                    }
                    field("Customer PO No."; Rec."Customer PO No.")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                    field("Parts Required"; Rec."Parts Required")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                    field(Description; Rec.Description)
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                }
                group(Control1220060060)
                {
                    ShowCaption = false;
                    field(Carrier; Rec.Carrier)
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                    field("Shipping Method"; Rec."Shipping Method")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                    field("Shipping Account"; Rec."Shipping Account")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                    field("Shipping Charge"; Rec."Shipping Charge")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                }
            }
            group(Control1220060061)
            {
                ShowCaption = false;
                group(Control1220060062)
                {
                    ShowCaption = false;
                    field(Technician; Rec.Technician)
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;
                    }
                    field(Lodging; Rec.Lodging)
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec.Lodging <> Rec.Lodging then begin
                                if xRec.Lodging > Rec.Lodging then
                                    Expenses := Expenses - (xRec.Lodging - Rec.Lodging);
                                if Rec.Lodging > xRec.Lodging then
                                    Expenses := Expenses + (Rec.Lodging - xRec.Lodging);
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field("Air Travel"; Rec."Air Travel")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec."Air Travel" <> Rec."Air Travel" then begin
                                if xRec."Air Travel" > Rec."Air Travel" then
                                    Expenses := Expenses - (xRec."Air Travel" - Rec."Air Travel");
                                if Rec."Air Travel" > xRec."Air Travel" then
                                    Expenses := Expenses + (Rec."Air Travel" - xRec."Air Travel");
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field("Rental Car"; Rec."Rental Car")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec."Rental Car" <> Rec."Rental Car" then begin
                                if xRec."Rental Car" > Rec."Rental Car" then
                                    Expenses := Expenses - (xRec."Rental Car" - Rec."Rental Car");
                                if Rec."Rental Car" > xRec."Rental Car" then
                                    Expenses := Expenses + (Rec."Rental Car" - xRec."Rental Car");
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field(Meals; Rec.Meals)
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec.Meals <> Rec.Meals then begin
                                if xRec.Meals > Rec.Meals then
                                    Expenses := Expenses - (xRec.Meals - Rec.Meals);
                                if Rec.Meals > xRec.Meals then
                                    Expenses := Expenses + (Rec.Meals - xRec.Meals);
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field(Freight; Rec.Freight)
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec.Freight <> Rec.Freight then begin
                                if xRec.Freight > Rec.Freight then
                                    Expenses := Expenses - (xRec.Freight - Rec.Freight);
                                if Rec.Freight > xRec.Freight then
                                    Expenses := Expenses + (Rec.Freight - xRec.Freight);
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field("Misc Expenses"; Rec."Misc Expenses")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec."Misc Expenses" <> Rec."Misc Expenses" then begin
                                if xRec."Misc Expenses" > Rec."Misc Expenses" then
                                    Expenses := Expenses - (xRec."Misc Expenses" - Rec."Misc Expenses");
                                if Rec."Misc Expenses" > xRec."Misc Expenses" then
                                    Expenses := Expenses + (Rec."Misc Expenses" - xRec."Misc Expenses");
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                }
            }
            group(Control1220060063)
            {
                ShowCaption = false;
                group(Control1220060064)
                {
                    ShowCaption = false;
                    field("Company Van Miles"; Rec."Company Van Miles")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if Rec."Personal Vehicle Miles" = 0 then begin
                                if xRec."Company Van Miles" <> Rec."Company Van Miles" then begin
                                    if xRec."Company Van Miles" > Rec."Company Van Miles" then
                                        Expenses := Expenses - ((xRec."Company Van Miles" - Rec."Company Van Miles") * (Rec."Mileage Rate" / 100));
                                    if Rec."Company Van Miles" > xRec."Company Van Miles" then
                                        Expenses := Expenses + ((Rec."Company Van Miles" - xRec."Company Van Miles") * (Rec."Mileage Rate" / 100));
                                end;

                                if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                    Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                                QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                            end else begin
                                Rec."Company Van Miles" := 0;
                                Rec.Modify;
                                Message('Personal Vehicle Miles entered, so Company Van Miles not allowed');
                            end;
                        end;
                    }
                    field("Personal Vehicle Miles"; Rec."Personal Vehicle Miles")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if Rec."Company Van Miles" = 0 then begin
                                if xRec."Personal Vehicle Miles" <> Rec."Personal Vehicle Miles" then begin
                                    if xRec."Personal Vehicle Miles" > Rec."Personal Vehicle Miles" then
                                        Expenses := Expenses - ((xRec."Personal Vehicle Miles" - Rec."Personal Vehicle Miles") * (Rec."Mileage Rate" / 100));
                                    if Rec."Personal Vehicle Miles" > xRec."Personal Vehicle Miles" then
                                        Expenses := Expenses + ((Rec."Personal Vehicle Miles" - xRec."Personal Vehicle Miles") * (Rec."Mileage Rate" / 100));
                                end;

                                if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                    Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                                QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                            end else begin
                                Rec."Personal Vehicle Miles" := 0;
                                Rec.Modify;
                                Message('Company Van Miles entered, so Personal Vehicle Miles not allowed');
                            end;
                        end;
                    }
                    field("Travel Hours"; Rec."Travel Hours")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec."Travel Hours" <> Rec."Travel Hours" then begin
                                if xRec."Travel Hours" > Rec."Travel Hours" then
                                    LaborPrice := LaborPrice - ((xRec."Travel Hours" - Rec."Travel Hours") * Rec."Labor Rate");
                                if Rec."Travel Hours" > xRec."Travel Hours" then
                                    LaborPrice := LaborPrice + ((Rec."Travel Hours" - xRec."Travel Hours") * Rec."Labor Rate");
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field("Work Hours"; Rec."Work Hours")
                    {
                        ApplicationArea = All;
                        Editable = ControlsEditable;

                        trigger OnValidate()
                        begin
                            if xRec."Work Hours" <> Rec."Work Hours" then begin
                                if xRec."Work Hours" > Rec."Work Hours" then
                                    LaborPrice := LaborPrice - ((xRec."Work Hours" - Rec."Work Hours") * Rec."Labor Rate");
                                if Rec."Work Hours" > xRec."Work Hours" then
                                    LaborPrice := LaborPrice + ((Rec."Work Hours" - xRec."Work Hours") * Rec."Labor Rate");
                            end;

                            if Rec."Service Type" = Rec."Service Type"::Unpaid then
                                Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");

                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                }
                group(Control1220060065)
                {
                    ShowCaption = false;
                    field("Parts Quoted"; Rec."Parts Quoted")
                    {
                        ApplicationArea = All;
                        Caption = 'Parts Price';
                        Editable = false;
                    }
                    field(LaborPrice; LaborPrice)
                    {
                        ApplicationArea = All;
                        Caption = 'Labor Price';
                        Editable = false;
                    }
                    field(Expenses; Expenses)
                    {
                        ApplicationArea = All;
                        Caption = 'Expenses';
                        Editable = false;
                    }
                    field("Order Adj."; Rec."Order Adj.")
                    {
                        ApplicationArea = All;
                        Editable = OrderAdjEditable;

                        trigger OnValidate()
                        begin
                            QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
                        end;
                    }
                    field(QuotePrice; QuotePrice)
                    {
                        ApplicationArea = All;
                        Caption = 'Quote Price';
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Complete Order")
            {
                ApplicationArea = All;
                Caption = 'Complete Order';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    if Rec.Complete then
                        Error('The Field Service Order is already Complete');

                    //IF "Incomplete Parts" THEN
                    //  ERROR('The Field Service Order Parts are not complete, Please See Parts Department');

                    //IF Expenses = 0 THEN
                    //  ERROR('Expenses must be entered to Complete Order');

                    //IF LaborPrice = 0 THEN
                    //  ERROR('Hours must be entered to Complete Order');


                    if Rec."Service Type" = Rec."Service Type"::Paid then begin
                        //IF QuotePrice <= 0 THEN
                        //  ERROR('The Service Type Can''t be Paid if the Quote Price is Zero');
                        Paid
                    end else
                        UnPaid;

                    Rec.Complete := true;
                    Rec.Modify;
                end;
            }
            action(Traveler)
            {
                ApplicationArea = All;
                Caption = 'Traveler';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                trigger OnAction()
                begin
                    FS2 := Rec;
                    FS2.SetFilter("Field Service No.", Rec."Field Service No.");
                    FS2.SetRecFilter;
                    REPORT.RunModal(50151, true, false, FS2);
                end;
            }
            action(Envelope)
            {
                ApplicationArea = All;
                Caption = 'Envelope';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = report;
                trigger OnAction()
                begin
                    FS2 := Rec;
                    FS2.SetFilter("Field Service No.", Rec."Field Service No.");
                    FS2.SetRecFilter;
                    REPORT.RunModal(50150, true, false, FS2);
                end;
            }
            action("Current &Status")
            {
                ApplicationArea = All;
                Caption = 'Current &Status';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    FS.SetRange(FS."Field Service No.", Rec."Field Service No.");
                    PAGE.Run(50154, FS);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ControlsEditable := true;  //ICE RSK 1/19/21 set it to true inititally
        OrderAdjEditable := true;
    end;

    trigger OnAfterGetCurrRecord()  //ICE RSK 1/19/21
    begin
        if Rec.Complete then begin
            ControlsEditable := false;
        end else begin
            ControlsEditable := true;
        end;
        if Rec."Service Type" = Rec."Service Type"::Unpaid then begin
            Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");
            OrderAdjEditable := false;
        end else begin
            if Rec.Complete then
                OrderAdjEditable := false
            else
                OrderAdjEditable := true;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(QuotePrice);
        Clear(Expenses);
        Expenses := Rec.Lodging + Rec."Air Travel" + Rec."Rental Car" + Rec.Meals + Rec."Misc Expenses" + Rec.Freight
                    + (Rec."Company Van Miles" * (Rec."Mileage Rate" / 100)) + (Rec."Personal Vehicle Miles" * (Rec."Mileage Rate" / 100));
        LaborPrice := ((Rec."Travel Hours" + Rec."Work Hours") * Rec."Labor Rate");
        if Rec."Service Type" = Rec."Service Type"::Unpaid then begin
            Rec."Order Adj." := -(Expenses + LaborPrice + Rec."Parts Quoted");
            OrderAdjEditable := false;
        end else begin
            if Rec.Complete then
                OrderAdjEditable := false
            else
                OrderAdjEditable := true;
        end;

        if Rec.Complete then begin
            ControlsEditable := false;
        end else begin
            ControlsEditable := true;
        end;

        QuotePrice := Rec."Parts Quoted" + LaborPrice + Expenses + Rec."Order Adj.";
    end;

    var
        WOD: Record WorkOrderDetail;
        FS: Record FieldService;
        FS2: Record FieldService;
        QuotePrice: Decimal;
        Expenses: Decimal;
        LaborPrice: Decimal;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Cust: Record Customer;
        Ok: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLineNo: Integer;
        ShipTo: Record "Ship-to Address";
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        GPS: Record "General Posting Setup";
        ReturnInventoryQty: Decimal;
        RemoveInventoryQty: Decimal;
        PartsComplete: Record Parts;
        AdjRemainder: Decimal;
        WOP: Record Parts;
        Item: Record Item;
        SerialNo: Code[20];
        WOS: Record Status;
        BOL: Record BillofLading;
        Tech: Text[30];
        [InDataSet]
        OrderAdjEditable: Boolean;
        [InDataSet]
        ControlsEditable: Boolean;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    procedure Paid()
    begin
        if Rec."Customer PO No." = '' then
            Error('Customer PO No. must be entered to Complete this Order');

        if Rec."Income Code" = 0 then
            Error('Income Code must be entered to Complete this Order');

        CreateOrder;
        CreateLines;
        UpdateParts;
        UpdateWOS;
        Reservation;
    end;

    procedure UnPaid()
    begin
        WOP.Reset;
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", Rec."Field Service No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
        WOP.SetFilter(WOP."Pulled Quantity", '>0');
        if WOP.Find('-') then begin
            repeat
                if Item.Get(WOP."Part No.") then begin
                    WOP.CalcFields(WOP."In-Process Quantity");
                    if Item."Costing Method" = Item."Costing Method"::Specific then
                        SerialNo := WOP."Serial No."
                    else
                        SerialNo := '';
                    ReturnInventory;
                    RemoveInventory;
                    WOP."In-Process Quantity" := 0;
                    WOP.Modify;
                end;
            until WOP.Next = 0;
        end;
        UpdateParts;
        UpdateWOS;
    end;

    procedure InitSalesHeaderRecord()
    begin
        if (SalesHeader."No. Series" <> '') and
           (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
        then
            SalesHeader."Posting No. Series" := SalesHeader."No. Series"
        else
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
        if SalesSetup."Shipment on Invoice" then
            NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
    end;

    procedure CreateOrder()
    begin
        Clear(SalesHeader);

        SalesHeader.Init;
        SalesSetup.Get;

        SalesHeader."No." := Rec."Field Service No.";

        InitSalesHeaderRecord;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader.Validate("Sell-to Customer No.", Rec.Customer);
        ShipTo.Get(SalesHeader."Sell-to Customer No.", Rec."Ship To Code");
        SalesHeader.Validate("Posting Date", Today);
        SalesHeader."Order Date" := Rec."Date Ordered";
        SalesHeader."Ship-to Code" := Rec."Ship To Code";
        SalesHeader."Ship-to Name" := Rec."Ship To Name";
        SalesHeader."Ship-to Address" := Rec."Ship To Address 1";
        SalesHeader."Ship-to Address 2" := Rec."Ship To Address 2";
        SalesHeader."Ship-to City" := Rec."Ship To City";
        SalesHeader."Ship-to County" := Rec."Ship To State";
        SalesHeader."Ship-to Post Code" := Rec."Ship To Zip Code";
        SalesHeader."Ship-to Contact" := Rec.Attention;
        SalesHeader."Document Date" := Today;
        SalesHeader."Shipping No. Series" := SalesSetup."Posted Shipment Nos.";
        SalesHeader."Posting No. Series" := SalesSetup."Posted Invoice Nos.";
        //SalesHeader.Rep := ShipTo.Rep;
        SalesHeader."Salesperson Code" := ShipTo."Inside Sales";
        SalesHeader."Your Reference" := Rec."Customer PO No.";
        SalesHeader."Payment Terms Code" := Rec."Customer Payment Terms";
        //SalesHeader."Card Type" := Rec."Card Type";
        //SalesHeader."Credit Card No." := Rec."Credit Card No.";
        //SalesHeader."Credit Card Exp." := Rec."Credit Card Exp.";
        SalesHeader."Shipment Method Code" := Rec."Shipping Method";
        SalesHeader."Shipping Agent Code" := Rec.Carrier;
        //SalesHeader."Shipping Charge" := Rec."Shipping Charge";
        //SalesHeader."Shipping Account" := Rec."Shipping Account";

        // Need to link to Bill of Lading Record for information
        BOL.SetRange(BOL."Order No.", Rec."Field Service No.");
        if BOL.Find('+') then begin
            SalesHeader."Shipment Date" := BOL."Shipment Date";
            SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Partial;
            //  SalesHeader."Bill of Lading" := BOL."Bill of Lading";
            SalesHeader."Package Tracking No." := BOL."Package Tracking No.";
        end else begin
            SalesHeader."Shipment Date" := Today;
            SalesHeader."Shipping Advice" := SalesHeader."Shipping Advice"::Partial;
        end;

        if Rec."Tax Liable" = true then
            SalesHeader."Tax Liable" := true
        else
            SalesHeader."Tax Liable" := false;

        if Cust.Get(SalesHeader."Sell-to Customer No.") then begin
            SalesHeader."Tax Exemption No." := Cust."Tax Exemption No.";
            //  SalesHeader."Exempt Organization" :=  Cust."Exempt Organization";
        end else begin
            SalesHeader."Tax Exemption No." := '';
            //  SalesHeader."Exempt Organization" :=  '';
        end;

        SalesHeader."Shortcut Dimension 1 Code" := 'FS';
        SalesHeader.Insert;
    end;

    procedure CreateLines()
    begin
        //>> Field Service No.
        LineLoop;
        SalesLine.Type := SalesLine.Type::" ";
        SalesLine.Validate("No.", '');
        SalesLine.Description := Rec."Field Service No.";
        //SalesLine."Commission Calculated" := FALSE;
        //SalesLine."Cross Reference Item" := 'Field Service';
        SalesLine.Insert;


        //Labor Total
        AdjRemainder := 0;
        if Rec."Order Adj." < 0 then begin
            if Abs(Rec."Order Adj.") > LaborPrice then begin
                AdjRemainder := LaborPrice + Rec."Order Adj.";
            end else begin
                if Round(LaborPrice + Rec."Order Adj.") > 0 then begin
                    LineLoop;
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                    GPSLoop;
                    SalesLine.Validate(Quantity, 1);
                    SalesLine.Description := 'Labor ';
                    SalesLine."Unit Price" := Round(LaborPrice + Rec."Order Adj.");
                    SalesLine.Validate("Unit Price");
                    //      SalesLine."Commission Calculated" := TRUE;
                    SalesLine.Insert;
                end;
            end;
        end else begin
            if Round(LaborPrice + Rec."Order Adj.") > 0 then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                GPSLoop;
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Labor ';
                SalesLine."Unit Price" := Round(LaborPrice + Rec."Order Adj.");
                SalesLine.Validate("Unit Price");
                //    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
            end;
        end;

        // Expenses Total
        if AdjRemainder < 0 then begin
            if Abs(AdjRemainder) > Expenses then begin
                AdjRemainder := Expenses + AdjRemainder;
            end else begin
                if Round(Expenses + AdjRemainder) > 0 then begin
                    LineLoop;
                    SalesLine.Type := SalesLine.Type::"G/L Account";
                    GPSLoop;
                    SalesLine.Validate(Quantity, 1);
                    SalesLine.Description := 'Expenses ';
                    SalesLine."Unit Price" := Round(Expenses + AdjRemainder);
                    SalesLine.Validate("Unit Price");
                    //      SalesLine."Commission Calculated" := TRUE;
                    SalesLine.Insert;
                    AdjRemainder := 0;
                end;
            end;
        end else begin
            if Round(Expenses) > 0 then begin
                LineLoop;
                SalesLine.Type := SalesLine.Type::"G/L Account";
                GPSLoop;
                SalesLine.Validate(Quantity, 1);
                SalesLine.Description := 'Expenses ';
                SalesLine."Unit Price" := Round(Expenses);
                SalesLine.Validate("Unit Price");
                //    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
            end;
        end;

        // Parts Total
        if Round(Rec."Parts Quoted" + AdjRemainder) > 0 then begin
            LineLoop;
            SalesLine.Type := SalesLine.Type::"G/L Account";
            if GPS."Sales Account" = '' then
                GPSLoop;
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
            SalesLine.Validate(Quantity, 1);
            SalesLine.Description := 'Parts ';
            SalesLine."Unit Price" := Round(Rec."Parts Quoted" + AdjRemainder);
            SalesLine.Validate("Unit Price");
            //  SalesLine."Commission Calculated" := TRUE;
            SalesLine.Insert;
        end;


        //>>Create Resources Line
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", Rec."Field Service No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Resource);
        if WOP.Find('-') then begin
            repeat
                LineLoop;
                SalesLine.Type := SalesLine.Type::Resource;
                SalesLine.Validate("No.", WOP."Part No.");   //Shop Labor
                SalesLine.Validate(Quantity, WOP."Quoted Quantity");
                SalesLine.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                //    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
            until WOP.Next = 0;
        end;

        //>>Create Parts Lines
        WOP.Reset;
        WOP.SetCurrentKey("Work Order No.", "Part No.");
        WOP.SetRange(WOP."Work Order No.", Rec."Field Service No.");
        WOP.SetRange(WOP."Part Type", WOP."Part Type"::Item);
        WOP.SetFilter(WOP."Pulled Quantity", '>0');
        if WOP.Find('-') then begin
            repeat
                if Item.Get(WOP."Part No.") then begin
                    WOP.CalcFields(WOP."In-Process Quantity");
                    if Item."Costing Method" = Item."Costing Method"::Specific then begin
                        SerialNo := WOP."Serial No."
                    end else begin
                        SerialNo := ''
                    end
                end;

                ReturnInventory;
                LineLoop;
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", WOP."Part No.");

                if Item."Costing Method" = Item."Costing Method"::Specific then begin
                    //      SalesLine."Serial No." := SerialNo
                end;

                SalesLine.Validate(Reserve, SalesLine.Reserve::Always);
                SalesLine.Validate(Quantity, WOP."Pulled Quantity");
                SalesLine.Validate("Unit Price", 0);
                if GPS."Gen. Prod. Posting Group" = '' then
                    GPSLoopNoGLEntry;
                SalesLine.Validate("Gen. Prod. Posting Group", GPS."Gen. Prod. Posting Group");
                if SalesLine."VAT Prod. Posting Group" = '' then
                    SalesLine."VAT Prod. Posting Group" := 'DEFAULT';
                //    SalesLine."Commission Calculated" := TRUE;
                SalesLine.Insert;
                WOP."In-Process Quantity" := 0;
                WOP.Modify;
            until WOP.Next = 0;
        end;
    end;

    procedure UpdateParts()
    begin
        PartsComplete.SetCurrentKey("Work Order No.", "Part No.");
        PartsComplete.SetRange(PartsComplete."Work Order No.", Rec."Field Service No.");
        if PartsComplete.Find('-') then begin
            repeat
                PartsComplete.Complete := true;
                PartsComplete.Modify;
            until PartsComplete.Next = 0;
        end;
    end;

    procedure Reservation()
    begin
        // Reservation Entry
        Commit;
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.Find('-') then begin
            repeat
                if (SalesLine.Reserve = SalesLine.Reserve::Always) and (SalesLine."Outstanding Qty. (Base)" <> 0) then
                    SalesLine.AutoReserve();
            until
              SalesLine.Next = 0;
        end;
    end;

    procedure UpdateWOS()
    begin
        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", Rec."Field Service No.");
        WOS.SetRange(WOS.Step, WOS.Step::QOT);
        if WOS.Find('-') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS."Regular Hours" := 1 / 100;
            WOS.Employee := 'UNK';
            WOS.Modify;
        end;


        WOS.SetCurrentKey(WOS."Order No.", WOS."Line No.");
        WOS.SetRange(WOS."Order No.", Rec."Field Service No.");
        WOS.SetRange(WOS.Step, WOS.Step::"B-O");
        if WOS.Find('-') then begin
            WOS.Status := WOS.Status::Complete;
            WOS."Date Out" := WorkDate;
            WOS."Regular Hours" := 125 / 1000;
            WOS.Employee := 'UNK';
            WOS.Modify;
        end;
    end;

    procedure TaxCheck()
    begin
    end;

    procedure LineLoop()
    begin
        Clear(SalesLine);
        SalesLineNo := SalesLineNo + 10000;
        SalesLine.Init;
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Line No." := SalesLineNo;
        SalesLine.Validate(SalesLine."Document No.", SalesHeader."No.");
    end;

    procedure GPSLoop()
    begin
        // Field Service Table - Income Code
        // ,SERVICE,SALES,TURBO,ELECTRONIC,DRY,CRYO,EXPENSE FS,FREIGHT FS,LABOR FS,TRAVEL FS
        if (Rec."Income Code" = 1) then begin
            GPS.Get('', 'REPAIR');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (Rec."Income Code" = 2) then begin
            GPS.Get('', 'PP SALES');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (Rec."Income Code" = 3) then begin
            GPS.Get('', 'TURBO');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (Rec."Income Code" = 4) then begin
            GPS.Get('', 'ELECTRONIC');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (Rec."Income Code" = 5) then begin
            GPS.Get('', 'DRY PUMP');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (Rec."Income Code" = 6) then begin
            GPS.Get('', 'CRYO');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
        if (Rec."Income Code" = 7) then begin
            GPS.Get('', 'INCOME FS');
            SalesLine.Validate("No.", GPS."Sales Account");   //Sales Account
        end;
    end;

    procedure GPSLoopNoGLEntry()
    begin
        if (Rec."Income Code" = 1) then begin
            GPS.Get('', 'REPAIR');
        end;
        if (Rec."Income Code" = 2) then begin
            GPS.Get('', 'PP SALES');
        end;
        if (Rec."Income Code" = 3) then begin
            GPS.Get('', 'TURBO');
        end;
        if (Rec."Income Code" = 4) then begin
            GPS.Get('', 'ELECTRONIC');
        end;
        if (Rec."Income Code" = 5) then begin
            GPS.Get('', 'DRY PUMP');
        end;
        if (Rec."Income Code" = 6) then begin
            GPS.Get('', 'CRYO');
        end;
        if (Rec."Income Code" = 7) then
            GPS.Get('', 'INCOME FS');
    end;

    procedure ReturnInventory()
    begin
        ReturnInventoryQty := WOP."Pulled Quantity";
        if ReturnInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'TRANSFER';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
                ItemJournalLine."Document No." := Rec."Field Service No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := Rec."Field Service No." + ' ' + 'SHIP RETURN PARTS';
                ItemJournalLine."Location Code" := 'IN PROCESS';

                ItemJournalLine.Quantity := ReturnInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);
                ItemJournalLine."New Location Code" := 'MAIN';
                ItemJournalLine.Validate(ItemJournalLine."New Location Code");

                if SerialNo <> '' then begin
                    WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;

    procedure RemoveInventory()
    begin
        RemoveInventoryQty := WOP."Pulled Quantity";
        if RemoveInventoryQty <> 0 then begin
            if WOP."Part Type" = WOP."Part Type"::Item then begin
                ItemJournalLine.Init;
                ItemJournalLine."Journal Template Name" := 'ITEM';
                ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
                ItemJournalLine."Journal Batch Name" := 'WARRANTY';
                ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
                ItemJournalLine."Line No." := LineNumber;
                ItemJournalLine."Entry Type" := ItemLedgEntryType::"Negative Adjmt."; ///--! Negative Adjustment
                ItemJournalLine."Document No." := Rec."Field Service No.";
                ItemJournalLine."Item No." := WOP."Part No.";
                ItemJournalLine.Validate(ItemJournalLine."Item No.");
                ItemJournalLine."Posting Date" := WorkDate;
                ItemJournalLine.Description := Rec."Field Service No." + ' ' + 'WARRANTY';
                ItemJournalLine."Location Code" := 'MAIN';
                ItemJournalLine.Quantity := RemoveInventoryQty;
                ItemJournalLine.Validate(ItemJournalLine.Quantity);

                if SerialNo <> '' then begin
                    WOD.SetItemSerialNo_(Database::"Item Journal Line", ItemJournalLine, SerialNo);
                    ItemJournalLine."Serial No." := SerialNo;
                    ItemJournalLine."New Serial No." := SerialNo;
                end;

                ItemJournalLine.Insert;

                PostLine.Run(ItemJournalLine);

                ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
                ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
                if ItemJournalClear.Find('-') then
                    repeat
                        ItemJournalClear.Delete;
                    until ItemJournalClear.Next = 0;
            end;
        end;
    end;
}

