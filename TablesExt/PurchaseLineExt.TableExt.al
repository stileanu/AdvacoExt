tableextension 50121 PurchaseLineExt extends "Purchase Line"
{
    /*
        1/12/01 HTCS RJK
        Added Code to OnValidate of Work ORder No. to see if it matches a real Work Order
        Insert by HTCS RJK 01/23/01
        Added code to OnMOdify Triger that if Type <> xRec Type they must confirm.

        2/1/01, HTCS, RCA - Added code to: "Quantity" - OnValidate()

        11/08/01 HEF
        Added Sum Index Qty. Received to Key

        12/04/01
        ADDED NEW KEY
        Document Type,Buy-from Vendor No.,Document No.,Line No.

        03/28/05
        Added new Key
        Document Type,Type,No.

        08/27/12 ADV
        Added code to update "Quality Clause" in the Purch. Header table

        04/26/16 ADV
        Added field <Orig. Expected Receipt Date> for Vendor Responsiveness report

        09/29/18
        Added code to synch Serial# with Receipt, if Item was received.

        02/02/19
        Added code to confirm user wants a Serial No.

        07/20/19
        Added tagged code to calculate Expected Receipt Date, from Leading Time field.
    */
    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                PurchHeader: Record "Purchase Header";

            begin
                PurchHeader.GET("Document Type", "Document No.");

                // 07/20/19 start
                // Calculate Expected Receipt Date
                //"Expected Receipt Date" := PurchHeader."Expected Receipt Date";
                IF "Document Type" = "Document Type"::"Credit Memo" THEN
                    "Expected Receipt Date" := PurchHeader."Expected Receipt Date"
                ELSE BEGIN
                    IF Type = Type::Item THEN BEGIN
                        ItemRec.GET("No.");
                        IF GetItemVendor("No.", "Buy-from Vendor No.") THEN BEGIN
                            IF Format(ItemVendor."Lead Time Calculation") <> '' THEN
                                "Expected Receipt Date" := CALCDATE(ItemVendor."Lead Time Calculation", PurchHeader."Expected Receipt Date")
                            ELSE
                                IF Format(ItemRec."Lead Time Calculation") <> '' THEN
                                    "Expected Receipt Date" := CALCDATE(ItemRec."Lead Time Calculation", PurchHeader."Expected Receipt Date")
                                ELSE
                                    "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
                        END ELSE
                            IF ItemRec.GET("No.") THEN BEGIN
                                IF Format(ItemRec."Lead Time Calculation") <> '' THEN
                                    "Expected Receipt Date" := CALCDATE(ItemRec."Lead Time Calculation", PurchHeader."Expected Receipt Date")
                                ELSE
                                    "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
                            END;
                    END;
                END;
                // 07/20/19 end

                // 04/26/16 ADV: Start
                "Orig. Expected Receipt Date" := "Expected Receipt Date";
                // 04/26/16 ADV: End


                IF Type = Type::Item then begin
                    GetItem(); //ICE RSK 12/3/20
                    /// 08/27/12 Start
                    IF Item."Receiving Inspection" THEN BEGIN
                        // Test if "I" is already in "Quality Clause"
                        IF NOT PurchHeader.TestInQualityClause('I', PurchHeader) THEN
                            // Add the code I
                            PurchHeader.AddCodeToQualityClause('I', PurchHeader);
                    END ELSE BEGIN
                        IF PurchHeader.TestInQualityClause('I', PurchHeader) THEN
                            IF NOT PurchHeader.ExistInspectionReqItem(PurchHeader."No.", xRec."No.") THEN
                                PurchHeader.DelCodeFromQualityClause('I', PurchHeader);
                    END;
                    // 08/27/12 End
                end;
            end;
        }

        modify("Expected Receipt Date")
        {
            trigger OnAfterValidate()
            begin
                // 07/20/19 start
                IF xRec."Expected Receipt Date" <> 0D THEN EXIT;

                // Calculate Expected Receipt Date
                IF Type <> Type::Item THEN EXIT;
                IF "No." = '' THEN EXIT;

                PurchaseHeader.GET("Document Type", "Document No.");
                ItemRec.GET("No.");
                IF GetItemVendor("No.", "Buy-from Vendor No.") THEN BEGIN
                    IF FORMAT(ItemVendor."Lead Time Calculation") <> '' THEN
                        "Expected Receipt Date" := CALCDATE(ItemVendor."Lead Time Calculation", PurchaseHeader."Expected Receipt Date")
                    ELSE
                        IF FORMAT(ItemRec."Lead Time Calculation") <> '' THEN
                            "Expected Receipt Date" := CALCDATE(ItemRec."Lead Time Calculation", PurchaseHeader."Expected Receipt Date")
                        ELSE
                            "Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
                END ELSE
                    IF ItemRec.GET("No.") THEN BEGIN
                        IF FORMAT(ItemRec."Lead Time Calculation") <> '' THEN
                            "Expected Receipt Date" := CALCDATE(ItemRec."Lead Time Calculation", PurchaseHeader."Expected Receipt Date")
                        ELSE
                            "Expected Receipt Date" := PurchaseHeader."Expected Receipt Date";
                    END;
                // 07/20/19 end
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                IF "Document Type" = "Document Type"::Order THEN begin  //ICE RSK 12/4/20 add criteria
                    //insert by htcs, rca
                    "Qty. to Invoice" := 0;
                    "Qty. to Receive" := 0;
                    "Qty. to Invoice (Base)" := 0;
                    "Qty. to Receive (Base)" := 0;
                    //<< end rca insert
                END;
            end;
        }
        modify("Tax Liable")
        {
            trigger OnBeforeValidate()
            begin
                //>> HEF INSERT
                IF "Tax Liable" THEN BEGIN
                    "Tax Area Code" := 'MD';
                    "Tax Group Code" := 'DEFAULT';
                END ELSE BEGIN
                    "Tax Area Code" := '';
                    "Tax Group Code" := '';
                END;
                //<< HEF END INSERT
            end;
        }
        field(50000; "Work Order No."; Code[20])
        {
            Caption = 'Work Order No.';

            trigger OnValidate()
            begin

                Ok := FALSE;
                xOrderNo := '';
                IF xRec."Work Order No." <> '' THEN BEGIN
                    IF xRec."Work Order No." <> Rec."Work Order No." THEN BEGIN
                        xOrderNo := xRec."Work Order No.";
                        IF NOT CONFIRM('Are you sure you want to remove the link between this Purchase Order and %1', FALSE, xOrderNo) THEN BEGIN
                            "Work Order No." := xRec."Work Order No.";
                            Ok := TRUE;
                            MODIFY;
                        END ELSE BEGIN
                            //Clears Sales Order Purchase Order Number for Item
                            xOrderNo := COPYSTR(xRec."Work Order No.", 1, 7);
                            IF SO.GET("Document Type" = "Document Type"::Order, xOrderNo) THEN BEGIN
                                SalesLine.SETRANGE("Document Type", SO."Document Type");
                                SalesLine.SETRANGE("Document No.", SO."No.");
                                SalesLine.SETRANGE("No.", "No.");
                                IF SalesLine.FIND('-') THEN BEGIN
                                    SalesLine."Purchase Order No." := '';
                                    SalesLine.MODIFY;
                                    Ok := TRUE;
                                END;
                                COMMIT;
                                SalesLine.RESET;
                            END;
                            //Clears Work Order Purchase Order Number for Item
                            IF WOD.GET(xOrderNo) THEN BEGIN
                                Parts.SETRANGE(Parts."Work Order No.", WOD."Work Order No.");
                                Parts.SETRANGE(Parts."Part No.", "No.");
                                IF Parts.FIND('-') THEN BEGIN
                                    Parts."Purchase Order No." := '';
                                    Parts.MODIFY;
                                    Ok := TRUE;
                                END;
                                COMMIT;
                                Parts.RESET;
                            END;
                        END;
                    END;
                END;
                OrderNo := COPYSTR("Work Order No.", 1, 7);
                NumberLength := STRLEN(OrderNo);
                IF NumberLength = 7 THEN BEGIN
                    IF SO.GET("Document Type" = "Document Type"::Order, OrderNo) THEN BEGIN
                        SalesLine.SETRANGE("Document Type", SO."Document Type");
                        SalesLine.SETRANGE("Document No.", SO."No.");
                        SalesLine.SETRANGE("No.", "No.");
                        IF SalesLine.FIND('-') THEN BEGIN
                            SalesLine."Purchase Order No." := "Document No.";
                            SalesLine.MODIFY;
                        END;
                        COMMIT;
                        Ok := TRUE;
                    END;
                    IF WOD.GET(OrderNo) THEN BEGIN
                        Parts.SETRANGE(Parts."Work Order No.", WOD."Work Order No.");
                        Parts.SETRANGE(Parts."Part No.", "No.");
                        IF Parts.FIND('-') THEN BEGIN
                            Parts."Purchase Order No." := "Document No.";
                            Parts.MODIFY;
                        END;
                        COMMIT;
                        Ok := TRUE;
                        Parts.RESET;
                    END;
                END ELSE BEGIN
                    Ok := TRUE;
                END;

                IF Ok = FALSE THEN BEGIN
                    "Work Order No." := '';
                    MODIFY;
                    MESSAGE('The number you entered does not match a Work Order Detail or Sales Order');
                END;

            end;
        }
        field(50001; "Labels to Print"; Integer)
        {
            Caption = 'Labels to Print';
        }
        field(50002; Inspector; Code[20])
        {
            Caption = 'Inspector';
            TableRelation = Resource."No." WHERE("Gen. Prod. Posting Group" = FILTER(''), Type = CONST(Person));
        }
        field(50003; "Inspection Date"; Date)
        {
            Caption = 'Inspection Date';
        }
        field(50004; "Receiving Inspection"; Boolean)
        {
            Caption = 'Receiving Inspection';
        }
        field(50005; Code; Code[5])
        {
            Caption = 'Code';
        }
        field(50006; "Qty. Released"; Decimal)
        {
            Caption = 'Qty. Released';
        }
        field(50007; "Orig. Expected Receipt Date"; Date)
        {
            Caption = 'Orig. Expected Receipt Date';
            Description = 'ADV 4/26/16';
        }
    }

    trigger OnAfterModify()
    begin
        //>> HEF Insert
        IF (xRec."No." <> '') OR (xRec.Description <> '') THEN BEGIN
            IF Type <> xRec.Type THEN BEGIN
                IF NOT CONFIRM('Are you sure you want to change the Purchase Line Type?') THEN
                    ERROR('Purchase Line reverted to original Type.');
            END;
        END;
        //>> End Insert
    end;

    trigger OnAfterDelete()
    var
        PurchHeader: Record "Purchase Header";

    begin
        PurchHeader.GET("Document Type", "Document No.");
        // 08/27/12 Start
        // Clear Quality Clause Code
        IF Type = Type::Item THEN
            IF NOT PurchHeader.ExistInspectionReqItem(PurchHeader."No.", "No.") THEN
                PurchHeader.DelCodeFromQualityClause('I', PurchHeader);
        // 08/27/12 End
    end;

    var
        ItemVendor: Record "Item Vendor";
        ItemRec: Record Item;
        Item: Record Item;
        PurchaseHeader: Record "Purchase Header";
        OK: Boolean;
        xOrderNo: Code[20];
        SO: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Parts: Record Parts;
        WOD: Record WorkOrderDetail;
        OrderNo: Code[20];
        NumberLength: Integer;

    procedure GetItemVendor(No: Code[20]; BuyFromVendorNo: Code[20]): Boolean
    begin
        // 07/20/19 new function
        //WITH ItemVendor DO BEGIN ///--! With statement dropped
        ItemVendor.SETRANGE("Item No.", No);
        ItemVendor.SETRANGE("Vendor No.", BuyFromVendorNo);
        IF ItemVendor.FIND('+') THEN
            EXIT(TRUE);
        //END;
        EXIT(FALSE);
    end;

    procedure GetItem()
    begin
        TESTFIELD("No.");
        IF Item."No." <> "No." THEN
            Item.GET("No.");
    end;
}