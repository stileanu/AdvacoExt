page 50143 "IDR Header"
{
    PageType = Card;
    SourceTable = IDRHeader;

    layout
    {
        area(content)
        {
            group(Control1220060032)
            {
                ShowCaption = false;
                grid(Control1220060031)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060030)
                    {
                        ShowCaption = false;
                        field("No."; "No.")
                        {
                            ApplicationArea = All;
                            Caption = 'IDR No.';
                            Editable = false;
                        }
                        field("Document Type"; "Document Type")
                        {
                            ApplicationArea = All;
                            Caption = 'Type';
                        }
                        field("Inspector Code"; "Inspector Code")
                        {
                            ApplicationArea = All;
                            Caption = 'Inspector';
                        }
                        field("Document Date"; "Document Date")
                        {
                            ApplicationArea = All;
                            Caption = 'Date';
                            Editable = false;
                        }
                    }
                }
            }
            group(General)
            {
                group(Receiving)
                {
                    Caption = 'Receiving';
                    field("Purchase Order No."; "Purchase Order No.")
                    {
                        ApplicationArea = All;
                        Editable = PurchaseOrderNoEditable;
                    }
                    field("Invoice No."; "Invoice No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Packing List/Invoice No.';
                        Editable = InvoiceNoEditable;
                    }
                    field("Vendor No."; "Vendor No.")
                    {
                        ApplicationArea = All;
                        Editable = VendorNoEditable;
                    }
                    field("Vendor Name"; "Vendor Name")
                    {
                        ApplicationArea = All;
                        Editable = VendorNameEditable;
                    }
                }
                group("Production / Test")
                {
                    Caption = 'Production / Test';
                    field("Order No."; "Order No.")
                    {
                        ApplicationArea = All;
                        Editable = OrderNoEditable;
                    }
                    field("Model No."; "Model No.")
                    {
                        ApplicationArea = All;
                        Editable = ModelNoEditable;
                    }
                    field("Serial No."; "Serial No.")
                    {
                        ApplicationArea = All;
                        Editable = SerialNoEditable;
                    }
                    field("Process Code"; "Process Code")
                    {
                        ApplicationArea = All;
                        Editable = ProcessCodeEditable;
                    }
                }
            }
            group(Control1220060040)
            {
                ShowCaption = false;
                group("Disposition:")
                {
                    Caption = 'Disposition:';
                    field("Return to Vendor"; "Return to Vendor")
                    {
                        ApplicationArea = All;
                    }
                    field("RMA No."; "RMA No.")
                    {
                        ApplicationArea = All;
                    }
                    field(Scrap; Scrap)
                    {
                        ApplicationArea = All;
                    }
                    field("Scrap Cost"; "Scrap Cost")
                    {
                        ApplicationArea = All;
                        Caption = 'Cost';
                    }
                    field(Restock; Restock)
                    {
                        ApplicationArea = All;
                    }
                    field("Rework/Repair"; "Rework/Repair")
                    {
                        ApplicationArea = All;
                    }
                }
                group("QA Close Out Approval:")
                {
                    Caption = 'QA Close Out Approval:';
                    field("Rework Operator"; "Rework Operator")
                    {
                        ApplicationArea = All;
                    }
                    field("Rework Date"; "Rework Date")
                    {
                        ApplicationArea = All;
                    }
                    field("ReTest Operator"; "ReTest Operator")
                    {
                        ApplicationArea = All;
                    }
                    field("ReTest Date"; "ReTest Date")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Control1220060039)
            {
                ShowCaption = false;
                group("Rework / Retest Information:")
                {
                    Caption = 'Rework / Retest Information:';
                    field("QA Approval"; "QA Approval")
                    {
                        ApplicationArea = All;
                        Caption = 'Quality Assurance';
                        Editable = false;
                    }
                    field("Completion Date"; "Completion Date")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group("Kit Information:")
                {
                    Caption = 'Kit Information:';
                    field("Kit Part No."; "Kit Part No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Kit Vendor No."; "Kit Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(IDRlines; "IDR Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("IDR Report")
            {
                ApplicationArea = All;
                Caption = 'IDR Report';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IDR.SetRange(IDR."No.", "No.");
                    REPORT.RunModal(50143, true, false, IDR);
                end;
            }
            action("Close IDR")
            {
                ApplicationArea = All;
                Caption = 'Close IDR';
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Are you sure you want to Close this IDR', false) then begin
                        Message('Close IDR has been Aborted');
                    end else begin
                        "IDR Closed" := true;
                        "Completion Date" := Today;
                        "QA Approval" := UserId;
                        Modify;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Type Determines which fields are edible
        if "Document Type" = "Document Type"::" " then begin
            PurchaseOrderNoEditable := false;
            InvoiceNoEditable := false;
            VendorNoEditable := false;
            VendorNameEditable := false;
            OrderNoEditable := false;
            ModelNoEditable := false;
            SerialNoEditable := false;
            ProcessCodeEditable := false;
        end;

        if "Document Type" = "Document Type"::Receiving then begin
            PurchaseOrderNoEditable := true;
            InvoiceNoEditable := true;
            VendorNoEditable := true;
            VendorNameEditable := true;
            OrderNoEditable := false;
            ModelNoEditable := false;
            SerialNoEditable := false;
            ProcessCodeEditable := false;
        end;

        if "Document Type" = "Document Type"::Production then begin
            PurchaseOrderNoEditable := false;
            InvoiceNoEditable := false;
            VendorNoEditable := false;
            VendorNameEditable := false;
            OrderNoEditable := true;
            ModelNoEditable := true;
            SerialNoEditable := true;
            ProcessCodeEditable := true;
        end;

        if "IDR Closed" then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;

    var
        OK: Boolean;
        DocType: Code[20];
        IDR: Record IDRHeader;
        [InDataSet]
        PurchaseOrderNoEditable: Boolean;
        [InDataSet]
        InvoiceNoEditable: Boolean;
        [InDataSet]
        VendorNoEditable: Boolean;
        [InDataSet]
        VendorNameEditable: Boolean;
        [InDataSet]
        OrderNoEditable: Boolean;
        [InDataSet]
        ModelNoEditable: Boolean;
        [InDataSet]
        SerialNoEditable: Boolean;
        [InDataSet]
        ProcessCodeEditable: Boolean;
}

