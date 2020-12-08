page 50160 FinanceManagerRC
{
    Caption = 'Finance Manager Role Center';
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
            group("Group")
            {
                Caption = 'General Ledger';
                action("Chart of Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                    RunObject = page "Chart of Accounts";
                }
                action("Budgets")
                {
                    ApplicationArea = Suite;
                    Caption = 'G/L Budgets';
                    RunObject = page "G/L Budget Names";
                }
                action("Account Schedules")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedules';
                    RunObject = page "Account Schedule Names";
                }
                action("Analyses by Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by Dimensions';
                    RunObject = page "Analysis View List";
                }
                action("Export GIFI Info. to Excel")
                {
                    ApplicationArea = BasicCA;
                    Caption = 'Export GIFI Info. to Excel';
                    RunObject = Report "Export GIFI Info. to Excel";
                }
                action("Export Electr. Accounting")
                {
                    ApplicationArea = BasicMX;
                    Caption = 'Export Electr. Accounting';
                    RunObject = page "Export Electr. Accounting";
                }
                group("Group1")
                {
                    Caption = 'VAT';
                    action("VAT Statements")
                    {
                        ApplicationArea = BasicMX;
                        Caption = 'VAT Statements';
                        RunObject = page "VAT Statement";
                    }
                    group("Group2")
                    {
                        Caption = 'Reports';
                        action("VAT Exceptions")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT Exceptions';
                            RunObject = report "VAT Exceptions";
                        }
                        action("VAT Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT Register';
                            RunObject = report "VAT Register";
                        }
                        action("VAT Registration No. Check")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Batch VAT Registration No. Check';
                            RunObject = report "VAT Registration No. Check";
                        }
                        action("VAT Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT Statement';
                            RunObject = report "VAT Statement";
                        }
                        action("VAT- VIES Declaration Tax Auth")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT- VIES Declaration Tax Auth';
                            RunObject = report "VAT- VIES Declaration Tax Auth";
                        }
                        action("VAT- VIES Declaration Disk")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'VAT- VIES Declaration Disk...';
                            RunObject = report "VAT- VIES Declaration Disk";
                        }
                        action("Day Book VAT Entry")
                        {
                            Caption = 'Day Book VAT Entry';
                            RunObject = report "Day Book VAT Entry";
                        }
                        action("Day Book Cust. Ledger Entry")
                        {
                            Caption = 'Day Book Cust. Ledger Entry';
                            RunObject = report "Day Book Cust. Ledger Entry";
                        }
                        action("Day Book Vendor Ledger Entry")
                        {
                            Caption = 'Day Book Vendor Ledger Entry';
                            RunObject = report "Day Book Vendor Ledger Entry";
                        }
                        action("Sales Taxes Collected")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sales Taxes Collected';
                            RunObject = report "Sales Taxes Collected";
                        }
                        action("GST/HST Internet File Transfer")
                        {
                            ApplicationArea = BasicCA;
                            Caption = 'GST/HST Internet File Transfer';
                            RunObject = Report "GST/HST Internet File Transfer";
                        }
                    }
                }
                group("Group3")
                {
                    Caption = 'Intercompany';
                    action("General Journals")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany General Journal';
                        RunObject = page "IC General Journal";
                    }
                    action("Inbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Inbox Transactions';
                        RunObject = page "IC Inbox Transactions";
                    }
                    action("Outbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Outbox Transactions';
                        RunObject = page "IC Outbox Transactions";
                    }
                    action("Handled Inbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Handled Intercompany Inbox Transactions';
                        RunObject = page "Handled IC Inbox Transactions";
                    }
                    action("Handled Outbox Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Handled Intercompany Outbox Transactions';
                        RunObject = page "Handled IC Outbox Transactions";
                    }
                    action("Intercompany Transactions")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'IC Transaction';
                        RunObject = report "IC Transactions";
                    }
                }
                group("Group4")
                {
                    Caption = 'Consolidation';
                    action("Business Units")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Business Units';
                        RunObject = page "Business Unit List";
                    }
                    action("Export Consolidation")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Export Consolidation...';
                        RunObject = report "Export Consolidation";
                    }
                    action("G/L Consolidation Eliminations")
                    {
                        ApplicationArea = Suite;
                        Caption = 'G/L Consolidation Eliminations';
                        RunObject = report "G/L Consolidation Eliminations";
                    }
                }
                group("Group5")
                {
                    Caption = 'Journals';
                    action("General Journals1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journals';
                        RunObject = page "General Journal";
                    }
                    action("Recurring Journals")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                    }
                    action("General Journals2")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany General Journal';
                        RunObject = page "IC General Journal";
                    }
                }
                group("Group6")
                {
                    Caption = 'Register/Entries';
                    action("G/L Registers")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Registers';
                        RunObject = page "G/L Registers";
                    }
                    action("Navigate")
                    {
                        ApplicationArea = Basic, Suite, FixedAssets, CostAccounting;
                        Caption = 'Navigate';
                        RunObject = page "Navigate";
                    }
                    action("General Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Ledger Entries';
                        RunObject = page "General Ledger Entries";
                    }
                    action("G/L Budget Entries")
                    {
                        ApplicationArea = Suite;
                        Caption = 'G/L Budget Entries';
                        RunObject = page "G/L Budget Entries";
                    }
                    action("VAT Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Entries';
                        RunObject = page "VAT Entries";
                    }
                    action("Analysis View Entries")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis View Entries';
                        RunObject = page "Analysis View Entries";
                    }
                    action("Analysis View Budget Entries")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis View Budget Entries';
                        RunObject = page "Analysis View Budget Entries";
                    }
                    action("Item Budget Entries")
                    {
                        ApplicationArea = ItemBudget;
                        Caption = 'Item Budget Entries';
                        RunObject = page "Item Budget Entries";
                    }
                }
                group("Group7")
                {
                    Caption = 'Reports';
                    group("Group8")
                    {
                        Caption = 'Entries';
                        action("G/L Register")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'G/L Register';
                            RunObject = Report "G/L Register";
                        }
                        action("Detail Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Detail Trial Balance';
                            RunObject = report "Detail Trial Balance";
                        }
                        action("Dimensions - Detail")
                        {
                            ApplicationArea = Dimensions;
                            Caption = 'Dimensions - Detail';
                            RunObject = report "Dimensions - Detail";
                        }
                        action("Dimensions - Total")
                        {
                            ApplicationArea = Dimensions;
                            Caption = 'Dimensions - Total';
                            RunObject = report "Dimensions - Total";
                        }
                        action("Check Value Posting")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Dimension Check Value Posting';
                            RunObject = report "Check Value Posting";
                        }
                        action("Cross Ref. by Account No.")
                        {
                            Caption = 'Cross Ref. by Account No.';
                            RunObject = Report "Cross Reference by Account No.";
                        }
                        action("Cross Ref. by Source")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Cross Ref. by Source';
                            RunObject = Report "Cross Reference by Source";
                        }
                        action("General Ledger Worksheet")
                        {
                            ApplicationArea = Suite;
                            Caption = 'General Ledger Worksheet';
                            RunObject = Report "General Ledger Worksheet";
                        }
                        action("Item Charges - Specification")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Charges - Specification';
                            RunObject = report "Item Charges - Specification";
                        }
                    }
                    group("Group9")
                    {
                        Caption = 'Financial Statement';
                        action("Account Schedule")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Account Schedule';
                            RunObject = report "Account Schedule";
                        }
                        action("Account Schedule Layout")
                        {
                            Caption = 'Account Schedule Layout';
                            RunObject = Report "Account Schedule Layout";
                        }
                        action("Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance';
                            RunObject = Report "Trial Balance";
                        }
                        action("Trial Balance/Budget")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance/Budget';
                            RunObject = report "Trial Balance/Budget";
                        }
                        action("Trial Balance/Previous Year")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance/Previous Year';
                            RunObject = report "Trial Balance/Previous Year";
                        }
                        action("Closing Trial Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Closing Trial Balance';
                            RunObject = Report "Closing Trial Balance";
                        }
                        action("Consolidated Trial Balance")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Consolidated Trial Balance';
                            RunObject = Report "Consolidated Trial Balance";
                        }
                        action("Consolidated Trial Balance (4)")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Consolidated Trial Balance (4)';
                            RunObject = Report "Consolidated Trial Balance (4)";
                        }
                        action("Budget")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Budget';
                            RunObject = Report Budget;
                        }
                        action("Trial Balance by Period")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance by Period';
                            RunObject = report "Trial Balance by Period";
                        }
                        action("Fiscal Year Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Fiscal Year Balance';
                            RunObject = report "Fiscal Year Balance";
                        }
                        action("Balance Comp. - Prev. Year")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Balance Comp. - Prev. Year';
                            RunObject = report "Balance Comp. - Prev. Year";
                        }
                        action("Balance Sheet")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Balance Sheet';
                            RunObject = codeunit "Run Acc. Sched. Balance Sheet";
                            AccessByPermission = tabledata 15 = R;
                        }
                        action("Income Statement")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Income Statement';
                            RunObject = codeunit "Run Acc. Sched. Income Stmt.";
                            AccessByPermission = tabledata 15 = R;
                        }
                        action("Statement of Cashflows")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Cash Flow Statement';
                            RunObject = codeunit "Run Acc. Sched. CashFlow Stmt.";
                            AccessByPermission = tabledata 15 = R;
                        }
                        action("Statement of Retained Earnings")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Retained Earnings Statement';
                            RunObject = codeunit "Run Acc. Sched. Retained Earn.";
                            AccessByPermission = tabledata 15 = R;
                        }
                        action("Account Balances by GIFI Code")
                        {
                            ApplicationArea = BasicCA;
                            Caption = 'Account Balances by GIFI Code';
                            RunObject = Report "Account Balances by GIFI Code";
                        }
                        action("Trial Balance Detail/Summary")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Trial Balance Detail/Summary';
                            RunObject = Report "Trial Balance Detail/Summary";
                        }
                        action("Trial Balance, per Global Dim.")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Trial Balance, per Global Dim.';
                            RunObject = Report "Trial Balance, per Global Dim.";
                        }
                        action("Trial Balance, Spread G. Dim.")
                        {
                            ApplicationArea = Suite;
                            Caption = 'Trial Balance, Spread G. Dim.';
                            RunObject = Report "Trial Balance, Spread G. Dim.";
                        }
                        action("Trial Balance, Spread Periods")
                        {
                            Caption = 'Trial Balance, Spread Periods';
                            RunObject = Report "Trial Balance, Spread Periods";
                        }
                    }
                    group("Group10")
                    {
                        Caption = 'Miscellaneous';
                        action("Country/Region List")
                        {
                            Caption = 'Country/Region List';
                            RunObject = Report "Country/Region List";
                        }
                        action("Currency List")
                        {
                            Caption = 'Currency List';
                            RunObject = Report "Currency List";
                        }
                        action("Foreign Currency Balance")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Foreign Currency Balance';
                            RunObject = report "Foreign Currency Balance";
                        }
                        action("Language List")
                        {
                            Caption = 'Language List';
                            RunObject = Report "Language List";
                        }
                        action("Reason Code List")
                        {
                            Caption = 'Reason Code List';
                            RunObject = Report "Reason Code List";
                        }
                        action("Currency Balances - Rec./Pay.")
                        {
                            Caption = 'Currency Balances - Rec./Pay.';
                            RunObject = Report "Currency Balances - Rec./Pay.";
                        }
                        action("XBRL Spec. 2 Instance Document")
                        {
                            ApplicationArea = XBRL;
                            Caption = 'XBRL Spec. 2 Instance Document';
                            RunObject = report "XBRL Export Instance - Spec. 2";
                        }
                        action("XBRL Mapping of G/L Accounts")
                        {
                            ApplicationArea = XBRL;
                            Caption = 'XBRL Mapping of G/L Accounts';
                            RunObject = report "XBRL Mapping of G/L Accounts";
                        }
                        action("Reconcile Cust. and Vend. Accs")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Reconcile Cust. and Vend. Accs';
                            RunObject = report "Reconcile Cust. and Vend. Accs";
                        }
                        action("G/L Deferral Summary")
                        {
                            Caption = 'G/L Deferral Summary';
                            RunObject = report "Deferral Summary - G/L";
                        }
                    }
                    group("Group11")
                    {
                        Caption = 'Setup List';
                        action("Chart of Accounts1")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Chart of Accounts';
                            RunObject = Report "Chart of Accounts";
                        }
                        action("Change Log Setup List")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Change Log Setup List';
                            RunObject = report "Change Log Setup List";
                        }
                    }
                }
                group("Group12")
                {
                    Caption = 'Setup';
                    action("General Ledger Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Ledger Setup';
                        RunObject = page "General Ledger Setup";
                    }
                    action("Deferral Template List")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Deferral Templates';
                        RunObject = page "Deferral Template List";
                    }
                    action("Journal Templates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Journal Templates';
                        RunObject = page "General Journal Templates";
                    }
                    action("G/L Account Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'G/L Account Categories';
                        RunObject = page "G/L Account Categories";
                        AccessByPermission = tabledata 570 = R;
                    }
                    action("XBRL Taxonomies")
                    {
                        ApplicationArea = XBRL;
                        Caption = 'XBRL Taxonomies';
                        RunObject = page "XBRL Taxonomies";
                    }
                }
            }
            group("Group13")
            {
                Caption = 'Cash Management';
                action("Bank Accounts")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Accounts';
                    RunObject = page "Bank Account List";
                }
                action("Receivables-Payables")
                {
                    ApplicationArea = Suite;
                    Caption = 'Receivables-Payables';
                    RunObject = page "Receivables-Payables";
                }
                action("Payment Registration")
                {
                    Caption = 'Payment Registration';
                    RunObject = page "Payment Registration";
                }
                action("Deposit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deposits';
                    RunObject = page Deposits;
                }
                action("Posted Deposit")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Deposits';
                    RunObject = page "Posted Deposit List";
                }
                group("Group14")
                {
                    Caption = 'Cash Flow';
                    action("Cash Flow Forecasts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Forecasts';
                        RunObject = page "Cash Flow Forecast List";
                    }
                    action("Chart of Cash Flow Accounts")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chart of Cash Flow Accounts';
                        RunObject = page "Chart of Cash Flow Accounts";
                    }
                    action("Cash Flow Manual Revenues")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Manual Revenues';
                        RunObject = page "Cash Flow Manual Revenues";
                    }
                    action("Cash Flow Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Manual Expenses';
                        RunObject = page "Cash Flow Manual Expenses";
                    }
                    action("Cash Flow Worksheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Worksheet';
                        RunObject = page "Cash Flow Worksheet";
                    }
                }
                group("Group15")
                {
                    Caption = 'Reconciliation';
                    action("Bank Account Reconciliations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Reconciliations';
                        RunObject = page "Bank Acc. Reconciliation List";
                    }
                    action("Posted Payment Reconciliations")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Posted Payment Reconciliations';
                        RunObject = page "Posted Payment Reconciliations";
                    }
                    action("Payment Reconciliation Journals")
                    {
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                    }
                }
                group("Group16")
                {
                    Caption = 'Journals';
                    action("Cash Receipt Journal")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Receipt Journals';
                        RunObject = page "Cash Receipt Journal";
                    }
                    action("Sales Tax Journal")
                    {
                        ApplicationArea = SalesTax;
                        Caption = 'Sales Tax Journal';
                        RunObject = page "Sales Tax Journal";
                    }
                    action("Payment Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Journals';
                        RunObject = page "Payment Journal";
                    }
                    action("Payment Reconciliation Journals1")
                    {
                        Caption = 'Payment Reconciliation Journals';
                        RunObject = page "Pmt. Reconciliation Journals";
                    }
                }
                group("Group17")
                {
                    Caption = 'Ledger Entries';
                    action("Bank Account Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Ledger Entries';
                        RunObject = page "Bank Account Ledger Entries";
                    }
                    action("Check Ledger Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Check Ledger Entries';
                        RunObject = page "Check Ledger Entries";
                    }
                    action("Cash Flow Ledger Entries1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Ledger Entries';
                        RunObject = page "Cash Flow Forecast Entries";
                    }
                }
                group("Group18")
                {
                    Caption = 'Reports';
                    action("Deposit1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deposit';
                        RunObject = Report Deposit;
                    }
                    action("Deposit Test Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deposit Test Report';
                        RunObject = Report "Deposit Test Report";
                    }
                    action("Register")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Register';
                        RunObject = report "Bank Account Register";
                    }
                    action("Check Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account - Check Details';
                        RunObject = report "Bank Account - Check Details";
                    }
                    action("Labels")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account - Labels';
                        RunObject = report "Bank Account - Labels";
                    }
                    action("List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account - List';
                        RunObject = report "Bank Account - List";
                    }
                    action("Detail Trial Bal.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Acc. - Detail Trial Bal.';
                        RunObject = report "Bank Acc. - Detail Trial Bal.";
                    }
                    action("Receivables-Payables1")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Receivables-Payables';
                        RunObject = report "Receivables-Payables";
                    }
                    action("Cash Flow Date List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Date List';
                        RunObject = report "Cash Flow Date List";
                    }
                    action("Dimensions - Detail1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Cash Flow Dimensions - Detail';
                        RunObject = report "Cash Flow Dimensions - Detail";
                    }
                }
                group("Group19")
                {
                    Caption = 'Setup';
                    action("Payment Application Rules")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Application Rules';
                        RunObject = page "Payment Application Rules";
                    }
                    action("Cash Flow Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Setup';
                        RunObject = page "Cash Flow Setup";
                    }
                    action("Report Selection - Cash Flow")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Report Selections';
                        RunObject = page "Report Selection - Cash Flow";
                    }
                    action("Report Selection - Bank Acc.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Selections Bank Account';
                        RunObject = page "Report Selection - Bank Acc.";
                    }
                    action("Payment Terms")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Terms';
                        RunObject = page "Payment Terms";
                    }
                    action("Payment Methods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payment Methods';
                        RunObject = page "Payment Methods";
                    }
                    action("Currencies")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Currencies';
                        RunObject = page "Currencies";
                    }
                }
            }

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
                        Caption = 'Customer Order Status';
                        RunObject = page "Customer Order Status"; ///--!
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
            /*
            group("Group42")
            {
                Caption = 'Fixed Assets';
                action("Fixed Assets")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Fixed Assets';
                    RunObject = page "Fixed Asset List";
                }
                action("Insurance")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Insurance';
                    RunObject = page "Insurance List";
                }
                action("Calculate Depreciation...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Depreciation...';
                    RunObject = report "Calculate Depreciation";
                }
                action("Fixed Assets...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Fixed Assets...';
                    RunObject = report "Index Fixed Assets";
                }
                action("Insurance...")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Index Insurance...';
                    RunObject = report "Index Insurance";
                }
                group("Group43")
                {
                    Caption = 'Journals';
                    action("G/L Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA G/L Journals';
                        RunObject = page "Fixed Asset G/L Journal";
                    }
                    action("FA Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journals';
                        RunObject = page "Fixed Asset Journal";
                    }
                    action("FA Reclass. Journal")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journals';
                        RunObject = page "FA Reclass. Journal";
                    }
                    action("Insurance Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journals';
                        RunObject = page "Insurance Journal";
                    }
                    action("Recurring Journals1")
                    {
                        ApplicationArea = Suite, FixedAssets;
                        Caption = 'Recurring General Journals';
                        RunObject = page "Recurring General Journal";
                    }
                    action("Recurring Fixed Asset Journals")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Recurring Fixed Asset Journals';
                        RunObject = page "Recurring Fixed Asset Journal";
                    }
                }
                group("Group44")
                {
                    Caption = 'Reports';
                    group("Group45")
                    {
                        Caption = 'Fixed Assets';
                        action("Posting Group - Net Change")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Posting Group - Net Change';
                            RunObject = report "FA Posting Group - Net Change";
                        }
                        action("Register1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Register';
                            RunObject = report "Fixed Asset Register";
                        }
                        action("Acquisition List")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Acquisition List';
                            RunObject = report "Fixed Asset - Acquisition List";
                        }
                        action("Analysis1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Analysis';
                            RunObject = report "Fixed Asset - Analysis";
                        }
                        action("Book Value 01")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 01';
                            RunObject = report "Fixed Asset - Book Value 01";
                        }
                        action("Book Value 02")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Book Value 02';
                            RunObject = report "Fixed Asset - Book Value 02";
                        }
                        action("Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Details';
                            RunObject = report "Fixed Asset - Details";
                        }
                        action("G/L Analysis")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA G/L Analysis';
                            RunObject = report "Fixed Asset - G/L Analysis";
                        }
                        action("List1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA List';
                            RunObject = report "Fixed Asset - List";
                        }
                        action("Projected Value")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Projected Value';
                            RunObject = report "Fixed Asset - Projected Value";
                        }
                    }
                    group("Group46")
                    {
                        Caption = 'Insurance';
                        action("Uninsured FAs")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Uninsured FAs';
                            RunObject = report "Insurance - Uninsured FAs";
                        }
                        action("Register2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Register';
                            RunObject = report "Insurance Register";
                        }
                        action("Analysis2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Analysis';
                            RunObject = report "Insurance - Analysis";
                        }
                        action("Coverage Details")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance Coverage Details';
                            RunObject = report "Insurance - Coverage Details";
                        }
                        action("List2")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Insurance List';
                            RunObject = report "Insurance - List";
                        }
                        action("Tot. Value Insured")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'FA Total Value Insured';
                            RunObject = report "Insurance - Tot. Value Insured";
                        }
                    }
                    group("Group47")
                    {
                        Caption = 'Maintenance';
                        action("Register3")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Register';
                            RunObject = report "Maintenance Register";
                        }
                        action("Analysis3")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Analysis';
                            RunObject = report "Maintenance - Analysis";
                        }
                        action("Details1")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Details';
                            RunObject = report "Maintenance - Details";
                        }
                        action("Next Service")
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance Next Service';
                            RunObject = report "Maintenance - Next Service";
                        }
                    }
                }
                group("Group48")
                {
                    Caption = 'Registers/Entries';
                    action("FA Registers")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Registers';
                        RunObject = page "FA Registers";
                    }
                    action("Insurance Registers")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Registers';
                        RunObject = page "Insurance Registers";
                    }
                    action("FA Ledger Entries")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Ledger Entries';
                        RunObject = page "FA Ledger Entries";
                    }
                    action("Maintenance Ledger Entries")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance Ledger Entries';
                        RunObject = page "Maintenance Ledger Entries";
                    }
                    action("Ins. Coverage Ledger Entries")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Coverage Ledger Entries';
                        RunObject = page "Ins. Coverage Ledger Entries";
                    }
                }
                group("Group49")
                {
                    Caption = 'Setup';
                    action("FA Setup")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Setup';
                        RunObject = page "Fixed Asset Setup";
                    }
                    action("FA Classes")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Classes';
                        RunObject = page "FA Classes";
                    }
                    action("FA Subclasses")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Subclasses';
                        RunObject = page "FA Subclasses";
                    }
                    action("FA Locations")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Locations';
                        RunObject = page "FA Locations";
                    }
                    action("Insurance Types")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Types';
                        RunObject = page "Insurance Types";
                    }
                    action("Maintenance")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Maintenance';
                        RunObject = page "Maintenance";
                    }
                    action("Depreciation Books")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Books';
                        RunObject = page "Depreciation Book List";
                    }
                    action("Depreciation Tables")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Tables';
                        RunObject = page "Depreciation Table List";
                    }
                    action("FA Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Journal Templates';
                        RunObject = page "FA Journal Templates";
                    }
                    action("FA Reclass. Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Reclassification Journal Template';
                        RunObject = page "FA Reclass. Journal Templates";
                    }
                    action("Insurance Journal Templates")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insurance Journal Templates';
                        RunObject = page "Insurance Journal Templates";
                    }
                }
            }
            */
            group("Group50")
            {
                Caption = 'Inventory';
                action("Inventory Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Inventory Periods';
                    RunObject = page "Inventory Periods";
                }
                action("Phys. Invt. Counting Periods")
                {
                    ApplicationArea = Warehouse, Basic, Suite;
                    Caption = 'Physical Invtory Counting Periods';
                    RunObject = page "Phys. Invt. Counting Periods";
                }
                action("Application Worksheet")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Application Worksheet';
                    RunObject = page "Application Worksheet";
                }
                group("Group51")
                {
                    Caption = 'Costing';
                    action("Adjust Item Costs/Prices")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Item Costs/Prices';
                        RunObject = report "Adjust Item Costs/Prices";
                    }
                    action("Adjust Cost - Item Entries")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Adjust Cost - Item Entries...';
                        RunObject = report "Adjust Cost - Item Entries";
                    }
                    action("Update Unit Cost...")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Update Unit Costs...';
                        RunObject = report "Update Unit Cost";
                    }
                    action("Post Inventory Cost to G/L")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Inventory Cost to G/L';
                        RunObject = report "Post Inventory Cost to G/L";
                    }
                }
                group("Group52")
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
                    action("Phys. Inventory Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Physical Inventory Journals';
                        RunObject = page "Phys. Inventory Journal";
                    }
                    action("Revaluation Journals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Revaluation Journals';
                        RunObject = page "Revaluation Journal";
                    }
                }
                group("Group53")
                {
                    Caption = 'Reports';
                    action("Inventory to G/L Reconcile")
                    {
                        Caption = 'Inventory to G/L Reconcile';
                        RunObject = Report "Inventory to G/L Reconcile";
                    }
                    action("Inventory - Transaction Detail")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Transaction Detail';
                        RunObject = Report "Item Transaction Detail";
                    }
                    action("Inventory - Reorders")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Reorders';
                        RunObject = report "Inventory - Reorders";
                    }
                    action("Item Substitutions")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Item Substitutions';
                        RunObject = report "Item Substitutions";
                    }
                    action("Inventory Valuation")
                    {
                        Caption = 'Inventory Valuation';
                        RunObject = Report "Inventory Valuation";
                    }
                    action("Inventory Valuation - WIP")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Production Order - WIP';
                        RunObject = report "Inventory Valuation - WIP";
                    }
                    action("Inventory - Vendor Purchases")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory - Vendor Purchases';
                        RunObject = Report "Vendor Purchases by Item";
                    }
                    action("Item Comment List")
                    {
                        Caption = 'Item Comment List';
                        RunObject = Report "Item Comment List";
                    }
                    action("Inventory Labels")
                    {
                        Caption = 'Inventory Labels';
                        RunObject = Report "Inventory Labels";
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
                    action("Physical Inventory List")
                    {
                        ApplicationArea = Warehouse;
                        Caption = 'Physical Inventory List';
                        RunObject = report "Phys. Inventory List";
                    }
                    action("Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Status';
                        RunObject = report "Status";
                    }
                    action("Cost Shares Breakdown")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Cost Shares Breakdown';
                        RunObject = report "Cost Shares Breakdown";
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
                    action("Inventory - G/L Reconciliation")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Inventory - G/L Reconciliation';
                        RunObject = page "Inventory - G/L Reconciliation";
                    }
                    action("Item List")
                    {
                        Caption = 'Item List';
                        RunObject = Report "Item List";
                    }
                    action("Item Register")
                    {
                        Caption = 'Item Register';
                        RunObject = Report "Item Register";
                    }
                    action("Physical Inventory Count")
                    {
                        Caption = 'Physical Inventory Count';
                        RunObject = Report "Physical Inventory Count";
                    }
                    action("Serial Number Status/Aging")
                    {
                        Caption = 'Serial Number Status/Aging';
                        RunObject = Report "Serial Number Status/Aging";
                    }
                    action("Item Transaction Detail")
                    {
                        Caption = 'Item Transaction Detail';
                        RunObject = Report "Item Transaction Detail";
                    }
                    action("Location List")
                    {
                        Caption = 'Location List';
                        RunObject = Report "Location List";
                    }
                    action("Over Stock")
                    {
                        Caption = 'Over Stock';
                        RunObject = Report "Over Stock";
                    }
                    action("Top __ Inventory Items")
                    {
                        Caption = 'Top __ Inventory Items';
                        RunObject = Report "Top __ Inventory Items";
                    }
                }
                group("Group54")
                {
                    Caption = 'Setup';
                    action("Inventory Posting Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Posting Setup';
                        RunObject = page "Inventory Posting Setup";
                    }
                    action("Inventory Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Setup';
                        RunObject = page "Inventory Setup";
                    }
                    action("Item Charges")
                    {
                        ApplicationArea = ItemCharges;
                        Caption = 'Item Charges';
                        RunObject = page "Item Charges";
                    }
                    action("Item Categories")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Categories';
                        RunObject = page "Item Categories";
                    }
                    action("Rounding Methods")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Rounding Methods';
                        RunObject = page "Rounding Methods";
                        AccessByPermission = tabledata 156 = R;
                    }
                    action("Analysis Types")
                    {
                        ApplicationArea = SalesAnalysis, PurchaseAnalysis, InventoryAnalysis;
                        Caption = 'Analysis Types';
                        RunObject = page "Analysis Types";
                    }
                    action("Inventory Analysis Report")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Inventory Analysis Reports';
                        RunObject = page "Analysis Report Inventory";
                    }
                    action("Analysis View Card")
                    {
                        ApplicationArea = InventoryAnalysis, Dimensions;
                        Caption = 'Inventory Analysis by Dimensions';
                        RunObject = page "Analysis View List Inventory";
                    }
                    action("Analysis Column Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Column Templates';
                        RunObject = report "Run Invt. Analysis Col. Temp.";
                    }
                    action("Analysis Line Templates")
                    {
                        ApplicationArea = InventoryAnalysis;
                        Caption = 'Invt. Analysis Line Templates';
                        RunObject = report "Run Invt. Analysis Line Temp.";
                    }
                }
            }

            group(Action91)
            {
                Caption = 'Resources';
                Image = Journals;
                ToolTip = 'Manage the people or machines that are used to perform job tasks. ';
                action(Action93)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resources';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource List";
                    ToolTip = 'Manage your resources'' job activities by setting up their costs and prices. The job-related prices, discounts, and cost factor rules are set up on the respective job card. You can specify the costs and prices for individual resources, resource groups, or all available resources of the company. When resources are used or sold in a job, the specified prices and costs are recorded for the project.';
                }
                action("Resource Groups")
                {
                    ApplicationArea = Suite;
                    Caption = 'Resource Groups';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Groups";
                    ToolTip = 'Organize resources in groups, such as Consultants, for easier assignment of common values and to analyze financial figures by groups.';
                }
                action(ResourceJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post usage and sales of your resources for internal use and statistics. Use time sheet entries as input. Note that unlike with job journals, entries posted with resource journals are not posted to G/L accounts.';
                }
                action(RecurringResourceJournals)
                {
                    ApplicationArea = Jobs;
                    Caption = 'Recurring Resource Journals';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Resource Jnl. Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring usage and sales of your resources for internal use and statistics in a journal that is preset for your usual posting.';
                }
                action("Resource Registers")
                {
                    ApplicationArea = Jobs;
                    Caption = 'Resource Registers';
                    Image = ResourceRegisters;
                    RunObject = Page "Resource Registers";
                    ToolTip = 'View auditing details for all resource ledger entries. Every time an entry is posted, a register is created in which you can see the first and last number of its entries in order to document when entries were posted.';
                }
            }

            group("Group20")
            {
                Caption = 'Cost Accounting';
                action("Chart of Cost Centers")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Chart of Cost Centers';
                    RunObject = page "Chart of Cost Centers";
                }
                action("Chart of Cost Objects")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Chart of Cost Objects';
                    RunObject = page "Chart of Cost Objects";
                }
                action("Chart of Cost Types")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Chart of Cost Types';
                    RunObject = page "Chart of Cost Types";
                }
                action("Allocations")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Allocations';
                    RunObject = page "Cost Allocation Sources";
                }
                action("Cost Budgets")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Budgets';
                    RunObject = page "Cost Budget Names";
                }
                action("Cost Journal")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Journals';
                    RunObject = page "Cost Journal";
                }
                group("Group21")
                {
                    Caption = 'Registers';
                    action("Registers")
                    {
                        ApplicationArea = CostAccounting;
                        Caption = 'Cost Registers';
                        RunObject = page "Cost Registers";
                    }
                    action("Cost Budget Registers")
                    {
                        ApplicationArea = CostAccounting;
                        Caption = 'Cost Budget Registers';
                        RunObject = page "Cost Budget Registers";
                    }
                }
                group("Group22")
                {
                    Caption = 'Reports';
                    group("Group23")
                    {
                        Caption = 'Setup Information';
                        action("Allocations1")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Allocations';
                            RunObject = report "Cost Allocations";
                        }
                    }
                    group("Group24")
                    {
                        Caption = 'Entries';
                        action("Cost Journal1")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Acctg. Journal';
                            RunObject = report "Cost Acctg. Journal";
                        }
                        action("Account Details")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Types Details';
                            RunObject = report "Cost Types Details";
                        }
                    }
                    group("Group25")
                    {
                        Caption = 'Cost & Revenue';
                        action("P/L Statement")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Acctg. Statement';
                            RunObject = report "Cost Acctg. Statement";
                        }
                        action("P/L Statement per Period")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Acctg. Stmt. per Period';
                            RunObject = report "Cost Acctg. Stmt. per Period";
                        }
                        action("Analysis")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Acctg. Analysis';
                            RunObject = report "Cost Acctg. Analysis";
                        }
                    }
                    group("Group26")
                    {
                        Caption = 'Cost Budget';
                        action("P/L Statement with Budget")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Acctg. Statement/Budget';
                            RunObject = report "Cost Acctg. Statement/Budget";
                        }
                        action("Cost Center")
                        {
                            ApplicationArea = CostAccounting;
                            Caption = 'Cost Acctg. Balance/Budget';
                            RunObject = report "Cost Acctg. Balance/Budget";
                        }
                    }
                }
                group("Group27")
                {
                    Caption = 'Setup';
                    action("Cost Accounting Setup")
                    {
                        ApplicationArea = CostAccounting;
                        Caption = 'Cost Accounting Setup';
                        RunObject = page "Cost Accounting Setup";
                    }
                    action("Cost Journal Templates")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cost Journal Templates';
                        RunObject = page "Cost Journal Templates";
                    }
                }
            }
            group("Group55")
            {
                Caption = 'Setup';
                action("General Posting Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Posting Setup';
                    RunObject = page "General Posting Setup";
                }
                action("Incoming Documents Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Incoming Documents Setup';
                    RunObject = page "Incoming Documents Setup";
                }
                action("Accounting Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                    RunObject = page "Accounting Periods";
                }
                action("Standard Text Codes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Standard Text Codes';
                    RunObject = page "Standard Text Codes";
                }
                action("No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'No. Series';
                    RunObject = page "No. Series";
                }
                action("GIFI Codes")
                {
                    ApplicationArea = BasicCA;
                    Caption = 'GIFI Codes';
                    RunObject = page "GIFI Codes";
                }
                group("Group56")
                {
                    Caption = 'Sales Tax';
                    action("Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax Groups';
                        RunObject = page "Tax Groups";
                    }
                    action("Jurisdictions")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax Jurisdictions';
                        RunObject = page "Tax Jurisdictions";
                    }
                    action("Areas")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax Areas';
                        RunObject = page "Tax Area List";
                    }
                    action("Tax Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax Details';
                        RunObject = page "Tax Details";
                    }
                    action("Copy Tax Setup")
                    {
                        Caption = 'Copy Tax Setup';
                        RunObject = page "Copy Tax Setup";
                    }
                    action("Tax Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Tax Setup';
                        RunObject = page "Tax Setup";
                    }
                }
                group("Group57")
                {
                    Caption = 'VAT';
                    action("Posting Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Posting Setup';
                        RunObject = page "VAT Posting Setup";
                    }
                    action("VAT Clauses")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Clauses';
                        RunObject = page "VAT Clauses";
                    }
                    action("VAT Change Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Rate Change Setup';
                        RunObject = page "VAT Rate Change Setup";
                    }
                    action("VAT Statement Templates")
                    {
                        ApplicationArea = BasicMX;
                        Caption = 'VAT Statement Templates';
                        RunObject = page "VAT Statement Templates";
                    }
                }
                group("Group58")
                {
                    Caption = 'Intrastat';
                    action("Areas1")
                    {
                        Caption = 'Areas';
                        RunObject = page "Tax Area List";
                    }
                }
                group("Group59")
                {
                    Caption = 'Intercompany';
                    action("Intercompany Setup")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Setup';
                        RunObject = page "IC Setup";
                    }
                    action("Partner Code")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Partners';
                        RunObject = page "IC Partner List";
                    }
                    action("Chart of Accounts2")
                    {
                        ApplicationArea = Intercompany;
                        Caption = 'Intercompany Chart of Accounts';
                        RunObject = page "IC Chart of Accounts";
                    }
                    action("Dimensions")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Intercompany Dimensions';
                        RunObject = page "IC Dimensions";
                    }
                }
                group("Group60")
                {
                    Caption = 'Dimensions';
                    action("Dimensions1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimensions';
                        RunObject = page "Dimensions";
                    }
                    action("Analyses by Dimensions1")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Analysis by Dimensions';
                        RunObject = page "Analysis View List";
                    }
                    action("Dimension Combinations")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Dimension Combinations';
                        RunObject = page "Dimension Combinations";
                    }
                    action("Default Dimension Priorities")
                    {
                        ApplicationArea = Dimensions;
                        Caption = 'Default Dimension Priorities';
                        RunObject = page "Default Dimension Priorities";
                    }
                }
                group("Group61")
                {
                    Caption = 'Trail Codes';
                    action("Source Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Source Codes';
                        RunObject = page "Source Codes";
                    }
                    action("Reason Codes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Reason Codes';
                        RunObject = page "Reason Codes";
                    }
                    action("Source Code Setup")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Source Code Setup';
                        RunObject = page "Source Code Setup";
                    }
                }
                group("Group62")
                {
                    Caption = 'Posting Groups';
                    action("General Business")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Gen. Business Posting Groups';
                        RunObject = page "Gen. Business Posting Groups";
                    }
                    action("Gen. Product Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'General Product Posting Groups';
                        RunObject = page "Gen. Product Posting Groups";
                    }
                    action("Customer Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Posting Groups';
                        RunObject = page "Customer Posting Groups";
                    }
                    action("Vendor Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor Posting Groups';
                        RunObject = page "Vendor Posting Groups";
                    }
                    action("Bank Account")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Account Posting Groups';
                        RunObject = page "Bank Account Posting Groups";
                    }
                    action("Inventory Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Inventory Posting Groups';
                        RunObject = page "Inventory Posting Groups";
                    }
                    action("FA Posting Groups")
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Posting Groups';
                        RunObject = page "FA Posting Groups";
                    }
                    action("Business Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Business Posting Groups';
                        RunObject = page "VAT Business Posting Groups";
                    }
                    action("Product Posting Groups")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'VAT Product Posting Groups';
                        RunObject = page "VAT Product Posting Groups";
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

                action(PumpRelease)
                {
                    ///Visible = false;
                    ApplicationArea = All;
                    Caption = 'Pump Release';
                    Image = ReleaseDoc;
                    RunObject = codeunit PumpRelease;
                    ToolTip = 'Enters data to release a Work Order Detail.';
                }
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
                    RunObject = report "Outstanding Vendor Repairs";
                    //RunObject = codeunit UnderConstruction;
                    ToolTip = 'Runs Shop Work Order Status Report.';
                }
                group(WOReports)
                {
                    Caption = 'Sales Reports Office';

                    action(CustomerCommentList)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Comment List';
                        Image = Comment;
                        RunObject = report "Customer Comment List";
                        ToolTip = 'Runs Customer Comments Report.';

                    }
                    action(CustomerDocumentNos_)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Document Nos.';
                        Image = Documents;
                        RunObject = report "Customer Document Nos.";
                        ToolTip = 'Runs Customer Document Nos. Report.';

                    }

                    action(CustomerListing)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Listing';
                        Image = List;
                        RunObject = report "Customer Listing";
                        ToolTip = 'Runs Customer Document Nos. Report.';

                    }
                    action(CustomerSalesStatistics)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Sales Statistics';
                        Image = StatisticsDocument;
                        RunObject = report "Customer Sales Statistics";
                        ToolTip = 'Runs Customer Document Nos. Report.';

                    }
                    action(OpenCustomerEntries_10053)
                    {
                        ApplicationArea = All;
                        Caption = 'Open Customer Entries';
                        Image = EntriesList;
                        RunObject = report "Open Customer Entries";
                        ToolTip = 'Runs Open Customer Entries Report.';
                    }
                    action(OutstandingSalesOrderAging_10055)
                    {
                        ApplicationArea = All;
                        Caption = 'Outstanding Sales Order Aging';
                        Image = Aging;
                        RunObject = report "Outstanding Sales Order Aging";
                        ToolTip = 'Runs Outstanding Sales Order Aging Report.';
                    }
                    action(OutstandingSalesOrderStatus_10056)
                    {
                        ApplicationArea = All;
                        Caption = 'Outstanding Sales Order Status';
                        Image = Status;
                        RunObject = report "Outstanding Sales Order Status";
                        ToolTip = 'Runs Outstanding Sales Order Status Report.';
                    }
                    action(ShipToAddressListing_10061)
                    {
                        ApplicationArea = All;
                        Caption = 'Ship-To Address Listing';
                        Image = ShipAddress;
                        RunObject = report "Ship-To Address Listing";
                        ToolTip = 'Runs Ship-To Address Listing Report.';
                    }
                    action(CustomerTop10List_111)
                    {
                        ApplicationArea = All;
                        Caption = 'Top __ Customer List';
                        Image = ShipAddress;
                        RunObject = report "Customer - Top 10 List";
                        ToolTip = 'Runs Top __ Customer List Report.';
                    }

                    action(WOBillOfLading_50016)
                    {
                        ApplicationArea = All;
                        Caption = 'WO Bill Of Lading';
                        Image = Document;
                        RunObject = report "WO Bill Of Lading";
                        ToolTip = 'Runs WO Bill Of Lading Report.';
                    }
                    action(SOBillOfLading_50017)
                    {
                        ApplicationArea = All;
                        Caption = 'SO Bill Of Lading';
                        Image = Document;
                        RunObject = report "SO Bill Of Lading";
                        ToolTip = 'Runs SO Bill Of Lading Report.';
                    }
                    action(BillofLadingReport_50018)
                    {
                        ApplicationArea = All;
                        Caption = 'Bill of Lading Report';
                        Image = Documents;
                        RunObject = report "Bill of Lading Report";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Bill of Lading Report.';
                    }
                    action(WorkOrderAnalysis_50025)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Order Analysis';
                        Image = AnalysisView;
                        RunObject = report "Work Order Analysis";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Work Order Analysis Report.';
                    }
                    action(RepMonthlyStatement_50046)
                    {
                        ApplicationArea = All;
                        Caption = 'Rep. Monthly Statement';
                        Image = PurchaseTaxStatement;
                        RunObject = report "Rep. Monthly Statement";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Rep. Monthly Statement Report.';
                    }
                    action(SalesRepMonthlyInvoices_50058)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales Rep Monthly Invoices';
                        Image = "Invoicing-Document";
                        RunObject = report "Sales Rep Monthly Invoices";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Sales Rep Monthly Invoices Report.';
                    }
                    action(CommissionsPaidAndOutstanding_50044)
                    {
                        ApplicationArea = All;
                        Caption = 'Commissions Paid & Outstanding';
                        Image = PaymentForecast;
                        RunObject = report "Commissions Paid & Outstanding";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Commissions Paid & Outstanding Report.';
                    }
                    action(OCXCommissionReport_50030)
                    {
                        ApplicationArea = All;
                        Caption = 'OCX Commission Report';
                        Image = Percentage;
                        RunObject = report "OCX Commission Report";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs OCX Commission Report Report.';
                    }
                    action(OCXBillingList_50031)
                    {
                        ApplicationArea = All;
                        Caption = 'OCX Billing List';
                        Image = ReceivableBill;
                        RunObject = report "OCX Billing List";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs OCX Billing List Report.';
                    }
                    action(OCXSalesAnalysis_50027)
                    {
                        ApplicationArea = All;
                        Caption = 'OCX Sales Analysis';
                        Image = Sales;
                        RunObject = report "OCX Sales Analysis";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs OCX Sales Analysis Report.';
                    }
                    action(OCXPurchasesAnalysis_50028)
                    {
                        ApplicationArea = All;
                        Caption = 'OCX Purchases Analysis';
                        Image = Purchase;
                        RunObject = report "OCX Purchases Analysis";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs OCX Purchases Analysis Report.';
                    }
                    action(OCXCompletedWorkOrders_50032)
                    {
                        ApplicationArea = All;
                        Caption = 'OCX Completed Work Orders';
                        Image = Completed;
                        RunObject = report "OCX Completed Work Orders";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs OCX Completed Work Orders Report.';
                    }
                    action(QuoteSentReport_50043)
                    {
                        ApplicationArea = All;
                        Caption = 'Quote Sent Report';
                        Image = Quote;
                        //RunObject = report "Quote Sent Report";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Quote Sent Report Report.';
                    }
                    action(CustomerWorkOrderStatusRpt_50009)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Work Order Status Rpt';
                        Image = CustomerRating;
                        //RunObject = report "Customer Work Order Status Rpt";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Customer Work Order Status Rpt Report.';
                    }
                    action(WarrantyAnalysis_50035)
                    {
                        ApplicationArea = All;
                        Caption = 'Warranty Analysis';
                        Image = WarrantyLedger;
                        //RunObject = report "Warranty Analysis";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Warranty Analysis Report.';
                    }
                    action(ExpediteList_50013)
                    {
                        ApplicationArea = All;
                        Caption = 'Expedite List';
                        Image = PaymentForecast;
                        //RunObject = report "Expedite List";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Expedite List Report.';
                    }
                    action(ShopEmployeeHours_50125)
                    {
                        ApplicationArea = All;
                        Caption = 'Shop Employee Hours';
                        Image = PaymentForecast;
                        //RunObject = report "Shop Employee Hours";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Shop Employee Hours Report.';
                    }
                    action(WorkOrderDateStatusRpt_50036)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Order Date Status Rpt';
                        Image = PaymentForecast;
                        //RunObject = report "Work Order Date Status Rpt";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Work Order Date Status Rpt Report.';
                    }
                    action(FirststTimeTestFailures_50137)
                    {
                        ApplicationArea = All;
                        Caption = '1st TimeTest Failures';
                        Image = WarrantyLedger;
                        //RunObject = report "1st TimeTest Failures";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs 1st TimeTest Failures Report.';
                    }
                    action(WorkOrderShipments_50118)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Order Shipments';
                        Image = PaymentForecast;
                        RunObject = report "Work Order Shipments";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Work Order Shipments Report.';
                    }
                    action(WorkOrderInstallDate_50122)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Order Install Date';
                        Image = PaymentForecast;
                        RunObject = report "Work Order Install Date";
                        //RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Work Order Install Date Report.';
                    }
                    action(CustomerInvoices_50088)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer Invoices';
                        Image = PaymentForecast;
                        //RunObject = report "Customer Invoices";
                        RunObject = codeunit UnderConstruction;
                        ToolTip = 'Runs Customer Invoices Report.';
                    }
                }
            }
        }
    }
}
