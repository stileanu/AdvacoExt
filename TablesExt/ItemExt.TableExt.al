tableextension 50104 ItemExt Extends Item
{

    // To find commented code, use pattern <//--!>

    /*1/9/01 htcs rca
    testing - added key "Alternative Item No."  -  used for special items dataport

    08/09/01 HEF
    CLASS ON VALIDATE CODE

    Description Removed Auto Fill of Search Description

    //>> HEF INSERT
      Added Parts, WOD, and OK to Globals

    05/24/12 ADV
    Added new field <FIA Reference> to store path and file name to FIA Document.
    Added control on F50059 Item Card All on Ordering tab.

    02/13/18
    Added code to synchronize Item Posting Group and Gen. Prod. Posting Group with <Location Item> table.*/
    fields
    {
        field(50000; "Last Direct Cost Change Date"; Date)
        {
            Caption = 'Last Direct Cost Change Date';
        }
        field(50001; "Blanket Reorder Point"; Decimal)
        {
            Caption = 'Blanket Reorder Point';
        }
        field(50002; "Blanket Reorder Quantity"; Decimal)
        {
            Caption = 'Blanket Reorder Quantity';
        }
        field(50003; "Qty. Rec. Blanket Purch. Order"; Decimal)
        {
            Caption = 'Qty. Rec. Blanket Purch. Order';
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Qty. Received (Base)" WHERE("Document Type" = CONST("Blanket Order"), Type = CONST(Item), "No." = FIELD("No."),
                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                            "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"),
                            "Bin Code" = FIELD("Bin Filter"), "Expected Receipt Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50004; "Qty. on Blanket Purch. Order"; Decimal)
        {
            Caption = 'Qty. on Blanket Purch. Order';
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line".Quantity WHERE("Document Type" = CONST("Blanket Order"), Type = CONST(Item), "No." = FIELD("No."),
                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                            "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"),
                            "Bin Code" = FIELD("Bin Filter"), "Expected Receipt Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50005; "Qty. On Blanket Released"; Decimal)
        {
            Caption = 'Qty. On Blanket Released';
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Qty. Released" WHERE("Document Type" = CONST("Blanket Order"), Type = CONST(Item), "No." = FIELD("No."),
                            "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                            "Location Code" = FIELD("Location Filter"), "Drop Shipment" = FIELD("Drop Shipment Filter"), "Variant Code" = FIELD("Variant Filter"),
                            "Bin Code" = FIELD("Bin Filter"), "Expected Receipt Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50006; "User ID"; Code[50])
        {
            Caption = 'User ID';

        }
        field(50010; "UPS Shipping Surcharge"; Boolean)
        {
            Caption = 'UPS Shipping Surcharge';
        }
        field(50020; "Model Type"; Enum ModelType)
        {
            Caption = 'Model Type';
            //OptionCaption = ' ,Blower,Cryo Compressor,Cryo Pump,Diffusion Pump,Dry Pump - Ebara,Dry Pump - Edwards,Dry Pump - Leybold,Filter System,Leak Detector,Mechanical Pump,Scroll Pump,Turbo Controller,Turbo Pump';
            //OptionMembers = " ",Blower,"Cryo Compressor","Cryo Pump","Diffusion Pump","Dry Pump - Ebara","Dry Pump - Edwards","Dry Pump - Leybold","Filter System","Leak Detector","Mechanical Pump","Scroll Pump","Turbo Controller","Turbo Pump";
        }
        field(50030; "Receiving Inspection"; Boolean)
        {
            Caption = 'Receiving Inspection';
        }
        field(50040; "Manual Reorder Point"; Boolean)
        {
            Caption = 'Manual Reorder Point';
        }
        field(50050; "OverYearSupply"; Code[1])
        {
            caption = 'OverYearSupply';
        }
        field(50060; "RIA Reference"; Text[120])
        {
            //ADV-FIA Document per Chip
            Caption = 'RIA Reference';
        }
        field(50061; "Qty. on Purchase Orders"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code" = FIELD("Location Filter"),
                                                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Expected Receipt Date" = FIELD("Date Filter"),
                                                                               "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'Qty. on Purch. Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

        }
        field(50070; Class; Code[10])
        {
            //ADV-FIA Document per Chip
            Caption = 'Class';

            trigger OnValidate()
            begin
                //INSERT HEF
                IF (Class <> 'ITEM') AND (Class <> 'PUMP') AND (Class <> 'MODEL') THEN
                    ERROR('The only valid Class entries are ''PUMP'', ''MODEL'', or ''ITEM''.');
                IF Class = 'PUMP' THEN
                    "Costing Method" := "Costing Method"::Specific
                ELSE
                    "Costing Method" := "Costing Method"::FIFO;


                IF (Class = 'ITEM') THEN BEGIN
                    ItemNo := COPYSTR("No.", 1, 2);
                    IF ItemNo = 'AD' THEN BEGIN
                        "Price/Profit Calculation" := 1;   //'Price=Cost+Profit'
                        "Profit %" := 28.57143;
                    END ELSE BEGIN
                        "Price/Profit Calculation" := 1;  //'Price=Cost+Profit'
                        "Profit %" := 46.23657;
                    END;
                    VALIDATE("Profit %");
                END;

                //END INSERT HEF    

            end;
        }

        field(59900; "Old ReOrder Point"; Decimal)
        {
            Caption = 'Old ReOrder Point';
        }
        field(59910; "Old ReOrder Qty"; Decimal)
        {
            Caption = 'Old Reorder Qty.';
        }

        modify("Inventory Posting Group")
        {
            trigger OnAfterValidate()
            //ICE-MPC location Item table is not in the base version
            begin
                //--!OT
                // 02/13/18 Start
                /*
                LocationItem.RESET;
                LocationItem.SETRANGE("Item No.", "No.");
                IF LocationItem.FINDFIRST THEN
                    REPEAT
                        LocationItem."Inventory Posting Group" := "Inventory Posting Group";
                        LocationItem.MODIFY;
                    UNTIL LocationItem.NEXT = 0;
                // 02/13/18 End
                */
            end;
        }

        modify("Price/Profit Calculation")
        {
            trigger OnAfterValidate()
            var
                VATPostingSetup: Record "VAT Posting Setup";

            begin
                if VATPostingSetup.GET then;
                //>> HEF INSERT
                CASE "Price/Profit Calculation" OF
                    "Price/Profit Calculation"::"Profit=Price-Cost":
                        IF "Unit Price" <> 0 THEN
                            "Profit %" :=
                                ROUND(
                                100 * (1 - "Last Direct Cost" / ("Unit Price" /
                                (1 + VATPostingSetup."VAT %" / 100))), 0.00001)
                        ELSE
                            "Profit %" := 0;
                    "Price/Profit Calculation"::"Price=Cost+Profit":
                        IF "Profit %" < 100 THEN
                            "Unit Price" :=
                                ROUND(
                                ("Last Direct Cost" / (1 - "Profit %" / 100)) *
                                (1 + VATPostingSetup."VAT %" / 100), 0.00001);
                END;
                //<< HEF END INSERT    
            end;
        }
        /*modify("Average Cost")
        trigger OnAfterValidate()
        ICE-MPC Average Cost field is no longer in base
        begin
         
            //INSERT HEF ADDED TO FILL IN LAST DIRECT COST AND STANDARD COST IF EMPTY
            IF "Last Direct Cost" = 0 THEN BEGIN
            "Last Direct Cost" := "Average Cost";
            VALIDATE("Price/Profit Calculation");
            END;
            IF "Standard Cost" = 0 THEN
            "Standard Cost" := "Average Cost";
            //END INSERT   
        end;*/
        modify("Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                //--!OT
                //>> Item Cross Reference - start
                //IF ("Vendor Item No." <> '') AND ("Vendor No." <> '') THEN
                //    DistIntegration.ICRCreatePrimaryVendorEntry(Rec);
                //<< Item Cross Reference - end
            end;
        }
        modify("Vendor Item No.")
        {
            trigger OnAfterValidate()
            begin
                //--!OT
                //>> Item Cross Reference - start
                //IF ("Vendor Item No." <> '') AND ("Vendor No." <> '') THEN
                //    DistIntegration.ICRCreatePrimaryVendorEntry(Rec);
                //<< Item Cross Reference - end
            end;
        }
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                //>> HEF INSERT

                PartsUsed := FALSE;
                IF Blocked THEN BEGIN
                    Parts.SETRANGE(Parts."Part No.", "No.");
                    IF Parts.FIND('-') THEN BEGIN
                        REPEAT
                            IF WOD.GET(Parts."Work Order No.") THEN BEGIN
                                IF WOD.Complete THEN BEGIN
                                    OK := TRUE
                                END ELSE BEGIN
                                    IF Parts."Quoted Quantity" > 0 THEN BEGIN
                                        WO := WO + ', ' + Parts."Work Order No.";
                                        PartsUsed := TRUE;
                                    END;
                                END;
                            END;
                        UNTIL Parts.NEXT = 0;
                    END;
                END;

                IF PartsUsed THEN
                    MESSAGE('%1 is quoted for the following Work Orders %2', "No.", WO);
                //<< HEF END INSERT
            end;
        }
        modify("Gen. Prod. Posting Group")
        {
            trigger OnAfterValidate()
            begin
                //--!OT
                // 02/13/18 Start
                /*
                LocationItem.RESET;
                LocationItem.SETRANGE("Item No.", "No.");
                IF LocationItem.FINDFIRST THEN
                    REPEAT
                        LocationItem."General Product Posting Group" := "Gen. Prod. Posting Group";
                        LocationItem.MODIFY;
                    UNTIL LocationItem.NEXT = 0;
                // 02/13/18 End
                */
            end;
        }
    }
    trigger OnModify()
    begin

        //>> HEF INSERT
        "User ID" := USERID;
        VALIDATE("Price/Profit Calculation");
        IF xRec."Last Direct Cost" <> "Last Direct Cost" THEN BEGIN
            "Last Direct Cost Change Date" := TODAY;
        END;
        //<< HEF END 
        //>> Contracts Start
        //-!OC
        //DistIntegration.ContractUpdateItemContractLine(Rec);
        //<< Contracts End
    end;

    trigger OnDelete()

    begin
        //INSERT HEF
        IF Class = 'MODEL' THEN BEGIN
            WOD.SETCURRENTKEY("Model No.");
            WOD.SETRANGE(WOD."Model No.", xRec."No.");
            IF WOD.FIND('-') THEN
                ERROR('Model %1 has been assigned to atleast one Work Order and can''t be Renamed or Deleted', xRec."No.");

            // Dist-Log Start
            //--!OC
            //DistIntegration.LocationItemDelete(Rec);

            //ItemSubstitution.SETRANGE(ItemSubstitution."Item No.","No."); ICE-MPC replace with below
            ItemSubstitution.SETRANGE(ItemSubstitution."Sub. Item No.", "No.");
            ItemSubstitution.SETRANGE(ItemSubstitution."Variant Code", "Variant Filter");
            IF ItemSubstitution.FIND('-') THEN
                ItemSubstitution.DELETEALL;
            ItemSubstitution.RESET;
            //ItemSubstitution.SETRANGE(ItemSubstitution."Substitute Item No.","No."); ICE_MPC Replaced with below
            ItemSubstitution.SETRANGE(ItemSubstitution."Substitute No.", "No.");
            ItemSubstitution.SETRANGE(ItemSubstitution."Substitute Variant Code", "Variant Filter");
            IF ItemSubstitution.FIND('-') THEN
                ItemSubstitution.DELETEALL;

            //--!OT
            //NonStocks.NonStockItemDel(Rec);
            //ItemSubstitution.NonStockItemDel(Rec);
            // Dist-Log End
        END;
        //END INSERT HEF 

        //>> Item Cross Reference - Start
        //--!OC
        //DistIntegration.ICRDeleteItem("No.");
        //<< Item Cross Reference - End
    end;


    trigger OnAfterRename()
    begin

        //INSERT HEF
        IF Class = 'MODEL' THEN BEGIN
            WOD.SETCURRENTKEY("Model No.");
            WOD.SETRANGE(WOD."Model No.", xRec."No.");
            IF WOD.FIND('-') THEN BEGIN
                ERROR('Model %1 has been assigned to at least one Work Order and can''t be Renamed or Deleted', xRec."No.");
            END ELSE BEGIN
                "Last Date Modified" := TODAY;
                "User ID" := USERID;
            END;
        END ELSE BEGIN
            "Last Date Modified" := TODAY;
            "User ID" := USERID;
        END;
        // END INSERT HEF 
    end;

    var

        Parts: Record Parts;
        WOD: Record WorkOrderDetail;
        ItemSubstitution: Record "Item Substitution";
        //--!OT
        //NonStocks: Codeunit "Non Stocks";
        //--!OT
        //LocationItem: Record "Location Item";
        PartsUsed: Boolean;
        WO: Code[250];
        OK: Boolean;
        ItemNo: Code[2];

}
