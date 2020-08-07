page 50057 "Item Add"
{
    // 1/9/01, htcs, rca - added variable: LocationItem
    //                     added code to:  OnQueryCloseForm() : Boolean

    PageType = Card;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(General)
            {
                group(Control1000000020)
                {
                    ShowCaption = false;
                    field("No."; "No.")
                    {
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            if AssistEdit() then
                                CurrPage.Update;
                        end;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = All;
                    }
                    field("Search Description"; "Search Description")
                    {
                        ApplicationArea = All;
                    }
                    field("Base Unit of Measure"; "Base Unit of Measure")
                    {
                        ApplicationArea = All;
                    }
                    field("Profit %"; "Profit %")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Unit Price"; "Unit Price")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Receiving Inspection"; "Receiving Inspection")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Control1000000019)
                {
                    ShowCaption = false;
                    field("Costing Method"; "Costing Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Inventory Posting Group"; "Inventory Posting Group")
                    {
                        ApplicationArea = All;
                    }
                    field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            "VAT Prod. Posting Group" := 'DEFAULT';
                            Modify;
                        end;
                    }
                    field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Vendor No."; "Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Item No."; "Vendor Item No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Lead Time Calculation"; "Lead Time Calculation")
                    {
                        ApplicationArea = All;
                    }
                    field("UPS Shipping Surcharge"; "UPS Shipping Surcharge")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Add Item")
            {
                ApplicationArea = All;
                Caption = 'Add Item';
                Visible = false;

                trigger OnAction()
                begin
                    /*99999
                    DisplayMessage := FALSE;
                    IF ("No." <> '') AND (Class <> 'MODEL') THEN BEGIN
                        TESTFIELD(Description);
                        TESTFIELD("Base Unit of Measure");
                        TESTFIELD("Average Cost");
                        TESTFIELD("Inventory Posting Group");
                        TESTFIELD("Gen. Prod. Posting Group");
                        TESTFIELD(Class);
                        IF Location.FIND('-') THEN REPEAT
                          IF NOT LocationItem.GET(Location.Code,"No.",'') THEN BEGIN
                            DisplayMessage := TRUE;
                            LocationItem.INIT;
                            LocationItem."Location Code" := Location.Code;
                            LocationItem.VALIDATE("Item No.","No.");
                            LocationItem."General Product Posting Group" := "Gen. Prod. Posting Group";
                            LocationItem."Inventory Posting Group" := "Inventory Posting Group";
                            LocationItem.INSERT;
                          END;
                        UNTIL Location.NEXT = 0;
                    END;
                    
                    IF DisplayMessage THEN BEGIN
                      MESSAGE('Item Locations Created');
                    END
                    99999*/

                end;
            }
            action("&Location Item")
            {
                ApplicationArea = All;
                Caption = '&Location Item';
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetRange("No.");
    end;

    trigger OnInit()
    begin
        Clear(Rec);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Tax Group Code" := 'DEFAULT';
        "VAT Prod. Posting Group" := 'DEFAULT';
        "Price/Profit Calculation" := "Price/Profit Calculation"::"Price=Cost+Profit";
        "Profit %" := 46.23657;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        /*99999
        //>> HEF INSERT
        IF "No." <> '' THEN BEGIN
          IF (Class = 'ITEM') OR (Class = 'PUMP') THEN BEGIN
            TESTFIELD(Description);
            TESTFIELD("Base Unit of Measure");
            TESTFIELD("Inventory Posting Group");
            TESTFIELD("Gen. Prod. Posting Group");
            TESTFIELD(Class);
            IF Location.FIND('-') THEN REPEAT
              IF NOT LocationItem.GET(Location.Code,"No.",'') THEN BEGIN
                DisplayMessage := TRUE;
                LocationItem.INIT;
                LocationItem."Location Code" := Location.Code;
                LocationItem.VALIDATE("Item No.","No.");
                LocationItem."General Product Posting Group" := "Gen. Prod. Posting Group";
                LocationItem."Inventory Posting Group" := "Inventory Posting Group";
                LocationItem.INSERT;
              END;
            UNTIL
            Location.NEXT = 0;
          END ELSE BEGIN
            IF Class <> 'MODEL' THEN
              ERROR('ITEM or PUMP must be filled in when Adding a Part');
          END;
        END;
        //<< END INSERT
        99999*/

    end;

    var
        Location: Record Location;
        ContractType: Option Sales,Purchase;
        DisplayMessage: Boolean;
}

