pageextension 62006 ItemCardExt extends "Item Card"
{
    layout
    {
        // Add  changes to page layout 
        addbefore(Blocked)
        {
            field("UPS Shipping Surcharge"; Rec."UPS Shipping Surcharge")
            {
                ApplicationArea = all;
            }
        }
        addafter(Blocked)
        {
            field(Class; Rec.Class)
            {
                ApplicationArea = All;
            }
            field("Model Type"; Rec."Model Type")
            {
                ApplicationArea = All;
            }
        }
        //ICE RSK 2/3/21 add qtyavailable
        addbefore("Qty. on Purch. Order")
        {
            field(QtyAvailable; QtyAvailable)
            {
                Caption = 'Qty. Available';
                ApplicationArea = All;
                Editable = false;

            }
            field("Qty. on Blanket Purch. Order"; Rec."Qty. on Blanket Purch. Order")
            {
                Caption = 'Qty. on Blanket Orders';
                ApplicationArea = All;
            }
        }
        addafter("Purch. Unit of Measure")
        {
            field("Receiving Inspection"; Rec."Receiving Inspection")
            {
                ApplicationArea = All;
            }
            field("RIA Reference"; Rec."RIA Reference")
            {
                ApplicationArea = All;
                Enabled = lRecInspect;

            }
        }
        addbefore(ReorderPointParameters)
        {
            group(Advaco)
            {
                field("Manual Reorder Point"; Rec."Manual Reorder Point")
                {
                    ApplicationArea = All;
                    Caption = 'Manual Reorder Entry';
                    //Enabled = ReorderPointEnable;
                }
                field("Blanket Reorder Point"; Rec."Blanket Reorder Point")
                {
                    ApplicationArea = All;
                }
                field("Blanket Reorder Quantity"; Rec."Blanket Reorder Quantity")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        addafter(AdjustInventory)
        {
            action(ReturnCommitted)
            {
                Caption = 'Return Committed';
                ApplicationArea = All;
                Image = Reuse;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Move Inventory Items from COMMITTED back to MAIN to be re-used.';
                PromotedOnly = true;

                trigger OnAction()
                begin

                    IF Rec.Class = 'ITEM' THEN
                        Page.RunModal(50055, Rec)
                    ELSE
                        Message('Return Commited is available for items only');
                end;
            }
        }
    }

    var
        Location: Record Location;
        ContractType: Option Sales,Purchase;
        DisplayMessage: Boolean;
        Exist: Boolean;
        QtyAvailable: Decimal;
        Item: Record Item;
        OldLocation: Record Location;
        Ok: Boolean;
        msgShowed: Boolean;
        ADVMSG001: Label 'Receiving Inspection required for Item %1, but no RIA Reference document path set.';
        [InDataSet]
        RIAReferenceEnabled: Boolean;
        lRecInspect: Boolean;

    trigger OnAfterGetRecord()
    begin

        Rec.SetRange("No.");
        QtyAvailable := 0;

        IF Item.GET(Rec."No.") THEN BEGIN
            Item.SETFILTER("Location Filter", '%1|%2', 'MAIN', 'COMMITTED');
            Item.CALCFIELDS(Inventory, "Qty. on Purch. Order", "Reserved Qty. on Inventory");
            QtyAvailable := (Item.Inventory - Item."Reserved Qty. on Inventory");

        END;

        // 05/24/12 Start
        msgShowed := FALSE;

        IF Rec."Receiving Inspection" THEN
            lRecInspect := TRUE
        ELSE
            lRecInspect := FALSE;
        // 05/24/12 End

    end;

}