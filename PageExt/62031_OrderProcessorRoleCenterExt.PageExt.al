pageextension 62031 OrderProcessorRoleCenterExt extends "Order Processor Role Center"
{//
    layout
    {

    }

    actions
    {
        modify("Sales &Quote")
        {
            Visible = false;
        }
        modify("Sales &Invoice")
        {
            Visible = false;
        }
        modify("Sales &Order")
        {
            Visible = false;
        }
        modify("Sales &Return Order")
        {
            Visible = false;
        }
        modify("Sales &Credit Memo")
        {
            Visible = false;
        }
        modify(Action42)
        {
            Visible = false;
        }

        addbefore(Action76)
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
        }
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
            }
            group("Sales&Shipping")
            {
                Caption = 'Sales & Shipping Orders';
                action(PumpRelease)
                {
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
        }
        addbefore("Sales &Journal")
        {
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
        addafter(Action31)
        {
            group(WorkOrder)
            {
                Caption = 'Work Order';
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
                    //RunObject = report "Outstanding Vendor Repairs"; ///--! 
                    RunObject = codeunit UnderConstruction;
                    ToolTip = 'Runs Shop Work Order Status Report.';
                }
            }
        }
        addafter(Reports)
        {
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
    }

    var
        myInt: Integer;
}