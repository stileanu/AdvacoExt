page 50059 "Item Card All"
{
    // 1/9/01, htcs, rca - added variable: LocationItem
    // 
    // 05/24/12 ADV
    // Added new control <RIA Reference> on tab Ordering for Reception Instruction document location. 
    //Tested

    PageType = Card;
    SourceTable = Item;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit() then
                            CurrPage.Update;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; "Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; "Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Shelf No."; "Shelf No.")
                {
                    ApplicationArea = All;
                }
                field("Model Type"; "Model Type")
                {
                    ApplicationArea = All;
                }
                field("Search Description"; "Search Description")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                }
                field(QtyAvailable; QtyAvailable)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Available';
                    Editable = false;
                }
                field("Qty. on Blanket Purch. Order"; "Qty. on Blanket Purch. Order")
                {
                    ApplicationArea = All;
                    Caption = 'Qty. on Blanket Order';
                }
                field("Qty. on Purch. Order"; "Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order"; "Qty. on Sales Order")
                {
                    ApplicationArea = All;
                }
                field("UPS Shipping Surcharge"; "UPS Shipping Surcharge")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                field("Costing Method"; "Costing Method")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; "Last Direct Cost")
                {
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; "Price/Profit Calculation")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; "Profit %")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        "Tax Group Code" := 'DEFAULT';
                        "VAT Prod. Posting Group" := 'DEFAULT';
                    end;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Net Invoiced Qty."; "Net Invoiced Qty.")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; "Item Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; "Sales Unit of Measure")
                {
                    ApplicationArea = All;
                }
            }
            group(Ordering)
            {
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field(Reserve; Reserve)
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; "Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; "Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Receiving Inspection"; "Receiving Inspection")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // 05/24/12 Start
                        if "Receiving Inspection" then
                            RIAReferenceEnabled := true
                        else
                            RIAReferenceEnabled := false;
                        // 05/24/12 End
                    end;
                }
                field("RIA Reference"; "RIA Reference")
                {
                    ApplicationArea = All;
                    Enabled = RIAReferenceEnabled;
                }
                field("Maximum Inventory"; "Maximum Inventory")
                {
                    ApplicationArea = All;
                }
                field("Reorder Point"; "Reorder Point")
                {
                    ApplicationArea = All;
                }
                field("Old ReOrder Point"; "Old ReOrder Point")
                {
                    ApplicationArea = All;
                }
                field("Reorder Quantity"; "Reorder Quantity")
                {
                    ApplicationArea = All;
                }
                field("Old ReOrder Qty"; "Old ReOrder Qty")
                {
                    ApplicationArea = All;
                }
                field("Manual ReOrder Point"; "Manual ReOrder Point")
                {
                    ApplicationArea = All;
                }
                field("Blanket Reorder Point"; "Blanket Reorder Point")
                {
                    ApplicationArea = All;
                }
                field("Blanket Reorder Quantity"; "Blanket Reorder Quantity")
                {
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; "Purch. Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Manufacturer Code"; "Manufacturer Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Return Committed")
            {
                ApplicationArea = All;
                Caption = 'Return Committed';
            }
            action("Add Item")
            {
                ApplicationArea = All;
                Caption = 'Add Item';
            }
            action("&Location Item")
            {
                ApplicationArea = All;
                Caption = '&Location Item';
            }
            group("&Item")
            {
                Caption = '&Item';
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    action("Ledger E&ntries")
                    {
                        ApplicationArea = All;
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("&Application Entries")
                    {
                        ApplicationArea = All;
                        /*Caption = '&Application Entries';
                        RunObject = Page "Item Application Entries";
                        RunPageLink = Field20=FIELD("No.");
                        RunPageView = SORTING(Field20,"Posting Date"); */
                        Caption = 'Application Worksheet';
                        RunObject = page "Application Worksheet";
                        RunPageLink = "Item No." = field("No.");  //ICE-MPC BC Upgrade
                    }
                    action("&Reservation Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Item No." = FIELD("No."),
                                      "Reservation Status" = CONST(Reservation);
                        //RunPageView = SORTING("Reservation Status","Item No.","Variant Code","Location Code",Field5402,"Expected Receipt Date"); ICE-MPC BC Upgrade
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        ApplicationArea = All;
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                    }
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    action(Action1000000129)
                    {
                        ApplicationArea = All;
                        Caption = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
                        ShortCutKey = 'F7';

                        trigger OnAction()
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RunModal;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        ApplicationArea = All;
                        Caption = 'Entry Statistics';
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter"),
                                      "Bin Filter" = FIELD("Bin Filter");
                    }
                    action("T&urnover")
                    {
                        ApplicationArea = All;
                        Caption = 'T&urnover';
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."),
                                      "Date Filter" = FIELD("Date Filter"),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                group("Items b&y")
                {
                    Caption = 'Items b&y';
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        Image = ItemAvailbyLoc;

                        trigger OnAction()
                        var
                            ItemsByLocation: Page "Items by Location";
                        begin
                            ItemsByLocation.SetRecord(Rec);
                            ItemsByLocation.Run;
                        end;
                    }
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                    action(Action1000000122)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."),
                                      "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                      "Location Filter" = FIELD("Location Filter"),
                                      "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                      "Variant Filter" = FIELD("Variant Filter");
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item),
                                  "No." = FIELD("No.");
                }
                action("&Picture")
                {
                    ApplicationArea = All;
                    Caption = '&Picture';
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter"),
                                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                                  "Location Filter" = FIELD("Location Filter"),
                                  "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                                  "Variant Filter" = FIELD("Variant Filter");
                }
                separator(Separator1000000117)
                {
                }
                action("&Units of Measure")
                {
                    ApplicationArea = All;
                    Caption = '&Units of Measure';
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                }
                separator(Separator1000000108)
                {
                }
                action("Where-Used")
                {
                    ApplicationArea = All;
                    Caption = 'Where-Used';

                    trigger OnAction()
                    var
                        ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                    begin
                        ProdBOMWhereUsed.SetItem(Rec, WorkDate);
                        ProdBOMWhereUsed.RunModal;
                    end;
                }
                action("Calc. Stan&dard Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Calc. Stan&dard Cost';
                    //RunObject = Codeunit Codeunit54; ICE-MPC BC Upgrade
                    trigger OnAction()
                    var
                        CalculateStdCost: Codeunit "Calculate Standard Cost";
                    begin
                        Clear(CalculateStdCost);
                        CalculateStdCost.CalcItem("No.", false);
                    end;

                }
                separator(Separator1000000101)
                {
                    Caption = '';
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                action(Orders)
                {
                    ApplicationArea = All;
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action("Ven&dors")
                {
                    ApplicationArea = All;
                    Caption = 'Ven&dors';
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action("Quantity Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Discounts';
                }
                action("Open Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Open Orders';
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type = CONST(Item),
                                  "No." = FIELD("No.");
                    //RunPageView = SORTING("Document Type",Type,"No.","Variant Code","Drop Shipment","Location Code","Bin Code","Expected Receipt Date");
                    RunPageView = SORTING("Document Type", Type, "No.");  //ICE-MPC BC Upgrade
                }
                action("Closed Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Orders';
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.")
                                  ORDER(Ascending)
                                  WHERE("Document No." = FILTER('PPR*'));
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("No.");
        QtyAvailable := 0;

        if Item.Get("No.") then begin
            Item.SetFilter("Location Filter", '%1|%2', 'MAIN', 'COMMITTED');
            Item.CalcFields(Inventory, "Qty. on Purch. Order", "Reserved Qty. on Inventory");
            QtyAvailable := (Item.Inventory - Item."Reserved Qty. on Inventory");

        end;

        // 05/24/12 Start
        msgShowed := false;
        if "Receiving Inspection" then
            RIAReferenceEnabled := true
        else
            RIAReferenceEnabled := false;
        // 05/24/12 End
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Price/Profit Calculation" := "Price/Profit Calculation"::"Price=Cost+Profit";
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        /*99999
        //>> HEF INSERT
        IF (Class = 'ITEM') OR (Class = 'PUMP') THEN BEGIN
          IF "Last Direct Cost" = 0 THEN
            ERROR('Last Direct Cost must be entered before Closing Form');
        END;
        
        IF ("No." <> '') AND (Class <> 'MODEL') THEN BEGIN
            TESTFIELD(Description);
            TESTFIELD("Base Unit of Measure");
            TESTFIELD("Average Cost");
            TESTFIELD("Inventory Posting Group");
            TESTFIELD("Gen. Prod. Posting Group");
            TESTFIELD(Class);
            IF Location.FIND('-') THEN REPEAT
              IF NOT LocationItem.GET(Location.Code,"No.",'') THEN BEGIN
                LocationItem.INIT;
                LocationItem."Location Code" := Location.Code;
                LocationItem.VALIDATE("Item No.","No.");
                LocationItem."General Product Posting Group" := "Gen. Prod. Posting Group";
                LocationItem."Inventory Posting Group" := "Inventory Posting Group";
                LocationItem.INSERT;
              END;
            UNTIL Location.NEXT = 0;
        END;
        //<< HEF END INSERT
        99999*/

    end;

    var
        Location: Record Location;
        ContractType: Option Sales,Purchase;
        DisplayMessage: Boolean;
        Exist: Boolean;
        QtyAvailable: Decimal;
        Item: Record Item;
        OldLocation: Record Location;
        Ok: Boolean;
        msgShowed: Boolean;
        ADVMSG001: Label 'Receiving Inspection required for Item %1, but no RIA Reference document path set.';
        [InDataSet]
        RIAReferenceEnabled: Boolean;
}

