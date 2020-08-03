page 50003 "Model List"
{
    // 12/07/00 HTCS RJK
    //   Added Filter to FORM properties to exclude those Items where Class = MODEL;

    Editable = false;
    PageType = List;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                }
                field(Description;Description)
                {
                }
                field("Assembly BOM";"Assembly BOM")
                {
                }
                field("Base Unit of Measure";"Base Unit of Measure")
                {
                }
                field("Shelf No.";"Shelf No.")
                {
                    Visible = false;
                }
                field("Costing Method";"Costing Method")
                {
                    Visible = false;
                }
                field("Standard Cost";"Standard Cost")
                {
                    Visible = false;
                }
                field("Unit Cost";"Unit Cost")
                {
                }
                field("Last Direct Cost";"Last Direct Cost")
                {
                    Visible = false;
                }
                field("Price/Profit Calculation";"Price/Profit Calculation")
                {
                    Visible = false;
                }
                field("Profit %";"Profit %")
                {
                    Visible = false;
                }
                field("Unit Price";"Unit Price")
                {
                }
                field("Inventory Posting Group";"Inventory Posting Group")
                {
                    Visible = false;
                }
                field("Gen. Prod. Posting Group";"Gen. Prod. Posting Group")
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field("Vendor No.";"Vendor No.")
                {
                }
                field("Vendor Item No.";"Vendor Item No.")
                {
                    Visible = false;
                }
                field("Tariff No.";"Tariff No.")
                {
                    Visible = false;
                }
                field("Search Description";"Search Description")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Item)
            {
                Caption = 'Item';
                Image = DataEntry;
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Item No."=FIELD("No.");
                        RunPageView = SORTING("Item No.")
                                      ORDER(Descending);
                        Scope = Repeater;
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the history of transactions that have been posted for the selected record.';
                    }
                    action("&Reservation Entries")
                    {
                        ApplicationArea = Reservation;
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status"=CONST(Reservation),
                                      "Item No."=FIELD("No.");
                        RunPageView = SORTING("Item No.","Variant Code","Location Code","Reservation Status");
                        ToolTip = 'View all reservations that are made for the item, either manually or automatically.';
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        ApplicationArea = Warehouse;
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Category5;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No."=FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        Scope = Repeater;
                        ToolTip = 'View how many units of the item you had in stock at the last physical count.';
                    }
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Action1220060033)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Statistics';
                        Image = Statistics;
                        ShortCutKey = 'F7';
                        ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

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
                        ApplicationArea = Suite;
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No."=FIELD("No."),
                                      "Date Filter"=FIELD("Date Filter"),
                                      "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                                      "Location Filter"=FIELD("Location Filter"),
                                      "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                                      "Variant Filter"=FIELD("Variant Filter");
                        ToolTip = 'View statistics for item ledger entries.';
                    }
                    action("T&urnover")
                    {
                        ApplicationArea = Suite;
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No."=FIELD("No."),
                                      "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                                      "Location Filter"=FIELD("Location Filter"),
                                      "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                                      "Variant Filter"=FIELD("Variant Filter");
                        ToolTip = 'View a detailed account of item turnover by periods after you have set the relevant filters for location and variant.';
                    }
                    action("&Value Entries")
                    {
                        ApplicationArea = Advanced;
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No."=FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ToolTip = 'View the history of posted amounts that affect the value of the item. Value entries are created for every transaction with the item.';
                    }
                    action("Item &Tracking Entries")
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;
                        ToolTip = 'View serial or lot numbers that are assigned to items.';

                        trigger OnAction()
                        var
                            ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForMasterData(3,'',"No.",'','','','');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        ApplicationArea = Warehouse;
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Item No."=FIELD("No.");
                        RunPageView = SORTING("Item No.","Bin Code","Location Code","Variant Code","Unit of Measure Code","Lot No.","Serial No.","Entry Type",Dedicated);
                        ToolTip = 'View the history of quantities that are registered for the item in warehouse activities. ';
                    }
                }
            }
            group(Availability)
            {
                Caption = 'Availability';
                Image = Item;
                action("Items b&y Location")
                {
                    AccessByPermission = TableData Location=R;
                    ApplicationArea = Location;
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ToolTip = 'Show a list of items grouped by location.';

                    trigger OnAction()
                    begin
                        PAGE.Run(PAGE::"Items by Location",Rec);
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    Image = ItemAvailability;
                    action(Period)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Period';
                        Image = Period;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No."=FIELD("No."),
                                      "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                                      "Location Filter"=FIELD("Location Filter"),
                                      "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                                      "Variant Filter"=FIELD("Variant Filter");
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';
                    }
                    action(Variant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No."=FIELD("No."),
                                      "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                                      "Location Filter"=FIELD("Location Filter"),
                                      "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                                      "Variant Filter"=FIELD("Variant Filter");
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';
                    }
                    action(Location)
                    {
                        ApplicationArea = Advanced;
                        Caption = 'Location';
                        Image = Warehouse;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No."=FIELD("No."),
                                      "Global Dimension 1 Filter"=FIELD("Global Dimension 1 Filter"),
                                      "Global Dimension 2 Filter"=FIELD("Global Dimension 2 Filter"),
                                      "Location Filter"=FIELD("Location Filter"),
                                      "Drop Shipment Filter"=FIELD("Drop Shipment Filter"),
                                      "Variant Filter"=FIELD("Variant Filter");
                        ToolTip = 'View the actual and projected quantity of the item per location.';
                    }
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name"=CONST(Item),
                                  "No."=FIELD("No.");
                }
                separator(Separator1220060055)
                {
                }
                action("&Units of Measure")
                {
                    ApplicationArea = Advanced;
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No."=FIELD("No.");
                    Scope = Repeater;
                    ToolTip = 'Set up the different units that the item can be traded in, such as piece, box, or hour.';
                }
                action("Va&riants")
                {
                    ApplicationArea = Planning;
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No."=FIELD("No.");
                    ToolTip = 'View how the inventory level of an item will develop over time according to the variant that you select.';
                }
                action("Cross Re&ferences")
                {
                    ApplicationArea = Advanced;
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    RunObject = Page "Item Cross Reference Entries";
                    RunPageLink = "Item No."=FIELD("No.");
                    Scope = Repeater;
                    ToolTip = 'Set up a customer''s or vendor''s own identification of the selected item. Cross-references to the customer''s item number means that the item number is automatically shown on sales documents instead of the number that you use.';
                }
                action("Substituti&ons")
                {
                    ApplicationArea = Suite;
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type=CONST(Item),
                                  "No."=FIELD("No.");
                    ToolTip = 'View substitute items that are set up to be sold instead of the item.';
                }
                separator(Separator1220060059)
                {
                }
                action(Translations)
                {
                    ApplicationArea = Advanced;
                    Caption = 'Translations';
                    Image = Translations;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No."=FIELD("No."),
                                  "Variant Code"=CONST('');
                    Scope = Repeater;
                    ToolTip = 'Set up translated item descriptions for the selected item. Translated item descriptions are automatically inserted on documents according to the language code.';
                }
                action("E&xtended Text")
                {
                    ApplicationArea = Advanced;
                    Caption = 'E&xtended Text';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name"=CONST(Item),
                                  "No."=FIELD("No.");
                    RunPageView = SORTING("Table Name","No.","Language Code","All Language Codes","Starting Date","Ending Date");
                    Scope = Repeater;
                    ToolTip = 'Select or set up additional text for the description of the item. Extended text can be inserted under the Description field on document lines for the item.';
                }
                separator(Separator1220060170)
                {
                }
                action("Bill of Materials")
                {
                    Caption = 'Bill of Materials';
                    RunObject = Page "Assembly BOM";
                    RunPageLink = "Parent Item No."=FIELD("No.");
                }
                action("Where-Used List")
                {
                    Caption = 'Where-Used List';
                    RunObject = Page "Where-Used List";
                    RunPageLink = Type=CONST(Item),
                                  "No."=FIELD("No.");
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type=CONST(Item),
                                  Code=FIELD("No.");
                    RunPageView = SORTING(Type,Code);
                }
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type=CONST(Item),
                                  "No."=FIELD("No.");
                    RunPageView = SORTING("Document Type",Type,"No.");
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                Image = Purchasing;
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    Image = Vendor;
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Action1220060009)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Action1220060008)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Item No."=FIELD("No.");
                    RunPageView = SORTING("Item No.");
                }
                action(Action1220060006)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type=CONST(Item),
                                  "No."=FIELD("No.");
                    RunPageView = SORTING("Document Type",Type,"No.");
                }
            }
        }
    }
}

