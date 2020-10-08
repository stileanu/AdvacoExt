page 50077 "Blanket Purch Order Subform"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER("Blanket Order"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                    Caption = 'Qty to Release';
                }
                field("Qty. Released"; Rec."Qty. Released")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchaseHeader: Record "Purchase Header";

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
        Rec.Find;
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

