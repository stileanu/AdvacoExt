page 50164 ShippingTeamMbrRC
{
    Caption = 'Shop Team Member';
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

                action(Action50002)
                {
                    ApplicationArea = All;
                    Caption = 'Step Entry';
                    Image = StepInto;
                    RunObject = codeunit "Step Entry";
                    ToolTip = 'Enters data for current step and advances Work Order to next step.';
                }
                group("Sales&ShippingM")
                {
                    Caption = 'Shipping Orders';
                    action(WorkOrderShippingM)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Order Shipping';
                        Image = ShipmentLines;
                        RunObject = codeunit Shipping;
                        ToolTip = 'Enters data to modify the quote step for current Work Order.';
                    }
                    action(SalesOrderShippingM)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Order Shipping';
                        Image = Shipment;
                        RunObject = codeunit SOShipping;
                        ToolTip = 'Enters data to ship a Sales Order.';
                    }
                    action(CreditMemoShippingM)
                    {
                        ApplicationArea = All;
                        Caption = 'Credit Memo Shipping';
                        Image = Shipment;
                        RunObject = codeunit CMShipping;
                        ToolTip = 'Enters data to ship a Sales Order.';
                    }
                    action(FSShippingM)
                    {
                        ApplicationArea = All;
                        Caption = 'Field Service Shipping';
                        Image = ServiceTasks;
                        RunObject = codeunit "FSShipping";
                        ToolTip = 'Processes Field Service orders shipping.';
                    }
                }
                group(Reports)
                {
                    Caption = 'Reporting';

                    action(ShopWorkOrderStatusM)
                    {
                        ApplicationArea = All;
                        Caption = 'Shop Work Order Status';
                        Image = Status;
                        RunObject = report "Shop Work Order Status Rpt";
                        ToolTip = 'Runs Shop Work Order Status Report.';
                    }
                    action(BoxedWorkOrderStatusM)
                    {
                        ApplicationArea = All;
                        Caption = 'Boxed Work Order Status';
                        Image = Status;
                        RunObject = report "Boxed Work Order Status Rpt";
                        ToolTip = 'Runs Boxed Work Order Status Report.';
                    }
                    action(VendorRepairsStatusM)
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
        }
        area(Processing)
        {
            action(StepEntry)
            {
                ApplicationArea = All;
                Caption = 'Step Entry';
                Image = StepInto;
                RunObject = codeunit "Step Entry";
                ToolTip = 'Enters data for current step and advances Work Order to next step.';
            }
            group("Sales&Shipping")
            {
                Caption = 'Shipping Orders';
                action(WorkOrderShipping)
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Shipping';
                    Image = ShipmentLines;
                    RunObject = codeunit Shipping;
                    ToolTip = 'Enters data to modify the quote step for current Work Order.';
                }
                action(SalesOrderShipping)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Shipping';
                    Image = Shipment;
                    RunObject = codeunit SOShipping;
                    ToolTip = 'Enters data to ship a Sales Order.';
                }
                action(CreditMemoShipping)
                {
                    ApplicationArea = All;
                    Caption = 'Credit Memo Shipping';
                    Image = Shipment;
                    RunObject = codeunit CMShipping;
                    ToolTip = 'Enters data to ship a Sales Order.';
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
        area(Reporting)
        {
            group(WorkOrder)
            {
                Caption = 'Reporting';
                Image = Report2;

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
    }
}