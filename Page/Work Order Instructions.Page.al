#pragma implicitwith disable
page 50038 "Work Order Instructions"
{
    // 11/02/10 ADV
    //   Added new control "Customer Part No.".
    //   Added new control "Part Quality Ctrl Instructions".
    //   Added code to validate Part No. and make fields editable in certain conditions.
    // 
    // 09/18/12 ADV
    //   Modified the validation code to an inform message instead of error about the pre-existance
    //   of Part No in the WO table. If user answers no, the add process is canceled. 
    // 
    // 04/01/13 ADV
    //   Added control to show Block/Unblocked Status.
    //   Added code to allow user to see/set blocked records based on permissions.
    // 
    // 01/03/18
    //   Eliminate the test for Customer Part No. (CUST_NO_MISMATCH Error), per Kaye email.

    DelayedInsert = true;
    PageType = Card;
    SourceTable = WorkInstructions;

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1000000011)
                {
                    ShowCaption = false;
                    field("Customer Code"; Rec."Customer Code")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            CustomerCodeOnAfterValidate;
                        end;
                    }
                    field(Step; Rec.Step)
                    {
                        ApplicationArea = All;
                    }
                    field("Ship To Code"; Rec."Ship To Code")
                    {
                        ApplicationArea = All;
                        Editable = ShipToCodeEditable;
                    }
                    field(Model; Rec.Model)
                    {
                        ApplicationArea = All;
                        Editable = ModelEditable;
                    }
                    field("Customer Part No."; Rec."Customer Part No.")
                    {
                        ApplicationArea = All;
                        Editable = CustomerPartNoEditable;

                        trigger OnValidate()
                        begin
                            // 11/02/10 Start
                            // Validate "Customer Part No."
                            if Rec."Customer Part No." <> '' then begin
                                WorkOrdDetail.Reset;
                                WorkOrdDetail.SetCurrentKey("Customer Part No.");
                                WorkOrdDetail.SetRange("Customer Part No.", Rec."Customer Part No.");
                                if not WorkOrdDetail.Find('-') then begin
                                    // 09/18/12 Start
                                    if Confirm(NO_SUCH_PART, false, Rec."Customer Part No.") then begin
                                        Rec.NoConditionModify := true;
                                        //RENAME("Customer Code","Ship To Code",Step,Model,"Customer Part No.");
                                    end else begin
                                        Rec."Customer Part No." := xRec."Customer Part No.";
                                        //EXIT;
                                        // 09/18/12 End
                                        Error('');
                                    end;

                                    //01/03/18 Start
                                end;
                                //END ELSE
                                //  IF WorkOrdDetail."Customer ID" <> "Customer Code" THEN BEGIN
                                //    ERROR(CUST_NO_MISMATCH,"Customer Part No.",WorkOrdDetail."Customer ID","Customer Code");
                                //  END;
                                //01/03/18 End

                                Rec.Model := '';
                                Rec."Ship To Code" := '';
                                ModelEditable := false;
                                ShipToCodeEditable := false;
                            end else begin
                                ModelEditable := true;
                                ShipToCodeEditable := true;
                            end;
                            // 11/02/10 End
                        end;
                    }
                    field("Part Quality Ctrl Instructions"; Rec."Part Quality Ctrl Instructions")
                    {
                        ApplicationArea = All;
                        Editable = PartQualityCtrlEditable;

                        trigger OnDrillDown()
                        var
                            FilterString: Text[250];
                        begin
                            //CommFileName := 'Z:\Westminster\Quality Management System Documents\Work Instructions';
                            CommFileName := Rec."Part Quality Ctrl Instructions";
                            FilterString := 'Adobe PDF (*.pdf)|*.pdf|All files (*.*)|*.*';
                            ///--! "Part Quality Ctrl Instructions" := CommDlgMgmt.OpenFile('Attach Quality Control Document',CommFileName,4,FilterString,0);
                            CurrPage.Update;
                        end;
                    }
                    field(Instruction; Rec.Instruction)
                    {
                        ApplicationArea = All;
                    }
                    field(Blocked; Rec.Blocked)
                    {
                        ApplicationArea = All;
                        Enabled = false;
                        Visible = BlockedVisible;
                    }
                }
                group(Control1000000012)
                {
                    ShowCaption = false;
                    field("Date Last Modified"; Rec."Date Last Modified")
                    {
                        ApplicationArea = All;
                        Caption = 'Date';
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Block/Unblock")
            {
                ApplicationArea = All;
                Caption = 'Block/Unblock';
                Enabled = BlockUnblockEnabled;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = BlockUnblockVisible;

                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                    BlockWI: Boolean;
                    DelWI: Boolean;
                begin
                    // 04/01/13 Start
                    // Get permissions 
                    User.Get(UserSecurityId);

                    UserSetup.Get(User."User Name");
                    BlockWI := UserSetup.GetParamStatus(User."User Security ID", 2);

                    if Rec.Blocked and BlockWI then begin
                        Rec.Blocked := false;
                        Rec.Modify(true);
                    end else begin
                        Rec.Blocked := true;
                        Rec.Modify(true);
                    end;
                    // 04/01/13 End
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        // 11/02/10 Start
        if Rec."Customer Code" <> '' then begin
            CustomerPartNoEditable := true;
            PartQualityCtrlEditable := true;
        end else begin
            CustomerPartNoEditable := false;
            PartQualityCtrlEditable := false;
        end;
        if Rec."Customer Part No." <> '' then begin
            ModelEditable := false;
            ShipToCodeEditable := false;
        end else begin
            ModelEditable := true;
            ShipToCodeEditable := true;
        end;
        // 11/02/10 End
    end;

    trigger OnInit()
    begin
        Clear(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        // 11/02/10 Start
        if Rec."Customer Code" <> '' then begin
            CustomerPartNoEditable := true;
            PartQualityCtrlEditable := true;
        end else begin
            CustomerPartNoEditable := false;
            PartQualityCtrlEditable := false;
        end;

        // Validate "Customer Part No."
        if Rec."Customer Part No." <> '' then begin
            WorkOrdDetail.Reset;
            WorkOrdDetail.SetCurrentKey("Customer Part No.");
            WorkOrdDetail.SetRange("Customer Part No.", Rec."Customer Part No.");
            if not WorkOrdDetail.Find('-') then begin
                if not Confirm(StrSubstNo(NO_SUCH_PART, Rec."Customer Part No."), true) then
                    Error('');
                //01/03/18 Start
            end;
            //END ELSE
            //  IF WorkOrdDetail."Customer ID" <> "Customer Code" THEN BEGIN
            //    ERROR(CUST_NO_MISMATCH,"Customer Part No.",WorkOrdDetail."Customer ID","Customer Code");
            //  END;
            //01/03/18 End
        end;
        // 11/02/10 End
    end;

    trigger OnOpenPage()
    begin
        // 04/01/13 Start
        // set FILTERGROUP based on permissions
        User.Get(UserSecurityId);

        UserSetup.Get(User."User Name");
        IF (NOT UserSetup.GetParamStatus(User."User Security ID", 2)) AND (NOT UserSetup.GetParamStatus(User."User Security ID", 3)) THEN BEGIN
            prevFilterGroup := Rec.FILTERGROUP;
            Rec.FILTERGROUP(9);
            Rec.SETRANGE(Blocked, FALSE);
            Rec.FILTERGROUP(prevFilterGroup);
            BlockUnblockVisible := FALSE;
            BlockedVisible := FALSE;
        END ELSE BEGIN
            IF NOT UserSetup.GetParamStatus(User."User Security ID", 2) THEN
                BlockUnblockEnabled := FALSE;
        END;
        // 04/01/13 End

    end;

    var
        ///--! CommDlgMgmt: Codeunit "ComDialog Management";
        CommFileName: Text[250];
        WorkOrdDetail: Record WorkOrderDetail;
        UserSetup: Record "User Setup";
        prevFilterGroup: Integer;
        NO_SUCH_PART: Label 'Customer Part %1 does not exist in the database. Do you want to add it anyway?';
        CUST_NO_MISMATCH: Label 'Customer part %1 is set for Customer %2, not %3.';
        [InDataSet]
        CustomerPartNoEditable: Boolean;
        [InDataSet]
        PartQualityCtrlEditable: Boolean;
        [InDataSet]
        ModelEditable: Boolean;
        [InDataSet]
        ShipToCodeEditable: Boolean;
        [InDataSet]
        BlockedVisible: Boolean;
        [InDataSet]
        BlockUnblockVisible: Boolean;
        [InDataSet]
        BlockUnblockEnabled: Boolean;
        User: Record User;

    procedure CustomerCodeOnAfterValidate()
    begin
        if Rec."Customer Code" <> '' then begin
            CustomerPartNoEditable := true;
            PartQualityCtrlEditable := true;
        end else begin
            CustomerPartNoEditable := false;
            PartQualityCtrlEditable := false;
        end;
    end;
}

#pragma implicitwith restore

