page 50159 PurchaseMbrRC
{
    Caption = 'Purchase Team Member', Comment = '{Dependency=Match,"ProfileDescription_PURCASEMEMBER"}';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control104; "Headline RC Order Processor")
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Action50000)
            {
                Caption = 'Work Orders';
                Image = RegisteredDocs;
                ToolTip = 'Vew or edit detailed information for the Work Orders in the system.';

                action(Action50001)
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Master';
                    Image = OrderList;
                    RunObject = page "Work Order Master List";
                    ToolTip = 'View the list of Work Orders';
                }
                action(SepcialInquiry)
                {
                    ApplicationArea = All;
                    Caption = 'Special Inquiry';
                    Image = ViewDetails;
                    RunObject = page "Work Order Detail List";
                    ToolTip = 'View the lst of all details.';
                }
                action(Action50002)
                {
                    ApplicationArea = All;
                    Caption = 'Step Entry';
                    Image = StepInto;
                    RunObject = codeunit "Step Entry";
                    ToolTip = 'Enters data for current step and advances Work Order to next step.';
                }
                action(Action50003)
                {
                    ApplicationArea = All;
                    Caption = 'Quote Entry';
                    Image = Quote;
                    RunObject = codeunit "Quote Entry";
                    ToolTip = 'Enters data for current Work Order Quote step.';

                }
                action(Action50004)
                {
                    ApplicationArea = All;
                    Caption = 'Back Order Entry';
                    Image = OrderTracking;
                    RunObject = codeunit "Back Order Entry";
                    ToolTip = 'Enters data for current Work Order to put it in Back Order status.';

                }
                action(Action50005)
                {
                    ApplicationArea = All;
                    Caption = 'Parts Adjustment';
                    Image = PriceAdjustment;
                    RunObject = codeunit "Parts Adjustment";
                    ToolTip = 'Enters data to adjust parts list for current Work Order.';

                }
                action(Action50006)
                {
                    ApplicationArea = All;
                    Caption = 'Build Ahead';
                    Image = OrderPromising;
                    RunObject = codeunit "Build Ahead";
                    ToolTip = 'Enters data to put current Work Order in Build Ahead status.';

                }
                action(Action50007)
                {
                    ApplicationArea = All;
                    Caption = 'BA Quote Modify';
                    Image = NewSalesQuote;
                    RunObject = codeunit "Quote Modify";
                    ToolTip = 'Enters data to modify the quote step for current Work Order.';
                }
                action(Action50008)
                {
                    ApplicationArea = All;
                    Caption = 'Pump Module';
                    Image = BOMVersions;
                    RunObject = codeunit PumpModule;
                    ToolTip = 'Enters data to modify the quote step for current Work Order.';
                }
            }
            group("Group")
            {
                Caption = 'Purchasing';
                action("Vendors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                }
                action("Contacts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contacts';
                    RunObject = page "Contact List";
                }
                action("Quotes")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Quotes';
                    RunObject = page "Purchase Quotes";
                }
                action("Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Purchase Orders';
                    RunObject = page "Purchase Order List";
                }
                action("Blanket Orders")
                {
                    ApplicationArea = Suite;
                    Caption = 'Blanket Purchase Orders';
                    RunObject = page "Blanket Purchase Orders";
                }
                action("Return Orders")
                {
                    ApplicationArea = PurchReturnOrder;
                    Caption = 'Purchase Return Orders';
                    RunObject = page "Purchase Return Order List";
                }
                action("Transfer Orders")
                {
                    ApplicationArea = Location;
                    Caption = 'Transfer Orders';
                    RunObject = page "Transfer Orders";
                }
                action("Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action("Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
                action(InspectDefectReport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inspect Defect Report';
                    RunObject = page "IDR Header";
                }
                action("Certificates of Supply")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Certificates of Supply';
                    RunObject = page "Certificates of Supply";
                }
                action("Subcontracting Worksheet")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Subcontracting Worksheets';
                    RunObject = page "Subcontracting Worksheet";
                }
                action("Purchase Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Journals';
                    RunObject = page "Purchase Journal";
                }
                action(DailyPartsExport)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Daily Parts Export';
                    RunObject = page "Daily Parts Export";
                }
                group(ItemBOM)
                {
                    Caption = 'BOM Items';

                    action("Production BOM")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bill of Materials';
                        RunObject = page "Production BOM List";
                        //AccessByPermission = tabledata 5405 = R;
                    }
                    group("BOMRepGroup1")
                    {
                        Caption = 'BOM Reports';
                        action("Quantity Explosion of BOM")
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Quantity Explosion of BOM';
                            RunObject = report "Quantity Explosion of BOM";
                            //AccessByPermission = tabledata 5405 = R;
                        }
                        action("Where-Used (Top Level)")
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Where-Used (Top Level)';
                            RunObject = report "Where-Used (Top Level)";
                            //AccessByPermission = tabledata 5405 = R;
                        }
                        action("Routing Sheet")
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Routing Sheet';
                            RunObject = report "Routing Sheet";
                        }
                        action("Compare List")
                        {
                            ApplicationArea = Manufacturing;
                            Caption = 'Item BOM Compare List';
                            RunObject = report "Compare List";
                        }
                    }
                }
                group(Misc50190)
                {
                    Caption = 'Miscelaneous';

                    action("Resources")
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Resources';
                        RunObject = page "Resource List";
                    }
                    action("ItemsMbr")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Items';
                        RunObject = page "Item List";
                    }
                    action("AddItem")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Add Item';
                        RunObject = page "Item Add";
                    }
                }
                group("Group1")
                {
                    Caption = 'Budgets & Analysis';
                    action("Purchase Budgets")
                    {
                        ApplicationArea = PurchaseBudget;
                        Caption = 'Purchase Budgets';
                        RunObject = page "Budget Names Purchase";
                    }
                    action("Purchase Analysis Reports")
                    {
                        ApplicationArea = PurchaseAnalysis;
                        Caption = 'Purchase Analysis Reports';
                        RunObject = page "Analysis Report Purchase";
                    }
                    action("Analysis by Dimensions")
                    {
                        ApplicationArea = Dimensions, PurchaseAnalysis;
                        Caption = 'Purchase Analysis by Dimensions';
                        RunObject = page "Analysis View List Purchase";
                    }
                    action("Item Dimensions - Detail")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Detail';
                        RunObject = report "Item Dimensions - Detail";
                    }
                    action("Item Dimensions - Total")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Item Dimensions - Total';
                        RunObject = report "Item Dimensions - Total";
                    }
                }
                group("Group2")
                {
                    Caption = 'Registers/Entries';
                    action("Purchase Quote Archives")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Quote Archives';
                        RunObject = page "Purchase Quote Archives";
                    }
                    action("Purchase Order Archives")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Order Archives';
                        RunObject = page "Purchase Order Archives";
                    }
                    action("Posted Purchase Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = page "Posted Purchase Invoices";
                    }
                    action("Posted Return Shipments")
                    {
                        ApplicationArea = PurchReturnOrder;
                        Caption = 'Posted Purchase Return Shipments';
                        RunObject = page "Posted Return Shipments";
                    }
                    action("Posted Credit Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Credit Memos';
                        RunObject = page "Posted Purchase Credit Memos";
                    }
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posted Purchase Receipts';
                        RunObject = page "Posted Purchase Receipts";
                    }
                    action("G/L Registers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Item Tracing")
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item Tracing';
                        RunObject = page "Item Tracing";
                    }
                    action("Purchase Return Order Archives")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Return Order Archives';
                        RunObject = page "Purchase Return List Archive";
                    }
                    action("Vendor Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Ledger Entries';
                        RunObject = page "Vendor Ledger Entries";
                    }
                    action("Detailed Cust. Ledg. Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Vendor Ledger Entries';
                        RunObject = page "Detailed Vendor Ledg. Entries";
                    }
                    action("Value Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Value Entries';
                        RunObject = page "Value Entries";
                    }
                }
                group("Group3")
                {
                    Caption = 'Reports';
                    action("Inventory Purchase Orders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Purchase Advice';
                        RunObject = Report "Purchase Advice";
                    }
                    action("Inventory - Transaction Detail")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Transaction Detail';
                        RunObject = Report "Item Transaction Detail";
                    }
                    action("Inventory - Reorders")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory Reorders';
                        RunObject = report "Inventory - Reorders";
                    }
                    action("Item/Vendor Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item/Vendor Catalog';
                        RunObject = Report "Item/Vendor Catalog";
                    }
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        RunObject = Report "Aged Accounts Payable NA";
                    }
                    action("Vendor/Item Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Purchases by Item';
                        RunObject = Report "Vendor Purchases by Item";
                    }
                    action("List Price Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'List Price Sheet';
                        RunObject = Report "List Price Sheet";
                    }
                    action("Item Charges - Specification")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Charges - Specification';
                        RunObject = report "Item Charges - Specification";
                    }
                    action("Inventory - Vendor Purchases")
                    {
                        ApplicationArea = All;
                        Caption = 'Inventory - Vendor Purchases';
                        RunObject = Report "Vendor Purchases by Item";
                    }
                    action("Item Substitutions")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Item Substitutions';
                        RunObject = report "Item Substitutions";
                    }
                    action("Inventory Purchase Orders1")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Purchase Advice';
                        RunObject = Report "Purchase Advice";
                    }
                    action("Purchase Order Status")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase Order Status';
                        RunObject = Report "Purchase Order Status";
                    }
                    // action("Order")
                    // {
                    //     ApplicationArea = Suite;
                    //     Caption = 'Order';
                    //     RunObject = codeunit 8815;
                    // }
                    action("Purchasing Deferral Summary")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Purchasing Deferral Summary';
                        RunObject = report "Deferral Summary - Purchasing";
                    }
                    action("PO Received not Invoiced")
                    {
                        ApplicationArea = Suite;
                        Caption = 'PO Received not Invoiced';
                        RunObject = report "po received not invoiced";
                    }
                }
            }

            group(SalesReceivables)
            {
                Caption = 'Sales & Receivables';

                action(Customers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    Image = Customer;
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action(WorkInstructions)
                {
                    Caption = 'Work Instructions';
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    RunObject = Page "Work Order Instructions";
                    ToolTip = 'View or edit instructions for a specific Work Order.';
                }
                action(SalesOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("InsideSalespeople")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inside Salespeople';
                    RunObject = page "Salespersons/Purchasers";
                }
                action("OutsideRep")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Outside Rep';
                    RunObject = page "Outside Sales Reps";
                }
                action("InsideRepCorrectiom")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inside/Rep Correction';
                    RunObject = page "Inside Sales/Sales Rep Update";
                }

                group(WOTransactions)
                {
                    Caption = 'Work Order';

                    action(Action50051)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Order Master';
                        Image = OrderList;
                        RunObject = page "Work Order Master List";
                        ToolTip = 'View the list of Work Orders.';
                    }
                    action(Action50052)
                    {
                        ApplicationArea = All;
                        Caption = 'Quote Release';
                        Image = OrderList;
                        RunObject = codeunit "Quote Entry";
                        ToolTip = 'Edit and release a quote for an Work Order.';
                    }
                    action(Action50053)
                    {
                        ApplicationArea = All;
                        Caption = 'Re-Quote';
                        Image = OrderList;
                        RunObject = codeunit "Quote Entry";
                        ToolTip = 'Re-quote an Work Order.';
                    }
                }
                group(Reports1)
                {
                    Caption = 'Reports';

                    action(Action50054)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Order Status';
                        Image = Status;
                        RunObject = report "Office Sales Order Status";
                        ToolTip = 'Reports Office Sales order Status.';
                    }
                    action(Action50055)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Report';
                        Image = Status;
                        //RunObject = report "Bill of Lading Report"; ///--!
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Reports Bill of Lading Status.';
                    }
                }
            }
        }
        area(Processing)
        {

            action(WorkOrderMaster)
            {
                ApplicationArea = All;
                Caption = 'Work Order Master';
                Image = OrderList;
                RunObject = page "Work Order Master List";
                ToolTip = 'View the list of Work Orders';
            }
            action(SepcialInquiry1)
            {
                ApplicationArea = All;
                Caption = 'Special Inquiry';
                Image = ViewDetails;
                RunObject = page "Work Order Detail List";
                ToolTip = 'View the lst of all details.';
            }
            group(StepEntries)
            {
                Caption = 'WO Processing';

                action(StepEntry)
                {
                    ApplicationArea = All;
                    Caption = 'Step Entry';
                    Image = StepInto;
                    RunObject = codeunit "Step Entry";
                    ToolTip = 'Enters data for current step and advances Work Order to next step.';
                }
                action(QuoteEntry)
                {
                    ApplicationArea = All;
                    Caption = 'Quote Entry';
                    Image = Quote;
                    RunObject = codeunit "Quote Entry";
                    ToolTip = 'Enters data for current Work Order Quote step.';

                }
                action(BackOrderEntry)
                {
                    ApplicationArea = All;
                    Caption = 'Back Order Entry';
                    Image = OrderTracking;
                    RunObject = codeunit "Back Order Entry";
                    ToolTip = 'Enters data for current Work Order to put it in Back Order status.';

                }
                action(PartsAdjustment)
                {
                    ApplicationArea = All;
                    Caption = 'Parts Adjustment';
                    Image = PriceAdjustment;
                    RunObject = codeunit "Parts Adjustment";
                    ToolTip = 'Enters data to adjust parts list for current Work Order.';

                }
                action(BuildAhead)
                {
                    ApplicationArea = All;
                    Caption = 'Build Ahead';
                    Image = OrderPromising;
                    RunObject = codeunit "Build Ahead";
                    ToolTip = 'Enters data to put current Work Order in Build Ahead status.';

                }
                action(BAQuoteModify)
                {
                    ApplicationArea = All;
                    Caption = 'BA Quote Modify';
                    Image = NewSalesQuote;
                    RunObject = codeunit "Quote Modify";
                    ToolTip = 'Enters data to modify the quote step for current Work Order.';
                }
                action(PumpModule)
                {
                    ApplicationArea = All;
                    Caption = 'Pump Module';
                    Image = BOMVersions;
                    RunObject = codeunit PumpModule;
                    ToolTip = 'Enters data to modify the quote step for current Work Order.';
                }
            }
            group("Sales&Shipping")
            {
                Caption = 'Sales & Shipping Orders';
                action(PumpRelease)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Pump Release';
                    Image = ReleaseDoc;
                    RunObject = codeunit PumpRelease;
                    ToolTip = 'Enters data to release a Work Order Detail.';
                }
                action(SalesOrderShipping)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Shipping';
                    Image = Shipment;
                    RunObject = codeunit SOShipping;
                    ToolTip = 'Enters data to ship a Sales Order.';
                }
                action(WorkOrderShipping)
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Shipping';
                    Image = ShipmentLines;
                    RunObject = codeunit Shipping;
                    ToolTip = 'Enters data to modify the quote step for current Work Order.';
                }
                action(SalesOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order';
                    Image = Sales;
                    RunObject = page "Sales Order List";
                    ToolTip = 'Enters data for selected Sales Order.';
                }

            }
            group(Tasks1)
            {
                Caption = 'Tasks';

                action(OrderType)
                {
                    ApplicationArea = All;
                    Caption = 'Order Type';
                    Image = Sales;
                    RunObject = codeunit OrderType;
                    ToolTip = 'Edits Type for selected Work Order.';
                }
                action(ShopEmployees)
                {
                    ApplicationArea = All;
                    Caption = 'Shop Employees';
                    Image = Sales;
                    RunObject = page "Shop Employees";
                    ToolTip = 'Edits data for Shop Emplyee resources.';
                }
                action(AddModel)
                {
                    ApplicationArea = All;
                    Caption = 'Add Model';
                    Image = Sales;
                    RunObject = page "Model List";
                    ToolTip = 'Edits data for Pump Models.';
                }
            }
            group(FieldServiceGroup)
            {
                Caption = 'Field Service';

                action(FieldService)
                {
                    ApplicationArea = All;
                    Caption = 'Field Service';
                    Image = ServiceItemGroup;
                    RunObject = page "Field Service";
                    ToolTip = 'Edits data for Field Service orders.';
                }
                action(FSParts)
                {
                    ApplicationArea = All;
                    Caption = 'Field Service Parts';
                    Image = ServiceItemWorksheet;
                    RunObject = codeunit "FSParts";
                    ToolTip = 'Edits data for Field Service order Parts.';
                }
                action(FSShipping)
                {
                    ApplicationArea = All;
                    Caption = 'Field Service Shipping';
                    Image = ServiceTasks;
                    RunObject = codeunit "FSShipping";
                    ToolTip = 'Processes Field Service orders shipping.';
                }

            }
            group(History)
            {
                Caption = 'History';
                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
        }
        area(Reporting)
        {
            group(WorkOrder)
            {
                Caption = 'Reporting';
                Image = Report2;

                action(OfficeWorkOrderStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Office Work Order Status';
                    Image = Status;
                    RunObject = report "Office Work Order Status Rpt";
                    ToolTip = 'Runs Office Work Order Status Report.';
                }
                action(ShopWorkOrderStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Shop Work Order Status';
                    Image = Status;
                    RunObject = report "Shop Work Order Status Rpt";
                    ToolTip = 'Runs Shop Work Order Status Report.';
                }
                action(BoxedWorkOrderStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Boxed Work Order Status';
                    Image = Status;
                    RunObject = report "Boxed Work Order Status Rpt";
                    ToolTip = 'Runs Shop Work Order Status Report.';
                }
                action(VendorRepairsStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Repairs';
                    Image = Status;
                    //RunObject = report "Outstanding Vendor Repairs";
                    RunObject = codeunit UnderConstruction;
                    ToolTip = 'Runs Shop Work Order Status Report.';
                }
            }
        }
    }
}