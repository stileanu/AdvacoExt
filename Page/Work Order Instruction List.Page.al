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
                field(Blocked;Blocked)
                {
                    Editable = false;
                    Enabled = false;
                    Visible = BlockedVisible;
                }
                field("Customer Code";"Customer Code")
                {
                }
                field("Ship To Code";"Ship To Code")
                {
                }
                field(Step;Step)
                {
                }
                field(Model;Model)
                {
                }
                field("Customer Part No.";"Customer Part No.")
                {
                }
                field(Instruction;Instruction)
                {
                }
                field("Part Quality Ctrl Instructions";"Part Quality Ctrl Instructions")
                {
                    Visible = PartQualityCtrlInstructionsVisible;
                }
                field("Date Last Modified";"Date Last Modified")
                {
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
                Caption = 'Empty Lines';

                trigger OnAction()
                begin
                    SetRange(Instruction,'');
                    if not FindFirst then begin
                      Message(NO_EMPTY_REC);
                      SetRange(Instruction);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*99999
        // 04/01/2013 Start
        // set FILTERGROUP based on permissions
        UserSetup.GET(USERID);
        IF (NOT UserSetup.GetParamStatus(USERID,2)) AND (NOT UserSetup.GetParamStatus(USERID,3)) THEN BEGIN
          prevFilterGroup := FILTERGROUP;
          FILTERGROUP(9);
          SETRANGE(Blocked,FALSE);
          FILTERGROUP(prevFilterGroup);
          BlockedVisible := FALSE;
        END ELSE
          BlockedVisible := TRUE;
        PartQualityCtrlInstructionsVisible := FALSE;
        // 04/01/2013 End
        99999*/

    end;

    var
        UserSetup: Record "User Setup";
        prevFilterGroup: Integer;
        [InDataSet]
        BlockedVisible: Boolean;
        [InDataSet]
        PartQualityCtrlInstructionsVisible: Boolean;
        NO_EMPTY_REC: Label 'There are no empty Instruction lines in the file.';
}

