page 50103 "Close Work Order Details"
{
    // 071913 ADV
    //   new form, to run System Assembling process.

    Caption = 'BoxControl4Visible';

    layout
    {
        area(content)
        {
            group(Control1220060003)
            {
                ShowCaption = false;
                field(SalesOrderNo; SalesOrderNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order No.';
                }
                field(WorkOrderNo; WorkOrderNo)
                {
                    ApplicationArea = All;
                    Caption = 'Work Order No.';
                }
            }
            group(Figures)
            {
                Caption = 'Figures';
                group(Control1220060011)
                {
                    ShowCaption = false;
                    field("DetailNoCode[1]"; DetailNoCode[1])
                    {
                        ApplicationArea = All;
                        Caption = 'W/O #';
                        Editable = false;
                    }
                    field("DetailPartsCost[1]"; DetailPartsCost[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Parts';
                        Editable = false;
                    }
                    field("DetailLaborCost[1]"; DetailLaborCost[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Labor';
                        Editable = false;
                    }
                    field("DetailTotalCost[1]"; DetailTotalCost[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Total';
                    }
                }
                group(Control1220060016)
                {
                    ShowCaption = false;
                    Visible = BoxControl3Visible;
                    field("DetailNoCode[3]"; DetailNoCode[3])
                    {
                        ApplicationArea = All;
                        Caption = 'W/O #';
                        Editable = false;
                        Visible = BoxControl3Visible;
                    }
                    field("DetailPartsCost[3]"; DetailPartsCost[3])
                    {
                        ApplicationArea = All;
                        Caption = 'Parts';
                        Editable = false;
                        Visible = BoxControl3Visible;
                    }
                    field("DetailLaborCost[3]"; DetailLaborCost[3])
                    {
                        ApplicationArea = All;
                        Caption = 'Labor';
                        Editable = false;
                        Visible = BoxControl3Visible;
                    }
                    field("DetailTotalCost[3]"; DetailTotalCost[3])
                    {
                        ApplicationArea = All;
                        Caption = 'Total';
                        Editable = false;
                        Visible = BoxControl3Visible;
                    }
                }
            }
            group(Control1220060027)
            {
                ShowCaption = false;
                group(Control1220060026)
                {
                    ShowCaption = false;
                    field("DetailNoCode[2]"; DetailNoCode[2])
                    {
                        ApplicationArea = All;
                        Caption = 'W/O #';
                        Editable = false;
                    }
                    field("DetailPartsCost[2]"; DetailPartsCost[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Parts';
                        Editable = false;
                    }
                    field("DetailLaborCost[2]"; DetailLaborCost[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Labor';
                        Editable = false;
                    }
                    field("DetailTotalCost[2]"; DetailTotalCost[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Total';
                        Editable = false;
                    }
                }
                group(Control1220060021)
                {
                    ShowCaption = false;
                    field("DetailNoCode[4]"; DetailNoCode[4])
                    {
                        ApplicationArea = All;
                        Caption = 'W/O #';
                        Editable = false;
                        Visible = BoxControl4Visible;
                    }
                    field("DetailPartsCost[4]"; DetailPartsCost[4])
                    {
                        ApplicationArea = All;
                        Caption = 'Parts';
                        Editable = false;
                        Visible = BoxControl4Visible;
                    }
                    field("DetailLaborCost[4]"; DetailLaborCost[4])
                    {
                        ApplicationArea = All;
                        Caption = 'Labor';
                        Editable = false;
                        Visible = BoxControl4Visible;
                    }
                    field("DetailTotalCost[4]"; DetailTotalCost[4])
                    {
                        ApplicationArea = All;
                        Caption = 'Total';
                        Editable = false;
                        Visible = BoxControl4Visible;
                    }
                }
            }
            group(Control1220060029)
            {
                ShowCaption = false;
                group(Control1220060028)
                {
                    ShowCaption = false;
                    field(ItemCode; ItemCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Item Code';
                        Editable = false;
                    }
                    field(SerialNoCode; SerialNoCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Serial #';
                        Editable = false;
                    }
                    field(TotalOrderCosts; TotalOrderCosts)
                    {
                        ApplicationArea = All;
                        Caption = 'Total';
                        Editable = false;
                    }
                }
                group(Control1220060033)
                {
                    ShowCaption = false;
                    field("'More than four Detailed Orders. Can show only four of them.'"; 'More than four Detailed Orders. Can show only four of them.')
                    {
                        ApplicationArea = All;
                        Editable = false;
                        ShowCaption = false;
                        Visible = MoreThen5Visible;
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Show Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Show Sales Order';
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if SalesHeader."No." = '' then
                        Error(Error002);

                    SalesOrderForm.SetTableView(SalesHeader);
                    SalesOrderForm.SetRecord(SalesHeader);
                    SalesOrderForm.Run;
                end;
            }
            action("Show Work Order")
            {
                ApplicationArea = All;
                Caption = 'Show Work Order';
                Enabled = false;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if WorkOrderMaster."Work Order Master No." = '' then
                        Error(Error003);

                    WorkOrderForm.SetTableView(WorkOrderMaster);
                    WorkOrderForm.SetRecord(WorkOrderMaster);
                    WorkOrderForm.Run;
                end;
            }
            action("Close Work Order")
            {
                ApplicationArea = All;
                Caption = 'Close Work Order';
                Enabled = false;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Message001, true) then begin
                        // Close Work Order Details
                        WorkOrderDetail.Reset;
                        WorkOrderDetail.SetCurrentKey("Work Order Master No.");
                        WorkOrderDetail.SetRange("Work Order Master No.", WorkOrderNo);
                        if WorkOrderDetail.FindSet then
                            repeat
                                WorkOrderDetail.Complete := true;
                                WorkOrderDetail.Modify;
                            until WorkOrderDetail.Next = 0;
                        SalesOrderNo := '';
                        WorkOrderNo := '';
                        Clear(DetailPartsCost);
                        Clear(DetailLaborCost);
                        Clear(DetailTotalCost);
                        Clear(DetailNoCode);
                        Clear(ItemCode);
                        Clear(SerialNoCode);
                        Clear(TotalOrderCosts);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action("Create Item Journal Lines")
            {
                ApplicationArea = All;
                Caption = 'Create Item Journal Lines';
                Enabled = false;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ItemJnlTempl: Record "Item Journal Template";
                    ItemJnlLine: Record "Item Journal Line";
                    ActualBatch: Code[10];
                begin
                    if (WorkOrderNo = '') then
                        Error(Error011);
                    if ItemJnlLine.FindFirst then begin
                        if Confirm(Message002, true, true) then
                            ItemJnlLine.DeleteAll
                        else
                            exit;
                    end;
                    GenerateItemJnlLines;
                    Commit;
                    // Run Item Jnl Line form
                    Clear(ItemJnlForm);
                    ItemJnlTempl.SetRange(Type, 0);
                    ItemJnlTempl.FindFirst;
                    ItemJnlLine.FilterGroup := 2;
                    ItemJnlLine.SetRange("Journal Template Name", ItemJnlTempl.Name);
                    ItemJnlLine.SetRange("Journal Batch Name", ItemJnlBatch);
                    ItemJnlLine.FilterGroup := 0;

                    ItemJnlForm.SetTableView(ItemJnlLine);
                    ActualBatch := GetBatchName;
                    SetBatchName(ItemJnlBatch);
                    //ItemJnlForm.SETRECORD(ItemJnlLine);
                    if ItemJnlForm.RunModal = ACTION::LookupOK then;
                    SetBatchName(ActualBatch);
                    Clear(ItemJnlForm);
                end;
            }
            action("Create SN#/Modify SO")
            {
                ApplicationArea = All;
                Caption = 'Create SN#/Modify SO';
                Enabled = PostInvAdjEnabled;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Create and post inventory adjustment for new serial
                    CreateItemInInventory;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        ItemJnlBatch := 'SONOTLINK';
    end;

    trigger OnOpenPage()
    begin
        PostInvAdjEnabled := false;
    end;

    var
        SalesOrderNo: Code[20];
        WorkOrderNo: Code[20];
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesOrderForm: Page "Sales Order Sales";
        WorkOrderMaster: Record WorkOrderMaster;
        WorkOrderDetail: Record WorkOrderDetail;
        PartsRec: Record Parts;
        WorkOrderForm: Page "Work Order Master";
        ItemJournal: Record "Item Journal Line";
        ItemJnlBatch: Code[10];
        DetailPartsCost: array[5] of Decimal;
        DetailLaborCost: array[5] of Decimal;
        DetailTotalCost: array[5] of Decimal;
        DetailNoCode: array[5] of Code[20];
        ArrayLimit: Integer;
        ItemCode: Code[20];
        SerialNoCode: Code[20];
        TotalOrderCosts: Decimal;
        ItemJnlManagement: Codeunit ItemJnlManagement;
        ItemJnlForm: Page "Item Journal";
        Error001: Label 'Cannot find Sales Order No. %1  you entered.';
        Error002: Label 'There is no Sales Order set.';
        Error003: Label 'There is no Work Order Set';
        Error004: Label 'Cannot find Work Order No. %1  you entered.';
        Error005: Label 'You need to selet a Sales Order first.';
        Error006: Label 'No Item set in the Sales Order.';
        Error007: Label 'No WO Details found.';
        Error008: Label 'There are some Back Ordered parts. Do you want to continue? (Y/N) ';
        Error009: Label 'Sales Order Line is not Item Type. Check with Sales.';
        Error010: Label 'There are BO Parts. Cannot continue.';
        Error011: Label 'Work Order No. not set.';
        Error012: Label 'Work Order detail %1 is closed. Cannot use this form.';
        Error013: Label 'Serial No. %1 for item %2 is not IN PROCESS location.';
        Message001: Label 'Do you want to close the Work Order? (Y/N)';
        Message002: Label 'The batch SONOTLINK is not empty. Do youy want to clean it?';
        [InDataSet]
        BoxControl3Visible: Boolean;
        [InDataSet]
        BoxControl4Visible: Boolean;
        [InDataSet]
        MoreThen5Visible: Boolean;
        [InDataSet]
        PostInvAdjEnabled: Boolean;
        CurrentJnlBatchName: Code[10];

    procedure CalculateDetailsCosts()
    begin
        ArrayLimit := 0;
        TotalOrderCosts := 0;
        Clear(SerialNoCode);

        if SetWODetails then
            repeat
                ArrayLimit += 1;
                WorkOrderDetail.CalcFields("Labor Quoted", "Parts Cost");
                DetailNoCode[ArrayLimit] := WorkOrderDetail."Work Order No.";
                DetailPartsCost[ArrayLimit] := WorkOrderDetail."Parts Cost";
                DetailLaborCost[ArrayLimit] := WorkOrderDetail."Labor Quoted";
                DetailTotalCost[ArrayLimit] := WorkOrderDetail."Labor Quoted" + WorkOrderDetail."Parts Cost";
                TotalOrderCosts += WorkOrderDetail."Labor Quoted" + WorkOrderDetail."Parts Cost";
                if (StrLen(SerialNoCode) <> 0) and (StrLen(SerialNoCode) < 20) then
                    SerialNoCode := SerialNoCode + '/';
                SerialNoCode := CopyStr(SerialNoCode + WorkOrderDetail."Serial No.", 1, 20);
                if ArrayLimit = 3 then begin
                    BoxControl3Visible := true;
                end;
                if ArrayLimit = 4 then
                    BoxControl4Visible := true;
                if ArrayLimit = 5 then
                    MoreThen5Visible := true;
            until WorkOrderDetail.Next = 0
        else
            Error(Error007);
        if SalesOrderNo = '' then
            Error(Error005);
        if SalesLine."No." = '' then
            Error(Error006)
        else
            ItemCode := SalesLine."No.";
    end;

    procedure GenerateItemJnlLines()
    var
        ItemLineNo: Integer;
        LocItemLedger: Record "Item Ledger Entry";
    begin
        // Check BO parts
        if CheckBOParts then
            Error(Error010);

        // Clean Journal
        if ItemJournal.FindFirst then
            ItemJournal.DeleteAll;
        ItemLineNo := 10000;

        // Find WO Details
        if WorkOrderNo <> '' then begin
            if not SetWODetails then
                Error(Error007);
        end else
            // No WO Set
            Error(Error003);

        // Work Order Details loop
        repeat
            // Parts loop
            PartsRec.Reset;
            PartsRec.SetRange("Work Order No.", WorkOrderDetail."Work Order No.");
            PartsRec.SetRange("Part Type", PartsRec."Part Type"::Item);
            if PartsRec.FindFirst then
                repeat
                    ItemJournal.Reset;
                    ItemJournal.Init;
                    ItemJournal."Journal Template Name" := 'ITEM';
                    ItemJournal."Journal Batch Name" := ItemJnlBatch;
                    ItemJournal."Line No." := ItemLineNo;
                    ItemLineNo := ItemLineNo + 10000;
                    ItemJournal.Validate("Posting Date", Today);
                    ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Negative Adjmt.";
                    ItemJournal."Document No." := Format(Today, 6, '<Month,2><Day,2><Year>') + 'SOPARTS';
                    PartsRec.CalcFields("Committed Quantity", "In-Process Quantity");
                    ItemJournal.Validate("Item No.", PartsRec."Part No.");
                    ItemJournal.Validate("Location Code", 'IN PROCESS');
                    ItemJournal.Validate("Unit Amount", PartsRec."Part Cost");
                    ItemJournal.Validate(Quantity, PartsRec."In-Process Quantity");
                    ItemJournal.Insert;
                    // Check for serial no.
                    if PartsRec."Serial No." <> '' then begin
                        LocItemLedger.SetCurrentKey("Document No.", "Item No.", "Location Code");
                        LocItemLedger.SetRange("Item No.", PartsRec."Part No.");
                        LocItemLedger.SetRange("Document No.", PartsRec."Work Order No.");
                        LocItemLedger.SetRange("Location Code", 'IN PROCESS');
                        LocItemLedger.SetRange("Serial No.", PartsRec."Serial No.");
                        if LocItemLedger.FindFirst then begin
                            ItemJournal."Serial No." := LocItemLedger."Serial No.";
                            ItemJournal.Modify;
                        end else
                            Error(Error013, PartsRec."Serial No.", PartsRec."Part No.");
                    end;
                until PartsRec.Next = 0;
        until WorkOrderDetail.Next = 0;
    end;

    procedure CreateItemInInventory()
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange("Document No.", SalesOrderNo);
        SalesLine.FindFirst;
        if SalesLine.Type <> SalesLine.Type::Item then
            Error(Error009);

        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'ITEM');
        ItemJnlLine.SetRange("Journal Batch Name", ItemJnlBatch);
        if ItemJnlLine.FindFirst then begin
            if Confirm(Message002, true, true) then
                ItemJnlLine.DeleteAll
            else
                exit;
        end;

        ItemJournal.Reset;
        ItemJournal.Init;
        ItemJournal."Journal Template Name" := 'ITEM';
        ItemJournal."Journal Batch Name" := ItemJnlBatch;
        if ItemJnlLine.FindLast then
            ItemJournal."Line No." := ItemJnlLine."Line No." + 10000
        else
            ItemJournal."Line No." := 10000;
        ItemJournal."Posting Date" := Today;
        ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
        ItemJournal."Document No." := Format(Today, 6, '<Month,2><Day,2><Year>') + 'SYSADJ';
        ItemJournal.Validate("Item No.", SalesLine."No.");
        ItemJournal.Validate("Location Code", 'MAIN');
        ItemJournal.Validate("Unit Amount", Round(TotalOrderCosts, 0.01));
        ItemJournal.Validate("Serial No.", SerialNoCode);
        ItemJournal.Validate(Quantity, 1);
        ItemJournal.Insert;

        // Post Jnl Line
        //>>  Whse. Management - start
        //99999LogIntegration.ItemJournalCheck(ItemJournal);
        //<<  Whse. Management - end
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post+Print", ItemJournal);

        // Modify Sales Order Line
        //99999SalesLine.VALIDATE("Serial No.",SerialNoCode); 
        //SalesLine.Modify;
    end;

    procedure SetWODetails(): Boolean
    begin
        WorkOrderDetail.Reset;
        WorkOrderDetail.SetCurrentKey("Work Order Master No.");
        WorkOrderDetail.SetRange("Work Order Master No.", WorkOrderMaster."Work Order Master No.");
        if WorkOrderDetail.FindSet then
            exit(true)
        else
            exit(false);
    end;

    procedure CheckBOParts(): Boolean
    begin
        repeat
            PartsRec.Reset;
            PartsRec.SetRange("Work Order No.", WorkOrderDetail."Work Order No.");
            if PartsRec.FindSet then
                repeat
                    if PartsRec."Quantity Backorder" <> 0 then
                        exit(true);
                until PartsRec.Next = 0;
        until WorkOrderDetail.Next = 0;
        exit(false);
    end;

    procedure GetBatchName(): Code[10]
    begin
        exit(CurrentJnlBatchName);
    end;

    procedure SetBatchName(NewBatch: Code[10])
    begin
        CurrentJnlBatchName := NewBatch;
    end;
}

