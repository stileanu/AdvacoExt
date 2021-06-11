#pragma implicitwith disable
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
    //ICE RSK 12/13/20 added comment field


    PageType = Card;
    //ApplicationArea = All;
    //UsageCategory = Administration;
    UsageCategory = None;
    SourceTable = WorkOrderMaster;
    PromotedActionCategories = 'New,Process,Report,Details';

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1220060045)
                {
                    ShowCaption = false;
                    field("Work Order Master No."; Rec."Work Order Master No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(Customer; Rec.Customer)
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Code"; Rec."Ship To Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Date Ordered"; Rec."Date Ordered")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    //ICE RSK 12/13/20
                    field(Comment; Format(Rec.Comment))
                    {

                        ApplicationArea = all;
                    }
                }

            }

            group(gCustomer)
            {
                Caption = 'Customer';

                group(Control1220060050)
                {
                    ShowCaption = false;
                    field("Customer Name"; Rec."Customer Name")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer Address 1"; Rec."Customer Address 1")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer Address 2"; Rec."Customer Address 2")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer City"; Rec."Customer City")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer State"; Rec."Customer State")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Customer Zip Code"; Rec."Customer Zip Code")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Tax Liable"; Rec."Tax Liable")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Tax Exemption No."; Rec."Tax Exemption No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Exempt Organization"; Rec."Exempt Organization")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
                group(Control1220060051)
                {
                    ShowCaption = false;
                    field("Ship To Name"; Rec."Ship To Name")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Ship To Address 1"; Rec."Ship To Address 1")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Address 2"; Rec."Ship To Address 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To City"; Rec."Ship To City")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Ship To State"; Rec."Ship To State")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Ship To Zip Code"; Rec."Ship To Zip Code")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field(Attention; Rec.Attention)
                    {
                        //Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = All;
                    }
                    field("Fax No."; Rec."Fax No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Date Required"; Rec."Date Required")
                    {
                        ApplicationArea = All;
                    }
                    field("Inside Sales"; Rec."Inside Sales")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(Rep; Rec.Rep)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Pickup Sheet"; Rec."Pickup Sheet")
                    {
                        ApplicationArea = All;
                    }
                    field(Details; Rec.Details)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
            }


            group(Payment)
            {
                group(Control1220060052)
                {
                    ShowCaption = false;
                    field("Payment Method"; Rec."Payment Method")
                    {
                        //Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Customer Payment Terms"; Rec."Customer Payment Terms")
                    {
                        //Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Card Type"; Rec."Card Type")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Credit Card No."; Rec."Credit Card No.")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Credit Card Exp."; Rec."Credit Card Exp.")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    field("Credit Card SC"; Rec."Credit Card SC")
                    {
                        Editable = ControlsEditable;
                        ApplicationArea = All;
                    }
                    group("Credit Card Comments")
                    {
                        Caption = 'Credit Card Comments';
                        field("CC Comments 1"; Rec."CC Comments 1")
                        {
                            //Editable = ControlsEditable;
                            ShowCaption = false;
                            MultiLine = true;
                            ApplicationArea = All;
                        }
                        field("CC Comments 2"; Rec."CC Comments 2")
                        {
                            //Editable = ControlsEditable;
                            ShowCaption = false;
                            MultiLine = true;
                            ApplicationArea = All;
                        }
                        field("CC Comments 3"; Rec."CC Comments 3")
                        {
                            //Editable = ControlsEditable;
                            ShowCaption = false;
                            MultiLine = true;
                            ApplicationArea = All;
                        }
                    }
                }
                group(Control1220060053)
                {
                    ShowCaption = false;
                    group("Name on Card")
                    {
                        Caption = 'Name on Card';
                        field(Control1220060035; Rec."Name on Card")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                    }
                    group("Bill-to Address")
                    {
                        Caption = 'Bill-to Address';
                        field("Bill-to Address 1"; Rec."Bill-to Address 1")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                        field("Bill-to Address 2"; Rec."Bill-to Address 2")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                        field("Bill-to Address 3"; Rec."Bill-to Address 3")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                        field("Bill-to Address 4"; Rec."Bill-to Address 4")
                        {
                            Editable = ControlsEditable;
                            ShowCaption = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    actions
    {

        area(Processing)

        {
            action("Edit Credit Card")
            {
                Caption = 'Edit Credit Card';
                ApplicationArea = All;
                Enabled = EditCCVisible;
                Promoted = true;
                PromotedCategory = Process;
                Image = CreditCard;

                trigger OnAction()
                begin
                    ControlsEditable := true;
                    EditCreditCard := true;
                end;
            }
            action("Customer Notes")
            {
                Caption = 'Customer Notes';
                ApplicationArea = All;
                Enabled = CustInfoVisible;
                PromotedCategory = Process;
                Promoted = true;
                Image = Notes;

                trigger OnAction()
                begin
                    if Rec."Work Order Master No." <> '' then begin
                        // 10/25/10 Start
                        //CustFile := 'F:\SHARED\CUSTOMER RECORDS\' + Customer + '-' + "Ship To Code" + '.doc';
                        CustFile := HyperlinkString + Rec.Customer + '-' + Rec."Ship To Code" + '.doc';
                        // 10/25/10 End
                        HyperLink(CustFile);
                    end;
                end;
            }
            action("WO Traveler")
            {
                Caption = 'WO Traveler';
                ApplicationArea = All;
                Enabled = TravelerEnabled;
                Promoted = true;
                PromotedCategory = Process;
                Image = Documents;

                trigger OnAction()
                begin
                    Pickup := false;
                    WOM2 := Rec;
                    ///--! WOD.SetCurrentKey("Work Order No.");
                    WOD.SetRange(WOD."Work Order Master No.", Rec."Work Order Master No.");
                    if WOD.FindFirst() then begin
                        REPORT.RunModal(50002, true, false, WOD);
                        if (WODEXIST.Carrier = 'ADV') or (WODEXIST.Carrier = 'ADVNC') then begin
                            if Rec."Pickup Sheet" then begin
                                Message('Pickup Sheet Already Printed, Please see Sales Manager if duplicate required');
                            end else begin
                                if not Confirm('Does Work Order %1 need to a Pick Up Sheet printed', false, Rec."Work Order Master No.") then begin
                                    Pickup := true;
                                    Message('Pickup Sheet was Cancelled.');
                                end else begin
                                    Pickup := true;
                                    WOM2.SetFilter("Work Order Master No.", Rec."Work Order Master No.");
                                    WOM2.SetRecFilter;
                                    REPORT.RunModal(50003, true, false, WOM2);
                                end;
                            end;
                        end;
                    end else
                        Message('No Details for this work order yet.');

                    if Pickup then begin
                        Rec."Pickup Sheet" := true;
                        Rec.Modify;
                    end;
                end;
            }
            action(Envelope)
            {
                Caption = '&Envelope';
                ApplicationArea = All;
                Enabled = EnvelopeEnabled;
                Promoted = true;
                PromotedCategory = Process;
                Image = DocumentsMaturity;

                trigger OnAction()
                begin
                    WOM2 := Rec;
                    WOM2.SetFilter("Work Order Master No.", Rec."Work Order Master No.");
                    WOM2.SetRecFilter;
                    REPORT.RunModal(50000, true, false, WOM2);
                end;
            }
        }
        area(Navigation)
        {

            action("&View Details")
            {
                Caption = '&View Details';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                Image = ViewDetails;

                trigger OnAction()
                begin
                    WorkOrderDetail.SetCurrentKey("Work Order Master No.");
                    WorkOrderDetail.SetRange(WorkOrderDetail."Work Order Master No.", Rec."Work Order Master No.");
                    if WorkOrderDetail.Find('-') then begin
                        ///--! move to open detail list
                        //Page.Run(50002, WorkOrderDetail);
                        Page.Run(50001, WorkOrderDetail);
                    end else begin
                        Message('No Detail Records exist for this Master.');
                    end;
                end;
            }
            action("&Add Detail")
            {
                Caption = '&Add Detail';
                ApplicationArea = All;
                Enabled = AddEnabled;
                Promoted = true;
                PromotedCategory = Category4;
                Image = AddAction;

                trigger OnAction()
                begin
                    if (Rec."Ship To Code" = '') then
                        Error('Ship To Code must be entered before adding a detail');

                    AddRecords.Run(Rec);
                end;
            }
            //ICE RSK 12/13/20
            action(Comments)
            {
                Caption = 'Comments';
                ApplicationArea = all;
                Promoted = True;
                PromotedCategory = Category4;
                Image = ViewComments;
                RunObject = page "ADVACO Comment Sheet";
                RunPageLink = "Table Name" = const(WorkOrderMaster), "No." = field("Work Order Master No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."File Exists" := false;
        // 10/25/10  Start
        //CustFile := 'F:\SHARED\Customer Records\' + Customer + '-' + "Ship To Code" + '.doc';
        CustFile := HyperlinkString + Rec.Customer + '-' + Rec."Ship To Code" + '.doc';
        // 10/25/10 End
        // To be rewritten for cloud!
        ///--! "File Exists" := Exists(CustFile);

        if Rec."File Exists" = true then
            CustInfoVisible := true
        else
            CustInfoVisible := false;

        // 11/09/10 Start
        WODEXIST.SetCurrentKey("Work Order Master No.");
        // 11/09/10 End
        WODEXIST.SetRange(WODEXIST."Work Order Master No.", Rec."Work Order Master No.");

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
        WODCLOSED.SetRange(WODCLOSED."Work Order Master No.", Rec."Work Order Master No.");
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
        //HyperlinkString := '\\ADVACOSBS\advacoroot\Westminster\Shared\Customer Records\ ';
        HyperlinkString := 'Z:\';
        Ok2 := false;
    end;

    trigger OnOpenPage()
    begin
        ///--! Permission level check code. Should be replaced?
        User.Get(UserSecurityId);
        //Member.CalcFields("User Name");
        Ok2 := true;
        Member.SetRange("User Security ID", User."User Security ID");
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
        end else begin
            AddEnabled := true;
            EnvelopeEnabled := true;
            TravelerEnabled := true;
        end;


        Ok3 := true;
        Member.Reset();
        Member.SetRange("User Security ID", User."User Security ID");
        if Member.Find('-') then begin
            repeat
                if (Member."Role ID" = 'ADV-SALESMNGR') or (Member."Role ID" = 'SUPER') then
                    Ok3 := false;
            until Member.Next = 0;
        end;

        if Ok3 then
            PickIpSheetEditable := false
        else
            PickIpSheetEditable := true;

        // 04/28/11 ADV: Start
        EditCreditCard := false;
        EditCCButton := false;
        if not Ok3 then
            EditCCButton := true;
        EditCCVisible := EditCCButton;
        // 04/28/11 ADV: Stop
        //*/


        //EditCCButton := true;
        //EditCCVisible := EditCCButton;
        //PickIpSheetEditable := true;

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
        User: Record User;
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

#pragma implicitwith restore

