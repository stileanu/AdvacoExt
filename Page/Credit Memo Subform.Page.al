page 50142 "Credit Memo Subform"
{
    // Code Added to ONLookup of Cross Reference to Prevent change after Order Posted

    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER("Credit Memo"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Description)
                {
                }
                field(Quantity; Quantity)
                {
                    Caption = 'Qty.';
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    Visible = false;
                }
                field("Tax Liable"; "Tax Liable")
                {
                    Visible = false;
                }
                field("Tax Group Code"; "Tax Group Code")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    Visible = false;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    Visible = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    Visible = false;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //CALCFIELDS("Qty. Picked (Base)");
        //"Qty. Picked" := ("Qty. Picked (Base)" / "Qty. per Unit of Measure");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := xRec.Type;
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchaseHeader: Record "Purchase Header";
        "Credit Memo Header": Record "Purchase Header";

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.Run(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord;
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate then
            CurrPage.Update;
    end;

    procedure ShowReservation2()
    begin
        Find;
        Rec.ShowReservation;
    end;

    procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(true);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
    end;
}

