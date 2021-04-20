report 62200 Modify_ILE
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Item Ledger Entry" = rm;


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(Entry_No_; "Entry No.")
            {
            }

            trigger OnPreDataItem()
            begin
                "Item Ledger Entry".SetRange("Entry No.", 78125, 78126);
            end;

            trigger OnAfterGetRecord()
            begin
                "Document No." := '6817359';
                Modify();
            end;
        }

    }

    /*
        requestpage
        {
            layout
            {
                area(Content)
                {
                    group(GroupName)
                    {
                        field(Name; SourceExpression)
                        {
                            ApplicationArea = All;

                        }   
                    }
                }
            }

            actions
            {
                area(processing)
                {
                    action(ActionName)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
    */

    var
        myInt: Integer;
}