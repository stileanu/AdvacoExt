page 50081 "Purch. Cr. Memo Act Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = Advanced;
                    ToolTip = 'Specifies the line type.';
                }
                field(FilteredTypeField; TypeAsText)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Type';
                    Editable = CurrPageIsEditable;
                    LookupPageID = "Option Lookup List";
                    TableRelation = "Option Lookup Buffer"."Option Caption" WHERE("Lookup Type" = CONST(Purchases));
                    ToolTip = 'Specifies the type of transaction that will be posted with the document line. If you select Comment, then you can enter any text in the Description field, such as a message to a customer. ';
                    Visible = IsFoundation;

                    trigger OnValidate()
                    begin

                        TempOptionLookupBuffer.SetCurrentType(Type.AsInteger());
                        ///--!
                        // Function TempOptionLookupBuffer.AutoCompleteOption is [Scope('OnPrem')]
                        // Cannot be used on Cloud. Analyze another solution if needed
                        //if TempOptionLookupBuffer.AutoCompleteOption(TypeAsText, TempOptionLookupBuffer."Lookup Type"::Sales) then
                        Validate(Type, TempOptionLookupBuffer.ID);
                        TempOptionLookupBuffer.ValidateOption(TypeAsText);
                        UpdateEditableOnRow;
                        UpdateTypeText;
                        DeltaUpdateTotals;
                    end;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the cross-referenced item number. If you enter a cross reference between yours and your vendor''s or customer''s item number, then this number will override the standard item number when you enter the cross-reference number on a sales or purchase document.';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CrossReferenceNoLookUp;
                        InsertExtendedText(false);
                        NoOnAfterValidate;
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                        NoOnAfterValidate;
                    end;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = NOT IsCommentLine;
                    ToolTip = 'Specifies the number of a general ledger account, an item, an additional cost or a fixed asset, depending on what you selected in the Type field.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = NOT IsCommentLine;
                    ToolTip = 'Specifies a description of the entry of the product to be purchased. To add a non-transactional text line, fill in the Description field only.';

                    trigger OnValidate()
                    begin
                        UpdateEditableOnRow;

                        if "No." = xRec."No." then
                            exit;

                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;

                        UpdateTypeText;
                        DeltaUpdateTotals;
                    end;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Caption = 'Qty.';
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ShowMandatory = (NOT IsCommentLine) AND ("No." <> '');
                    ToolTip = 'Specifies the number of units of the item specified on the line.';

                    trigger OnValidate()
                    begin
                        DeltaUpdateTotals;
                    end;
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                    Caption = 'Qty. Credit Applied';
                }
                field("Qty. to Receive"; "Qty. to Receive")
                {
                    Caption = 'Qty. Returned';
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ShowMandatory = (NOT IsCommentLine) AND ("No." <> '');
                    ToolTip = 'Specifies the cost of one unit of the selected item or resource.';
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the sum of the amounts in the Amount Including Tax fields on the associated purchase lines.';
                }
                field("Tax Liable"; "Tax Liable")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies if the customer or vendor is liable for sales tax.';
                    Visible = false;
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the tax area that is used to calculate and post sales tax.';
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ShowMandatory = (NOT IsCommentLine) AND ("No." <> '');
                    ToolTip = 'Specifies the tax group that is used to calculate and post sales tax.';
                    Visible = TaxGroupCodeVisible;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ToolTip = 'Specifies the code for the location where the items on the line will be located.';
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("Use Duplication List"; "Use Duplication List")
                {
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {

                    trigger OnDrillDown()
                    begin
                        CurrPage.SaveRecord;
                        Commit;
                        ShowReservationEntries(true);
                        CurrPage.Update;
                    end;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UnitofMeasureCodeIsChangeable;
                    Enabled = UnitofMeasureCodeIsChangeable;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies the name of the unit of measure for the item, such as 1 bottle or 1 piece.';
                    Visible = false;
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the percentage of the item''s last purchase cost that includes indirect costs, such as freight that is associated with the purchase of the item.';
                    Visible = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the unit cost of the item on the line.';
                    Visible = false;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the price for one unit of the item.';
                    Visible = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                    Editable = NOT IsCommentLine;
                    Enabled = NOT IsCommentLine;
                    ToolTip = 'Specifies the discount percentage that is granted for the item on the line.';
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    Visible = false;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the invoice line is included when the invoice discount is calculated.';
                    Visible = false;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the invoice discount amount for the line.';
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the item ledger entry that the document or journal line is applied -to.';
                    Visible = false;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                }
                field("Insurance No."; "Insurance No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'Show the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = Planning;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location = R;
                        ApplicationArea = Location;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        AccessByPermission = TableData "BOM Buffer" = R;
                        ApplicationArea = Assembly;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
    end;

    trigger OnOpenPage()
    var
        TaxGroup: Record "Tax Group";
    begin
    end;

    var
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        Currency: Record Currency;
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        TempOptionLookupBuffer: Record "Option Lookup Buffer" temporary;
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        DocumentTotals: Codeunit "Document Totals";
        ShortcutDimCode: array[8] of Code[20];
        Text000: Label 'Unable to run this function while in View mode.';
        VATAmount: Decimal;
        InvoiceDiscountAmount: Decimal;
        InvoiceDiscountPct: Decimal;
        AmountWithDiscountAllowed: Decimal;
        InvDiscAmountEditable: Boolean;
        UpdateAllowedVar: Boolean;
        TypeAsText: Text[30];
        ItemChargeStyleExpression: Text;
        UnitofMeasureCodeIsChangeable: Boolean;
        IsFoundation: Boolean;
        IsCommentLine: Boolean;
        TaxGroupCodeVisible: Boolean;
        CurrPageIsEditable: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        UpdateInvDiscountQst: Label 'One or more lines have been invoiced. The discount distributed to invoiced lines will not be taken into account.\\Do you want to update the invoice discount?';
        PurchaseHeader: Record "Purchase Header";

    [Scope('Cloud')]
    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
    end;

    local procedure ValidateInvoiceDiscountAmount()
    var
        PurchaseHeader: Record "Purchase Header";
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        PurchaseHeader.Get("Document Type", "Document No.");
        if PurchaseHeader.InvoicedLineExists then
            //if not ConfirmManagement.ConfirmProcess(UpdateInvDiscountQst,true) then ICE-MPC BC Upgrade
            if not ConfirmManagement.GetResponseOrDefault(UpdateInvDiscountQst, true) then
                exit;

        DocumentTotals.PurchaseDocTotalsNotUpToDate;
        PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(InvoiceDiscountAmount, PurchaseHeader);
        CurrPage.Update(false);
    end;

    [Scope('Cloud')]
    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Calc.Discount", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
    end;

    [Scope('Cloud')]
    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM", Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
    end;

    [Scope('Cloud')]
    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        OnBeforeInsertExtendedText(Rec);
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            UpdateForm(true);
    end;

    [Scope('Cloud')]
    procedure ItemChargeAssgnt()
    begin
        ShowItemChargeAssgnt;
    end;

    [Scope('Cloud')]
    procedure OpenItemTrackingLines2()
    begin
        OpenItemTrackingLines;
    end;

    [Scope('Cloud')]
    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    [Scope('Cloud')]
    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    [Scope('Cloud')]
    procedure UpdateAllowed(): Boolean
    begin
        if UpdateAllowedVar = false then begin
            Message(Text000);
            exit(false);
        end;
        exit(true);
    end;

    [Scope('Cloud')]
    procedure ShowLineComments2()
    begin
        ShowLineComments;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Type = Type::"Charge (Item)") and ("No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SaveRecord;

        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalPurchaseLine);
        CurrPage.Update(false);
    end;

    local procedure GetTotalPurchHeader()
    begin
        DocumentTotals.GetTotalPurchaseHeaderAndCurrency(Rec, TotalPurchaseHeader, Currency);
    end;

    local procedure CalculateTotals()
    begin
        DocumentTotals.PurchaseCheckIfDocumentChanged(Rec, xRec);
        DocumentTotals.CalculatePurchaseSubPageTotals(
          TotalPurchaseHeader, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        DocumentTotals.RefreshPurchaseLine(Rec);
    end;

    local procedure DeltaUpdateTotals()
    begin
        DocumentTotals.PurchaseDeltaUpdateTotals(Rec, xRec, TotalPurchaseLine, VATAmount, InvoiceDiscountAmount, InvoiceDiscountPct);
        if "Line Amount" <> xRec."Line Amount" then
            SendLineInvoiceDiscountResetNotification;
    end;

    local procedure UpdateEditableOnRow()
    begin
        if Type <> Type::" " then
            UnitofMeasureCodeIsChangeable := CanEditUnitOfMeasureCode
        else
            UnitofMeasureCodeIsChangeable := false;

        IsCommentLine := Type = Type::" ";

        CurrPageIsEditable := CurrPage.Editable;
        InvDiscAmountEditable := CurrPageIsEditable and not PurchasesPayablesSetup."Calc. Inv. Discount";
    end;

    local procedure UpdateTypeText()
    var
        RecRef: RecordRef;
    begin
        if not IsFoundation then
            exit;

        RecRef.GetTable(Rec);
        TypeAsText := TempOptionLookupBuffer.FormatOption(RecRef.Field(FieldNo(Type)));
    end;

    local procedure SetItemChargeFieldsStyle()
    begin
        ItemChargeStyleExpression := '';
        if AssignedItemCharge then
            ItemChargeStyleExpression := 'Unfavorable';
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;


    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var PurchaseLine: Record "Purchase Line"; var ShortcutDimCode: array[8] of Code[20]; DimIndex: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var PurchaseLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCrossReferenceNoOnLookup(var PurchaseLine: Record "Purchase Line")
    begin
    end;
}

