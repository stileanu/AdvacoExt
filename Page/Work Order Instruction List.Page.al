page 50039 "Work Order Instruction List"
{
    // 04/01/2013 ADV
    //   Added code to allow user to see/not see blocked records based on permissions. 

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = WorkInstructions;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    Visible = BlockedVisible;
                }
                field("Customer Code"; "Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Ship To Code"; "Ship To Code")
                {
                    ApplicationArea = All;
                }
                field(Step; Step)
                {
                    ApplicationArea = All;
                }
                field(Model; Model)
                {
                    ApplicationArea = All;
                }
                field("Customer Part No."; "Customer Part No.")
                {
                    ApplicationArea = All;
                }
                field(Instruction; Instruction)
                {
                    ApplicationArea = All;
                }
                field("Part Quality Ctrl Instructions"; "Part Quality Ctrl Instructions")
                {
                    ApplicationArea = All;
                    Visible = PartQualityCtrlInstructionsVisible;
                }
                field("Date Last Modified"; "Date Last Modified")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Empty Lines")
            {
                ApplicationArea = All;
                Caption = 'Empty Lines';

                trigger OnAction()
                begin
                    SetRange(Instruction, '');
                    if not FindFirst then begin
                        Message(NO_EMPTY_REC);
                        SetRange(Instruction);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSecureID: Guid;
    begin
        // 04/01/2013 Start
        // set FILTERGROUP based on permissions
        //UserSetup.GET(UserSecurityId);
        UserSecureID := UserSecurityId();
        //IF (NOT UserSetup.GetParamStatus(User."User Security ID", 2)) AND (NOT UserSetup.GetParamStatus(User."User Security ID", 3)) THEN BEGIN
        IF (NOT UserSetup.GetParamStatus(UserSecureID, 2)) AND (NOT UserSetup.GetParamStatus(UserSecureID, 3)) THEN BEGIN
            prevFilterGroup := FILTERGROUP;
            FILTERGROUP(9);
            SETRANGE(Blocked, FALSE);
            FILTERGROUP(prevFilterGroup);
            BlockedVisible := FALSE;
        END ELSE
            BlockedVisible := TRUE;
        PartQualityCtrlInstructionsVisible := FALSE;
        // 04/01/2013 End
    end;

    var
        User: Record User;
        UserSetup: Record "User Setup";
        prevFilterGroup: Integer;
        [InDataSet]
        BlockedVisible: Boolean;
        [InDataSet]
        PartQualityCtrlInstructionsVisible: Boolean;
        NO_EMPTY_REC: Label 'There are no empty Instruction lines in the file.';
}

