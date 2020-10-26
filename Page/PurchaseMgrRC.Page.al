page 50158 PurchaseMgrRC
{
    Caption = 'Purchase Manager', Comment = '{Dependency=Match,"ProfileDescription_PURCASEMANAGER"}';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control104; "Headline RC Order Processor")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        /*
        area(Creation) 
        {
            action(ActionBarAction)  
            {
                RunObject = Page ObjectName; 
            }
        }
        */
        area(Sections)
        {
            group(Action50000)
            {
                Caption = 'Work Order';
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
                        Caption = 'Inventory Transaction Detail';
                        RunObject = Report "Item Transaction Detail";
                    }
                    action("Inventory - Reorders")
                    {
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
                }
            }
            group("Group8")
            {
                Caption = 'Inventory & Costing';
                action("Items1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    RunObject = page "Item List";
                }
                action("Nonstock Items")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Nonstock Items';
                    RunObject = page "Catalog Item List";
                }
                action("Stock keeping Units")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Stockkeeping Units';
                    RunObject = page "Stockkeeping Unit List";
                }
                action("Adjust Cost - Item Entries...")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjust Cost Item Entries';
                    RunObject = report "Adjust Cost - Item Entries";
                }
                action("Standard Costs Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standard Costs Worksheet';
                    RunObject = page "Standard Cost Worksheet";
                }
                action("Adjust Item Costs/Prices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Adjust Item Costs/Prices';
                    RunObject = report "Adjust Item Costs/Prices";
                }
                group("Group9")
                {
                    Caption = 'Journals';
                    action("Item Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Journals';
                        RunObject = page "Item Journal";
                    }
                    action("Item Reclass. Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Reclassification Journals';
                        RunObject = page "Item Reclass. Journal";
                    }
                    action("Recurring Item Journals")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Recurring Item Journals';
                        RunObject = page "Recurring Item Jnl.";
                    }
                }
                group("Group10")
                {
                    Caption = 'Reports';
                    action("Inventory Valuation")
                    {
                        Caption = 'Inventory Valuation';
                        RunObject = Report "Inventory Valuation";
                    }
                    action("Item Cost and Price List")
                    {
                        Caption = 'Item Cost and Price List';
                        RunObject = Report "Item Cost and Price List";
                    }
                    action("Item Age Composition - Qty.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Qty.';
                        RunObject = report "Item Age Composition - Qty.";
                    }
                    action("Inventory - Cost Variance1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Cost Variance';
                        RunObject = report "Inventory - Cost Variance";
                    }
                    action("Item Charges - Specification1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Charges - Specification';
                        RunObject = report "Item Charges - Specification";
                    }
                    action("Inventory - Inbound Transfer1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Inbound Transfer';
                        RunObject = report "Inventory - Inbound Transfer";
                    }
                    action("Invt. Valuation - Cost Spec.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Invt. Valuation - Cost Spec.';
                        RunObject = report "Invt. Valuation - Cost Spec.";
                    }
                    action("Item Age Composition - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Age Composition - Value';
                        RunObject = report "Item Age Composition - Value";
                    }
                    action("Item Register - Value")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Register - Value';
                        RunObject = report "Item Register - Value";
                    }
                    action("Item Expiration - Quantity")
                    {
                        ApplicationArea = ItemTracking;
                        Caption = 'Item Expiration - Quantity';
                        RunObject = report "Item Expiration - Quantity";
                    }
                    action("Item Turnover")
                    {
                        Caption = 'Item Turnover';
                        RunObject = Report "Item Turnover";
                    }
                    action("Over Stock")
                    {
                        Caption = 'Over Stock';
                        RunObject = Report "Over Stock";
                    }
                    action("Inventory Purchase Orders3")
                    {
                        ApplicationArea = Suite, Basic;
                        Caption = 'Purchase Advice';
                        RunObject = Report "Purchase Advice";
                    }
                    action("Purchase Order Status1")
                    {
                        Caption = 'Purchase Order Status';
                        RunObject = Report "Purchase Order Status";
                    }
                    action("Serial Number Status/Aging")
                    {
                        Caption = 'Serial Number Status/Aging';
                        RunObject = Report "Serial Number Status/Aging";
                    }
                }
            }

            /*
            addbefore(Tasks)
            {
                action(WorkOrderMaster)
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Master';
                    Image = OrderList;
                    RunObject = page "Work Order Master List";
                    ToolTip = 'View the list of Work Orders';
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
                }            group(SectionsGroupName)
                {
                    action(SectionsAction)
                    {
                        RunObject = Page ObjectName;
                    }
                }
            }
            area(Embedding)
            {
                action(EmbeddingAction)
                {
                    RunObject = Page ObjectName;
                }
            }
            */
        }
    }
}