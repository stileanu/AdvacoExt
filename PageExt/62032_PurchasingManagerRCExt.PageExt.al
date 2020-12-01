pageextension 62032 PurchasingManagerRCExt extends "Purchasing Manager Role Center"
{
    /*
    layout
    {
        addfirst()
        {

            part(Control104; "Headline RC Order Processor")
            {
                ApplicationArea = Basic, Suite;
            }        // Add changes to page layout here
        }
    }
    */

    actions
    {
        modify(Group11)
        {
            Visible = false;
        }
        modify(Group4)
        {
            Visible = false;
        }
        addbefore(Group)
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
                group(StepEntry)
                {
                    Caption = 'WO Processing';

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
                group("Sales&Shipping")
                {
                    Caption = 'Sales & Shipping Orders';
                    /*
                    action(PumpRelease)
                    {
                        ApplicationArea = All;
                        Caption = 'Pump Release';
                        Image = ReleaseDoc;
                        RunObject = codeunit PumpRelease;
                        ToolTip = 'Enters data to release a Work Order Detail.';
                    }
                    */

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
                group(WorkOrder)
                {
                    Caption = 'Work Order';
                    //Image = Report2;

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
                        //RunObject = report "Outstanding Vendor Repairs"; ///--!
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Shop Work Order Status Report.';
                    }
                }

                group(Misc)
                {

                    Caption = 'Miscelaneous';

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
                action(Sep1)
                {
                    Caption = '  ';
                }
                action(SalesOrders)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Orders';
                    Image = "Order";
                    RunObject = Page "Sales Order List";
                    ToolTip = 'Record your agreements with customers to sell certain products on certain delivery and payment terms. Sales orders, unlike sales invoices, allow you to ship partially, deliver directly from your vendor to your customer, initiate warehouse handling, and print various customer-facing documents. Sales invoicing is integrated in the sales order process.';
                }
                action(Sep2)
                {
                    Caption = '  ';
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
                action(Sep3)
                {
                    Caption = '  ';
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
                action(Sep4)
                {
                    Caption = '  ';
                }
                group(WOTransactions)
                {
                    Caption = '  ';

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

            }
        }
    }

    var
        myInt: Integer;
}