#pragma implicitwith disable
page 50039 "Work Order Instruction List"
{
    // 04/01/2013 ADV
    //   Added code to allow user to see/not see blocked records based on permissions. 

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = WorkInstructions;
    CardPageId = "Work Order Instructions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Enabled = false;
                    Visible = BlockedVisible;
                }
                field("Customer Code"; Rec."Customer Code")
                {
                    ApplicationArea = All;
                }
                field("Ship To Code"; Rec."Ship To Code")
                {
                    ApplicationArea = All;
                }
                field(Step; Rec.Step)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Customer Part No."; Rec."Customer Part No.")
                {
                    ApplicationArea = All;
                }
                field(Instruction; Rec.Instruction)
                {
                    ApplicationArea = All;
                }
                field("Part Quality Ctrl Instructions"; Rec."Part Quality Ctrl Instructions")
                {
                    ApplicationArea = All;
                    Visible = PartQualityCtrlInstructionsVisible;
                }
                field("Date Last Modified"; Rec."Date Last Modified")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("WI Card")
            {
                ApplicationArea = All;
                Caption = 'Work Instruction card';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                //RunObject = page "Work Order Instructions";
                //RunPageLink = ""
                trigger OnAction()
                begin
                    Page.RunModal(50038, Rec);
                end;

            }
            action("Empty Lines")
            {
                ApplicationArea = All;
                Caption = 'Empty Lines';

                trigger OnAction()
                begin
                    Rec.SetRange(Instruction, '');
                    if not Rec.FindFirst then begin
                        Message(NO_EMPTY_REC);
                        Rec.SetRange(Instruction);
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
            prevFilterGroup := Rec.FILTERGROUP;
            Rec.FILTERGROUP(9);
            Rec.SETRANGE(Blocked, FALSE);
            Rec.FILTERGROUP(prevFilterGroup);
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

#pragma implicitwith restore

