pageextension 62006 ItemCardExt extends "Item Card"
{
    layout
    {
        // Add  changes to page layout 
        addbefore(Blocked)
        {
            field("UPS Shipping Surcharge"; "UPS Shipping Surcharge")
            {
                ApplicationArea = all;
            }
        }
        addafter(Blocked)
        {
            field(Class; Class)
            {
                ApplicationArea = All;
            }
            field("Model Type"; "Model Type")
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
            field("Qty. on Blanket Purch. Order"; "Qty. on Blanket Purch. Order")
            {
                Caption = 'Qty. on Blanket Orders';
                ApplicationArea = All;
            }
        }
        addafter("Purch. Unit of Measure")
        {
            field("Receiving Inspection"; "Receiving Inspection")
            {
                ApplicationArea = All;
            }
            field("RIA Reference"; "RIA Reference")
            {
                ApplicationArea = All;
                Enabled = lRecInspect;

            }
        }
        addbefore(ReorderPointParameters)
        {
            group(Advaco)
            {
                field("Manual Reorder Point"; "Manual Reorder Point")
                {
                    ApplicationArea = All;
                    Caption = 'Manual Reorder Entry';
                    //Enabled = ReorderPointEnable;
                }
                field("Blanket Reorder Point"; "Blanket Reorder Point")
                {
                    ApplicationArea = All;
                }
                field("Blanket Reorder Quantity"; "Blanket Reorder Quantity")
                {
                    ApplicationArea = All;
                }
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

        SETRANGE("No.");
        QtyAvailable := 0;

        IF Item.GET("No.") THEN BEGIN
            Item.SETFILTER("Location Filter", '%1|%2', 'MAIN', 'COMMITTED');
            Item.CALCFIELDS(Inventory, "Qty. on Purch. Order", "Reserved Qty. on Inventory");
            QtyAvailable := (Item.Inventory - Item."Reserved Qty. on Inventory");

        END;

        // 05/24/12 Start
        msgShowed := FALSE;

        IF "Receiving Inspection" THEN
            lRecInspect := TRUE
        ELSE
            lRecInspect := FALSE;
        // 05/24/12 End

    end;

}