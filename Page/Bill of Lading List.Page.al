page 50035 "Bill of Lading List"
{
    Editable = false;
    PageType = List;
    SourceTable = BillofLading;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill of Lading"; Rec."Bill of Lading")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Container Quantity"; Rec."Container Quantity")
                {
                    ApplicationArea = All;
                }
                field("Container Type"; Rec."Container Type")
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
                field("Package Tracking No."; Rec."Package Tracking No.")
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

