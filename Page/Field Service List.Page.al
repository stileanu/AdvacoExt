page 50151 "Field Service List"
{
    Editable = false;
    PageType = List;
    caption = 'Field Service List';
    UsageCategory = Tasks;
    ApplicationArea = all;
    SourceTable = FieldService;
    CardPageId = 50150;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Field Service No."; Rec."Field Service No.")
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field("Date Ordered"; Rec."Date Ordered")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Address 1"; Rec."Customer Address 1")
                {
                    ApplicationArea = All;
                }
                field("Customer Address 2"; Rec."Customer Address 2")
                {
                    ApplicationArea = All;
                }
                field("Customer City"; Rec."Customer City")
                {
                    ApplicationArea = All;
                }
                field("Customer State"; Rec."Customer State")
                {
                    ApplicationArea = All;
                }
                field("Customer Zip Code"; Rec."Customer Zip Code")
                {
                    ApplicationArea = All;
                }
                field("Ship To Code"; Rec."Ship To Code")
                {
                    ApplicationArea = All;
                }
                field("Ship To Name"; Rec."Ship To Name")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address 1"; Rec."Ship To Address 1")
                {
                    ApplicationArea = All;
                }
                field("Ship To Address 2"; Rec."Ship To Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship To City"; Rec."Ship To City")
                {
                    ApplicationArea = All;
                }
                field("Ship To State"; Rec."Ship To State")
                {
                    ApplicationArea = All;
                }
                field("Ship To Zip Code"; Rec."Ship To Zip Code")
                {
                    ApplicationArea = All;
                }
                field(Attention; Rec.Attention)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Released; Rec.Released)
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("Inside Sales"; Rec."Inside Sales")
                {
                    ApplicationArea = All;
                }
                field(Rep; Rec.Rep)
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Exemption No."; Rec."Tax Exemption No.")
                {
                    ApplicationArea = All;
                }
                field("Exempt Organization"; Rec."Exempt Organization")
                {
                    ApplicationArea = All;
                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Income Code"; Rec."Income Code")
                {
                    ApplicationArea = All;
                }
                field("Customer PO No."; Rec."Customer PO No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Payment Terms"; Rec."Customer Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Card Type"; Rec."Card Type")
                {
                    ApplicationArea = All;
                }
                field("Credit Card No."; Rec."Credit Card No.")
                {
                    ApplicationArea = All;
                }
                field("Credit Card Exp."; Rec."Credit Card Exp.")
                {
                    ApplicationArea = All;
                }
                field("Parts Quoted"; Rec."Parts Quoted")
                {
                    ApplicationArea = All;
                }
                field("Order Adj."; Rec."Order Adj.")
                {
                    ApplicationArea = All;
                }
                field("Work Hours"; Rec."Work Hours")
                {
                    ApplicationArea = All;
                }
                field("Air Travel"; Rec."Air Travel")
                {
                    ApplicationArea = All;
                }
                field("Company Van Miles"; Rec."Company Van Miles")
                {
                    ApplicationArea = All;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = All;
                }
                field("Shipping Method"; Rec."Shipping Method")
                {
                    ApplicationArea = All;
                }
                field("Shipping Charge"; Rec."Shipping Charge")
                {
                    ApplicationArea = All;
                }
                field("Shipping Account"; Rec."Shipping Account")
                {
                    ApplicationArea = All;
                }
                field(Complete; Rec.Complete)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

