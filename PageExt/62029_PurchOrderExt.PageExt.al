pageextension 62029 PurchOrderExt extends "Purchase Order"
{
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Posting,Prepare,Order,Request Approval,Print/Send,Navigate';
    layout
    {
        addafter("Document Date")
        {
            field("Placed By"; "Placed by")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            field(APPurchPaymentTerms; APPurchPaymentTerms)
            {
                Caption = 'AP Payment Terms Code';
                Editable = false;
                ApplicationArea = All;
                Visible = lAccGroup;
            }
            field(PurchPaymentTerms; PurchPaymentTerms)
            {
                Caption = 'Purch. Payment Terms';
                Editable = false;
                ApplicationArea = All;
            }
            field("Vendor Repair"; "Vendor Repair")
            {
                ApplicationArea = All;
                Visible = lPurchGroup;
            }
            field("Order Acknowledgement"; "Order Acknowledgement")
            {
                ApplicationArea = All;
                Visible = lPurchGroup;
            }
        }
        addafter("Purchaser Code")
        {
            field("Quality Clause"; "Quality Clause")
            {
                ApplicationArea = All;

            }
            field("Phone No."; "Phone No.")
            {
                ApplicationArea = All;
                Visible = lPurchGroup;
            }
            field("Fax No."; "Vendor Fax")
            {
                ApplicationArea = All;
                Visible = lPurchGroup;
            }
        }

    }
    actions
    {
        addbefore(Receipts)
        {
            action(PrintLabels)
            {
                ApplicationArea = All;
                Visible = lPurchGroup;
                Caption = 'Print labels';
                Image = ShipAddress;
                Promoted = true;
                PromotedCategory = Category11;

                trigger OnAction()
                begin
                    PrintLabels;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        Ok: Boolean;
        User: Record User;
    begin
        ///--! Permission level check code.
        User.Get(UserSecurityId);
        //User.CalcFields("User Name");
        Ok := true;
        User.SetRange("User Security ID", User."User Security ID");

        lAccGroup := false;
        lPurchGroup := false;
        lShipGroup := false;

        //See if user is SUPER
        //user.setrange(user."User Name", userid);
        ///--!
        // Add the role for Accounting!
        IF User.FindFirst() THEN begin

            AccessControl.setrange("User Security ID", User."User Security ID");
            IF AccessControl.find('-') THEN begin
                repeat
                    ///--! To add what role is for accounting?? 
                    //if (AccessControl."Role ID" = 'SUPER') or (AccessControl."Role ID" = 'ADV-ACCT') THEN                
                    if AccessControl."Role ID" = 'SUPER' THEN
                        OK := FALSE;
                until AccessControl.next = 0;

            end;
        END;
        IF Ok THEN
            ERROR('This Purchase Order Card is for Accounting Only')
        else
            lAccGroup := true;
        //lAccGroup := false;
        //lSalesGroup := true;
        //lShipGroup := true;

        // 04/30/12 ADV Start
        IF PurchVendor.GET("Buy-from Vendor No.") THEN
            PurchPaymentTerms := PurchVendor."Payment Terms Code";
        IF APPurchVendor.GET("Pay-to Vendor No.") THEN
            APPurchPaymentTerms := APPurchVendor."Payment Terms Code";
        // 04/30/12 ADV End     

    end;

    trigger OnAfterGetRecord()
    begin
        // 04/30/12 ADV Start
        IF PurchVendor.GET("Buy-from Vendor No.") THEN
            PurchPaymentTerms := PurchVendor."Payment Terms Code";
        IF APPurchVendor.GET("Pay-to Vendor No.") THEN
            APPurchPaymentTerms := APPurchVendor."Payment Terms Code";
        // 04/30/12 ADV End       
    end;

    var

        PurchVendor: Record Vendor;
        APPurchVendor: Record Vendor;
        lAccGroup: Boolean;
        lPurchGroup: Boolean;
        lShipGroup: Boolean;
        APPurchPaymentTerms: Code[10];
        PurchPaymentTerms: Code[10];
        PurchLine: Record "Purchase Line";
        Labels: Record "Order Defects";
        LoopCounter: Integer;
        LabelCounter: Integer;
        Item: Record Item;
        Ok: Boolean;

    procedure PrintLabels()
    begin

        IF CONFIRM('Are you ready to print Labels?') THEN BEGIN
            PurchLine.RESET;
            PurchLine.SETRANGE(PurchLine."Document Type", "Document Type");
            PurchLine.SETRANGE(PurchLine."Document No.", "No.");
            PurchLine.SETRANGE(PurchLine."Labels to Print", 0, 9999);
            IF PurchLine.FIND('-') THEN BEGIN
                Labels.DELETEALL;
                REPEAT
                    IF Item.GET(PurchLine."No.") THEN
                        Ok := TRUE;
                    LabelCounter := 0;
                    LoopCounter := PurchLine."Labels to Print";
                    BEGIN
                        REPEAT
                            Labels.INIT;
                            Labels.Occurrence := Labels.Occurrence + 10000;
                            Labels."Order No." := PurchLine."Document No.";
                            Labels."Defect Code" := PurchLine."No.";
                            //Labels.Department := PurchLine.Description;
                            //Labels."Failure Item" := Item."Shelf/Bin No.";
                            LabelCounter := LabelCounter + 1;
                            Labels.INSERT;
                        UNTIL LabelCounter >= LoopCounter;
                    END;
                UNTIL PurchLine.NEXT = 0;
                ///--! Missing Report yet
                //REPORT.RUN(REPORT::"Bill of Lading Report");
            END;
        END;
    end;
}