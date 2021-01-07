report 50060 "Receiving Inspection"
{
    // 05/24/12 ADV
    // Added code to launch RIA Reference document as pdf file.
    // Adobe software set in <User Setup> table, document reference in Item card.
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/50060_Receiving Inspection.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;
    UseSystemPrinter = true;

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            RequestFilterFields = "Document No.", "Buy-from Vendor No.", "Type";

            column(Purchase_Line__Document_No__; "Document No.")
            {
            }
            column(Order_Date; PurchHeader."Order Date")
            {
            }
            column(ItemNo; ItemNo)
            {
            }
            column(ADVANCED_VACUUM_COMPANY__INC__; 'ADVANCED VACUUM COMPANY, INC.')
            {
            }
            column(Purchase_Line_Quantity; Quantity)
            {
            }
            column(PurchHeader__Buy_from_Vendor_No__; PurchHeader."Buy-from Vendor No.")
            {
            }
            column(PurchHeader__Buy_from_Vendor_Name_; PurchHeader."Buy-from Vendor Name")
            {
            }
            column(PurchHeader__Buy_from_Address_; PurchHeader."Buy-from Address")
            {
            }
            column(PurchHeader__Buy_from_City___________PurchHeader__Buy_from_State___________PurchHeader__Buy_from_ZIP_Code_; PurchHeader."Buy-from City" + ', ' + PurchHeader."Buy-from County" + '  ' + PurchHeader."Buy-from Post Code")
            {
            }
            column(Vendor__Fax_No__; Vendor."Fax No.")
            {
            }
            column(Purchase_Line_Description; Description)
            {
            }
            column(PurchHeader__Shipping_Agent_; PurchHeader."Shipping Agent")
            {
            }
            column(PurchHeader_Notes; PurchHeader.Notes)
            {
            }
            column(PurchHeader__Purchaser_Code_; PurchHeader."Purchaser Code")
            {
            }
            column(PurchHeader__Shipment_Method_Code_; PurchHeader."Shipment Method Code")
            {
            }
            column(PurchHeader__Buy_from_Contact_; PurchHeader."Buy-from Contact")
            {
            }
            column(PurchHeader__Payment_Terms_Code_; PurchHeader."Payment Terms Code")
            {
            }
            column(Advice; Advice)
            {
            }
            column(Vendor__Phone_No__; Vendor."Phone No.")
            {
            }
            column(V1215_BUSINESS_PKWY_N__; '1215 BUSINESS PKWY N.')
            {
            }
            column(WESTMINSTER__MD_21157_; 'WESTMINSTER, MD 21157')
            {
            }
            column(Motor_Serial_No____________________; 'Motor Serial No:__________________')
            {
            }
            column(Date_shipped_to_vendor_____________; 'Date shipped to vendor:___________')
            {
            }
            column(Inspections__; 'Inspections:')
            {
            }
            column(V1____; '1:')
            {
            }
            column(RIARef; RIARef)
            {
            }
            column(V2__; '2:')
            {
            }
            column(Reference_QP037_for_inspection_requirements_______________________________________________; 'Reference QP037 for inspection requirements _____________________________________________')
            {
            }
            column(Notes__; 'Notes:')
            {
            }
            column(Qty_Received_________; 'Qty Received:_______')
            {
            }
            column(Inspector_Signature_________________________________; 'Inspector Signature:_______________________________')
            {
            }
            column(Approval_Signature__________________________________; 'Approval Signature:________________________________')
            {
            }
            column(Date_________________; 'Date:_______________')
            {
            }
            column(Date__________________Control46; 'Date:_______________')
            {
            }
            column(Qty_Inspected_________; 'Qty Inspected:_______')
            {
            }
            column(Ship_Via__; 'Ship Via:')
            {
            }
            column(Method__; 'Method:')
            {
            }
            column(Shipping_Advice__; 'Shipping Advice:')
            {
            }
            column(Required_By__; 'Required By:')
            {
            }
            column(Buyer__; 'Buyer:')
            {
            }
            column(Notes___Control53; 'Notes:')
            {
            }
            column(Vendor_No___; 'Vendor No.:')
            {
            }
            column(Confirm_To__; 'Confirm To:')
            {
            }
            column(Phone_No___; 'Phone No.:')
            {
            }
            column(Fax_no___; 'Fax no.:')
            {
            }
            column(Terms__; 'Terms:')
            {
            }
            column(From__; 'From:')
            {
            }
            column(Ship_To__; 'Ship To:')
            {
            }
            column(Purchase_Line__Expected_Receipt_Date_; "Expected Receipt Date")
            {
            }
            column(Item_No__; 'Item No.')
            {
            }
            column(Description_; 'Description')
            {
            }
            column(Quantity_; 'Quantity')
            {
            }
            column(ADVACO_RECEIVING_INSPECTIONCaption; ADVACO_RECEIVING_INSPECTIONCaptionLbl)
            {
            }
            column(PICK_TICKETCaption; PICK_TICKETCaptionLbl)
            {
            }
            column(Purchase_Order__Caption; Purchase_Order__CaptionLbl)
            {
            }
            column(Order_DateCaption; Order_DateCaptionLbl)
            {
            }
            column(Purchase_Line_Document_Type; "Document Type")
            {
            }
            column(Purchase_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Print := false;
                RIARef := '';
                PurchHeader.Get("Document Type", "Document No.");
                if Vendor.Get(PurchHeader."Buy-from Vendor No.") then begin
                    if Item.Get("Purchase Line"."No.") then begin
                        if Item."Receiving Inspection" then begin
                            if Quantity > 0 then begin
                                Print := true;
                                ItemNo := "No.";
                            end;
                        end;

                        if Vendor."Receiving Inspection" then begin
                            if Quantity > 0 then begin
                                Print := true;
                                ItemNo := "No.";
                            end;
                        end;

                        if "Receiving Inspection" then begin
                            if Quantity > 0 then begin
                                Print := true;
                                ItemNo := "No.";
                            end;
                        end;

                        // 05/24/12 Start
                        if Print then begin
                            LaunchRIARef;
                        end;
                        // 05/24/12 End

                    end else begin
                        if "Receiving Inspection" then begin
                            if Quantity > 0 then begin
                                Print := true;
                                //        ItemNo :=  "Cross Reference Item";
                            end;
                        end;

                        if Vendor."Receiving Inspection" then begin
                            if Quantity > 0 then begin
                                Print := true;
                                //ItemNo := "Cross Reference Item";
                            end;
                        end;
                    end;
                end;

                //CASE PurchHeader."Shipping Advice" OF
                //  0:
                //    Advice := 'Ship partial';
                //  1:
                //    Advice := 'Ship Complete';
                //END;

                if Print = false then
                    CurrReport.Skip;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        Item: Record Item;
        OK: Boolean;
        ItemNo: Code[30];
        Print: Boolean;
        Advice: Code[20];
        RIARef: Text[250];
        ADVACO_RECEIVING_INSPECTIONCaptionLbl: Label 'ADVACO RECEIVING INSPECTION';
        PICK_TICKETCaptionLbl: Label 'PICK TICKET';
        Purchase_Order__CaptionLbl: Label 'Purchase Order #';
        Order_DateCaptionLbl: Label 'Order Date';

    procedure LaunchRIARef()
    var
        UserSetup: Record "User Setup";
        ADVMSG001: Label 'Adobe software not setup for user %1. Contact IT Department.';
        ADVMSG002: Label 'RIA Reference is not set for Item %1.';
        RefText: Text[250];
    begin
        // 05/24/12 New function
        UserSetup.Get(UserId);
        if UserSetup."Adobe Software" = '' then
            Message(StrSubstNo(ADVMSG001, UserId))
        else begin
            if Item."No." <> '' then
                if Item."RIA Reference" = '' then
                    Message(StrSubstNo(ADVMSG002, Item."No."))
                else
                    ;//Shell(UserSetup."Adobe Software", Item."RIA Reference");
        end;

        // extract file name from RIA Reference
        RefText := Item."RIA Reference";
        repeat
            RefText := CopyStr(RefText, StrPos(RefText, '\') + 1);
        until StrPos(RefText, '\') = 0;
        RIARef := 'RIA Reference - ' + RefText;
    end;
}

