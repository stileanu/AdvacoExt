page 50000 "Work Order Master"
{
    // 1/12/01 HTCS RCA
    // Added fields to form: "Payent Method" "Card Type" "Credit Card No." "Credit Card Exp."
    // 10/25/10 ADV
    //   Modify hyperlink to "Customer Records"
    // 01/05/11 ADV
    //   Select keys to eliminate slow search in WO Details.
    // 04/28/11 ADV
    //   Added CC processing fields. Make CC fields editable for Sales Manager.

    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    UsageCategory = None;
    SourceTable = WorkOrderMaster;

    layout
    {
        area(content)
        {
            group(Control1220060043)
            {
                ShowCaption = false;
                grid(Control1220060044)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1220060045)
                    {
                        ShowCaption = false;
                        field("Work Order Master No."; "Work Order Master No.")
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                        field(Customer; Customer)
                        {
                            ApplicationArea = All;
                        }
                        field("Ship To Code"; "Ship To Code")
                        {
                            ApplicationArea = All;
                        }
                        field("Date Ordered"; "Date Ordered")
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }

            group(General)
            {
                group(Control1220060050)
                {
                    ShowCaption = false;
                    field("Customer Name"; "Customer Name")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer Address 1"; "Customer Address 1")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer Address 2"; "Customer Address 2")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer City"; "Customer City")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer State"; "Customer State")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer Zip Code"; "Customer Zip Code")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Tax Liable"; "Tax Liable")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Tax Exemption No."; "Tax Exemption No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Exempt Organization"; "Exempt Organization")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
                group(Control1220060051)
                {
                    ShowCaption = false;
                    field("Ship To Name"; "Ship To Name")
                    {
                        Editable = false;
                    }
                    field("Ship To Address 1"; "Ship To Address 1")
                    {
                    }
                    field("Ship To Address 2"; "Ship To Address 2")
                    {
                    }
                    field("Ship To City"; "Ship To City")
                    {
                        Editable = false;
                    }
                    field("Ship To State"; "Ship To State")
                    {
                        Editable = false;
                    }
                    field("Ship To Zip Code"; "Ship To Zip Code")
                    {
                        Editable = false;
                    }
                    field("Phone No."; "Phone No.")
                    {
                        Editable = ControlsEditable;
                    }
                    field(Attention; Attention)
                    {
                        Editable = ControlsEditable;
                    }
                    field("E-Mail"; "E-Mail")
                    {
                    }
                    field("Fax No."; "Fax No.")
                    {
                    }
                    field("Date Required"; "Date Required")
                    {
                    }
                    field("Inside Sales"; "Inside Sales")
                    {
                        Editable = false;
                    }
                    field(Rep; Rep)
                    {
                        Editable = false;
                    }
                    field("Pickup Sheet"; "Pickup Sheet")
                    {
                    }
                    field(Details; Details)
                    {
                        Editable = false;
                    }
                }
            }


            group(Payment)
            {
                group(Control1220060052)
                {
                    ShowCaption = false;
                    field("Payment Method"; "Payment Method")
                    {
                        Editable = ControlsEditable;
                    }
                    field("Customer Payment Terms"; "Customer Payment Terms")
                    {
                        Editable = ControlsEditable;
                    }
                    field("Card Type"; "Card Type")
                    {
                        Editable = ControlsEditable;
                    }
                    field("Credit Card No."; "Credit Card No.")
                    {
                        Editable = ControlsEditable;
                    }
                    field("Credit Card Exp."; "Credit Card Exp.")
                    {
                        Editable = ControlsEditable;
                    }
                    field("Credit Card SC"; "Credit Card SC")
                    {
                        Editable = ControlsEditable;
                    }
                    group("Credit Card Comments")
                    {
                        Caption = 'Credit Card Comments';
                        field("CC Comments 1"; "CC Comments 1")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                        field("CC Comments 2"; "CC Comments 2")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                        field("CC Comments 3"; "CC Comments 3")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    group("Name on Card")
                    {
                        Caption = 'Name on Card';
                        field(Control1220060035; "Name on Card")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                    }
                    group("Bill-to Address")
                    {
                        Caption = 'Bill-to Address';
                        field("Bill-to Address 1"; "Bill-to Address 1")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                        field("Bill-to Address 2"; "Bill-to Address 2")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                        field("Bill-to Address 3"; "Bill-to Address 3")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                        field("Bill-to Address 4"; "Bill-to Address 4")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Edit Credit Card")
            {
                Caption = 'Edit Credit Card';
                Enabled = EditCCVisible;
                Promoted = true;

                trigger OnAction()
                begin
                    ControlsEditable := true;

                    EditCreditCard := true;
                end;
            }
            action("Customer Notes")
            {
                Caption = 'Customer Notes';
                Enabled = CustInfoVisible;
                Promoted = true;

                trigger OnAction()
                begin
                    if "Work Order Master No." <> '' then begin
                        // 10/25/10 Start
                        //CustFile := 'F:\SHARED\CUSTOMER RECORDS\' + Customer + '-' + "Ship To Code" + '.doc';
                        CustFile := HyperlinkString + Customer + '-' + "Ship To Code" + '.doc';
                        // 10/25/10 End
                        HyperLink(CustFile);
                    end;
                end;
            }
            action("WO Traveler")
            {
                Caption = 'WO Traveler';
                Enabled = TravelerEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    Pickup := false;
                    WOM2 := Rec;
                    ///--! WOD.SetCurrentKey("Work Order No.");
                    WOD.SetRange(WOD."Work Order Master No.", "Work Order Master No.");
                    REPORT.RunModal(50002, true, false, WOD);
                    if (WODEXIST.Carrier = 'ADV') or (WODEXIST.Carrier = 'ADVNC') then begin
                        if "Pickup Sheet" then begin
                            Message('Pickup Sheet Already Printed, Please see Sales Manager if duplicate required');
                        end else begin
                            if not Confirm('Does Work Order %1 need to a Pick Up Sheet printed', false, "Work Order Master No.") then begin
                                Pickup := true;
                                Message('Pickup Sheet was Cancelled.');
                            end else begin
                                Pickup := true;
                                WOM2.SetFilter("Work Order Master No.", "Work Order Master No.");
                                WOM2.SetRecFilter;
                                REPORT.RunModal(50003, true, false, WOM2);
                            end;
                        end;
                    end;

                    if Pickup then begin
                        "Pickup Sheet" := true;
                        Modify;
                    end;
                end;
            }
            action(Envelope)
            {
                Caption = 'Envelope';
                Enabled = EnvelopeEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    WOM2 := Rec;
                    WOM2.SetFilter("Work Order Master No.", "Work Order Master No.");
                    WOM2.SetRecFilter;
                    REPORT.RunModal(50000, true, false, WOM2);
                end;
            }
            action("&View Details")
            {
                Caption = '&View Details';
                Promoted = true;

                trigger OnAction()
                begin
                    WorkOrderDetail.SetCurrentKey("Work Order Master No.");
                    WorkOrderDetail.SetRange(WorkOrderDetail."Work Order Master No.", "Work Order Master No.");
                    if WorkOrderDetail.Find('-') then begin
                        PAGE.Run(50002, WorkOrderDetail);
                    end else begin
                        Message('No Detail Records exist for this Master.');
                    end;
                end;
            }
            action("&Add Detail")
            {
                Caption = '&Add Detail';
                Enabled = AddEnabled;
                Promoted = true;

                trigger OnAction()
                begin
                    if ("Ship To Code" = '') then
                        Error('Ship To Code must be entered before adding a detail');

                    AddRecords.Run(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        "File Exists" := false;
        // 10/25/10 Start
        //CustFile := 'F:\SHARED\Customer Records\' + Customer + '-' + "Ship To Code" + '.doc';
        CustFile := HyperlinkString + Customer + '-' + "Ship To Code" + '.doc';
        // 10/25/10 End
        // To be rewritten for cloud!
        ///--! "File Exists" := Exists(CustFile);

        if "File Exists" = true then
            CustInfoVisible := true
        else
            CustInfoVisible := false;

        // 11/09/10 Start
        WODEXIST.SetCurrentKey("Work Order Master No.");
        // 11/09/10 End
        WODEXIST.SetRange(WODEXIST."Work Order Master No.", "Work Order Master No.");

        // 04/28/11 ADV: Start
        if not EditCreditCard then begin
            // 04/28/11 ADV: Stop

            if WODEXIST.Find('-') then begin
                ControlsEditable := false;
            end else begin
                ControlsEditable := true;
            end;

            // 04/28/11 ADV: Start
        end else
            EditCreditCard := false;
        // 04/28/11 ADV: Stop
        WODCOUNT := 0;
        CLOSEDCOUNT := 0;

        // 11/09/10 Start
        WODCLOSED.SetCurrentKey("Work Order Master No.");
        // 11/09/10 End
        WODCLOSED.SetRange(WODCLOSED."Work Order Master No.", "Work Order Master No.");
        if WODCLOSED.Find('-') then begin
            repeat
                WODCOUNT := WODCOUNT + 1;
                if WODCLOSED.Complete = true then
                    CLOSEDCOUNT := CLOSEDCOUNT + 1;
            until WODCLOSED.Next = 0;
        end;

        if (WODCOUNT = CLOSEDCOUNT) and (WODCOUNT > 0) then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;

    trigger OnInit()
    begin
        //HyperlinkString := '\\ADVACOSBS\advacoroot\Westminster\Shared\Customer Records\';
        HyperlinkString := 'Z:\';
    end;

    trigger OnOpenPage()
    begin
        Member.CalcFields("User Name");
        Ok2 := true;
        Member.SetRange(Member."User Name", UserId);
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALES') or (Member."Role ID" = 'SUPER') then
                    Ok2 := false;
            until Member.Next = 0;
        end;

        if Ok2 then begin
            AddEnabled := false;
            EnvelopeEnabled := false;
            TravelerEnabled := false;
        end;


        Ok3 := true;
        Member.SetRange(Member."User Name", UserId);
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALESMNGR') or (Member."Role ID" = 'SUPER') then
                    Ok3 := false;
            until Member.Next = 0;
        end;

        if Ok3 then
            PickIpSheetEditable := false;

        // 04/28/11 ADV: Start
        EditCreditCard := false;
        EditCCButton := false;
        if not Ok3 then
            EditCCButton := true;
        EditCCVisible := EditCCButton;
        // 04/28/11 ADV: Stop
    end;

    var
        WorkOrderDetail: Record WorkOrderDetail;
        WorkOrderDetail2: Record WorkOrderDetail;
        WorkOrderDetail3: Record WorkOrderDetail;
        WOS: Record Status;
        Ok: Boolean;
        NextWONo: Code[10];
        RecordCount: Integer;
        AddRecords: Codeunit "Work Order Detail Insert";
        CustFile: Text[250];
        WOM: Record WorkOrderMaster;
        WorkOrderNo: Integer;
        WO: Code[10];
        WO2: Integer;
        WOM2: Record WorkOrderMaster;
        WOD: Record WorkOrderDetail;
        WODCLOSED: Record WorkOrderDetail;
        WODCOUNT: Integer;
        CLOSEDCOUNT: Integer;
        WODEXIST: Record WorkOrderDetail;
        Member: Record "Access Control";
        Ok2: Boolean;
        Pickup: Boolean;
        Ok3: Boolean;
        HyperlinkString: Text[96];
        EditCreditCard: Boolean;
        EditCCButton: Boolean;
        [InDataSet]
        AddEnabled: Boolean;
        [InDataSet]
        EnvelopeEnabled: Boolean;
        [InDataSet]
        TravelerEnabled: Boolean;
        [InDataSet]
        PickIpSheetEditable: Boolean;
        [InDataSet]
        EditCCVisible: Boolean;
        [InDataSet]
        CustInfoVisible: Boolean;
        [InDataSet]
        ControlsEditable: Boolean;
}

