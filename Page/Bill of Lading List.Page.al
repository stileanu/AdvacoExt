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
                field("Bill of Lading"; "Bill of Lading")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Order No."; "Order No.")
                {
                    ApplicationArea = All;
                }
                field(Customer; Customer)
                {
                    ApplicationArea = All;
                }
                field(Employee; Employee)
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Container Quantity"; "Container Quantity")
                {
                    ApplicationArea = All;
                }
                field("Container Type"; "Container Type")
                {
                    ApplicationArea = All;
                }
                field(Carrier; Carrier)
                {
                    ApplicationArea = All;
                }
                field("Shipping Method"; "Shipping Method")
                {
                    ApplicationArea = All;
                }
                field("Shipping Charge"; "Shipping Charge")
                {
                    ApplicationArea = All;
                }
                field("Shipping Account"; "Shipping Account")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
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

