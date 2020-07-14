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
                            IF ItemVendor."Lead Time Calculation" <> '' THEN
                                "Expected Receipt Date" := CALCDATE(ItemVendor."Lead Time Calculation", PurchHeader."Expected Receipt Date")
                            ELSE
                                IF ItemRec."Lead Time Calculation" <> '' THEN
                                    "Expected Receipt Date" := CALCDATE(ItemRec."Lead Time Calculation", PurchHeader."Expected Receipt Date")
                                ELSE
                                    "Expected Receipt Date" := PurchHeader."Expected Receipt Date";
                        END ELSE
                            IF ItemRec.GET("No.") THEN BEGIN
                                IF ItemRec."Lead Time Calculation" <> '' THEN
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

                GetItem();
                IF Type = Type::Item then begin
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

    procedure GetItemVendor(No: Code[20]; BuyFromVendorNo: Code[20]): Boolean
    begin
        // 07/20/19 new function
        WITH ItemVendor DO BEGIN
            SETRANGE("Item No.", No);
            SETRANGE("Vendor No.", BuyFromVendorNo);
            IF FIND('+') THEN
                EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    procedure GetItem()
    begin
        TESTFIELD("No.");
        IF Item."No." <> "No." THEN
            Item.GET("No.");
    end;
}