page 50161 AccountsPayableRC
{
    Caption = 'Accounts Payable Role Center';
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
            }
            /*
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
                action(PumpRelease1)
                {
                    ///Visible = false;
                    ApplicationArea = All;
                    Caption = 'Pump Release';
                    Image = ReleaseDoc;
                    RunObject = codeunit PumpRelease;
                    ToolTip = 'Enters data to release a Work Order Detail.';
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
            */
            group("Group28")
            {
                Caption = 'Receivables';
                action("Customers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    RunObject = page "Customer List";
                }
                action(InsideSalespeople)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inside Salespeople';
                    RunObject = page "Salespersons/Purchasers";
                    ToolTip = 'Person inside company that fcilitate work with a Customer';
                }
                action(Reps)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reps';
                    RunObject = page "Outside Sales Reps";
                    ToolTip = 'Entity ouside company that facilitate work with a Customer';
                }
                action(SalesJournals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales),
                                    Recurring = CONST(false));
                    ToolTip = 'Post any sales-related transaction directly to a customer, bank, or general ledger account instead of using dedicated documents. You can post all types of financial sales transactions, including payments, refunds, and finance charge amounts. Note that you cannot post item quantities with a sales journal.';
                }
                action(SalesOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action("Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Invoices';
                    RunObject = page "Sales Invoice List";
                }
                action("Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Credit Memos';
                    RunObject = page "Sales Credit Memos";
                }
                group(CustomerCare)
                {
                    Caption = 'Customer Care';

                    action("Credit Management")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Credit Management';
                        RunObject = page "Credit Manager Activities";
                    }
                    action(CustomerOrderStatus)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Order Status'; ///--!
                        RunObject = page "Customer Order Status";
                    }
                }
                action("Direct Debit Collections")
                {
                    ApplicationArea = Suite;
                    Caption = 'Direct Debit Collections';
                    RunObject = page "Direct Debit Collections";
                }
                action("Create Recurring Sales Invoice")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Recurring Sales Invoices';
                    RunObject = report "Create Recurring Sales Inv.";
                }
                action("Register Customer Payments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Register Customer Payments';
                    RunObject = page "Payment Registration";
                }
                group("Group29")
                {
                    Caption = 'Combine';
                    action("Combined Shipments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Combine Shipments...';
                        RunObject = report "Combine Shipments";
                    }
                    action("Combined Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder, PurchReturnOrder;
                        Caption = 'Combine Return Receipts...';
                        RunObject = report "Combine Return Receipts";
                    }
                }
                group("Group30")
                {
                    Caption = 'Collection';
                    action("Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminders';
                        RunObject = page "Reminder List";
                    }
                    action("Issued Reminders")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Reminders';
                        RunObject = page "Issued Reminder List";
                    }
                    action("Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Finance Charge Memos';
                        RunObject = page "Finance Charge Memo List";
                    }
                    action("Issued Finance Charge Memos")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Issued Finance Charge Memos';
                        RunObject = page "Issued Fin. Charge Memo List";
                    }
                }
                group("Group31")
                {
                    Caption = 'Journals';
                    action("Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Journals';
                        RunObject = page "Sales Journal";
                    }
                    action("Cash Receipt Journal1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                    }
                }
                group("Group32")
                {
                    Caption = 'Posted Documents';
                    action("Posted Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Invoices';
                        RunObject = page "Posted Sales Invoices";
                    }
                    action("Posted Sales Shipments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Shipments';
                        RunObject = page "Posted Sales Shipments";
                    }
                    action("Posted Credit Memos")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Sales Credit Memos';
                        RunObject = page "Posted Sales Credit Memos";
                    }
                    action("Posted Return Receipts")
                    {
                        ApplicationArea = SalesReturnOrder;
                        Caption = 'Posted Return Receipts';
                        RunObject = page "Posted Return Receipts";
                    }
                }
                group("Group33")
                {
                    Caption = 'Registers/Entries';
                    action("G/L Registers1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Customer Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Ledger Entries';
                        RunObject = page "Customer Ledger Entries";
                    }
                    action("Reminder/Fin. Charge Entries")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Reminder/Fin. Charge Entries';
                        RunObject = page "Reminder/Fin. Charge Entries";
                    }
                    action("Detailed Cust. Ledg. Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Customer Ledger Entries';
                        RunObject = page "Detailed Cust. Ledg. Entries";
                    }
                }
                group("Group456")
                {
                    Caption = 'Pump Release';
                    action(PumpRelease1)
                    {
                        ///Visible = false;
                        ApplicationArea = All;
                        Caption = 'Pump Release';
                        Image = ReleaseDoc;
                        RunObject = codeunit PumpRelease;
                        ToolTip = 'Enters data to release a Work Order Detail.';
                    }
                }
                group("Group34")
                {
                    Caption = 'Reports';
                    action("Cash Applied")
                    {
                        Caption = 'Cash Applied';
                        RunObject = Report "Cash Applied";
                    }
                    action("Customer Account Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Account Detail';
                        RunObject = Report "Customer Account Detail";
                    }
                    action("Customer Comment List")
                    {
                        Caption = 'Customer Comment List';
                        RunObject = Report "Customer Comment List";
                    }
                    action("Customer Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Statement';
                        RunObject = codeunit "Customer Layout - Statement";
                    }
                    action("Customer Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Register';
                        RunObject = Report "Customer Register";
                    }
                    action("Customer - Balance to Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Balance to Date';
                        RunObject = report "Customer - Balance to Date";
                    }
                    action("Customer - Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Detail Trial Bal.';
                        RunObject = report "Customer - Detail Trial Bal.";
                    }
                    action("Customer - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Listing';
                        RunObject = Report "Customer Listing";
                    }
                    action("Customer - Summary Aging Simp.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer - Summary Aging Simp.';
                        RunObject = report "Customer - Summary Aging Simp.";
                    }
                    action("Customer - Order Summary")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Order Summary';
                        RunObject = report "Customer - Order Summary";
                    }
                    action("Customer - Order Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Order Detail';
                        RunObject = report "Customer - Order Detail";
                    }
                    action("Customer - Labels")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Customer Labels';
                        RunObject = Report "Customer Labels NA";
                    }
                    action("Customer - Top 10 List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Top 10 List';
                        RunObject = report "Customer - Top 10 List";
                    }
                    action("Customer/Item Sales")
                    {
                        Caption = 'Customer/Item Statistics';
                        RunObject = Report "Customer/Item Statistics";
                    }
                    action("Salesperson - Sales Statistics")
                    {
                        Caption = 'Salesperson Statistics by Inv.';
                        RunObject = Report "Salesperson Statistics by Inv.";
                    }
                    action("Salesperson - Commission")
                    {
                        Caption = 'Salesperson Commission';
                        RunObject = Report "Salesperson Commissions";
                    }
                    action("Customer - Sales List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer - Sales List';
                        RunObject = report "Customer - Sales List";
                    }
                    action("Aged Accounts Receivable")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        RunObject = Report "Aged Accounts Receivable NA";
                    }
                    action("Customer - Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Trial Balance';
                        RunObject = report "Customer - Trial Balance";
                    }
                    action("Customer Sales Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Sales Statistics';
                        RunObject = Report "Customer Sales Statistics";
                    }
                    action("Customer - List1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Listing';
                        RunObject = Report "Customer Listing";
                    }
                    action("Customer/Item Sales1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer/Item Statistics';
                        RunObject = Report "Customer/Item Statistics";
                    }
                    action("Cust./Item Stat. by Salespers.")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Cust./Item Stat. by Salespers.';
                        RunObject = Report "Cust./Item Stat. by Salespers.";
                    }
                    action("Daily Invoicing Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Daily Invoicing Report';
                        RunObject = Report "Daily Invoicing Report";
                    }
                    action("Drop Shipment Status")
                    {
                        Caption = 'Drop Shipment Status';
                        RunObject = Report "Drop Shipment Status";
                    }
                    action("Item Status by Salesperson")
                    {
                        Caption = 'Item Status by Salesperson';
                        RunObject = Report "Item Status by Salesperson";
                    }
                    action("Open Customer Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Customer Entries';
                        RunObject = Report "Open Customer Entries";
                    }
                    action("Open Sales Invoices by Job")
                    {
                        Caption = 'Open Sales Invoices by Job';
                        RunObject = Report "Open Sales Invoices by Job";
                    }
                    action("Outstanding Sales Order Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Outstanding Sales Order Aging';
                        RunObject = Report "Outstanding Purch. Order Aging";
                    }
                    action("Outstanding Sales Order Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Outstanding Sales Order Status';
                        RunObject = Report "Outstanding Sales Order Status";
                    }
                    action("Sales Tax Area List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Tax Area List';
                        RunObject = Report "Sales Tax Area List";
                    }
                    action("Sales Tax Detail by Area")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Tax Detail by Area';
                        RunObject = Report "Sales Tax Detail by Area";
                    }
                    action("Sales Tax Detail List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Tax Detail List';
                        RunObject = Report "Sales Tax Detail List";
                    }
                    action("Sales Tax Group List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Tax Group List';
                        RunObject = Report "Sales Tax Group List";
                    }
                    action("Sales Tax Jurisdiction List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales Tax Jurisdiction List';
                        RunObject = Report "Sales Tax Jurisdiction List";
                    }
                    action("Salesperson Commissions")
                    {
                        Caption = 'Salesperson Commissions';
                        RunObject = Report "Salesperson Commissions";
                    }
                    action("Salesperson - Sales Statistics1")
                    {
                        Caption = 'Salesperson Statistics by Inv.';
                        RunObject = Report "Salesperson Statistics by Inv.";
                    }
                    action("Ship-To Address Listing")
                    {
                        Caption = 'Ship-To Address Listing';
                        RunObject = Report "Ship-To Address Listing";
                    }
                    action("Projected Cash Receipts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projected Cash Receipts';
                        RunObject = Report "Projected Cash Receipts";
                    }
                }
                group("Group35")
                {
                    Caption = 'Setup';
                    action("Sales & Receivables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales & Receivables Setup';
                        RunObject = page "Sales & Receivables Setup";
                    }
                    action("Payment Registration Setup")
                    {
                        Caption = 'Payment Registration Setup';
                        RunObject = page "Payment Registration Setup";
                    }
                    action("Report Selection Reminder and")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Selections Reminder/Fin. Charge';
                        RunObject = page "Report Selection - Reminder";
                    }
                    action("Reminder Terms")
                    {
                        ApplicationArea = BasicMX;
                        Caption = 'Reminder Terms';
                        RunObject = page "Reminder Terms";
                    }
                    action("Finance Charge Terms")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Finance Charge Terms';
                        RunObject = page "Finance Charge Terms";
                    }
                }
            }
            group("Group36")
            {
                Caption = 'Payables';
                action("Vendors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                    RunObject = page "Vendor List";
                }
                action("Orders1") //ICE RSK 12/16/20
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Orders';
                    RunObject = page "purchase order list";
                }
                action("Invoices1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                    RunObject = page "Purchase Invoices";
                }
                action("Credit Memos1")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                    RunObject = page "Purchase Credit Memos";
                }
                action("Incoming Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents';
                    RunObject = page "Incoming Documents";
                }
                action("Generate EFT Files")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Generate EFT Files';
                    RunObject = page "Generate EFT Files";
                }
                group("Group37")
                {
                    Caption = 'Journals';
                    action("Purchase Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Journals';
                        RunObject = page "Purchase Journal";
                    }
                    action("Payment Journals1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                    }
                }
                group("Group38")
                {
                    Caption = 'Posted Documents';
                    action("Posted Credit Memos1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Credit Memos';
                        RunObject = page "Posted Purchase Credit Memos";
                    }
                    action("Posted Purchase Invoices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Purchase Invoices';
                        RunObject = page "Posted Purchase Invoices";
                    }
                    action("Posted Purchase Receipts")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Posted Purchase Receipts';
                        RunObject = page "Posted Purchase Receipts";
                    }
                    action("Posted Return Shipments")
                    {
                        ApplicationArea = PurchReturnOrder;
                        Caption = 'Posted Purchase Return Shipments';
                        RunObject = page "Posted Return Shipments";
                    }
                }
                group("Group39")
                {
                    Caption = 'Registers/Entries';
                    action("G/L Registers2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Vendor Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Ledger Entries';
                        RunObject = page "Vendor Ledger Entries";
                    }
                    action("Detailed Cust. Ledg. Entries1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Detailed Vendor Ledger Entries';
                        RunObject = page "Detailed Vendor Ledg. Entries";
                    }
                    action("Credit Transfer Registers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Credit Transfer Registers';
                        RunObject = page "Credit Transfer Registers";
                    }
                    action("Employee Ledger Entries")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Employee Ledger Entries';
                        RunObject = page "Employee Ledger Entries";
                    }
                    // action("Detailed Employee Ledger Entries")
                    // {
                    //     ApplicationArea = BasicHR;
                    //     Caption = 'Detailed Employee Ledger Entries';
                    //     RunObject = page "Detailed Empl. Ledger Entries";
                    // }
                }
                group("Group40")
                {
                    Caption = 'Reports';
                    action("Vendor - Summary Aging")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        RunObject = Report "Aged Accounts Payable NA";
                    }
                    action("Purchase Statistics")
                    {
                        Caption = 'Vendor Purchase Statistics';
                        RunObject = Report "Vendor Purchase Statistics";
                    }
                    action("Vendor 1099 Magnetic Media")
                    {
                        ApplicationArea = BasicUS;
                        Caption = 'Vendor 1099 Magnetic Media';
                        RunObject = Report "Vendor 1099 Magnetic Media";
                    }
                    action("Item/Vendor Catalog")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item/Vendor Catalog';
                        RunObject = Report "Item/Vendor Catalog";
                    }
                    action("Vendor - Balance to Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Balance to Date';
                        RunObject = report "Vendor - Balance to Date";
                    }
                    action("Vendor Labels")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Labels';
                        RunObject = Report "Vendor Labels";
                    }
                    action("Vendor - List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - List';
                        RunObject = report "Vendor - List";
                    }
                    action("Vendor - Purchase List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Purchase List';
                        RunObject = report "Vendor - Purchase List";
                    }
                    action("Vendor - Summary Aging1")
                    {
                        Caption = 'Aged Accounts Payable';
                        RunObject = Report "Aged Accounts Payable NA";
                    }
                    action("Vendor - Top 10 List")
                    {
                        Caption = 'Top 10 Vendor List';
                        RunObject = Report "Top __ Vendor List";
                    }
                    action("Vendor - Trial Balance")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Trial Balance';
                        RunObject = report "Vendor - Trial Balance";
                    }
                    action("Vendor/Item Purchases")
                    {
                        Caption = 'Vendor Purchases by Item';
                        RunObject = Report "Vendor Purchases by Item";
                    }
                    action("AP - Vendor Register")
                    {
                        Caption = 'AP - Vendor Register';
                        RunObject = Report "AP - Vendor Register";
                    }
                    action("Cash Application")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Application';
                        RunObject = Report "Cash Application";
                    }
                    action("Cash Requirem. by Due Date")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Requirem. by Due Date';
                        RunObject = Report "Cash Requirements by Due Date";
                    }
                    action("Item Statistics by Purchaser")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Item Statistics by Purchaser';
                        RunObject = Report "Item Statistics by Purchaser";
                    }
                    action("Open Purchase Invoices by Job")
                    {
                        Caption = 'Open Purchase Invoices by Job';
                        RunObject = Report "Open Purchase Invoices by Job";
                    }
                    action("Open Vendor Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Vendor Entries';
                        RunObject = Report "Open Vendor Entries";
                    }
                    action("Outstanding Order Stat. by PO")
                    {
                        Caption = 'Outstanding Order Stat. by PO';
                        RunObject = Report "Outstanding Order Stat. by PO";
                    }
                    action("Outstanding Purch. Order Aging")
                    {
                        Caption = 'Outstanding Purch. Order Aging';
                        RunObject = Report "Outstanding Purch. Order Aging";
                    }
                    action("Outstanding Purch.Order Status")
                    {
                        Caption = 'Outstanding Purch.Order Status';
                        RunObject = Report "Outstanding Purch.Order Status";
                    }
                    action("Projected Cash Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Projected Cash Payments';
                        RunObject = Report "Projected Cash Payments";
                    }
                    action("Purchaser Stat. by Invoice")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Purchaser Stat. by Invoice';
                        RunObject = Report "Purchaser Stat. by Invoice";
                    }
                    action("Reconcile AP to GL")
                    {
                        Caption = 'Reconcile AP to GL';
                        RunObject = Report "Reconcile AP to GL";
                    }
                    action("Vendor - Top  List1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Top __ Vendor List';
                        RunObject = Report "Top __ Vendor List";
                    }
                    action("Vendor Account Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Account Detail';
                        RunObject = Report "Vendor Account Detail";
                    }
                    action("Vendor Comment List")
                    {
                        Caption = 'Vendor Comment List';
                        RunObject = Report "Vendor Comment List";
                    }
                    action("Purchase Statistics1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Purchase Statistics';
                        RunObject = Report "Vendor Purchase Statistics";
                    }
                    action("Vendor 1099 Information")
                    {
                        Caption = 'Vendor 1099 Information';
                        RunObject = Report "Vendor 1099 Information";
                    }
                    action("Vendor - List1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor - Listing';
                        RunObject = Report "Vendor - Listing";
                    }
                    action("Vendor/Item Statistics")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor/Item Statistics';
                        RunObject = Report "Vendor/Item Statistics";
                    }
                    Action(POReceivedNotInvoiced)
                    {
                        ApplicationArea = All;
                        Caption = 'PO Received not Invoiced';
                        RunObject = Report "PO Received not Invoiced";

                    }
                    Action(OutstandingEFTInvoices)
                    {
                        ApplicationArea = all;
                        Caption = 'Outstanding EFT Purchase Invoices';
                        RunObject = report "Outstanding EFT Purch.Invoices";
                    }
                }
                group("Group41")
                {
                    Caption = 'Setup';
                    action("Purchases & Payables Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchases & Payables Setup';
                        RunObject = page "Purchases & Payables Setup";
                    }
                    action("IRS 1099 Form-Box")
                    {
                        ApplicationArea = BasicUS;
                        Caption = '1099 Forms-Boxes';
                        RunObject = page "IRS 1099 Form-Box";
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
            /*
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
                    ///Visible = false;
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
            */
            group("Group455")
            {
                Caption = 'Pump Release';
                action(PumpRelease)
                {
                    ///Visible = false;
                    ApplicationArea = All;
                    Caption = 'Pump Release';
                    Image = ReleaseDoc;
                    RunObject = codeunit PumpRelease;
                    ToolTip = 'Enters data to release a Work Order Detail.';
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
                    ToolTip = 'Runs Boxed Work Order Status Report.';
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
