page 50023 "Build Ahead"
{
    SourceTable = Status;
    SourceTableView = SORTING("Order No.", Step)
                      ORDER(Ascending)
                      WHERE(Step = const(QOT),
                            Type = const(WorkOrder));

    layout
    {
        area(content)
        {
            group(Control1000000010)
            {
                ShowCaption = false;
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WOD.""Model No."""; WOD."Model No.")
                {
                    ApplicationArea = All;
                    Caption = 'Model No.';

                    trigger OnValidate()
                    begin
                        if WOD."Model No." <> OLDWOD."Model No." then begin
                            WOD.Validate(WOD."Model No.");
                            WOD.Modify;
                        end;
                    end;
                }
                field("WOD.""Serial No."""; WOD."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Serial No.';

                    trigger OnValidate()
                    begin
                        if WOD."Serial No." <> OLDWOD."Serial No." then
                            WOD.Modify;
                    end;
                }
                field("WOM.Customer"; WOM.Customer)
                {
                    ApplicationArea = All;
                    Caption = 'Customer';
                    Editable = false;
                }
                field(DateIn; DateIn)
                {
                    ApplicationArea = All;
                    Caption = 'Date In';
                }
                field(DateOut; DateOut)
                {
                    ApplicationArea = All;
                    Caption = 'Date Out';
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                }
                field(Regular; Regular)
                {
                    ApplicationArea = All;
                    Caption = 'Regular Hours';
                }
                field(Overtime; Overtime)
                {
                    ApplicationArea = All;
                    Caption = 'Overtime Hours';
                }
            }
            part(PartsLines; "Build Ahead Parts List")
            {
                ApplicationArea = All;
                SubPageLink = "Work Order No." = FIELD("Order No.");
            }
            part(PartsLines2; "Mechanics Parts Phase 2")
            {
                ApplicationArea = All;
                SubPageLink = "Work Order No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Build Ahead")
            {
                ApplicationArea = All;
                Caption = 'Build Ahead';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if WOD."Build Ahead" = true then
                        Error('The Work Order Parts have already been moved to In-Process Inventory');

                    //if Person = '' then
                    if Rec.Employee = '' then
                        Error('You must enter an Employee before Converting the Work Order to a Build Ahead')
                    else
                        Person := Rec.Employee;

                    if DateIn = 0D then
                        Error('You must enter a Date In before Converting the Work Order to a Build Ahead');

                    if DateOut = 0D then
                        Error('You must enter a Date Out before Converting the Work Order to a Build Ahead');

                    if (Regular = 0) and (Overtime = 0) then
                        Error('You must enter Time Worked before Converting the Work Order to a Build Ahead');

                    SerialNoFound := '';
                    QuotedQty := '';
                    NotChecked := '';

                    if WOD."Customer ID" = 'ADV-01' then begin
                        Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                        Parts.SetRange(Parts."Work Order No.", Rec."Order No.");
                        Parts.SetRange(Parts."Part Type", Parts."Part Type"::Item);
                        if Parts.Find('-') then begin
                            repeat
                                if Parts."Serial No." <> '' then begin
                                    SerialNoFound := 'FOUND';
                                    if SerialNoFound = 'FOUND' then
                                        if Parts."Quoted Quantity" = 0 then
                                            QuotedQty := 'ZERO';
                                end;
                            until Parts.Next = 0;
                        end;
                        if SerialNoFound = '' then
                            Error('The ADVACO Pump must be included in the QUOTE, Unable to Build Ahead Pump.');
                        if (SerialNoFound <> '') and (QuotedQty <> '') then
                            Error('Quoted Qty is Zero for Pump with Serial Number, Unable to Build Ahead Pump');

                        Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                        Mechanics.SetRange(Mechanics.Entered, false);
                        if Mechanics.Find('-') then begin
                            Error('All Mechanics Parts must be checked as Entered, Unable to Build Ahead Pump');
                            NotChecked := 'NotChecked';
                        end;

                        Parts.Reset;
                        Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                        Parts.SetRange(Parts."Work Order No.", Rec."Order No.");
                        Parts.SetRange(Parts."Part Type", Parts."Part Type"::Item);
                        if Parts.Find('-') then begin
                            repeat
                            begin
                                Parts.CalcFields(Parts."Committed Quantity");
                                if SerialNo = '' then begin
                                    if Parts."Serial No." <> '' then
                                        SerialNo := Parts."Serial No.";
                                end;
                                MoveInventory;
                            end;
                            if Parts."Quoted Quantity" = 0 then
                                Parts.Delete;
                            until Parts.Next = 0;
                        end;

                    end else begin
                        Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                        Parts.SetRange(Parts."Work Order No.", Rec."Order No.");
                        Parts.SetRange(Parts."Part Type", Parts."Part Type"::Item);
                        if Parts.Find('-') then begin
                            repeat
                                if Parts."Serial No." <> '' then
                                    if Parts."Quoted Quantity" = 0 then
                                        QuotedQty := 'ZERO';
                            until Parts.Next = 0;
                        end;
                        if (QuotedQty <> '') then
                            Error('Quoted Qty is Zero for Pump with Serial Number, Unable to Build Ahead Pump');

                        Mechanics.SetRange(Mechanics."Work Order No.", WOD."Work Order No.");
                        Mechanics.SetRange(Mechanics.Entered, false);
                        if Mechanics.Find('-') then begin
                            Error('All Mechanics Parts must be checked as Entered, Unable to Build Ahead Pump');
                            NotChecked := 'NotChecked';
                        end;

                        Parts.Reset;
                        Parts.SetCurrentKey(Parts."Work Order No.", Parts."Part No.");
                        Parts.SetRange(Parts."Work Order No.", Rec."Order No.");
                        Parts.SetRange(Parts."Part Type", Parts."Part Type"::Item);
                        if Parts.Find('-') then begin
                            repeat
                            begin
                                Parts.CalcFields(Parts."Committed Quantity");
                                if SerialNo = '' then begin
                                    if Parts."Serial No." <> '' then
                                        SerialNo := Parts."Serial No.";
                                end;
                                MoveInventory;
                            end;
                            if Parts."Quoted Quantity" = 0 then
                                Parts.Delete;
                            until Parts.Next = 0;
                        end;
                    end;

                    begin
                        WOS.Init;
                        WOS."Order No." := Rec."Order No.";
                        WOS."Line No." := Rec."Line No." + 10000;
                        WOS.Step := DetailStep.FromInteger(Rec.Step.AsInteger() + 1);
                        WOS.Status := WOS2.Status::Waiting;
                        WOS."Date In" := DateIn;
                        WOS."Date Out" := DateOut;
                        WOS."Regular Hours" := Regular;
                        WOS."Overtime Hours" := Overtime;
                        WOS.Employee := Person;
                        WOS.Insert;
                    end;

                    WOD."Build Ahead" := true;
                    WOD.Modify;
                    Commit;
                end;
            }
            action("Allocate Parts")
            {
                ApplicationArea = All;
                Caption = 'Allocate Parts';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // CurrForm.PartsLines.FORM.PartsAllocation

                    Parts.SetRange(Parts."Work Order No.", Rec."Order No.");
                    PAGE.RunModal(PAGE::"Parts Allocation", Parts);
                end;
            }
            action("Picking Ticket")
            {
                ApplicationArea = All;
                Caption = 'Picking Ticket';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    WOD.Reset;
                    WOD.Get(Rec."Order No.");
                    WOD.SetFilter(WOD."Work Order No.", Rec."Order No.");
                    REPORT.Run(50019, true, false, WOD);
                    WOD.Reset;
                end;
            }
            action("Pull Parts")
            {
                ApplicationArea = All;
                Caption = 'Pull Parts';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Parts.SetCurrentKey("Work Order No.", "Part Type", "Part No.");
                    Parts.SetRange(Parts."Work Order No.", Rec."Order No.");
                    if Parts.Find('-') then begin
                        repeat
                            Parts.CalcFields(Parts."In-Process Quantity");
                            if Parts."In-Process Quantity" > 0 then begin
                                Parts."Pulled Quantity" := Parts."In-Process Quantity";
                                Parts.Modify;
                            end;
                        until Parts.Next = 0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MasterNo := CopyStr(Rec."Order No.", 1, 5) + '00';
        if WOM.Get(MasterNo) then
            OK := true;

        WOD.Get(Rec."Order No.");
        OLDWOD := WOD;

        if WOI.Get(WOM.Customer, WOM."Ship To Code", Rec.Step) then
            Instructions := WOI.Instruction
        else
            Instructions := '';
    end;

    var
        WOD: Record WorkOrderDetail;
        OLDWOD: Record WorkOrderDetail;
        WOI: Record WorkInstructions;
        WOM: Record WorkOrderMaster;
        Instructions: Text[250];
        MasterNo: Code[7];
        OK: Boolean;
        Parts: Record Parts;
        MoveInventoryQty: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalClear: Record "Item Journal Line";
        LineNumber: Integer;
        PostLine: Codeunit "Item Jnl.-Post Line";
        SerialNo: Code[20];
        Item: Record Item;
        DateIn: Date;
        DateOut: Date;
        Person: Code[10];
        Regular: Decimal;
        Overtime: Decimal;
        WOS: Record Status;
        WOS2: Record Status;
        QuotedQty: Code[10];
        SerialNoFound: Code[10];
        NotChecked: Code[10];
        Mechanics: Record QuoteMechanicsParts;
        ItemLedgEntryType: Enum "Item Ledger Entry Type";

    procedure MoveInventory()
    begin
        MoveInventoryQty := Parts."Committed Quantity";
        if MoveInventoryQty > 0 then begin
            ItemJournalLine.Init;
            ItemJournalLine."Journal Template Name" := 'TRANSFER';
            ItemJournalLine.Validate(ItemJournalLine."Journal Template Name");
            ItemJournalLine."Journal Batch Name" := 'IN PROCESS';
            ItemJournalLine.Validate(ItemJournalLine."Journal Batch Name");
            ItemJournalLine."Line No." := LineNumber;
            ItemJournalLine."Entry Type" := ItemLedgEntryType::Transfer; ///--! Transfer
            ItemJournalLine."Document No." := Rec."Order No.";
            ItemJournalLine."Item No." := Parts."Part No.";
            ItemJournalLine.Validate(ItemJournalLine."Item No.");
            ItemJournalLine."Posting Date" := WorkDate;
            ItemJournalLine.Description := Rec."Order No." + ' ' + 'Build Ahead';
            ItemJournalLine."Location Code" := 'COMMITTED';
            ItemJournalLine.Quantity := MoveInventoryQty;
            ItemJournalLine.Validate(ItemJournalLine.Quantity);
            ItemJournalLine."New Location Code" := 'IN PROCESS';
            ItemJournalLine.Validate(ItemJournalLine."New Location Code");

            if SerialNo <> '' then begin
                ItemJournalLine."Serial No." := SerialNo;
                ItemJournalLine."New Serial No." := SerialNo;
                SerialNo := '';
            end;


            PostLine.Run(ItemJournalLine);

            ItemJournalClear.SetRange(ItemJournalClear."Journal Template Name", ItemJournalLine."Journal Template Name");
            ItemJournalClear.SetRange(ItemJournalClear."Journal Batch Name", ItemJournalLine."Journal Batch Name");
            if ItemJournalClear.Find('-') then
                repeat
                    ItemJournalClear.Delete;
                until ItemJournalClear.Next = 0;
        end;
    end;
}

